#!/usr/bin/env bash
# shellcheck disable=SC2034 # Some variables may remain unused in this file.
# shellcheck source=attr.sh
# shellcheck source=boxes.sh
# shellcheck source=color.sh
# shellcheck source=cursor.sh
# shellcheck source=function.sh

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# This is an application built using the libraries.
# It was creating a clock similar to this for work that inspired this library.

# This requires bash version 4.
if [[ "${BASH_VERSINFO[0]}" -lt "4" ]] ; then
    echo "This script requires Bash 4 or later."
    echo "Current version: ${BASH_VERSION}"
    exit 1
fi



# Thoughts
# This is based on: https://www.worldtimebuddy.com/
# Display the hours in a grid.
# Like I did for work the colors are:
#   early morning   - Cyan
#   Daytime         - Yellow
#   Evening         - Magenta
#   Night           - Blue

# Name | Time   | Grid
#------+--------+-------
# EST  | TIME   |
# CST  | TIME   |
# MST  | TIME   |
# PST  | TIME   |
#------+--------+-------
# UTC  | TIME   |
