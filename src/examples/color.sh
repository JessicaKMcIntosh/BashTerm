#!/usr/bin/env bash
# shellcheck source=../attr.sh
# shellcheck source=../color.sh

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Example of using the color library.

@define LIBRARY_LIST @EXAMPLE_LIBRARIES@
@include load_libraries.sh

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
