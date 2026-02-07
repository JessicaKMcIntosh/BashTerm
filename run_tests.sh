#!/usr/bin/env bash
# shellcheck disable=SC1090 # Don't consider sourced files.

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Test the BashTerm library.

# Loads and runs the test from the directory `test/`.
# Runs each of the test functions.

# Test Details:

# Test functions are defined as test::TEST_NAME()
# As each test is run it is unset.

# If the variable 'TEST_TITLE' is set it is printed with the file name.
# For example the file 'tests/base.sh' sets TEST_TITLE to 'Base Test'
# Output: Loading test file 'tests/base.sh'... (Base Test)

# This requires bash version 4.
if ((BASH_VERSINFO[0] < 4)); then
    echo "This script requires Bash 4 or later."
    echo "Current version: ${BASH_VERSION}"
    exit 1
fi

# Configuration:
declare TestDirectory="tests"
declare TestFailFatal=false
declare TestVerbose=false

# Saner shell defaults.
set -o nounset
shopt -s nullglob
shopt -u failglob

# Testing Variables:
declare TEST_COUNT        # The number of tests that have been run.
declare ASSERT_PASS_COUNT # The number of assertions that have passed.
declare ASSERT_FAIL_COUNT # The number of assertions that have failed.

# For testing the tests.
declare _TEST_SENTINEL="SENTINEL"

# Should this be needed by any tests.
declare -g _TERM_AWK_COMMAND="awk"
term::find_awk() {
    local awk_command
    # mawk is generally faster than gawk.
    for awk_command in {m,}awk gawk; do
        if command -v "${awk_command}" > /dev/null; then
            declare -g _TERM_AWK_COMMAND="${awk_command}"
            break
        fi
    done
}

# ----~~~~++++====#### Assertion Functions ####====++++~~~~----

_assert_check_fatal() {
    if ${TestFailFatal}; then
        echo "Bail out! A fatal test has failed."
        exit 1
    fi
}

# Test the condition and update the ASSERT_ variables accordingly.
# If the test fails print the message.
_assert() {
    local condition=${1}
    local caller=${2}
    local message=${3:-}

    if [[ ${condition} -ne 0 ]]; then
        ((ASSERT_FAIL_COUNT++))
        printf "not ok - [%s] %s\n" "${caller}" "${message}"
        return 1
    elif $TestVerbose; then
        printf "ok - [%s] %s\n" "${caller}" "${message}"
    fi
    ((ASSERT_PASS_COUNT++))
    return 0
}

