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
for library in "${library_list[@]}"; do
    source "$(find_library "${library}")" > /dev/null 2>&1 || exit 1
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
#   reverse     - The key text is printed in reverse.
#   sep         - The key and text separator text follows.
#                 For example "sep =>" results in "0 => Menu Text."
#   underline   - The key text is printed underlined.
# Returns:'
#   The item selected in the exit status.
#   All return codes MUST be less than or equal to 250.
#   251 - Invalid key entered and option "O" was given.
#   252 - Insufficient args passed.
#   255 - Error while building the menu.
# Notes:
#   The character "~" is used because it is uncommon and unlikely to appear in menu text.
term::menu() {
    if [[ "${#}" -lt "3" ]] ; then
        echo "INSUFFICIENT PARAMETERS PASSED!!!" >&2
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
    local -a scratch        # Scratch array.
    local -A option_list    # The various options set for the menu.

    # Setup the options.
    option_list[sep]="${_TERM_MENU_SEPARATOR}"
    option_list[prompt]="${_TERM_MENU_PROMPT}"
    mapfile -t -d "|" scratch < <(echo -n "${options}")
    for item in "${scratch[@]}"; do
        case "${item}" in
            sep*)   option_list[sep]="${item:3}";;
            prompt*)   option_list[prompt]="${item:6}";;
            *)      option_list[${item}]="${item}";;
        esac
    done

    # Build the menu.
    for item in "${!menu_items[@]}"; do
        # Defaults.
        key="$((item + 1))"
        rc="$((item + 1))"
        text="${menu_items[$item]}"

        # Check for parameters to the menu item.
        mapfile -t -d "|" scratch < <(echo -n "${menu_items[$item]}")
        if [[ "${#scratch[@]}" -gt "1" ]] ; then
            if [[ -n "${scratch[0]}" ]] ; then
                key="${scratch[0]}"
            fi
            if [[ "${#scratch[@]}" -gt "2" && -n "${scratch[1]}" ]] ; then
                rc="${scratch[1]}"
            fi
            text="${scratch[-1]}" # The menu item text is the last array element.
        fi

        # Check the return code.
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
                # there is text to print.
                valid_keys+="${key}"
                if [[ -v option_list[bold] ]] ; then
                    key="${TERM_BOLD}${key}${TERM_RESET}"
                elif [[ -v option_list[underline] ]] ; then
                    key="${TERM_UNDERLINE}${key}${TERM_RESET}"
                elif [[ -v option_list[reverse] ]] ; then
                    key="${TERM_REVERSE}${key}${TERM_RESET}"
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
        if [[ -n "${error_text}" ]] ; then
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
                echo "${error_text}"
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
    "||Set the separator to: ']'"
    "||Set the separator to: ':'"
    "|99|Set the separator to: '=>'"
    "c|100|Toggle the option 'clear'."
    "b|110|Toggle printing the key in bold."
    "u|111|Toggle printing the key underlined."
    "r|112|Toggle printing the key reversed."
    "o|120|Toggle the option 'one' for only one try."
    "P|130|Default prompt."
    "p|131|Simple Prompt."
    "D|200|Toggle debug mode."
    "0|0|Exit"
    "Press space for a surprise."
    " |250|~"
)

declare -A DEMO_OPTIONS
DEMO_OPTIONS=(
    [clear]=""
    [prompt]="${_TERM_MENU_PROMPT}"
    [sep]="]"
)

declare OPTION_STRING

menu_toggle_option(){
    local item="${1}"
    [[ -v DEMO_OPTIONS[$item] ]] && unset "DEMO_OPTIONS[${item}]" || DEMO_OPTIONS[$item]=""
}

menu_build_options(){
    OPTION_STRING=""
    for item in "${!DEMO_OPTIONS[@]}"; do
        OPTION_STRING+="${item}${DEMO_OPTIONS[$item]}|"
    done
}

menu_demo(){
    local item

    while true; do

        # Present the menu.
        term::menu "Test Menu!" "${OPTION_STRING}" "${DEMO_MENU[@]}"
        RC="${?}"
        echo "Returned: ${RC}"

        # Process the result.
        case "${RC}" in
            0) exit;;
            1) DEMO_OPTIONS[sep]="]";;
            2) DEMO_OPTIONS[sep]=":";;
            99) DEMO_OPTIONS[sep]="=>";;
            100) menu_toggle_option "clear";;
            110) menu_toggle_option "bold";;
            111) menu_toggle_option "underline";;
            112) menu_toggle_option "reverse";;
            120) menu_toggle_option "one";;
            130) DEMO_OPTIONS[prompt]="${_TERM_MENU_PROMPT}";;
            131) DEMO_OPTIONS[prompt]="Press a key: ";;
            200) menu_toggle_option "debug";;
        esac

        # Rebuild the options
        menu_build_options
        echo "Options: ${OPTION_STRING}"
        read -rsn1 -p "Press any key to continue..." >&2
    done
}

menu_build_options
menu_demo