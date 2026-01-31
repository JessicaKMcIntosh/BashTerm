#!/usr/bin/env bash
# shellcheck source=../attr.sh
# shellcheck source=../cursor.sh

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Example of using the cursor library.

@define LIBRARY_LIST @EXAMPLE_LIBRARIES@
@include load_libraries.sh

echo -n "${TERM_CLEAR}"

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
echo "${TERM_CLR_BOL}"

term::move "3" "0"
echo -n "#"
echo -n "${TERM_INSERT}"
echo -n "%"
echo -n "${TERM_EXIT_INSERT}"

term::move "10" "0"

echo -n "${TERM_RESET}"
