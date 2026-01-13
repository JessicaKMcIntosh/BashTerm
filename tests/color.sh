#!/usr/bin/env bash
# shellcheck source=color.sh

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Test the BashTerm library.

# All testing done with the xterm terminal.
export TERM="xterm"

# Test the color library.
find_library(){
    local library="${1}"
    for file_name in {./,../}${library} ; do
        if [[ -f  "${file_name}" ]] ; then
            echo "${file_name}"
        fi
done
}
source "$(find_library "color.sh")"

# Define some metadata about this test.
export TEST_TITLE="Test all color variables."

# Any setup that may need to be performed.
test_setup(){
    # The xterm color escape codes to test against.
    test_color_bg_black=$'\E[40m'
    test_color_bg_red=$'\E[41m'
    test_color_bg_green=$'\E[42m'
    test_color_bg_yellow=$'\E[43m'
    test_color_bg_blue=$'\E[44m'
    test_color_bg_magenta=$'\E[45m'
    test_color_bg_cyan=$'\E[46m'
    test_color_bg_white=$'\E[47m'
    test_color_bg_brightblack=$'\E[48m'
    test_color_bg_brightred=$'\E[49m'
    test_color_bg_brightgreen=$'\E[410m'
    test_color_bg_brightyellow=$'\E[411m'
    test_color_bg_brightblue=$'\E[412m'
    test_color_bg_brightmagenta=$'\E[413m'
    test_color_bg_brightcyan=$'\E[414m'
    test_color_bg_brightwhite=$'\E[415m'
    test_color_fg_black=$'\E[30m'
    test_color_fg_red=$'\E[31m'
    test_color_fg_green=$'\E[32m'
    test_color_fg_yellow=$'\E[33m'
    test_color_fg_blue=$'\E[34m'
    test_color_fg_magenta=$'\E[35m'
    test_color_fg_cyan=$'\E[36m'
    test_color_fg_white=$'\E[37m'
    test_color_fg_brightblack=$'\E[38m'
    test_color_fg_brightred=$'\E[39m'
    test_color_fg_brightgreen=$'\E[310m'
    test_color_fg_brightyellow=$'\E[311m'
    test_color_fg_brightblue=$'\E[312m'
    test_color_fg_brightmagenta=$'\E[313m'
    test_color_fg_brightcyan=$'\E[314m'
    test_color_fg_brightwhite=$'\E[315m'
}

# Any cleanup that may need to be performed.
test_cleanup(){
    # Cleanup the testing variables.
    unset test_color_fg_black
    unset test_color_fg_red
    unset test_color_fg_green
    unset test_color_fg_yellow
    unset test_color_fg_blue
    unset test_color_fg_magenta
    unset test_color_fg_cyan
    unset test_color_fg_white
    unset test_color_fg_brightblack
    unset test_color_fg_brightred
    unset test_color_fg_brightgreen
    unset test_color_fg_brightyellow
    unset test_color_fg_brightblue
    unset test_color_fg_brightmagenta
    unset test_color_fg_brightcyan
    unset test_color_fg_brightwhite
    unset test_color_bg_black
    unset test_color_bg_red
    unset test_color_bg_green
    unset test_color_bg_yellow
    unset test_color_bg_blue
    unset test_color_bg_magenta
    unset test_color_bg_cyan
    unset test_color_bg_white
    unset test_color_bg_brightblack
    unset test_color_bg_brightred
    unset test_color_bg_brightgreen
    unset test_color_bg_brightyellow
    unset test_color_bg_brightblue
    unset test_color_bg_brightmagenta
    unset test_color_bg_brightcyan
    unset test_color_bg_brightwhite
}

