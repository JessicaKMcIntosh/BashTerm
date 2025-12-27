#!/usr/bin/env bash

# Test the attribute library.

source "./attr.sh"

echo "Testing attributes:"
echo "Normal text ${TERM_ATTR_BOLD}Bold text${TERM_ATTR[sgr0]} not bold"
echo "Normal text ${TERM_ATTR_DIM}Dim text${TERM_ATTR_RESET} not dim"
echo "Normal text ${TERM_ATTR_INVISIBLE}Invisible text${TERM_ATTR_RESET} not invisible"
echo "Normal text ${TERM_ATTR_ITALICS}Italics text${TERM_ATTR_EXIT_ITALICS} not italics (This is probably not going to work.)"
echo "Normal text ${TERM_ATTR[rev]}Reversed text${TERM_ATTR_RESET} not reverse"
echo "Normal text ${TERM_ATTR_STANDOUT}Standout text${TERM_ATTR_RESET} not standout"
echo "Normal text ${TERM_ATTR[underline]}Underline text${TERM_ATTR[UNDERLINE]} not underlined"
