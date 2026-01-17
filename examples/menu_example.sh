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
declare -a library_list=("menu.sh")
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
declare _TERM_LOAD_LIBRARY
for _TERM_LOAD_LIBRARY in "${library_list[@]}"; do
    source "$(find_library "${_TERM_LOAD_LIBRARY}")" || exit 1
done
unset _TERM_LOAD_LIBRARY

# Example menu.
declare -a EXAMPLE_MENU
EXAMPLE_MENU=(
    "Set the separator to: ']'" # Simple, but may not contain '|'.
    "||Set the separator to: ')'" # Still simple, may contain '|'.
    "Set the separator to: ':'"
    "|99|Set the separator to: '=>'" # Different return code.
    ""
    "c|100|Toggle the option 'clear'."
    "q|101|Toggle the option 'quiet'."
    "b|110|Toggle printing the key in bold."
    "u|111|Toggle printing the key underlined."
    "r|112|Toggle printing the key reversed."
    "o|120|Toggle the option 'one' for only one try."
    ""
    "P|130|Default prompt."
    "p|131|Simple Prompt."
    "D|200|Toggle debug mode."
    ""
    "0|0|Exit"
    "~||Press space for a surprise." # Print only the text, no key.
    " |250|~" # No text. Just the side effect of the space key.
    # Common keys to exit the menu.
    "x|0|~"
    "X|0|~"
    "~|~|~" # This should not print.
    "" # Replaced with the options later.
)

# Allow the user to change the options.
declare -A EXAMPLE_OPTIONS
EXAMPLE_OPTIONS=(
    [clear]=""
    [prompt]="${_TERM_MENU_PROMPT}"
    [sep]="]"
)

# String of options passed to term::menu().
declare OPTION_STRING

# Toggle an option on or off.
menu_toggle_option(){
    local item="${1}"
    if [[ -v EXAMPLE_OPTIONS[$item] ]] ; then
        unset "EXAMPLE_OPTIONS[${item}]"
    else
        EXAMPLE_OPTIONS[$item]=""
    fi
}

# Build the option string from the options.
menu_build_options(){
    OPTION_STRING=""
    for item in "${!EXAMPLE_OPTIONS[@]}"; do
        OPTION_STRING+="${item}${EXAMPLE_OPTIONS[$item]}|"
    done
}

# A rather contrived example. :shrug:
menu_example(){
    local rc

    while true; do
        # Present the menu.
        EXAMPLE_MENU[-1]="~||Options: ${OPTION_STRING}"
        term::menu "Test Menu!" "${OPTION_STRING}" "${EXAMPLE_MENU[@]}"
        rc="${?}"
        echo "Returned: ${rc}"

        # Process the result.
        case "${rc}" in
            0) exit;;
            1) EXAMPLE_OPTIONS[sep]="]";;
            2) EXAMPLE_OPTIONS[sep]=")";;
            3) EXAMPLE_OPTIONS[sep]=":";;
            99) EXAMPLE_OPTIONS[sep]="=>";;
            100) menu_toggle_option "clear";;
            101) menu_toggle_option "quiet";;
            110) menu_toggle_option "bold";;
            111) menu_toggle_option "underline";;
            112) menu_toggle_option "reverse";;
            120) menu_toggle_option "one";;
            130) EXAMPLE_OPTIONS[prompt]="${_TERM_MENU_PROMPT}";;
            131) EXAMPLE_OPTIONS[prompt]="Press a key: ";;
            200) menu_toggle_option "debug";;
            250) printf "\nSURPRISE!!!\n";;
            251|252|253|254|255) exit;;
        esac

        # Rebuild the options
        menu_build_options
        echo "Options: ${OPTION_STRING}"
        read -rsn1 -p "Press any key to continue..." >&2
        echo ""
    done
}

menu_build_options
menu_example
