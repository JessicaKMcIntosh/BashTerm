#!/usr/bin/env bash

# Test the color library.

source "./attr.sh"
source "./color.sh"

echo "Testing colors:"
for color in "${_TERM_COLORS[@]}"; do
    echo -n "Color ${color} "
    echo -n "${TERM_FG[$color]}Foreground${TERM_ATTR_ORIG} "
    echo -n "${TERM_FG[$color]}${TERM_ATTR_DIM}Dim${TERM_ATTR_RESET} "
    echo -n "${TERM_FG[$color]}${TERM_ATTR_BOLD}Bold${TERM_ATTR_RESET} "
    echo -n "${TERM_FG[$color]}${TERM_ATTR_UNDERLINE}Underline${TERM_ATTR_RESET} "
    echo -n "${TERM_BG[$color]}Background${TERM_ATTR_ORIG} "
    echo    "Normal text"
done