# Checks that a variable exists.
# Optionally compares the variable contents.
assert_exists() {
    local variable=${1}
    local expected=""
    if (($# > 2)); then
        expected=${2}
        shift
    fi
    local message=${2:-}
    local actual

    if [[ -v ${variable} ]]; then
        if [[ -n ${expected} ]]; then
            actual=${!variable}
            if [[ ${expected} != "${actual}" ]]; then
                _assert "1" "assert_exists" "${message}"
                printf "Expected: (%s) Actual: (%s)\n" "${expected@Q}" "${actual@Q}"
                _assert_check_fatal
                return 1
            fi
        fi
    else
        _assert "1" "assert_exists" "${message}"
        printf "Variable (%s) does not exist.\n" "${variable}"
        return 1
    fi
    _assert "0" "assert_exists" "${message}"
    return 0
}

# Check if two strings are equal.
assert_equals() {
    local actual=${1}
    local expected=${2}
    local message=${3}
    local result

    [[ ${expected} == "${actual}" ]] && result=0 || result=1
    if ! _assert "${result}" "assert_equals" "${message}"; then
        printf "Expected: (%s) Actual: (%s)\n" "${expected@Q}" "${actual@Q}"
        return 1
    fi
    return 0
}

# Always fails.
assert_fail() {
    local message=${1}
    _assert "1" "assert_fail" "${message}"
    _assert_check_fatal
    return 1
}

# Always pass.
assert_pass() {
    local message=${1}
    _assert "0" "assert_pass" "${message}"
    return 0
}

# Run a command. Check the return status and output.
assert_run() {
    local command=${1}
    local expected_status=${2}
    local expected_output=${3}
    local message=${4}
    local actual_output actual_status

    # Run the command.
    actual_output="$(eval "${command}" 2>&1)"
    actual_status="${?}"

    # Check the return code.
    if [[ -n ${expected_status} ]]; then
        if [[ ${expected_status} != "${actual_status}" ]]; then
            _assert "1" "assert_run" "${message}"
            printf "Expected return code: (%s) Actual: (%s)\n" "${expected_status}" "${actual_status}"
            printf "Output: %s\n" "${actual_output@Q}"
            return 1
        fi
    fi
    if [[ ${expected_output} != "${actual_output}" ]]; then
        _assert "1" "assert_equals" "${message}"
        printf "Expected: (%s) Actual: (%s)\n" "${expected_output@Q}" "${actual_output@Q}"
        return 1
    fi
    _assert "0" "assert_equals" "${message}"
    return 0
}

# Test if a command completes successfully.
assert_success() {
    local command=${1}
    local message=${2}
    local status

    eval "${command}" > /dev/null 2>&1 && status="$?" || status="$?"
    if ! _assert "${status}" "assert_success" "${message}"; then
        printf "Command failed: (%s)\n" "${command}"
        _assert_check_fatal
        return 1
    fi
    return 0
}

# ----~~~~++++====#### Testing Functions ####====++++~~~~----

# Loop over the files in '$TestDirectory'.
run_a_test_files() {
    local test_file
    echo "Running the tests from 'test/'..."
    for test_file in "${TestDirectory}"/*.sh; do
        # Run the tests from the file.
        run_a_test_file "${test_file}"
    done
}

# Run tests passed in on the command line.
run_test_args() {
    local test_file file_name
    echo "Running the tests given on the command line..."

    while (($# > 0)); do
        file_name=${1}
        test_file=${file_name}
        shift

        # Try to locate the test file.
        if [[ ! -f ${test_file} ]]; then
            test_file="${TestDirectory}/${test_file}"
            if [[ ! -f ${test_file} ]]; then
                if [[ -f "${test_file}.sh" ]]; then
                    test_file="${test_file}.sh"
                else
                    printf "Unable to locate the test file '%s' in the directory '%s'.\n" "${file_name}" "${TestDirectory}/"
                    exit 1
                fi
            fi
        fi

        # Run the tests from the file.
        run_a_test_file "${test_file}"
    done
    echo ""
}

# Load the file then run the tests from the file.
run_a_test_file() {
    local test_file="${1}"

    # Load the test file.
    echo ""
    printf "Loading test file '%s'..." "${test_file}"
    source "${test_file}"
    if [[ -v TEST_TITLE ]]; then
        printf " (%s)" "${TEST_TITLE}"
        unset TEST_TITLE
    fi
    echo ""

    # Clear the fatal flag. Set this in 'test_setup()' per test.
    TestFailFatal=false

    # Do setup if needed.
    if declare -F "test_setup" > /dev/null 2>&1; then
        test_setup
        unset test_setup
    fi

    run_tests

    # Do cleanup if needed.
    if declare -F "test_cleanup" > /dev/null 2>&1; then
        test_cleanup
        unset test_cleanup
    fi
}

# Run the tests loaded from the file.
# As each test is run it is deleted.
run_tests() {
    local name
    for name in $(compgen -A function test::); do
        ((TEST_COUNT++))
        printf "Running %s...\n" "${name}"
        "${name}"
        unset -f "${name}"
    done
}

# Print a report of the test results.
print_report() {
    echo ""
    echo "Test Report:"
    printf "  Tests run:         %d\n" "${TEST_COUNT}"
    printf "  Assertions Total:  %d\n" "$((ASSERT_PASS_COUNT + ASSERT_FAIL_COUNT))"
    printf "  Assertions Passed: %d\n" "${ASSERT_PASS_COUNT}"
    printf "  Assertions Failed: %d\n" "${ASSERT_FAIL_COUNT}"
}

# Check if there are any left over variables.
check_variables() {
    local functions variables

    functions="$(compgen -A function test_)"
    if [[ -n ${functions} ]]; then
        echo ""
        echo "NOTE: There are leftover test functions:"
        echo "${functions}" | column
    fi

    variables="$(compgen -v test_)"
    if [[ -n ${variables} ]]; then
        echo ""
        echo "NOTE: There are leftover test variables:"
        echo "${variables}" | column
    fi
}

# ----~~~~++++====#### CLI Functions ####====++++~~~~----

# Print the usage help text.
print_usage() {
    # Print any messages passed in.
    if (($# > 0)); then
        while (($# > 0)); do
            echo "${1}"
            shift
        done
        echo ""
    fi

    echo "Run Unit tests for BashTerm."
    echo "Usage: ${0} [OPTIONS] [TEST(S)]"
    echo ""
    echo "Run tests in the directory '${TestDirectory}'."
    echo "By default all tests in the directory are run."
    echo "Give the name of the list to run specific tests."
    echo ""
    echo "Options:"
    echo "  -h  Print this text."
    echo "  -v  Verbose testing output."
    exit 1
}

# Main processing.
main() {
    local option

    # Check command line args.
    while getopts ":hv" option; do
        case "${option}" in
            h) print_usage ;;
            v) TestVerbose=true ;;
            *) if [[ ${OPTARG} == "-" ]]; then
                print_usage # They probably only want help. Catches --help.
            else
                print_usage "Invalid option '${OPTARG}'." # Illegal option.
            fi ;;
        esac
    done
    shift $((OPTIND - 1))

    # Setup the variables.
    TEST_COUNT=0
    ASSERT_PASS_COUNT=0
    ASSERT_FAIL_COUNT=0

    # Check for AWK.
    term::find_awk

    # Were tests to run given on the command line?
    if (($# > 0)); then
        # Run the given tets.
        run_test_args "${@}"
    else
        # Run all the tests.
        run_a_test_files
    fi

    # Print the report.
    print_report

    # Check if there are any left over test variables.
    check_variables
}

# Start the testing.
main "${@}"
