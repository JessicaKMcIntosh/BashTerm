#!/usr/bin/env bash
# shellcheck source=../attr.sh
# shellcheck source=../color.sh

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Print a nice color and attribute table.

@define LIBRARY_LIST @EXAMPLE_LIBRARIES@
@include load_libraries.sh

# I got the idea from the project 'ansi'.
# https://github.com/fidian/ansi
# Go check it out, it probably does what you want.
# I modified the table to suit the names in this library.
# I only looked at the output, I didn't bother reading the code.
# This table has an added column for the default foreground color.

color_table() {
    local bright_color     # Bright version of the color.
    local color_name       # Name of the line color.
    local color            # Iterator.
    declare -a TEST_COLORS # Colors to test.
    TEST_COLORS=(
        "black"
        "red"
        "green"
        "yellow"
        "blue"
        "magenta"
        "cyan"
        "white"
    )

    # Header for the table.
    echo -en "BG\u2193 / FG\u2192 "
    printf "%-10s" "DEFAULT"
    for color in "${TEST_COLORS[@]}"; do
        printf "%-9s" "${color}"
    done
    echo ""

    # Draw a line for each color, normal then bright.
    color_table_line "DEFAULT" ""
    for color in "${!TEST_COLORS[@]}"; do
        # Normal background color.
        color_name="${TEST_COLORS["${color}"]}"
        color_table_line "${color_name}" "${TERM_BG[${color}]}"
        # Bright background color.
        bright_color=$((color + 8))
        color_table_line "${color_name^^}" "${TERM_BG[${bright_color}]}"
    done
    echo ""

    # Legend
    echo "Legend:"
    echo -n "    Normal colors:  "
    echo -n "n = normal, "
    echo -n "b = ${TERM_ATTR[bold]}bold${TERM_ATTR[reset]}, "
    echo -n "d = ${TERM_ATTR[dim]}dim${TERM_ATTR[reset]}, "
    echo "u = ${TERM_ATTR[underline]}underline${TERM_ATTR[reset]} "
    echo -n "    BRIGHT Colors:  "
    echo -n "N = normal, "
    echo -n "B = ${TERM_ATTR[bold]}bold${TERM_ATTR[reset]}, "
    echo -n "D = ${TERM_ATTR[dim]}dim${TERM_ATTR[reset]}, "
    echo "U = ${TERM_ATTR[underline]}underline${TERM_ATTR[reset]}"
}

# Draw a line for each background color in the color table.
# The background color escape code is passed in to allow the default background.
color_table_line() {
    local color_name="${1}" # The name of the color.
    local bg_color="${2}"   # The background color escape code.
    local color             # Iterator.
    local bright_color      # Bright version of the color.
    printf "%-9s" "${color_name}"
    color_table_attribute "${bg_color}" "" "NOT_PRESENT" " "
    color_table_cell "${bg_color}" "" ""
    for color in "${!TEST_COLORS[@]}"; do
        bright_color=$((color + 8))
        color_table_cell "${bg_color}" "${TERM_FG[${color}]}" "${TERM_FG[${bright_color}]}"
    done
    echo ""
}

# Draw an individual cell in the color table.
# The background and foreground color escape codes is passed in to allow the
# default background and foreground.
color_table_cell() {
    local bg_color="${1}"
    local fg_color="${2}"
    local fg_color_bright="${3}"

    # Normal foreground color.
    echo -n "${bg_color}${fg_color}n"
    color_table_attribute "${bg_color}" "${fg_color}" "bold" "b"
    color_table_attribute "${bg_color}" "${fg_color}" "dim" "d"
    color_table_attribute "${bg_color}" "${fg_color}" "underline" "u"

    # Bright foreground color.
    if [[ -n ${fg_color_bright} ]]; then
        echo -n "${bg_color}${fg_color_bright}N"
        color_table_attribute "${bg_color}" "${fg_color_bright}" "bold" "B"
        color_table_attribute "${bg_color}" "${fg_color_bright}" "dim" "D"
        color_table_attribute "${bg_color}" "${fg_color_bright}" "underline" "U"
        color_table_attribute "${bg_color}" "${fg_color_bright}" "NOT_PRESENT" " "
    else
        color_table_attribute "${bg_color}" "${fg_color_bright}" "NOT_PRESENT" "      "
    fi
}

# Prints out text with the provided attribute and colors.
color_table_attribute() {
    local bg_color="${1}"
    local fg_color="${2}"
    local attr="${3}"
    local text="${4}"

    echo -n "${bg_color}"
    echo -n "${fg_color}"
    echo -n "${TERM_ATTR[${attr}]}"
    echo -n "${text}"
    echo -n "${TERM_ATTR[reset]}"
}

# Generate the table.
color_table
