#!/usr/bin/env bash
# shellcheck source=../attr.sh
# shellcheck source=../boxes.sh
# shellcheck source=../color.sh
# shellcheck source=../cursor.sh

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# This generates source-able code for all of the variables defined in the
# libraries.

# You might also want the functions from 'color.sh'.

# Usage:
# TERM=xterm ./export.sh > env_xterm.sh

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
source "$(find_library "boxes.sh")"
source "$(find_library "color.sh")"
source "$(find_library "cursor.sh")"

echo "# Generated: $(date)"
echo "# TERM=${TERM}"
echo ""

echo "# Stores terminal attribute escape sequences."
declare -p "TERM_ATTR"
echo ""

echo "# Stores terminal foreground color escape sequences."
declare -p "TERM_FG"
echo ""

echo "# Stores terminal background color escape sequences."
declare -p "TERM_BG"
echo ""

echo "# Stores terminal cursor escape sequences."
declare -p "TERM_CURSOR"
echo ""

echo "# Shortcut variables."
for name in $(compgen -e TERM_ATTR); do
    declare -p "${name}"
done
for name in $(compgen -e TERM_BG); do
    declare -p "${name}"
done
for name in $(compgen -e TERM_FG); do
    declare -p "${name}"
done
for name in $(compgen -e TERM_CURSOR); do
    declare -p "${name}"
done
