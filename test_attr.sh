#!/usr/bin/env bash

# Test the attribute library.

source "./attr.sh"

echo "Testing attributes:"
echo "Normal text ${TERM_ATTR[underline]}Underline text${TERM_ATTR[UNDERLINE]} not underlined"
echo "Normal text ${TERM_ATTR_BOLD}Bold text${TERM_ATTR[sgr0]} not bold"
echo "Normal text ${TERM_ATTR_DIM}Dim text${TERM_ATTR_RESET} not dim"
