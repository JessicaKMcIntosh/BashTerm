#!/usr/bin/env bash
# shellcheck source=attr.sh

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Demonstrate the library by calling out to various examples.

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

# Scripts to run for the demo.
declare -a DEMO_SCRIPTS
DEMO_SCRIPTS=(
"examples/attr_example.sh"
"examples/boxes_example.sh"
"examples/color_example.sh"
"examples/cursor_example.sh"
"examples/function_example.sh"
"examples/menu_example.sh"
"examples/printf_example.sh"
"examples/spinner_example.sh"
"examples/table.sh"
"./run_tests.sh"
)

# Demo menu.
declare -a DEMO_MENU
DEMO_MENU=(
    "a||Terminal attributes. (attr_example.sh)"
    "b||Box drawing characters. (boxes_example.sh)"
    "c||Terminal colors. (color_example.sh)"
    "u||Cursor movement. (cursor_example.sh)"
    "f||Function interface. (function_example.sh)"
    "m||Menu demonstrating options. (menu_example.sh)"
    "p||Custom printf function. (printf_example.sh)"
    "s||Spin spin. (spinner_example.sh)"
    "t||Color and attribute table. (table.sh)"
    "r||Run the library tests. (run_tests.sh)"
    "q|250|Exit"
    "x|250|~"
    "0|250|~"
)

menu_demo(){
    local options="clear"
    local rc

    while true; do
        # Present the menu.
        term::menu "Library Demo" "${options}" "${DEMO_MENU[@]}"
        rc="${?}"

        # Process the result.
        if [[ "${rc}" == "250" ]]; then
            exit 0
        fi
        ((rc--))
        if [[ -v DEMO_SCRIPTS[$rc] ]]; then
            eval "${DEMO_SCRIPTS[$rc]}"
            read -rsn1 -p "Press any key to continue..."
        fi
    done
}

menu_demo