test::colors(){
    assert_exists "TERM_FG[0]" "${test_color_fg_black}" "Check the value of TERM_FG[0]."
    assert_exists "TERM_FG[1]" "${test_color_fg_red}" "Check the value of TERM_FG[1]."
    assert_exists "TERM_FG[2]" "${test_color_fg_green}" "Check the value of TERM_FG[2]."
    assert_exists "TERM_FG[3]" "${test_color_fg_yellow}" "Check the value of TERM_FG[3]."
    assert_exists "TERM_FG[4]" "${test_color_fg_blue}" "Check the value of TERM_FG[4]."
    assert_exists "TERM_FG[5]" "${test_color_fg_magenta}" "Check the value of TERM_FG[5]."
    assert_exists "TERM_FG[6]" "${test_color_fg_cyan}" "Check the value of TERM_FG[6]."
    assert_exists "TERM_FG[7]" "${test_color_fg_white}" "Check the value of TERM_FG[7]."
    assert_exists "TERM_FG[8]" "${test_color_fg_brightblack}" "Check the value of TERM_FG[8]."
    assert_exists "TERM_FG[9]" "${test_color_fg_brightred}" "Check the value of TERM_FG[9]."
    assert_exists "TERM_FG[10]" "${test_color_fg_brightgreen}" "Check the value of TERM_FG[10]."
    assert_exists "TERM_FG[11]" "${test_color_fg_brightyellow}" "Check the value of TERM_FG[11]."
    assert_exists "TERM_FG[12]" "${test_color_fg_brightblue}" "Check the value of TERM_FG[12]."
    assert_exists "TERM_FG[13]" "${test_color_fg_brightmagenta}" "Check the value of TERM_FG[13]."
    assert_exists "TERM_FG[14]" "${test_color_fg_brightcyan}" "Check the value of TERM_FG[14]."
    assert_exists "TERM_FG[15]" "${test_color_fg_brightwhite}" "Check the value of TERM_FG[15]."
    assert_exists "TERM_BG[0]" "${test_color_bg_black}" "Check the value of TERM_BG[0]."
    assert_exists "TERM_BG[1]" "${test_color_bg_red}" "Check the value of TERM_BG[1]."
    assert_exists "TERM_BG[2]" "${test_color_bg_green}" "Check the value of TERM_BG[2]."
    assert_exists "TERM_BG[3]" "${test_color_bg_yellow}" "Check the value of TERM_BG[3]."
    assert_exists "TERM_BG[4]" "${test_color_bg_blue}" "Check the value of TERM_BG[4]."
    assert_exists "TERM_BG[5]" "${test_color_bg_magenta}" "Check the value of TERM_BG[5]."
    assert_exists "TERM_BG[6]" "${test_color_bg_cyan}" "Check the value of TERM_BG[6]."
    assert_exists "TERM_BG[7]" "${test_color_bg_white}" "Check the value of TERM_BG[7]."
    assert_exists "TERM_BG[8]" "${test_color_bg_brightblack}" "Check the value of TERM_BG[8]."
    assert_exists "TERM_BG[9]" "${test_color_bg_brightred}" "Check the value of TERM_BG[9]."
    assert_exists "TERM_BG[10]" "${test_color_bg_brightgreen}" "Check the value of TERM_BG[10]."
    assert_exists "TERM_BG[11]" "${test_color_bg_brightyellow}" "Check the value of TERM_BG[11]."
    assert_exists "TERM_BG[12]" "${test_color_bg_brightblue}" "Check the value of TERM_BG[12]."
    assert_exists "TERM_BG[13]" "${test_color_bg_brightmagenta}" "Check the value of TERM_BG[13]."
    assert_exists "TERM_BG[14]" "${test_color_bg_brightcyan}" "Check the value of TERM_BG[14]."
    assert_exists "TERM_BG[15]" "${test_color_bg_brightwhite}" "Check the value of TERM_BG[15]."
    assert_exists "TERM_FG[black]" "${test_color_fg_black}" "Check the value of TERM_FG[0]."
    assert_exists "TERM_FG[red]" "${test_color_fg_red}" "Check the value of TERM_FG[1]."
    assert_exists "TERM_FG[green]" "${test_color_fg_green}" "Check the value of TERM_FG[2]."
    assert_exists "TERM_FG[yellow]" "${test_color_fg_yellow}" "Check the value of TERM_FG[3]."
    assert_exists "TERM_FG[blue]" "${test_color_fg_blue}" "Check the value of TERM_FG[4]."
    assert_exists "TERM_FG[magenta]" "${test_color_fg_magenta}" "Check the value of TERM_FG[5]."
    assert_exists "TERM_FG[cyan]" "${test_color_fg_cyan}" "Check the value of TERM_FG[6]."
    assert_exists "TERM_FG[white]" "${test_color_fg_white}" "Check the value of TERM_FG[7]."
    assert_exists "TERM_FG[brightblack]" "${test_color_fg_brightblack}" "Check the value of TERM_FG[8]."
    assert_exists "TERM_FG[brightred]" "${test_color_fg_brightred}" "Check the value of TERM_FG[9]."
    assert_exists "TERM_FG[brightgreen]" "${test_color_fg_brightgreen}" "Check the value of TERM_FG[10]."
    assert_exists "TERM_FG[brightyellow]" "${test_color_fg_brightyellow}" "Check the value of TERM_FG[11]."
    assert_exists "TERM_FG[brightblue]" "${test_color_fg_brightblue}" "Check the value of TERM_FG[12]."
    assert_exists "TERM_FG[brightmagenta]" "${test_color_fg_brightmagenta}" "Check the value of TERM_FG[13]."
    assert_exists "TERM_FG[brightcyan]" "${test_color_fg_brightcyan}" "Check the value of TERM_FG[14]."
    assert_exists "TERM_FG[brightwhite]" "${test_color_fg_brightwhite}" "Check the value of TERM_FG[15]."
    assert_exists "TERM_BG[black]" "${test_color_bg_black}" "Check the value of TERM_BG[0]."
    assert_exists "TERM_BG[red]" "${test_color_bg_red}" "Check the value of TERM_BG[1]."
    assert_exists "TERM_BG[green]" "${test_color_bg_green}" "Check the value of TERM_BG[2]."
    assert_exists "TERM_BG[yellow]" "${test_color_bg_yellow}" "Check the value of TERM_BG[3]."
    assert_exists "TERM_BG[blue]" "${test_color_bg_blue}" "Check the value of TERM_BG[4]."
    assert_exists "TERM_BG[magenta]" "${test_color_bg_magenta}" "Check the value of TERM_BG[5]."
    assert_exists "TERM_BG[cyan]" "${test_color_bg_cyan}" "Check the value of TERM_BG[6]."
    assert_exists "TERM_BG[white]" "${test_color_bg_white}" "Check the value of TERM_BG[7]."
    assert_exists "TERM_BG[brightblack]" "${test_color_bg_brightblack}" "Check the value of TERM_BG[8]."
    assert_exists "TERM_BG[brightred]" "${test_color_bg_brightred}" "Check the value of TERM_BG[9]."
    assert_exists "TERM_BG[brightgreen]" "${test_color_bg_brightgreen}" "Check the value of TERM_BG[10]."
    assert_exists "TERM_BG[brightyellow]" "${test_color_bg_brightyellow}" "Check the value of TERM_BG[11]."
    assert_exists "TERM_BG[brightblue]" "${test_color_bg_brightblue}" "Check the value of TERM_BG[12]."
    assert_exists "TERM_BG[brightmagenta]" "${test_color_bg_brightmagenta}" "Check the value of TERM_BG[13]."
    assert_exists "TERM_BG[brightcyan]" "${test_color_bg_brightcyan}" "Check the value of TERM_BG[14]."
    assert_exists "TERM_BG[brightwhite]" "${test_color_bg_brightwhite}" "Check the value of TERM_BG[15]."
}

