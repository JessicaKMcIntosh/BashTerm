#!/usr/bin/env bash

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# A library of useful code for working with terminal attributes.
#
# Provides a variable interface to the terminal capabilities.
# For every attribute tput is called to generate and save the escape codes
# ahead of time.
# This could add undesired delays to loading the script.
# But it does have the advantabe of using variables
# And tput is only called once per escape code.
#
# See the file 'colors.sh' for the same interface for terminal colors.

# Customization:
# Add or remove to these arrays to customize your setup.
# For example remove attributes you don't need, or add your favorite.
# _TERM_ATTRIBUTES - The attributes to fetch escape codes for.
# _TERM_ATTRIBUTE_ALIASES - Aliasses to add to the TERM_ATTR array.

# See 'man 5 terminfo' for more information.

# This requires bash version 4.
if [[ "${BASH_VERSINFO[0]}" -lt "4" ]] ; then
    echo "This script requires Bash 4 or later."
    echo "Current version: ${BASH_VERSION}"
    exit 1
fi

# These are the main variables for the Library.
declare -A TERM_ATTR    # Stores terminal attribute escape sequences.

# Typical terminal attributes.
declare -a _TERM_ATTRIBUTES
_TERM_ATTRIBUTES=(
    "bold"
    "clear"
    "dim"
    "op"
    "rev"
    "ritm"
    "rmso"
    "rmul"
    "sgr0"
    "sitm"
    "smso"
    "smul"
)
for attr in "${_TERM_ATTRIBUTES[@]}"; do
    TERM_ATTR[$attr]="$(tput "${attr}")"
done

# Attribute aliases.
declare -A _TERM_ATTRIBUTE_ALIASES
_TERM_ATTRIBUTE_ALIASES=(
    [ITALICS]="ritm"
    [STANDOUT]="rmso"
    [UNDERLINE]="rmul"
    [default]="op"
    [default_color]="op"
    [italics]="sitm"
    [reset]="sgr0"
    [reverse]="rev"
    [standout]="smso"
    [underline]="smul"
)
for attr in "${!_TERM_ATTRIBUTE_ALIASES[@]}"; do
    TERM_ATTR["${attr}"]="${TERM_ATTR[${_TERM_ATTRIBUTE_ALIASES[$attr]}]}"
done

# Some handy shortcuts for less typing.
export TERM_ATTR_BOLD="${TERM_ATTR[bold]}"
export TERM_ATTR_CLEAR="${TERM_ATTR[clear]}"
export TERM_ATTR_DEFAULT="${TERM_ATTR[default_color]}"
export TERM_ATTR_DIM="${TERM_ATTR[dim]}"
export TERM_ATTR_EXIT_ITALICS="${TERM_ATTR[ITALICS]}"
export TERM_ATTR_EXIT_STANDOUT="${TERM_ATTR[STANDOUT]}"
export TERM_ATTR_EXIT_UNDERLINE="${TERM_ATTR[UNDERLINE]}"
export TERM_ATTR_ITALICS="${TERM_ATTR[italics]}"
export TERM_ATTR_RESET="${TERM_ATTR[reset]}"
export TERM_ATTR_REVERSE="${TERM_ATTR[reverse]}"
export TERM_ATTR_STANDOUT="${TERM_ATTR[standout]}"
export TERM_ATTR_UNDERLINE="${TERM_ATTR[underline]}"

