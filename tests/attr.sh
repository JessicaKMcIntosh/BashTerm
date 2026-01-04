#!/usr/bin/env bash
# shellcheck source=attr.sh

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Test the BashTerm library.

# All testing done with the xterm terminal.
export TERM="xterm"

# Test the attributes library.
source "attr.sh"

# Define some metadata about this test.
export TEST_TITLE="Test all attribute variables."

# Any setup that may need to be performed.
test_setup(){
    # The xterm escape codes to test against.
    test_attr_bold=$'\E[1m'
    test_attr_clear=$'\E[H\E[2J\E[3J'
    test_attr_dim=$'\E[2m'
    test_attr_smir=$'\E[4h'
    test_attr_invis=$'\E[8m'
    test_attr_rmir=$'\E[4l'
    test_attr_ritm=$'\E[23m'
    test_attr_rmso=$'\E[27m'
    test_attr_rmul=$'\E[24m'
    test_attr_sitm=$'\E[3m'
    test_attr_op=$'\E[39;49m'
    test_attr_sgr0=$'\E(B\E[m'
    test_attr_rev=$'\E[7m'
    test_attr_smso=$'\E[7m'
    test_attr_smul=$'\E[4m'
}

# Any cleanup that may need to be performed.
test_cleanup(){
    # Cleanup the testing variables.
    unset test_attr_bold
    unset test_attr_clear
    unset test_attr_dim
    unset test_attr_smir
    unset test_attr_invis
    unset test_attr_rmir
    unset test_attr_ritm
    unset test_attr_rmso
    unset test_attr_rmul
    unset test_attr_sitm
    unset test_attr_op
    unset test_attr_sgr0
    unset test_attr_rev
    unset test_attr_smso
    unset test_attr_smul
}

test::attributes(){
    assert_exists "TERM_ATTR[clear_screen]" "${test_attr_clear}" "Check the value of TERM_ATTR[clear_screen]."
    assert_exists "TERM_ATTR[enter_bold_mode]" "${test_attr_bold}" "Check the value of TERM_ATTR[enter_bold_mode]."
    assert_exists "TERM_ATTR[enter_dim_mode]" "${test_attr_dim}" "Check the value of TERM_ATTR[enter_dim_mode]."
    assert_exists "TERM_ATTR[enter_insert_mode]" "${test_attr_smir}" "Check the value of TERM_ATTR[enter_insert_mode]."
    assert_exists "TERM_ATTR[enter_italics_mode]" "${test_attr_sitm}" "Check the value of TERM_ATTR[enter_italics_mode]."
    assert_exists "TERM_ATTR[enter_reverse_mode]" "${test_attr_rev}" "Check the value of TERM_ATTR[enter_reverse_mode]."
    assert_exists "TERM_ATTR[enter_secure_mode]" "${test_attr_invis}" "Check the value of TERM_ATTR[enter_secure_mode]."
    assert_exists "TERM_ATTR[enter_standout_mode]" "${test_attr_smso}" "Check the value of TERM_ATTR[enter_standout_mode]."
    assert_exists "TERM_ATTR[enter_underline_mode]" "${test_attr_smul}" "Check the value of TERM_ATTR[enter_underline_mode]."
    assert_exists "TERM_ATTR[exit_attribute_mode]" "${test_attr_sgr0}" "Check the value of TERM_ATTR[exit_attribute_mode]."
    assert_exists "TERM_ATTR[exit_insert_mode]" "${test_attr_rmir}" "Check the value of TERM_ATTR[exit_insert_mode]."
    assert_exists "TERM_ATTR[exit_italics_mode]" "${test_attr_ritm}" "Check the value of TERM_ATTR[exit_italics_mode]."
    assert_exists "TERM_ATTR[exit_standout_mode]" "${test_attr_rmso}" "Check the value of TERM_ATTR[exit_standout_mode]."
    assert_exists "TERM_ATTR[exit_underline_mode]" "${test_attr_rmul}" "Check the value of TERM_ATTR[exit_underline_mode]."
    assert_exists "TERM_ATTR[orig_pair]" "${test_attr_op}" "Check the value of TERM_ATTR[orig_pair]."
}

test::aliases(){
    assert_exists "TERM_ATTR[INSERT]" "${test_attr_rmir}" "Check the value of TERM_ATTR[INSERT]."
    assert_exists "TERM_ATTR[ITALICS]" "${test_attr_ritm}" "Check the value of TERM_ATTR[ITALICS]."
    assert_exists "TERM_ATTR[STANDOUT]" "${test_attr_rmso}" "Check the value of TERM_ATTR[STANDOUT]."
    assert_exists "TERM_ATTR[UNDERLINE]" "${test_attr_rmul}" "Check the value of TERM_ATTR[UNDERLINE]."
    assert_exists "TERM_ATTR[orig]" "${test_attr_op}" "Check the value of TERM_ATTR[orig]."
    assert_exists "TERM_ATTR[insert]" "${test_attr_smir}" "Check the value of TERM_ATTR[insert]."
    assert_exists "TERM_ATTR[invisible]" "${test_attr_invis}" "Check the value of TERM_ATTR[invisible]."
    assert_exists "TERM_ATTR[italics]" "${test_attr_sitm}" "Check the value of TERM_ATTR[italics]."
    assert_exists "TERM_ATTR[reset]" "${test_attr_sgr0}" "Check the value of TERM_ATTR[reset]."
    assert_exists "TERM_ATTR[reverse]" "${test_attr_rev}" "Check the value of TERM_ATTR[reverse]."
    assert_exists "TERM_ATTR[standout]" "${test_attr_smso}" "Check the value of TERM_ATTR[standout]."
    assert_exists "TERM_ATTR[underline]" "${test_attr_smul}" "Check the value of TERM_ATTR[underline]."
}

test::shortcuts(){
    assert_exists "TERM_BOLD" "${test_attr_bold}" "Check the value of TERM_BOLD."
    assert_exists "TERM_CLEAR" "${test_attr_clear}" "Check the value of TERM_CLEAR."
    assert_exists "TERM_DIM" "${test_attr_dim}" "Check the value of TERM_DIM."
    assert_exists "TERM_INSERT" "${test_attr_smir}" "Check the value of TERM_INSERT."
    assert_exists "TERM_INVISIBLE" "${test_attr_invis}" "Check the value of TERM_INVISIBLE."
    assert_exists "TERM_EXIT_INSERT" "${test_attr_rmir}" "Check the value of TERM_EXIT_INSERT."
    assert_exists "TERM_EXIT_ITALICS" "${test_attr_ritm}" "Check the value of TERM_EXIT_ITALICS."
    assert_exists "TERM_EXIT_STANDOUT" "${test_attr_rmso}" "Check the value of TERM_EXIT_STANDOUT."
    assert_exists "TERM_EXIT_UNDERLINE" "${test_attr_rmul}" "Check the value of TERM_EXIT_UNDERLINE."
    assert_exists "TERM_ITALICS" "${test_attr_sitm}" "Check the value of TERM_ITALICS."
    assert_exists "TERM_ORIG" "${test_attr_op}" "Check the value of TERM_ORIG."
    assert_exists "TERM_RESET" "${test_attr_sgr0}" "Check the value of TERM_RESET."
    assert_exists "TERM_REVERSE" "${test_attr_rev}" "Check the value of TERM_REVERSE."
    assert_exists "TERM_STANDOUT" "${test_attr_smso}" "Check the value of TERM_STANDOUT."
    assert_exists "TERM_UNDERLINE" "${test_attr_smul}" "Check the value of TERM_UNDERLINE."

}
