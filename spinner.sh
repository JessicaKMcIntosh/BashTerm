#!/usr/bin/env bash

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# A simple spinner using Unicode characters.

# See 'man 5 terminfo' for more information.

# This requires bash version 4.
if [[ "${BASH_VERSINFO[0]}" -lt "4" ]] ; then
    echo "This script requires Bash 4 or later."
    echo "Current version: ${BASH_VERSION}"
    exit 1
fi

# These are the main variables for the Library.
# declare -A TERM_FG      # Stores terminal foreground color escape sequences.
# declare -A TERM_BG      # Stores terminal background color escape sequences.


_TERM_SPIN_SIX=(
    $'\u283F' # ⠿ Braille Pattern Dots-123456
    $'\u2837' # ⠷ Braille Pattern Dots-12356
    $'\u282F' # ⠯ Braille Pattern Dots-12346
    $'\u281F' # ⠟ Braille Pattern Dots-12345
    $'\u283B' # ⠻ Braille Pattern Dots-12456
    $'\u283D' # ⠽ Braille Pattern Dots-13456
    $'\u283E' # ⠾ Braille Pattern Dots-23456
)

_TERM_SPIN_SIX_IN_OUT=(
    $'\u283F' # ⠿ Braille Pattern Dots-123456
    $'\u2837' # ⠷ Braille Pattern Dots-12356
    $'\u2827' # ⠧ Braille Pattern Dots-1236
    $'\u2807' # ⠇ Braille Pattern Dots-123
    $'\u2803' # ⠃ Braille Pattern Dots-12
    $'\u2801' # ⠁ Braille Pattern Dots-1
    $'\u2800' # ⠀ Braille Pattern Blank
    $'\u2808' # ⠈ Braille Pattern Dots-4
    $'\u2818' # ⠘ Braille Pattern Dots-45
    $'\u2838' # ⠸ Braille Pattern Dots-456
    $'\u283C' # ⠼ Braille Pattern Dots-3456
    $'\u283E' # ⠾ Braille Pattern Dots-23456
)

_TERM_SPIN_EIGHT=(
$'\u28FF' # ⣿ Braille Pattern Dots-12345678
$'\u28F7' # ⣷ Braille Pattern Dots-1235678
$'\u28EF' # ⣯ Braille Pattern Dots-1234678
$'\u28DF' # ⣟ Braille Pattern Dots-1234578
$'\u287F' # ⡿ Braille Pattern Dots-1234567
$'\u28BF' # ⢿ Braille Pattern Dots-1234568
$'\u28FB' # ⣻ Braille Pattern Dots-1245678
$'\u28FD' # ⣽ Braille Pattern Dots-1345678
$'\u28FE' # ⣾ Braille Pattern Dots-2345678
)
