#!/usr/bin/env bash
# shellcheck source=../attr.sh

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Test the BashTerm library.

# Test utility 'm1.awk'.

# Define some metadata about this test.
export TEST_TITLE="Test the utility 'm1.awk'."

# Any setup that may need to be performed.
test_setup() {
    declare -g test_m1_temp_file=""
    trap '[[ -n $test_m1_temp_file ]] && rm -f "${test_m1_temp_file}"' EXIT
    test_m1_temp_file=$(mktemp --tmpdir BashTermTestFile.XXXXXXXXXX) || exit
}

# Any cleanup that may need to be performed.
test_cleanup() {
    rm -f "${test_m1_temp_file}"
    trap EXIT
    unset test_m1_temp_file
}

test::m1_comments() {
    local test_data test_result
    printf -v test_data "@comment This is a comment\n@@ This is also a comment.\nThis will be printed."
    printf -v test_result "This will be printed."
    assert_run "echo ${test_data@Q} | ${_TERM_AWK_COMMAND} -f src/utilities/m1.awk -" "0" "${test_result}" "Comments should not be printed."
}

test::m1_define() {
    local test_data test_result
    printf -v test_data "@define VARIABLE Value\n@VARIABLE"
    printf -v test_result "Value"
    assert_run "echo ${test_data@Q} | ${_TERM_AWK_COMMAND} -f src/utilities/m1.awk -" "0" "${test_result}" "Define a variable."
}

test::m1_append() {
    local test_data test_result
    printf -v test_data "@define VARIABLE Value\n@append VARIABLE Appended\n@VARIABLE"
    printf -v test_result "Value\nAppended"
    assert_run "echo ${test_data@Q} | ${_TERM_AWK_COMMAND} -f src/utilities/m1.awk -" "0" "${test_result}" "Define a variable."
}

test::m1_default() {
    local test_data test_result
    printf -v test_data "@default DEFAULT Default\n@DEFAULT@\n@default DEFAULT Not Default\n@DEFAULT@"
    printf -v test_result "Default\nDefault"
    assert_run "echo ${test_data@Q} | ${_TERM_AWK_COMMAND} -f src/utilities/m1.awk -" "0" "${test_result}" "Default value for an undefined variable."
}

test::m1_if() {
    local test_data test_result
    printf -v test_data "@define TRUE 1\n@define FALSE 0\n@if TRUE\nTrue\n@fi\n@if FALSE\nFalse\n@fi"
    printf -v test_result "True"
    assert_run "echo ${test_data@Q} | ${_TERM_AWK_COMMAND} -f src/utilities/m1.awk -" "0" "${test_result}" "If a variable is true."
}

test::m1_unless() {
    local test_data test_result
    printf -v test_data "@define TRUE 1\n@define FALSE 0\n@unless TRUE\nTrue\n@fi\n@unless FALSE\nFalse\n@fi"
    printf -v test_result "False"
    assert_run "echo ${test_data@Q} | ${_TERM_AWK_COMMAND} -f src/utilities/m1.awk -" "0" "${test_result}" "Unless a variable is true."
}

test::m1_undefine() {
    local test_data test_result
    printf -v test_data "@define UNDEFINE TRUE\n@if UNDEFINE\nSet\n@fi\n@undefine UNDEFINE\n@unless UNDEFINE\nUnSet\n@fi"
    printf -v test_result "Set\nUnSet"
    assert_run "echo ${test_data@Q} | ${_TERM_AWK_COMMAND} -f src/utilities/m1.awk -" "0" "${test_result}" "Undefine a variable."
}

test::m1_ignore() {
    local test_data test_result
    printf -v test_data "Before\n@ignore DELIMITER\nThis should not be printed.\nDELIMITER\nAfter"
    printf -v test_result "Before\nAfter"
    assert_run "echo ${test_data@Q} | ${_TERM_AWK_COMMAND} -f src/utilities/m1.awk -" "0" "${test_result}" "Ignore text between delimiters."
}

test::m1_stderr() {
    local test_data test_result
    printf -v test_data "@stderr Error"
    printf -v test_result "Error"
    assert_run "echo ${test_data@Q} | ${_TERM_AWK_COMMAND} -f src/utilities/m1.awk - 2>&1" "0" "${test_result}" "Print to STDERR."
}

test::m1_system() {
    local test_data test_result
    printf -v test_data "@system printf System\n"
    printf -v test_result "System"
    assert_run "echo ${test_data@Q} | ${_TERM_AWK_COMMAND} -f src/utilities/m1.awk -" "0" "${test_result}" "Execute a system command."
}

test::m1_echo() {
    local test_data test_result
    printf -v test_data "@echo Echo"
    printf -v test_result "Echo"
    assert_run "echo ${test_data@Q} | ${_TERM_AWK_COMMAND} -f src/utilities/m1.awk -" "0" "${test_result}" "Explicitly echo text."
}

test::m1_exit() {
    local test_data test_result
    printf -v test_data "@exit 2\nThis should not print."
    printf -v test_result ""
    assert_run "echo ${test_data@Q} | ${_TERM_AWK_COMMAND} -f src/utilities/m1.awk -" "2" "${test_result}" "Exit prematurely with the given exit status."
}

test::m1_D() {
    local test_data test_result
    printf -v test_data "@VARIABLE@"
    printf -v test_result "Value"
    assert_run "echo ${test_data@Q} | ${_TERM_AWK_COMMAND} -f src/utilities/m1.awk -- -DVARIABLE=Value -" "0" "${test_result}" "Exit prematurely with the given exit status."
}

test::m1_output() {
    local test_data test_result
    # shellcheck disable=SC2059
    printf -v test_data "This is sent to STDOUT.\n@output ${test_m1_temp_file}\nThis is sent to the output file.\n@output -\nThis is also sent to STDOUT."
    printf -v test_result "This is sent to STDOUT.\nThis is also sent to STDOUT."
    assert_run "echo ${test_data@Q} | ${_TERM_AWK_COMMAND} -f src/utilities/m1.awk -" "0" "${test_result}" "Send output to a file."

    # Check the contents of the output file.
    test_result="$(cat "${test_m1_temp_file}")"
    assert_equals "${test_result}" "This is sent to the output file." "Send output to a file. File contents."
}

test::m1_input() {
    local test_data test_result
    echo "Included contents." > "${test_m1_temp_file}"
    # shellcheck disable=SC2059
    printf -v test_data "@include ${test_m1_temp_file}"
    printf -v test_result "Included contents."
    assert_run "echo ${test_data@Q} | ${_TERM_AWK_COMMAND} -f src/utilities/m1.awk -" "0" "${test_result}" "Send output to a file."
}
