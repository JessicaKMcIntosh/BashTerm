#!/usr/bin/env bash

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Test the BashTerm library.

# Test the base functionality of the BashTerm testing script.

# Define some metadata about this test.
export TEST_TITLE="Make sure the assert tests work."

# Any setup that may need to be performed.
test_setup(){
    # Failures are fatal for this test.
    declare -x TestFailFatal=true
}

# Any cleanup that may need to be performed.
test_cleanup(){
    # Nothing done.
    :
}

test::assert_equals(){
    assert_equals "Foo" "Foo" "'Foo' should be 'Foo'."
}

test::assert_equals_fail(){
    local failures
    failures="${ASSERT_FAIL}"
    ((failures++))

    # Make a failure.
    TestFailFatal=false
    assert_equals "bar" "foo" "This test will always fail." > /dev/null
    TestFailFatal=true

    # Readjust the tests since this test should fail.
    if [[ "${failures}" -eq "${ASSERT_FAIL}" ]] ; then
        ((ASSERT_FAIL--))
        ((ASSERT_PASS++))
    else
        assert_fail "assert_equals should have failed for inequal values."
    fi
}

test::assert_exists(){
    assert_exists "_TEST_SENTINAL" "'ASSERT_PASS' should exist."
    assert_exists "_TEST_SENTINAL" "SENTINAL" "'_TEST_SENTINAL' should exist and be 'SENTINAL'."
}

test::assert_exists_fail(){
    local failures
    failures="${ASSERT_FAIL}"
    ((failures+=2))

    # Make a failure.
    TestFailFatal=false
    assert_exists "_TEST_SENTINAL_WRONG" "This test will always fail." > /dev/null
    assert_exists "_TEST_SENTINAL" "WRONG_VALUE" "This test will always fail." > /dev/null
    TestFailFatal=true

    # Readjust the tests since this test should fail.
    if [[ "${failures}" -eq "${ASSERT_FAIL}" ]] ; then
        ((ASSERT_FAIL-=2))
        ((ASSERT_PASS+=2))
    else
        assert_fail "assert_exists should fail for an unset variable and incorrect value."
    fi
}

test::assert_run(){
    assert_run "printf success" "0" "success" "Successful command should succeed."
}

test::assert_run_fail(){
    local failures
    failures="${ASSERT_FAIL}"
    ((failures+=2))

    # Make a failure.
    TestFailFatal=false
    assert_run "printf --help" "0" "success" "This test will always fail." > /dev/null
    assert_run "printf success" "0" "WRONG_VALUE" "This test will always fail." > /dev/null
    TestFailFatal=true

    # Readjust the tests since this test should fail.
    if [[ "${failures}" -eq "${ASSERT_FAIL}" ]] ; then
        ((ASSERT_FAIL-=2))
        ((ASSERT_PASS+=2))
    else
        assert_fail "assert_run should have failed for incorrect values."
    fi
}

test::assert_success(){
    assert_success "true" "true should always succeed."
}

test::assert_fail(){
    local failures
    failures="${ASSERT_FAIL}"
    ((failures++))

    # Make a failure.
    TestFailFatal=false
    assert_fail "This should always fail." > /dev/null
    TestFailFatal=true

    # Readjust the tests since this test should fail.
    if [[ "${failures}" -eq "${ASSERT_FAIL}" ]] ; then
        ((ASSERT_FAIL--))
        ((ASSERT_PASS++))
    else
        echo "assert_equals should have failed.."
        exit 1
    fi
}

