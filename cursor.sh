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

# Temporary variables that are unset at the end of the script.
declare _TERM_TEMP_ATTR
declare _TERM_TEMP_CODE

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
    # [insert_character]="ich1"   # insert character (Rarely present.)
    [insert_line]="il1"         # insert line
    [left]="cub1"               # move left one space
    [normal]="cnorm"            # make cursor appear normal (undo civis/cvvis)
    [restore]="rc"              # restore cursor to position of last
    [right]="cuf1"              # non-destructive space (move right one space)
    [save]="sc"                 # save current cursor
    [show]="cvvis"              # make cursor very visible
    # [to_ll]="ll"                # last line, first column (if no cup) (Rarely present.)
    [up]="cuu1"                 # up one line
    [visible]="cvvis"           # make cursor very visible
)
for _TERM_TEMP_ATTR in "${!_TERM_CURSOR_ATTRIBUTES[@]}"; do
    if _TERM_TEMP_CODE="$(tput "${_TERM_CURSOR_ATTRIBUTES[$_TERM_TEMP_ATTR]}")" ; then
        TERM_CURSOR[$_TERM_TEMP_ATTR]="${_TERM_TEMP_CODE}"
        TERM_CURSOR[${_TERM_CURSOR_ATTRIBUTES[$_TERM_TEMP_ATTR]}]="${_TERM_TEMP_CODE}"
    else
        echo "WARNING: This terminal does not support the capability: ${_TERM_CURSOR_ATTRIBUTES[$_TERM_TEMP_ATTR]}"
        unset "TERM_ATTR[$_TERM_TEMP_ATTR]"
    fi
done

# Some handy shortcuts for less typing.
declare -A _TERM_CURSOR_SHORTCUTS
_TERM_CURSOR_SHORTCUTS=(
    [CLR_BOL]="el1"
    [CLR_EOL]="el"
    [CLR_EOS]="ed"
    [DELETE_CHAR]="dch1"
    [DELETE_LINE]="dl1"
    [DOWN]="cud1"
    [HIDE]="civis"
    [HOME]="home"
    # [INSERT_CHAR]="ich1" # (Rarely present.)
    [INSERT_LINE]="il1"
    [LEFT]="cub1"
    [NORMAL]="cnorm"
    [RESTORE]="rc"
    [RIGHT]="cuf1"
    [SAVE]="sc"
    [SHOW]="cvvis"
    # [TO_LL]="ll" # (Rarely present.)
    [UP]="cuu1"
    [VISIBLE]="cvvis"
)
for _TERM_TEMP_ATTR in "${!_TERM_CURSOR_SHORTCUTS[@]}"; do
    declare -x "TERM_${_TERM_TEMP_ATTR}=${TERM_CURSOR[${_TERM_CURSOR_SHORTCUTS[$_TERM_TEMP_ATTR]}]}"
done

# Remove the temporary variables.
unset _TERM_TEMP_ATTR
unset _TERM_TEMP_CODE

# Functions for cursor positions.

# Move the cursor to an row and column position.
# Can accept row and column as separate values or as
# as a single "ROW;COLUMN" value as returned by term::pos().
term::move(){
    local row="${1-0}"
    local col="${2-0}"

    # If the row contains a ; and the column is 0 just use the row value.
    if [[ "${row}" =~ ";" && "${col}" -eq 0 ]] ; then
        tput cup "${row}"
    else
        tput cup "${row}" "${col}"
    fi
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

