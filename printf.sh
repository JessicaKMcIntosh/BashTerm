#!/usr/bin/env bash

# A printf implementation with terminal attributes.

# This is really only an example.
# Adapt to your needs.

# Short attribute codes.
# - reset
# d dim mode
# h hide cursor
# H home cursor
# i insert mode
# I exit insert mode
# l bold mode
# L clear screen
# o default colors
# s standout mode
# S exit standout mode
# t italics mode
# T exit italics mode
# u underline mode
# U exit underline mode
# v reverse mode
# V secure mode (invisible)
# z show cursor
# k black foreground
# r red foreground
# g green foreground
# y yellow foreground
# b blue foreground
# m magenta foreground
# c cyan foreground
# w white foreground
# K black background
# R red background
# G green background
# Y yellow background
# B blue background
# M magenta background
# C cyan background
# W white background

source "./attr.sh"
source "./color.sh"
source "./cursor.sh"

term::printf(){
    while [[ "$#" -gt 0 ]]; do
        echo "${1}"
        shift
    done | awk -f printf.awk
}

term::printf "This%{rev}is%{sgr0} a %%%(underline)format%(UNDERLINE) %s%(reset).\n" "test" # | hexdump -C
term::printf "Color %(green)Green%(reset) Normal %(CYAN)More%(reset)\n"
term::printf "Short %[m]color%[r] codes%[o] and %[byB]Attributes%[-]\n"
# Be careful with backslashes in double quotes.
# '\x22\\\x3d\x22' == "\x22\\\\\x3d\x22"
term::printf 'Backslash escapes: \x7e \x22\\\x3d\x22 => \042\075\042 \176\012'
