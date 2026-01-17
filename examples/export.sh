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

# Usage:
# TERM=xterm ./export.sh > env_xterm.sh

# Load the libraries.
declare -a library_list=("attr.sh" "boxes.sh" "color.sh" "cursor.sh")
find_library(){
    local library="${1}"
    local file_name
    for file_name in {../,./}${library} ; do
        if [[ -f  "${file_name}" ]] ; then
            echo "${file_name}"
            exit
        fi
    done
    echo "Unable to locate the library '${library}'." >&2
    exit 1
}
#TERM_VERBOSE=0 # Uncomment for verbose library loading.
declare _TERM_LOAD_LIBRARY
for _TERM_LOAD_LIBRARY in "${library_list[@]}"; do
    source "$(find_library "${_TERM_LOAD_LIBRARY}")" || exit 1
done
unset _TERM_LOAD_LIBRARY

echo "# Generated: $(date)"
echo "# TERM=${TERM}"
echo "# System: $(uname -s -r -m -o)"
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
for name in $(compgen -e TERM_); do
    declare -p "${name}"
done
for name in $(compgen -e TERM_BG); do
    declare -p "${name}"
done
for name in $(compgen -e TERM_FG); do
    declare -p "${name}"
done
echo ""

echo "# Functions."
for name in $(compgen -A function term::); do
    declare -f "${name}"
done
