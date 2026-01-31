#!/usr/bin/env bash
# shellcheck source=../attr.sh

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Example of using the attribute library.

# This requires bash version 4.
if ((BASH_VERSINFO[0] < 4)); then
    echo "This script requires Bash 4 or later."
    echo "Current version: ${BASH_VERSION}"
    exit 1
fi

# Load the libraries.
declare -a library_list=("attr.sh")
find_library() {
    local library="${1}"
    local file_name
    for file_name in {../,./}${library}; do
        if [[ -f ${file_name} ]]; then
            echo "${file_name}"
            exit
        fi
    done
    echo "Unable to locate the library '${library}'." >&2
    exit 1
}
#TERM_VERBOSE=0 # Uncomment for verbose library loading.
declare _TERM_LOAD_LIBRARY
# shellcheck disable=SC2167 # Go home Shellcheck, you are drunk.
for _TERM_LOAD_LIBRARY in "${library_list[@]}"; do
    source "$(find_library "${_TERM_LOAD_LIBRARY}")" || exit 1
done
unset _TERM_LOAD_LIBRARY

echo "Testing attributes:"
echo "Normal text ${TERM_BOLD}Bold text${TERM_ATTR[sgr0]} not bold"
echo "Normal text ${TERM_DIM}Dim text${TERM_RESET} not dim"
echo "Normal text ${TERM_INVISIBLE}Invisible text${TERM_RESET} not invisible"
echo "Normal text ${TERM_ITALICS}Italics text${TERM_EXIT_ITALICS} not italics (This is probably not going to work.)"
echo "Normal text ${TERM_ATTR[rev]}Reversed text${TERM_RESET} not reverse"
echo "Normal text ${TERM_STANDOUT}Standout text${TERM_RESET} not standout"
echo "Normal text ${TERM_ATTR[underline]}Underline text${TERM_ATTR[UNDERLINE]} not underlined"
