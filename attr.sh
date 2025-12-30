#!/usr/bin/env bash

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# A library of useful code for working with terminal attributes.

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
declare -A _TERM_ATTRIBUTES
_TERM_ATTRIBUTES=(
    [clear_screen]="clear"          # clear screen and home cursor
    [enter_bold_mode]="bold"        # turn on bold (extra bright) mode
    [enter_dim_mode]="dim"          # turn on half-bright mode
    [enter_italics_mode]="sitm"     # Enter italic mode
    [enter_reverse_mode]="rev"      # turn on reverse video mode
    [enter_secure_mode]="invis"     # turn on blank mode (characters invisible)
    [enter_standout_mode]="smso"    # begin standout mode
    [enter_underline_mode]="smul"   # begin underline mode
    [exit_attribute_mode]="sgr0"    # turn off all attributes
    [exit_italics_mode]="ritm"      # End italic mode
    [exit_standout_mode]="rmso"     # exit standout mode
    [exit_underline_mode]="rmul"    # exit underline mode
    [orig_pair]="op"                # Set default pair to its original value
)
for attr in "${!_TERM_ATTRIBUTES[@]}"; do
    TERM_ATTR[$attr]="$(tput "${_TERM_ATTRIBUTES[$attr]}")"
    TERM_ATTR[${_TERM_ATTRIBUTES[$attr]}]="${TERM_ATTR[$attr]}"
done

# Attribute aliases.
declare -A _TERM_ATTRIBUTE_ALIASES
_TERM_ATTRIBUTE_ALIASES=(
    [ITALICS]="ritm"
    [STANDOUT]="rmso"
    [UNDERLINE]="rmul"
    [orig]="op"
    [invisible]="invis"
    [italics]="sitm"
    [reset]="sgr0"
    [reverse]="rev"
    [standout]="smso"
    [underline]="smul"
)
for attr in "${!_TERM_ATTRIBUTE_ALIASES[@]}"; do
    TERM_ATTR["${attr}"]="${TERM_ATTR[${_TERM_ATTRIBUTE_ALIASES[$attr]}]}"
done

# Create the shortcut variables.
declare -A _TERM_ATTRIBUTE_SHORTCUTS
_TERM_ATTRIBUTE_SHORTCUTS=(
    [EXIT_ITALICS]="ritm"
    [EXIT_STANDOUT]="rmso"
    [EXIT_UNDERLINE]="rmul"
    [BOLD]="bold"
    [CLEAR]="clear"
    [DIM]="dim"
    [ORIG]="op"
    [INVISIBLE]="invis"
    [ITALICS]="sitm"
    [RESET]="sgr0"
    [REVERSE]="rev"
    [STANDOUT]="smso"
    [UNDERLINE]="smul"
)
for attr in "${!_TERM_ATTRIBUTE_SHORTCUTS[@]}"; do
    declare -x "TERM_ATTR_${attr}=${TERM_ATTR[${_TERM_ATTRIBUTE_SHORTCUTS[$attr]}]}"
done
