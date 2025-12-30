#!/usr/bin/env bash

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# A library of useful code for working with terminal colors.

# See 'man 5 terminfo' for more information.

# This requires bash version 4.
if [[ "${BASH_VERSINFO[0]}" -lt "4" ]] ; then
    echo "This script requires Bash 4 or later."
    echo "Current version: ${BASH_VERSION}"
    exit 1
fi

# These are the main variables for the Library.
declare -A TERM_FG      # Stores terminal foreground color escape sequences.
declare -A TERM_BG      # Stores terminal background color escape sequences.

# Terminal colors.
declare -a _TERM_COLORS
_TERM_COLORS=(
    "black"
    "red"
    "green"
    "yellow"
    "blue"
    "magenta"
    "cyan"
    "white"
    "brightblack"
    "brightred"
    "brightgreen"
    "brightyellow"
    "brightblue"
    "brightmagenta"
    "brightcyan"
    "brightwhite"
)

# Set the color codes in the variables.
for color in "${!_TERM_COLORS[@]}"; do
    TERM_FG[${_TERM_COLORS[$color]}]="$(tput setaf "${color}")"
    TERM_FG[${color}]="${TERM_FG[${_TERM_COLORS[$color]}]}"
done
for color in "${!_TERM_COLORS[@]}"; do
    TERM_BG[${_TERM_COLORS[$color]}]="$(tput setab "${color}")"
    TERM_BG[${color}]="${TERM_BG[${_TERM_COLORS[$color]}]}"
done

# Color aliases.
declare -A _TERM_COLOR_ALIASES
_TERM_COLOR_ALIASES=(
    [gray]="brightblack"
    [grey]="brightblack"
)
for color in "${!_TERM_COLOR_ALIASES[@]}"; do
    _TERM_COLORS["${color}"]="${_TERM_COLORS[${_TERM_COLOR_ALIASES[$color]}]}"
done

# Some handy shortcuts for less typing.
for color in "${_TERM_COLORS[@]}"; do
    declare -x "TERM_FG_${color^^}=${TERM_FG[$color]}"
    declare -x "TERM_BG_${color^^}=${TERM_BG[$color]}"
done

