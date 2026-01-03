#!/usr/bin/env bash
# shellcheck source=attr.sh
# shellcheck source=boxes.sh
# shellcheck source=color.sh
# shellcheck source=cursor.sh

# A printf implementation with terminal attributes.

# This is really only an example.
# Adapt to your needs.

# Load the libraries.
find_library(){
    local library="${1}"
    for file_name in {./,../}${library} ; do
        if [[ -f  "${file_name}" ]] ; then
            echo "${file_name}"
        fi
done
}
source "$(find_library "attr.sh")"
source "$(find_library "boxes.sh")"
source "$(find_library "color.sh")"
source "$(find_library "cursor.sh")"

# Find the printf.awk file.
AWK_FILE="$(find_library "printf.awk")"
if [[ ! -f "${AWK_FILE}" ]] ; then
    echo "Unable to locate 'printf.awk' in the current or parent directories."
    echo "ABORTING!!"
    exit 1
fi

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

term::printf(){
    while [[ "$#" -gt 0 ]]; do
        echo "${1}"
        shift
    done | awk -f "${AWK_FILE}"
    # done | gawk --lint -f "${AWK_FILE}" # For development.
}
