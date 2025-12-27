#!/usr/bin/env bash
# shellcheck disable=2034 # These variables will remain unused in this file.

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# A library of unicode box drawing characters.

# See the following resources:
# https://www.compart.com/en/unicode/block/U+2500
# https://en.wikipedia.org/wiki/Box-drawing_characters

# This requires bash version 4.
if [[ "${BASH_VERSINFO[0]}" -lt "4" ]] ; then
    echo "This script requires Bash 4 or later."
    echo "Current version: ${BASH_VERSION}"
    exit 1
fi

# These are the main variables for the Library.
declare -A TERM_BOX     # Stores unicode box drawing characters.

# Variables meaning:
#
# This is what I came up with to make drawing boxes a little easier.
# See the files `all_boxes.sh` and `alt_boxes.sh` for other options.
#
# The first character indicates the type.
# L = Light       eg. │┐┘┌└
# H = Heavy       eg. ┃┓┛┏┗
# D = Double line eg. ║╗╝╔╚
# R = Rounded     eg. │╮╯╭╰
# Rounded is the same as Light, but the corners are rounded.
#
# These are just lines in the given orientation.
# L_LH = Light Line Horizontal '─'
# H_LV = Heavy Line Vertical   '┃'
#
# For the box parts the second two letters indicate the position.
# First Letter:  Vertical Orientation   - T = Top,  M = Middle, B = Bottom
# Second Letter: Horizontal Orientation - L = Left, C = Center, R = Right
#
# L_TL, L_TC, L_TR = Light:      Top Left '┌',    Top Center '┬',    Top Right '┐'
# H_ML, H_MC, H_MR = Heavy:   Middle Left '┣', Middle Center '╋', Middle Right '┫'
# D_BL, D_BC, D_BR = Double:  Bottom Left '╚', Bottom Center '╩', Bottom Right '╝'
# R_BL, R_BC, R_BR = Rounded: Bottom Left '╰', Bottom Center '┴', Bottom Right '╯'

# Light boxes.
TERM_BOX["L_LH"]=$'\u2500'  # ─ Box Drawings Light Horizontal
TERM_BOX["L_LV"]=$'\u2502'  # │ Box Drawings Light Vertical
TERM_BOX["L_TC"]=$'\u252C'  # ┬ Box Drawings Light Down and Horizontal
TERM_BOX["L_TL"]=$'\u250C'  # ┌ Box Drawings Light Down and Right
TERM_BOX["L_TR"]=$'\u2510'  # ┐ Box Drawings Light Down and Left
TERM_BOX["L_ML"]=$'\u251C'  # ├ Box Drawings Light Vertical and Right
TERM_BOX["L_MC"]=$'\u253C'  # ┼ Box Drawings Light Vertical and Horizontal
TERM_BOX["L_MR"]=$'\u2524'  # ┤ Box Drawings Light Vertical and Left
TERM_BOX["L_BC"]=$'\u2534'  # ┴ Box Drawings Light Up and Horizontal
TERM_BOX["L_BL"]=$'\u2514'  # └ Box Drawings Light Up and Right
TERM_BOX["L_BR"]=$'\u2518'  # ┘ Box Drawings Light Up and Left

# Heavy boxes.
TERM_BOX["H_LH"]=$'\u2501'  # ━ Box Drawings Heavy Horizontal
TERM_BOX["H_LV"]=$'\u2503'  # ┃ Box Drawings Heavy Vertical
TERM_BOX["H_TC"]=$'\u2533'  # ┳ Box Drawings Heavy Down and Horizontal
TERM_BOX["H_TL"]=$'\u250F'  # ┏ Box Drawings Heavy Down and Right
TERM_BOX["H_TR"]=$'\u2513'  # ┓ Box Drawings Heavy Down and Left
TERM_BOX["H_ML"]=$'\u2523'  # ┣ Box Drawings Heavy Vertical and Right
TERM_BOX["H_MC"]=$'\u254B'  # ╋ Box Drawings Heavy Vertical and Horizontal
TERM_BOX["H_MR"]=$'\u252B'  # ┫ Box Drawings Heavy Vertical and Left
TERM_BOX["H_BC"]=$'\u253B'  # ┻ Box Drawings Heavy Up and Horizontal
TERM_BOX["H_BL"]=$'\u2517'  # ┗ Box Drawings Heavy Up and Right
TERM_BOX["H_BR"]=$'\u251B'  # ┛ Box Drawings Heavy Up and Left

# Double boxes.
TERM_BOX["D_LH"]=$'\u2550'  # ═ Box Drawings Double Horizontal
TERM_BOX["D_LV"]=$'\u2551'  # ║ Box Drawings Double Vertical
TERM_BOX["D_TC"]=$'\u2566'  # ╦ Box Drawings Double Down and Horizontal
TERM_BOX["D_TL"]=$'\u2554'  # ╔ Box Drawings Double Down and Right
TERM_BOX["D_TR"]=$'\u2557'  # ╗ Box Drawings Double Down and Left
TERM_BOX["D_ML"]=$'\u2560'  # ╠ Box Drawings Double Vertical and Right
TERM_BOX["D_MC"]=$'\u256C'  # ╬ Box Drawings Double Vertical and Horizontal
TERM_BOX["D_MR"]=$'\u2563'  # ╣ Box Drawings Double Vertical and Left
TERM_BOX["D_BC"]=$'\u2569'  # ╩ Box Drawings Double Up and Horizontal
TERM_BOX["D_BL"]=$'\u255A'  # ╚ Box Drawings Double Up and Right
TERM_BOX["D_BR"]=$'\u255D'  # ╝ Box Drawings Double Up and Left

# Rounded light boxes.
TERM_BOX["R_LH"]=$'\u2500'  # ─ Box Drawings Light Horizontal
TERM_BOX["R_LV"]=$'\u2502'  # │ Box Drawings Light Vertical
TERM_BOX["R_TC"]=$'\u252C'  # ┬ Box Drawings Light Down and Horizontal
TERM_BOX["R_TL"]=$'\u256D'  # ╭ Box Drawings Light Arc Down and Right
TERM_BOX["R_TR"]=$'\u256E'  # ╮ Box Drawings Light Arc Down and Left
TERM_BOX["R_ML"]=$'\u251C'  # ├ Box Drawings Light Vertical and Right
TERM_BOX["R_MC"]=$'\u253C'  # ┼ Box Drawings Light Vertical and Horizontal
TERM_BOX["R_MR"]=$'\u2524'  # ┤ Box Drawings Light Vertical and Left
TERM_BOX["R_BC"]=$'\u2534'  # ┴ Box Drawings Light Up and Horizontal
TERM_BOX["R_BL"]=$'\u2570'  # ╰ Box Drawings Light Arc Up and Right
TERM_BOX["R_BR"]=$'\u256F'  # ╯ Box Drawings Light Arc Up and Left

