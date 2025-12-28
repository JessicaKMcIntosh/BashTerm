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
export TERM_BG_BLACK="${TERM_BG[black]}"
export TERM_BG_BLUE="${TERM_BG[blue]}"
export TERM_BG_BRIGHT_BLACK="${TERM_BG[brightblack]}"
export TERM_BG_BRIGHT_BLUE="${TERM_BG[brightblue]}"
export TERM_BG_BRIGHT_CYAN="${TERM_BG[brightcyan]}"
export TERM_BG_BRIGHT_GREEN="${TERM_BG[brightgreen]}"
export TERM_BG_BRIGHT_MAGENTA="${TERM_BG[brightmagenta]}"
export TERM_BG_BRIGHT_RED="${TERM_BG[brightred]}"
export TERM_BG_BRIGHT_WHITE="${TERM_BG[brightwhite]}"
export TERM_BG_BRIGHT_YELLOW="${TERM_BG[brightyellow]}"
export TERM_BG_CYAN="${TERM_BG[cyan]}"
export TERM_BG_GREEN="${TERM_BG[green]}"
export TERM_BG_MAGENTA="${TERM_BG[magenta]}"
export TERM_BG_RED="${TERM_BG[red]}"
export TERM_BG_WHITE="${TERM_BG[white]}"
export TERM_BG_YELLOW="${TERM_BG[yellow]}"
export TERM_FG_BLACK="${TERM_FG[black]}"
export TERM_FG_BLUE="${TERM_FG[blue]}"
export TERM_FG_BRIGHT_BLACK="${TERM_FG[brightblack]}"
export TERM_FG_BRIGHT_BLUE="${TERM_FG[brightblue]}"
export TERM_FG_BRIGHT_CYAN="${TERM_FG[brightcyan]}"
export TERM_FG_BRIGHT_GREEN="${TERM_FG[brightgreen]}"
export TERM_FG_BRIGHT_MAGENTA="${TERM_FG[brightmagenta]}"
export TERM_FG_BRIGHT_RED="${TERM_FG[brightred]}"
export TERM_FG_BRIGHT_WHITE="${TERM_FG[brightwhite]}"
export TERM_FG_BRIGHT_YELLOW="${TERM_FG[brightyellow]}"
export TERM_FG_CYAN="${TERM_FG[cyan]}"
export TERM_FG_GREEN="${TERM_FG[green]}"
export TERM_FG_MAGENTA="${TERM_FG[magenta]}"
export TERM_FG_RED="${TERM_FG[red]}"
export TERM_FG_WHITE="${TERM_FG[white]}"
export TERM_FG_YELLOW="${TERM_FG[yellow]}"
