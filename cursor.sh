#!/usr/bin/env bash
# shellcheck disable=2034 # These variables will remain unused in this file.

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# A library of useful code for working with terminal cursors.
#
# Provides a variable and functional interface to the terminal cursor capabilities.
# For variables tput is called once per attribute to save the escape code.
# This could add undesired delays to loading the script.
# But it does have the advantage of using variables and tput is only called once.
# Functions either print the variable or call tput.

# Customization:
# Change the array _TERM_CURSOR_ATTRIBUTES to customize the attributes to fetch
# escape codes for.

# See 'man 5 terminfo' for more information.

# This requires bash version 4.
if [[ "${BASH_VERSINFO[0]}" -lt "4" ]] ; then
    echo "This script requires Bash 4 or later."
    echo "Current version: ${BASH_VERSION}"
    exit 1
fi

# These are the main variables for the Library.
declare -A TERM_CURSOR  # Stores terminal cursor escape sequences.

# Typical terminal cursor attributes.
# Descriptions and names are from 'man 5 terminfo'.
declare -A _TERM_CURSOR_ATTRIBUTES
_TERM_CURSOR_ATTRIBUTES=(
    [clr_bol]="el1"             # Clear to beginning of line
    [clr_eol]="el"              # clear to end of line
    [clr_eos]="ed"              # clear to end of screen
    [delete_character]="dch1"   # delete character
    [delete_line]="dl1"         # delete line
    [down]="cud1"               # down one line
    [hide]="civis"              # make cursor invisible
    [home]="home"               # home cursor (if no cup)
    [insert_character]="ich1"   # insert character
    [insert_line]="il1"         # insert line
    [invisible]="civis"         # make cursor invisible
    [left]="cub1"               # move left one space
    [normal]="cnorm"            # make cursor appear normal (undo civis/cvvis)
    [restore]="rc"              # restore cursor to position of last
    [right]="cuf1"              # non-destructive space (move right one space)
    [save]="sc"                 # save current cursor
    [show]="cvvis"              # make cursor very visible
    [to_ll]="ll"                # last line, first column (if no cup)
    [up]="cuu1"                 # up one line
    [visible]="cvvis"           # make cursor very visible
)
for attr in "${!_TERM_CURSOR_ATTRIBUTES[@]}"; do
    TERM_CURSOR[$attr]="$(tput setaf "${_TERM_CURSOR_ATTRIBUTES[$attr]}")"
    TERM_CURSOR[${_TERM_CURSOR_ATTRIBUTES[$attr]}]="${TERM_CURSOR[$attr]}"
done

# Some handy shortcuts for less typing.
export TERM_CURSOR_CLR_BOL="${TERM_CURSOR[clr_bol]}"
export TERM_CURSOR_CLR_EOL="${TERM_CURSOR[clr_eol]}"
export TERM_CURSOR_CLR_EOS="${TERM_CURSOR[clr_eos]}"
export TERM_CURSOR_DELETE_CHAR="${TERM_CURSOR[delete_character]}"
export TERM_CURSOR_DELETE_LINE="${TERM_CURSOR[delete_line]}"
export TERM_CURSOR_DOWN="${TERM_CURSOR[down]}"
export TERM_CURSOR_HIDE="${TERM_CURSOR[hide]}"
export TERM_CURSOR_HOME="${TERM_CURSOR[home]}"
export TERM_CURSOR_INSERT_CHAR="${TERM_CURSOR[insert_character]}"
export TERM_CURSOR_INSERT_LINE="${TERM_CURSOR[insert_line]}"
export TERM_CURSOR_INVISIBLE="${TERM_CURSOR[invisible]}"
export TERM_CURSOR_LEFT="${TERM_CURSOR[left]}"
export TERM_CURSOR_NORMAL="${TERM_CURSOR[normal]}"
export TERM_CURSOR_RESTORE="${TERM_CURSOR[restore]}"
export TERM_CURSOR_RIGHT="${TERM_CURSOR[right]}"
export TERM_CURSOR_SAVE="${TERM_CURSOR[save]}"
export TERM_CURSOR_SHOW="${TERM_CURSOR[show]}"
export TERM_CURSOR_TO_LL="${TERM_CURSOR[to_ll]}"
export TERM_CURSOR_UP="${TERM_CURSOR[up]}"
export TERM_CURSOR_VISIBLE="${TERM_CURSOR[visible]}"

# Functions for cursor positions.

# Move the cursor to an row and column position.
term::move(){
    local row="${1-0}"
    local col="${2-0}"
    tput cup "${row}" "${col}"
}

# Report the cursor position. row;col
term::pos(){
    local position
    # shellcheck disable=SC2162 # There are no backslashes to mangle.
    read -sdR -p "$(tput u7)" position
    position="${position#*[}" # Strip the escape.
    echo "${position}"
}

# Report the cursor row.
term::row(){
    local column
    local row
    # shellcheck disable=SC2162 # There are no backslashes to mangle.
    IFS=';' read -sdR -p "$(tput u7)" row column
    row="${row#*[}" # Strip the escape.
    echo "${row}"
}

# Report the cursor column.
term::col(){
    local column
    local row
    # shellcheck disable=SC2162 # There are no backslashes to mangle.
    IFS=';' read -sdR -p "$(tput u7)" row column
    echo "${column}"
}

# Report the number of columns the terminal has.
term::cols(){
    local cols
    cols="$(tput cols)"
    echo "${cols}"
}

# Report the number of lines the terminal has.
term::lines(){
    local lines
    lines="$(tput lines)"
    echo "${lines}"
}

