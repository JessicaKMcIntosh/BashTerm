#!/usr/bin/env bash

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Test the BashTerm library.

# Test the base functionality of the BashTerm testing script.

# Define some metadata about this test.
export TEST_TITLE="Make sure the assert tests work."

# Any setup that may need to be performed.
test_setup() {
    # Failures are fatal for this test.
    declare -x TestFailFatal=true
}

# Any cleanup that may need to be performed.
test_cleanup() {
    # Nothing done.
    :
}

test::assert_equals() {
    assert_equals "EQUAL" "EQUAL" "Equal values should be equal."
}

test::assert_equals_fail() {
    local save_assert_fail=${ASSERT_FAIL_COUNT}
    local save_assert_pass=${ASSERT_PASS_COUNT}
    local save_verbose=${TestVerbose}
    local test_message="assert_equals should fail for non-equal values."

    # Make a failure.
    TestFailFatal=false
    TestVerbose=false
    assert_equals "Bar" "Foo" "FAIL: 'Foo' should not be equal to 'BAR'" > /dev/null
    TestFailFatal=true
    TestVerbose=${save_verbose}

    if ((save_assert_fail == (ASSERT_FAIL_COUNT - 1))); then
        ASSERT_FAIL_COUNT=${save_assert_fail}
        assert_pass "${test_message}"
    else
        ASSERT_PASS_COUNT=${save_assert_pass}
        assert_fail "${test_message}"
    fi
}

test::assert_exists() {
    assert_exists "_TEST_SENTINEL" "'_TEST_SENTINEL' should exist."
    assert_exists "_TEST_SENTINEL" "SENTINEL" "'_TEST_SENTINEL' should exist and be equal to 'SENTINEL'."
}

test::assert_exists_fail() {
    local save_assert_fail=${ASSERT_FAIL_COUNT}
    local save_assert_pass=${ASSERT_PASS_COUNT}
    local save_verbose=${TestVerbose}
    local test_message="assert_exists should fail for an unset variable and incorrect value."

    # Make a failure.
    TestFailFatal=false
    TestVerbose=false
    assert_exists "_TEST_SENTINEL_WRONG" "FAIL: '_TEST_SENTINEL_WRONG' should not exist." > /dev/null
    assert_exists "_TEST_SENTINEL" "WRONG_VALUE" "FAIL: '_TEST_SENTINEL' should not be equal to 'WRONG_VALUE'." > /dev/null
    TestFailFatal=true
    TestVerbose=${save_verbose}

    if ((save_assert_fail == (ASSERT_FAIL_COUNT - 2))); then
        ASSERT_FAIL_COUNT=${save_assert_fail}
        assert_pass "${test_message}"
    else
        ASSERT_PASS_COUNT=${save_assert_pass}
        assert_fail "${test_message}"
    fi
}

test::assert_fail() {
    local save_assert_fail=${ASSERT_FAIL_COUNT}
    local save_assert_pass=${ASSERT_PASS_COUNT}
    local save_verbose=${TestVerbose}
    local test_message="assert_fail should always fail."

    # Make a failure.
    TestFailFatal=false
    TestVerbose=false
    assert_fail "This should always fail." > /dev/null
    TestFailFatal=true
    TestVerbose=${save_verbose}

    if ((save_assert_fail == (ASSERT_FAIL_COUNT - 1))); then
        ASSERT_FAIL_COUNT=${save_assert_fail}
        assert_pass "${test_message}"
    else
        ASSERT_PASS_COUNT=${save_assert_pass}
        echo "${test_message}"
        exit 1
    fi
}

test::assert_pass() {
    assert_pass "assert_pass should always pass."
}

test::assert_run() {
    assert_run "printf success" "0" "success" "Successful command should succeed."
}

test::assert_run_fail() {
    local save_assert_fail=${ASSERT_FAIL_COUNT}
    local save_assert_pass=${ASSERT_PASS_COUNT}
    local save_verbose=${TestVerbose}
    local test_message="assert_run should fail for incorrect values."

    # Make a failure.
    TestFailFatal=false
    TestVerbose=false
    assert_run "printf --help" "0" "success" "FAIL: Invalid command should fail." > /dev/null
    assert_run "printf success" "0" "WRONG_VALUE" "FAIL: Incorrect output should not match." > /dev/null
    TestFailFatal=true
    TestVerbose=${save_verbose}

    if ((save_assert_fail == (ASSERT_FAIL_COUNT - 2))); then
        ASSERT_FAIL_COUNT=${save_assert_fail}
        assert_pass "${test_message}"
    else
        ASSERT_PASS_COUNT=${save_assert_pass}
        assert_fail "${test_message}"
    fi
}

test::assert_success() {
    assert_success "true" "true should always succeed."
}
