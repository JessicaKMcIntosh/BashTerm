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

# Only load the library once.
declare -A _TERM_LOADED # Track loaded files.
declare _TERM_FILE_NAME="${BASH_SOURCE[0]##*/}"
if [[ -v _TERM_LOADED[${_TERM_FILE_NAME}] ]] ; then
    [[ -v TERM_VERBOSE ]] && echo "Already loaded '${_TERM_FILE_NAME}'."
    return 0
fi
_TERM_LOADED[${_TERM_FILE_NAME}]="${BASH_SOURCE[0]}"
[[ -v TERM_VERBOSE ]] && echo "Loading '${_TERM_FILE_NAME}'..."
unset _TERM_FILE_NAME

# These are the main variables for the Library.
declare -A TERM_FG      # Stores terminal foreground color escape sequences.
declare -A TERM_BG      # Stores terminal background color escape sequences.

# Temporary variables that are unset at the end of the script.
declare _TERM_TEMP_COLOR

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
for _TERM_TEMP_COLOR in "${!_TERM_COLORS[@]}"; do
    TERM_FG[${_TERM_COLORS[$_TERM_TEMP_COLOR]}]="$(tput setaf "${_TERM_TEMP_COLOR}")"
    TERM_FG[${_TERM_TEMP_COLOR}]="${TERM_FG[${_TERM_COLORS[$_TERM_TEMP_COLOR]}]}"
done
for _TERM_TEMP_COLOR in "${!_TERM_COLORS[@]}"; do
    TERM_BG[${_TERM_COLORS[$_TERM_TEMP_COLOR]}]="$(tput setab "${_TERM_TEMP_COLOR}")"
    TERM_BG[${_TERM_TEMP_COLOR}]="${TERM_BG[${_TERM_COLORS[$_TERM_TEMP_COLOR]}]}"
done

# Color aliases.
declare -A _TERM_COLOR_ALIASES
_TERM_COLOR_ALIASES=(
    [gray]="brightblack"
    [grey]="brightblack"
)
for _TERM_TEMP_COLOR in "${!_TERM_COLOR_ALIASES[@]}"; do
    TERM_FG[${_TERM_TEMP_COLOR}]="${TERM_FG[${_TERM_COLOR_ALIASES[$_TERM_TEMP_COLOR]}]}"
    TERM_BG[${_TERM_TEMP_COLOR}]="${TERM_BG[${_TERM_COLOR_ALIASES[$_TERM_TEMP_COLOR]}]}"
done

# Some handy shortcuts for less typing.
for _TERM_TEMP_COLOR in "${_TERM_COLORS[@]}"; do
    declare -x "TERM_FG_${_TERM_TEMP_COLOR^^}=${TERM_FG[$_TERM_TEMP_COLOR]}"
    declare -x "TERM_BG_${_TERM_TEMP_COLOR^^}=${TERM_BG[$_TERM_TEMP_COLOR]}"
done

# Remove the temporary variables.
unset _TERM_TEMP_COLOR
