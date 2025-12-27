#!/usr/bin/env bash

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# This generates source-able code for all of the variables defined in the
# library.

# If you only want to generate the variables once, and for a specific terminal,
# use this script. The result can be sourced to define the variables.

# You might also want the functions from 'color.sh'.

# Usage:
# TERM=xterm ./export.sh > env_xterm.sh

source "./attr.sh"
source "./boxes.sh"
source "./color.sh"
source "./cursor.sh"
source "./function.sh"

echo "# Stores terminal attribute escape sequences."
declare -p "TERM_ATTR"
echo ""

echo "# Stores unicode box drawing characters."
declare -p "TERM_BOX"
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
for name in $(compgen -e | grep '^TERM_'); do
    declare -p "${name}"
done