test::aliases(){
    assert_exists "TERM_FG[gray]" "${test_color_fg_brightblack}" "Check the value of TERM_FG[gray]."
    assert_exists "TERM_FG[grey]" "${test_color_fg_brightblack}" "Check the value of TERM_FG[grey]."
    assert_exists "TERM_BG[gray]" "${test_color_bg_brightblack}" "Check the value of TERM_BG[gray]."
    assert_exists "TERM_BG[grey]" "${test_color_bg_brightblack}" "Check the value of TERM_BG[grey]."
}

test::shortcuts(){
    assert_exists "TERM_BG_BLACK" "${test_color_bg_black}" "Check the value of TERM_BG_BLACK."
    assert_exists "TERM_BG_BLUE" "${test_color_bg_blue}" "Check the value of TERM_BG_BLUE."
    assert_exists "TERM_BG_BRIGHTBLACK" "${test_color_bg_brightblack}" "Check the value of TERM_BG_BRIGHTBLACK."
    assert_exists "TERM_BG_BRIGHTBLUE" "${test_color_bg_brightblue}" "Check the value of TERM_BG_BRIGHTBLUE."
    assert_exists "TERM_BG_BRIGHTCYAN" "${test_color_bg_brightcyan}" "Check the value of TERM_BG_BRIGHTCYAN."
    assert_exists "TERM_BG_BRIGHTGREEN" "${test_color_bg_brightgreen}" "Check the value of TERM_BG_BRIGHTGREEN."
    assert_exists "TERM_BG_BRIGHTMAGENTA" "${test_color_bg_brightmagenta}" "Check the value of TERM_BG_BRIGHTMAGENTA."
    assert_exists "TERM_BG_BRIGHTRED" "${test_color_bg_brightred}" "Check the value of TERM_BG_BRIGHTRED."
    assert_exists "TERM_BG_BRIGHTWHITE" "${test_color_bg_brightwhite}" "Check the value of TERM_BG_BRIGHTWHITE."
    assert_exists "TERM_BG_BRIGHTYELLOW" "${test_color_bg_brightyellow}" "Check the value of TERM_BG_BRIGHTYELLOW."
    assert_exists "TERM_BG_CYAN" "${test_color_bg_cyan}" "Check the value of TERM_BG_CYAN."
    assert_exists "TERM_BG_GREEN" "${test_color_bg_green}" "Check the value of TERM_BG_GREEN."
    assert_exists "TERM_BG_MAGENTA" "${test_color_bg_magenta}" "Check the value of TERM_BG_MAGENTA."
    assert_exists "TERM_BG_RED" "${test_color_bg_red}" "Check the value of TERM_BG_RED."
    assert_exists "TERM_BG_WHITE" "${test_color_bg_white}" "Check the value of TERM_BG_WHITE."
    assert_exists "TERM_BG_YELLOW" "${test_color_bg_yellow}" "Check the value of TERM_BG_YELLOW."
    assert_exists "TERM_FG_BLACK" "${test_color_fg_black}" "Check the value of TERM_FG_BLACK."
    assert_exists "TERM_FG_BLUE" "${test_color_fg_blue}" "Check the value of TERM_FG_BLUE."
    assert_exists "TERM_FG_BRIGHTBLACK" "${test_color_fg_brightblack}" "Check the value of TERM_FG_BRIGHTBLACK."
    assert_exists "TERM_FG_BRIGHTBLUE" "${test_color_fg_brightblue}" "Check the value of TERM_FG_BRIGHTBLUE."
    assert_exists "TERM_FG_BRIGHTCYAN" "${test_color_fg_brightcyan}" "Check the value of TERM_FG_BRIGHTCYAN."
    assert_exists "TERM_FG_BRIGHTGREEN" "${test_color_fg_brightgreen}" "Check the value of TERM_FG_BRIGHTGREEN."
    assert_exists "TERM_FG_BRIGHTMAGENTA" "${test_color_fg_brightmagenta}" "Check the value of TERM_FG_BRIGHTMAGENTA."
    assert_exists "TERM_FG_BRIGHTRED" "${test_color_fg_brightred}" "Check the value of TERM_FG_BRIGHTRED."
    assert_exists "TERM_FG_BRIGHTWHITE" "${test_color_fg_brightwhite}" "Check the value of TERM_FG_BRIGHTWHITE."
    assert_exists "TERM_FG_BRIGHTYELLOW" "${test_color_fg_brightyellow}" "Check the value of TERM_FG_BRIGHTYELLOW."
    assert_exists "TERM_FG_CYAN" "${test_color_fg_cyan}" "Check the value of TERM_FG_CYAN."
    assert_exists "TERM_FG_GREEN" "${test_color_fg_green}" "Check the value of TERM_FG_GREEN."
    assert_exists "TERM_FG_MAGENTA" "${test_color_fg_magenta}" "Check the value of TERM_FG_MAGENTA."
    assert_exists "TERM_FG_RED" "${test_color_fg_red}" "Check the value of TERM_FG_RED."
    assert_exists "TERM_FG_WHITE" "${test_color_fg_white}" "Check the value of TERM_FG_WHITE."
    assert_exists "TERM_FG_YELLOW" "${test_color_fg_yellow}" "Check the value of TERM_FG_YELLOW."
}
