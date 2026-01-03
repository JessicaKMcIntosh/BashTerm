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
export TERM_BOX_L_LH=$'\u2500'  # ─ Box Drawings Light Horizontal
export TERM_BOX_L_LV=$'\u2502'  # │ Box Drawings Light Vertical
export TERM_BOX_L_TC=$'\u252C'  # ┬ Box Drawings Light Down and Horizontal
export TERM_BOX_L_TL=$'\u250C'  # ┌ Box Drawings Light Down and Right
export TERM_BOX_L_TR=$'\u2510'  # ┐ Box Drawings Light Down and Left
export TERM_BOX_L_ML=$'\u251C'  # ├ Box Drawings Light Vertical and Right
export TERM_BOX_L_MC=$'\u253C'  # ┼ Box Drawings Light Vertical and Horizontal
export TERM_BOX_L_MR=$'\u2524'  # ┤ Box Drawings Light Vertical and Left
export TERM_BOX_L_BC=$'\u2534'  # ┴ Box Drawings Light Up and Horizontal
export TERM_BOX_L_BL=$'\u2514'  # └ Box Drawings Light Up and Right
export TERM_BOX_L_BR=$'\u2518'  # ┘ Box Drawings Light Up and Left

# Heavy boxes.
export TERM_BOX_H_LH=$'\u2501'  # ━ Box Drawings Heavy Horizontal
export TERM_BOX_H_LV=$'\u2503'  # ┃ Box Drawings Heavy Vertical
export TERM_BOX_H_TC=$'\u2533'  # ┳ Box Drawings Heavy Down and Horizontal
export TERM_BOX_H_TL=$'\u250F'  # ┏ Box Drawings Heavy Down and Right
export TERM_BOX_H_TR=$'\u2513'  # ┓ Box Drawings Heavy Down and Left
export TERM_BOX_H_ML=$'\u2523'  # ┣ Box Drawings Heavy Vertical and Right
export TERM_BOX_H_MC=$'\u254B'  # ╋ Box Drawings Heavy Vertical and Horizontal
export TERM_BOX_H_MR=$'\u252B'  # ┫ Box Drawings Heavy Vertical and Left
export TERM_BOX_H_BC=$'\u253B'  # ┻ Box Drawings Heavy Up and Horizontal
export TERM_BOX_H_BL=$'\u2517'  # ┗ Box Drawings Heavy Up and Right
export TERM_BOX_H_BR=$'\u251B'  # ┛ Box Drawings Heavy Up and Left

# Double boxes.
export TERM_BOX_D_LH=$'\u2550'  # ═ Box Drawings Double Horizontal
export TERM_BOX_D_LV=$'\u2551'  # ║ Box Drawings Double Vertical
export TERM_BOX_D_TC=$'\u2566'  # ╦ Box Drawings Double Down and Horizontal
export TERM_BOX_D_TL=$'\u2554'  # ╔ Box Drawings Double Down and Right
export TERM_BOX_D_TR=$'\u2557'  # ╗ Box Drawings Double Down and Left
export TERM_BOX_D_ML=$'\u2560'  # ╠ Box Drawings Double Vertical and Right
export TERM_BOX_D_MC=$'\u256C'  # ╬ Box Drawings Double Vertical and Horizontal
export TERM_BOX_D_MR=$'\u2563'  # ╣ Box Drawings Double Vertical and Left
export TERM_BOX_D_BC=$'\u2569'  # ╩ Box Drawings Double Up and Horizontal
export TERM_BOX_D_BL=$'\u255A'  # ╚ Box Drawings Double Up and Right
export TERM_BOX_D_BR=$'\u255D'  # ╝ Box Drawings Double Up and Left

# Rounded light boxes.
export TERM_BOX_R_LH=$'\u2500'  # ─ Box Drawings Light Horizontal
export TERM_BOX_R_LV=$'\u2502'  # │ Box Drawings Light Vertical
export TERM_BOX_R_TC=$'\u252C'  # ┬ Box Drawings Light Down and Horizontal
export TERM_BOX_R_TL=$'\u256D'  # ╭ Box Drawings Light Arc Down and Right
export TERM_BOX_R_TR=$'\u256E'  # ╮ Box Drawings Light Arc Down and Left
export TERM_BOX_R_ML=$'\u251C'  # ├ Box Drawings Light Vertical and Right
export TERM_BOX_R_MC=$'\u253C'  # ┼ Box Drawings Light Vertical and Horizontal
export TERM_BOX_R_MR=$'\u2524'  # ┤ Box Drawings Light Vertical and Left
export TERM_BOX_R_BC=$'\u2534'  # ┴ Box Drawings Light Up and Horizontal
export TERM_BOX_R_BL=$'\u2570'  # ╰ Box Drawings Light Arc Up and Right
export TERM_BOX_R_BR=$'\u256F'  # ╯ Box Drawings Light Arc Up and Left

