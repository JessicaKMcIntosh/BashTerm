#!/usr/bin/env bash
# shellcheck source=../attr.sh
# shellcheck source=../color.sh

# Example of using the color library.

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
source "$(find_library "color.sh")"

echo "Testing colors:"
for color in "${_TERM_COLORS[@]}"; do
    echo -n "Color ${color} "
    echo -n "${TERM_FG[$color]}Foreground${TERM_ORIG} "
    echo -n "${TERM_FG[$color]}${TERM_DIM}Dim${TERM_RESET} "
    echo -n "${TERM_FG[$color]}${TERM_BOLD}Bold${TERM_RESET} "
    echo -n "${TERM_FG[$color]}${TERM_UNDERLINE}Underline${TERM_RESET} "
    echo -n "${TERM_BG[$color]}Background${TERM_ORIG} "
    echo    "Normal text"
done
