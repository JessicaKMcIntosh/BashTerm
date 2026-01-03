#!/usr/bin/env bash
# shellcheck source=../attr.sh
# shellcheck source=../cursor.sh

# Example of using the cursor library.

# Load the libraries.
find_library(){
    local library="${1}"
    for file_name in {./,../}${library} ; do
        if [[ -f  "${file_name}" ]] ; then
            echo "${file_name}"
        fi
done
}
source "$(find_library "attr.sh")"
source "$(find_library "cursor.sh")"

echo -n "${TERM_ATTR_CLEAR}"

echo -n "Cursor position: "
term::pos
echo -n "Cursor row: "
term::row
echo -n "Cursor column: "
term::col
echo -n "Terminal columns: "
term::cols
echo -n "Terminal lines: "
term::lines

term::move "2" "2"
echo "$TERM_ATTR_CLR_BOL"

term::move "3" "0"
echo -n "#"
tput smir
echo -n "%"

term::move "10" "0"
