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

# Saner shell defaults.
set -o nounset
shopt -s nullglob
shopt -u failglob

# Testing Variables:
declare TEST_COUNT  # The number of tests that have been run.
declare ASSERT_PASS # The number of assertions that have passed.
declare ASSERT_FAIL # The number of assertions that have failed.

# For testing the tests.
declare _TEST_SENTINEL="SENTINEL"

# ----~~~~++++====#### Assertion Functions ####====++++~~~~----

_assert_check_fatal() {
    if ${TestFailFatal}; then
        echo "Fatal failure! Aborting..."
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
        ((ASSERT_FAIL++))
        printf "FAILED: [%s] " "${caller}"
        if [[ -n ${message} ]]; then
            printf "%s " "${message}"
        fi
        return 1
    fi
    ((ASSERT_PASS++))
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
    local result=1

    # Does the variable exist?
    [[ -v ${variable} ]] && result=0 || result=1
    if ! _assert "${result}" "assert_exists" "${message}"; then
        printf "Variable (%s) does not exist.\n" "${variable}"
        _assert_check_fatal
        return 1
    elif [[ -n ${expected} ]]; then
        # Yes. And there is an expected value. Are they equal?
        actual=${!variable}
        [[ ${expected} == "${actual}" ]] && result=0 || result=1
        if ! _assert "${result}" "assert_exists" "${message}"; then
            printf "Expected: (%s) Actual: (%s)\n" "${expected@Q}" "${actual@Q}"
            _assert_check_fatal
            return 1
        fi
    fi
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

# Run a command. Check the return status and output.
assert_run() {
    local command=${1}
    local expected_status=${2}
    local expected_output=${3}
    local message=${4}
    local actual_output
    local actual_status
    local result

    # Run the command.
    actual_output="$(eval "${command}" 2>&1)"
    actual_status="${?}"

    # Check the return code.
    if [[ -n ${expected_status} ]]; then
        [[ ${expected_status} == "${actual_status}" ]] && result=0 || result=1
        if ! _assert "${result}" "assert_run" "${message}"; then
            printf "Expected return code: (%s) Actual: (%s)\n" "${expected_status}" "${actual_status}"
            printf "Output: %s\n" "${actual_output@Q}"
            return 1
        fi
    fi
    [[ ${expected_output} == "${actual_output}" ]] && result=0 || result=1
    if ! _assert "${result}" "assert_equals" "${message}"; then
        printf "Expected: (%s) Actual: (%s)\n" "${expected_output@Q}" "${actual_output@Q}"
        return 1
    fi
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

# Loop over the files in `test/`.
run_test_files() {
    local test_file
    echo "Running the tests from 'test/'..."
    for test_file in "${TestDirectory}"/*.sh; do
        # Run the tests from the file.
        run_test_file "${test_file}"
    done
}

# Run tests passed in on the command line.
run_test_args() {
    local test_file
    echo "Running the tests given on the command line..."
    if (($# > 0)); then
        while (($# > 0)); do
            test_file="${TestDirectory}/${1}"
            if [[ ! -f ${test_file} ]]; then
                test_file="${TestDirectory}/${1}.sh"
                if [[ ! -f ${test_file} ]]; then
                    echo "Unable to locate the test file ${1} in ${TestDirectory}."
                    continue
                fi
            fi
            # Run the tests from the file.
            run_test_file "${test_file}"
            shift
        done
        echo ""
    fi
}

# Load the file then run the tests from the file.
run_test_file() {
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
    fi

    run_tests

    # Do cleanup if needed.
    if declare -F "test_cleanup" > /dev/null 2>&1; then
        test_cleanup
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
    printf "  Assertions Total:  %d\n" "$((ASSERT_PASS + ASSERT_FAIL))"
    printf "  Assertions Passed: %d\n" "${ASSERT_PASS}"
    printf "  Assertions Failed: %d\n" "${ASSERT_FAIL}"
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
    exit 1
}

# Main processing.
main() {
    local option

    # Check command line args.
    while getopts ":h" option; do
        case "${option}" in
            h) print_usage ;;
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
    ASSERT_PASS=0
    ASSERT_FAIL=0

    # Were tests to run given on the command line?
    if (($# > 0)); then
        # Run the given tets.
        run_test_args "${@}"
    else
        # Run all the tests.
        run_test_files
    fi

    # Print the report.
    print_report
}

# Start the testing.
main "${@}"
