#!/usr/bin/env bash

# Test the attribute library.

source "./attr.sh"

echo "Testing attributes:"
echo "Normal ${TERM_ATTR[underline]}Underline${TERM_ATTR[UNDERLINE]} not underlined"
echo "Normal ${TERM_ATTR_BOLD}Bold${TERM_ATTR[sgr0]} not bold"
echo "Normal ${TERM_ATTR_DIM}Dim${TERM_ATTR_RESET} not dim"
