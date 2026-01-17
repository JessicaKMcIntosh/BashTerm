#!/usr/bin/env bash
# shellcheck source=attr.sh

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# A library for making menus.

# This requires bash version 4.
if [[ "${BASH_VERSINFO[0]}" -lt "4" ]] ; then
    echo "This script requires Bash 4 or later."
    echo "Current version: ${BASH_VERSION}"
    exit 1
fi

# Only load the library once.
declare -A _TERM_LOADED # Track loaded files.
declare _TERM_FILE_NAME="${BASH_SOURCE[0]##*/}"
if [[ -v _TERM_LOADED[${_TERM_FILE_NAME}] ]] ; then
    [[ -v TERM_VERBOSE ]] && echo "Already loaded '${_TERM_FILE_NAME}'."
    return 0
fi
_TERM_LOADED[${_TERM_FILE_NAME}]="${BASH_SOURCE[0]}"
[[ -v TERM_VERBOSE ]] && echo "Loading '${_TERM_FILE_NAME}'..."
unset _TERM_FILE_NAME

# Load the libraries.
declare -a library_list=("attr.sh")
find_library(){
    local library="${1}"
    local file_name
    for file_name in {../,./}${library} ; do
        if [[ -f  "${file_name}" ]] ; then
            echo "${file_name}"
            exit
        fi
    done
    echo "Unable to locate the library '${library}'." >&2
    exit 1
}
#TERM_VERBOSE=0 # Uncomment for verbose library loading.
for library in "${library_list[@]}"; do
    source "$(find_library "${library}")" || exit 1
done

# Default settings.
declare _TERM_MENU_SEPARATOR=":"
declare _TERM_MENU_PROMPT="Select the option [~]: "

# Display a menu.
# Args:
#   $1 - Menu title.
#   $2 - Options!
#   $@ - Menu Item array.
# Menu item array:
#   These are composed of three fields separated by the vertical tab ("|") character.
#   ( "Key|Return|Text" )
#   Text -   The text to print for the menu item. Required!
#            If Text is "~" then the item is not printed.
#            Use this for the sideeffect of a key and return code.
#   Key -    The optional key the user should press.
#            If not present the key is the positional number + 1.
#            If Key is "~" then the key is ignored and the text is printed verbatim.
#   Return - The optional return code. The default is the positional number.
#   If either the key or return code are used both colons are required.
# Options:
#   These change how the menu is built and operates.
#   Options are separated by the vertical tab ("|") character.
#   clear       - Clear the screen before displaying the menu.
#   bold        - The key text is printed in bold.
#   debug       - Print some debug information.
#   one         - Exit after the first attempt. Returns 251 if a key was not selected.
#   prompt      - The user prompt. "~" is replaced with the valid keys.
#   quiet       - Do not print error text.
#   reverse     - The key text is printed in reverse.
#   sep         - The key and text separator text follows.
#                 For example "sep =>" results in "0 => Menu Text."
#   underline   - The key text is printed underlined.
# Returns:'
#   The item selected in the exit status.
#   All return codes MUST be less than or equal to 250.
#   If you need more than 250 menu items consider Whiptail.
#   https://en.wikibooks.org/wiki/Bash_Shell_Scripting/Whiptail
#   251 - Invalid key entered and option "one" was given.
#   252 - Insufficient args passed.
#   255 - Error while building the menu.
# Notes:
#   The character "~" is used because it is uncommon and unlikely to appear in menu text.
term::menu() {
    if [[ "${#}" -lt "3" ]] ; then
        echo "MENU ERROR: Insufficient parameters passed!" >&2
        exit 252
    fi
    local title="${1}"
    local options="${2}"
    shift 2
    local menu_items=("$@")

    # Internal variables.
    local item              # Current array item being worked on.
    local key               # The pressed key, also used for building the menu.
    local rc                # Return code.
    local text              # Temporary variable.
    local error_text=""     # Error to present the user.
    local valid_keys=""     # The list of valid keys.
    local -a menu_list      # The rendered menu list to print.
    local -A key_list       # Translate key to return code.
    local -A option_list    # The various options set for the menu.

    # Setup the options.
    option_list[sep]="${_TERM_MENU_SEPARATOR}"
    option_list[prompt]="${_TERM_MENU_PROMPT}"
    option_list[attr]="" # Attributes for the key character in the menu.
    while IFS="" read -r item; do
        [[ -z "${item}" ]] && continue
        case "${item}" in
            sep*)       option_list[sep]="${item:3}";;
            prompt*)    option_list[prompt]="${item:6}";;
            bold)       option_list[attr]+="${TERM_BOLD}";;
            reverse)    option_list[attr]+="${TERM_REVERSE}";;
            underline)  option_list[attr]+="${TERM_UNDERLINE}";;
            *)          option_list[${item}]="${item}";;
        esac
    done <<< "${options//|/$'\n'}"

    # Build the menu.
    for item in "${!menu_items[@]}"; do
        # Check for parameters to the menu item.
        IFS="|" read -r key rc text <<< "${menu_items[$item]}"
        if [[ -z "${rc}" && -z "${text}" ]] ; then
            # No parameters so use the defaults.
            key="$((item + 1))"
            rc="$((item + 1))"
            text="${menu_items[$item]}"
        else
            # Check for empty parameters.
            if [[ -z "${rc}" ]] ; then
                rc="$((item + 1))"
            fi
            if [[ -z "${key}" ]] ; then
                key="$((item + 1))"
            fi
        fi

        # Check that the return code is in range.
        if (( rc > 250 )) ; then
            echo "MENU ERROR: Return code (${rc}) invalid! Must be 250 or less." >&2
            return 255
        fi

        # Save the menu item.
        if [[ "${key}" == "~" && "${text}" != "~" ]] ; then
            # No key, just the text.
            menu_list+=("${text}")
        else
            # Save the key and return code.
            key_list[$key]=$rc
            if [[ "${text}" != "~" ]] ; then
                # There is text to print so save the menu item.
                valid_keys+="${key}"
                if [[ -v option_list[attr] ]] ; then
                    key="${option_list[attr]}${key}${TERM_RESET}"
                fi
                menu_list+=("${key}${option_list[sep]} ${text}")
            fi
        fi
    done

    # Debug data.
    if [[ -v option_list[debug] ]] ; then
        echo -n "DEBUG (Options): " >&2
        declare -p option_list >&2
        echo -n "DEBUG (Menu List): " >&2
        declare -p menu_list >&2
        echo -n "DEBUG (Key RC List): " >&2
        declare -p key_list >&2
        read -rsn1 -p "Press any key to continue..." >&2
    fi

    # Menu loop.
    while true; do
        # Print the menu.
        if [[ -v option_list[clear] ]] ; then
            clear
        fi
        echo "${title}"
        for item in "${menu_list[@]}"; do
            echo "$item"
        done

        # Print the error text if present and quiet is not set.
        if [[ -n "${error_text}" && ! (-v option_list[quiet]) ]] ; then
            echo "ERROR: ${error_text}"
        fi

        # Handle user input.
        read -r -n 1 -p "${option_list[prompt]/\~/${valid_keys}}"
        echo ""
        if [[ -v key_list["${REPLY}"] ]] ; then
            return "${key_list["${REPLY}"]}"
        else
            if [[ -n "${REPLY}" ]] ; then
                error_text="Invalid option ($REPLY)."
            else
                error_text="Please select a key."
            fi
            if [[ -v option_list[one] ]] ; then
                if [[ ! (-v option_list[quiet]) ]] ; then
                    echo "${error_text}"
                fi
                return 251
            else
                echo ""
            fi
        fi
    done
}

