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
    # Nothing done.
    :
}

# Any cleanup that may need to be performed.
test_cleanup(){
    # Nothing done.
    :
}

test::assert_equals(){
    assert_equals "Foo" "Foo" "Foo should be Foo."
}

test::assert_success(){
    assert_success "true" "true should always succeed."
}

test::will_always_fail(){
    local failures
    failures="${ASSERT_FAIL}"
    ((failures++))

    # Make a failure.
    assert_equals "bar" "foo" "This test will always fail."

    # Readjust the tests since this test should fail.
    if [[ "${failures}" -eq "${ASSERT_FAIL}" ]] ; then
        ((ASSERT_FAIL--))
        ((ASSERT_PASS++))
    else
        ((ASSERT_FAIL++))
        ((ASSERT_PASS--))
    fi
}
