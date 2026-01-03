#!/usr/bin/env bash
# shellcheck source=../attr.sh

# Example of using the attribute library.

# Load the library.
find_library(){
    local library="${1}"
    for file_name in {./,../}${library} ; do
        if [[ -f  "${file_name}" ]] ; then
            echo "${file_name}"
        fi
done
}
source "$(find_library "attr.sh")"

echo "Testing attributes:"
echo "Normal text ${TERM_ATTR_BOLD}Bold text${TERM_ATTR[sgr0]} not bold"
echo "Normal text ${TERM_ATTR_DIM}Dim text${TERM_ATTR_RESET} not dim"
echo "Normal text ${TERM_ATTR_INVISIBLE}Invisible text${TERM_ATTR_RESET} not invisible"
echo "Normal text ${TERM_ATTR_ITALICS}Italics text${TERM_ATTR_EXIT_ITALICS} not italics (This is probably not going to work.)"
echo "Normal text ${TERM_ATTR[rev]}Reversed text${TERM_ATTR_RESET} not reverse"
echo "Normal text ${TERM_ATTR_STANDOUT}Standout text${TERM_ATTR_RESET} not standout"
echo "Normal text ${TERM_ATTR[underline]}Underline text${TERM_ATTR[UNDERLINE]} not underlined"
