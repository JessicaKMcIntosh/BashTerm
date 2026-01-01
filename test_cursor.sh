#!/usr/bin/env bash

# Test the cursor library.

source "./cursor.sh"
source "./attr.sh"

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
echo "$TERM_CURSOR_CLR_BOL"

term::move "3" "0"
echo -n "#"
tput smir
echo -n "%"

term::move "10" "0"