# Demonstration menu.
declare -a DEMO_MENU
DEMO_MENU=(
    "Set the separator to: ']'"
    "||Set the separator to: ')'"
    "Set the separator to: ':'"
    "|99|Set the separator to: '=>'"
    "c|100|Toggle the option 'clear'."
    "q|101|Toggle the option 'quiet'."
    "b|110|Toggle printing the key in bold."
    "u|111|Toggle printing the key underlined."
    "r|112|Toggle printing the key reversed."
    "o|120|Toggle the option 'one' for only one try."
    "P|130|Default prompt."
    "p|131|Simple Prompt."
    "D|200|Toggle debug mode."
    "0|0|Exit"
    "~||Press space for a surprise."
    " |250|~" # No text. Just the sideeffect of the key.
    # Common keys to exit the menu.
    "x|0|~"
    "X|0|~"
    # "q|0|~"
    "" # Replaced with the options later.
)

# Allow the user to toggle options.
declare -A DEMO_OPTIONS
DEMO_OPTIONS=(
    [clear]=""
    [prompt]="${_TERM_MENU_PROMPT}"
    [sep]="]"
)

# String of options passed to term::menu().
declare OPTION_STRING

# Toggle an option on or off.
menu_toggle_option(){
    local item="${1}"
    if [[ -v DEMO_OPTIONS[$item] ]] ; then
        unset "DEMO_OPTIONS[${item}]"
    else
        DEMO_OPTIONS[$item]=""
    fi
}

# Build the option string from the options.
menu_build_options(){
    OPTION_STRING=""
    for item in "${!DEMO_OPTIONS[@]}"; do
        OPTION_STRING+="${item}${DEMO_OPTIONS[$item]}|"
    done
}

# A rather contrived example. :shrug:
menu_demo(){
    local rc

    while true; do
        # Present the menu.
        DEMO_MENU[-1]="~||Options: ${OPTION_STRING}"
        term::menu "Test Menu!" "${OPTION_STRING}" "${DEMO_MENU[@]}"
        rc="${?}"
        echo "Returned: ${rc}"

        # Process the result.
        case "${rc}" in
            0) exit;;
            1) DEMO_OPTIONS[sep]="]";;
            2) DEMO_OPTIONS[sep]=")";;
            3) DEMO_OPTIONS[sep]=":";;
            99) DEMO_OPTIONS[sep]="=>";;
            100) menu_toggle_option "clear";;
            101) menu_toggle_option "quiet";;
            110) menu_toggle_option "bold";;
            111) menu_toggle_option "underline";;
            112) menu_toggle_option "reverse";;
            120) menu_toggle_option "one";;
            130) DEMO_OPTIONS[prompt]="${_TERM_MENU_PROMPT}";;
            131) DEMO_OPTIONS[prompt]="Press a key: ";;
            200) menu_toggle_option "debug";;
            250) printf "\nSURPRISE!!!\n";;
        esac

        # Rebuild the options
        menu_build_options
        echo "Options: ${OPTION_STRING}"
        read -rsn1 -p "Press any key to continue..." >&2
        echo ""
    done
}

menu_build_options
menu_demo