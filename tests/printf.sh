#!/usr/bin/env bash
# shellcheck source=../printf.sh

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Test the BashTerm library.

# All testing done with the xterm terminal.
export TERM="xterm"

# Test the attributes library.

# Load the libraries.
declare -a library_list=("printf.sh")
find_library(){
    local library="${1}"
    local file_name
    for file_name in {../,./}${library} ; do
        if [[ -f  "${file_name}" ]] ; then
            echo "${file_name}"
            exit
        fi
    done
    echo "Unable to locate the library '${library}'." >&2
    exit 1
}
declare _TERM_LOAD_LIBRARY
for _TERM_LOAD_LIBRARY in "${library_list[@]}"; do
    source "$(find_library "${_TERM_LOAD_LIBRARY}")" || exit 1
done
unset _TERM_LOAD_LIBRARY

# Define some metadata about this test.
export TEST_TITLE="Test 'printf.sh'."

# Any setup that may need to be performed.
test_setup(){
    # The xterm escape codes to test against.
    test_attr_bold=$'\E[1m'
    test_attr_clear=$'\E[H\E[2J\E[3J'
    test_attr_cnorm=$'\E[?12l\E[?25h'
    test_attr_dim=$'\E[2m'
    test_attr_hide=$'\E[?25l'
    test_attr_home=$'\E[H'
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

# Test basic functionality.
test::basic(){
    assert_run "term::printf success" "0" "success" "Basic functionality teset."
    term::printf-v "_TEST_TEMP" "success"
    assert_exists "_TEST_TEMP" "success" "term::printf-v did not set the variable '_TEST_TEMP' correctly."
    unset _TEST_TEMP
}

# Test direct calls to tput.
test::tput(){
    assert_run 'term::printf "%{clear}"' "0" "${test_attr_clear}" "Check printf tput for 'clear'."
    assert_run 'term::printf "%{bold}"' "0" "${test_attr_bold}" "Check printf tput for 'bold'."
    assert_run 'term::printf "%{dim}"' "0" "${test_attr_dim}" "Check printf tput for 'dim'."
    assert_run 'term::printf "%{smir}"' "0" "${test_attr_smir}" "Check printf tput for 'smir'."
    assert_run 'term::printf "%{sitm}"' "0" "${test_attr_sitm}" "Check printf tput for 'sitm'."
    assert_run 'term::printf "%{rev}"' "0" "${test_attr_rev}" "Check printf tput for 'rev'."
    assert_run 'term::printf "%{invis}"' "0" "${test_attr_invis}" "Check printf tput for 'invis'."
    assert_run 'term::printf "%{smso}"' "0" "${test_attr_smso}" "Check printf tput for 'smso'."
    assert_run 'term::printf "%{smul}"' "0" "${test_attr_smul}" "Check printf tput for 'smul'."
    assert_run 'term::printf "%{sgr0}"' "0" "${test_attr_sgr0}" "Check printf tput for 'sgr0'."
    assert_run 'term::printf "%{rmir}"' "0" "${test_attr_rmir}" "Check printf tput for 'rmir'."
    assert_run 'term::printf "%{ritm}"' "0" "${test_attr_ritm}" "Check printf tput for 'ritm'."
    assert_run 'term::printf "%{rmso}"' "0" "${test_attr_rmso}" "Check printf tput for 'rmso'."
    assert_run 'term::printf "%{rmul}"' "0" "${test_attr_rmul}" "Check printf tput for 'rmul'."
    assert_run 'term::printf "%{op}"' "0" "${test_attr_op}" "Check printf tput for 'op'."
}

# Test looking up attributes in the environment.
test::environment(){
    assert_run 'term::printf "%(bold)"' "0" "${test_attr_bold}" "Check printf environment lookup for bold."
    assert_run 'term::printf "%(clear)"' "0" "${test_attr_clear}" "Check printf environment lookup for clear."
    assert_run 'term::printf "%(dim)"' "0" "${test_attr_dim}" "Check printf environment lookup for dim."
    assert_run 'term::printf "%(insert)"' "0" "${test_attr_smir}" "Check printf environment lookup for insert."
    assert_run 'term::printf "%(invisible)"' "0" "${test_attr_invis}" "Check printf environment lookup for invisible."
    assert_run 'term::printf "%(exit_insert)"' "0" "${test_attr_rmir}" "Check printf environment lookup for exit_insert."
    assert_run 'term::printf "%(ITALICS)"' "0" "${test_attr_ritm}" "Check printf environment lookup for exit_italics."
    assert_run 'term::printf "%(exit_standout)"' "0" "${test_attr_rmso}" "Check printf environment lookup for exit_standout."
    assert_run 'term::printf "%(UNDERLINE)"' "0" "${test_attr_rmul}" "Check printf environment lookup for exit_underline."
    assert_run 'term::printf "%(italics)"' "0" "${test_attr_sitm}" "Check printf environment lookup for italics."
    assert_run 'term::printf "%(orig)"' "0" "${test_attr_op}" "Check printf environment lookup for orig."
    assert_run 'term::printf "%(reset)"' "0" "${test_attr_sgr0}" "Check printf environment lookup for reset."
    assert_run 'term::printf "%(reverse)"' "0" "${test_attr_rev}" "Check printf environment lookup for reverse."
    assert_run 'term::printf "%(standout)"' "0" "${test_attr_smso}" "Check printf environment lookup for standout."
    assert_run 'term::printf "%(underline)"' "0" "${test_attr_smul}" "Check printf environment lookup for underline."
}

# Test backslash escaping.
test::backslash(){
    term::printf-v "_TEST_TEMP" '>\\<'; assert_equals "${_TEST_TEMP}" ">\<" "Backslash escape a backslash."
    term::printf-v "_TEST_TEMP" '>\a<'; assert_equals "${_TEST_TEMP}" $'>\a<' "Backslash escape a backslash."
    term::printf-v "_TEST_TEMP" '>\b<'; assert_equals "${_TEST_TEMP}" $'>\b<' "Backslash escape a backslash."
    term::printf-v "_TEST_TEMP" '>\e<'; assert_equals "${_TEST_TEMP}" $'>\e<' "Backslash escape a backslash."
    term::printf-v "_TEST_TEMP" '>\E<'; assert_equals "${_TEST_TEMP}" $'>\E<' "Backslash escape a backslash."
    term::printf-v "_TEST_TEMP" '>\f<'; assert_equals "${_TEST_TEMP}" $'>\f<' "Backslash escape a backslash."
    term::printf-v "_TEST_TEMP" '>\n<'; assert_equals "${_TEST_TEMP}" $'>\n<' "Backslash escape a backslash."
    term::printf-v "_TEST_TEMP" '>\r<'; assert_equals "${_TEST_TEMP}" $'>\r<' "Backslash escape a backslash."
    term::printf-v "_TEST_TEMP" '>\t<'; assert_equals "${_TEST_TEMP}" $'>\t<' "Backslash escape a backslash."
    term::printf-v "_TEST_TEMP" '>\v<'; assert_equals "${_TEST_TEMP}" $'>\v<' "Backslash escape a backslash."
    term::printf-v "_TEST_TEMP" '>\043<'; assert_equals "${_TEST_TEMP}" ">#<" "Backslash escape a backslash."
    term::printf-v "_TEST_TEMP" '>\141<'; assert_equals "${_TEST_TEMP}" ">a<" "Backslash escape a backslash."
    term::printf-v "_TEST_TEMP" '>\x7a<'; assert_equals "${_TEST_TEMP}" ">z<" "Backslash escape a backslash."
    unset _TEST_TEMP
}

# Test colors.
test::color(){
    assert_run 'term::printf "%(black)"' "0" "$(tput setaf 0)" "Check the foreground color black."
    assert_run 'term::printf "%(red)"' "0" "$(tput setaf 1)" "Check the foreground color red."
    assert_run 'term::printf "%(green)"' "0" "$(tput setaf 2)" "Check the foreground color green."
    assert_run 'term::printf "%(yellow)"' "0" "$(tput setaf 3)" "Check the foreground color yellow."
    assert_run 'term::printf "%(blue)"' "0" "$(tput setaf 4)" "Check the foreground color blue."
    assert_run 'term::printf "%(magenta)"' "0" "$(tput setaf 5)" "Check the foreground color magenta."
    assert_run 'term::printf "%(cyan)"' "0" "$(tput setaf 6)" "Check the foreground color cyan."
    assert_run 'term::printf "%(white)"' "0" "$(tput setaf 7)" "Check the foreground color white."
    assert_run 'term::printf "%(brightblack)"' "0" "$(tput setaf 8)" "Check the foreground color brightblack."
    assert_run 'term::printf "%(brightred)"' "0" "$(tput setaf 9)" "Check the foreground color brightred."
    assert_run 'term::printf "%(brightgreen)"' "0" "$(tput setaf 10)" "Check the foreground color brightgreen."
    assert_run 'term::printf "%(brightyellow)"' "0" "$(tput setaf 11)" "Check the foreground color brightyellow."
    assert_run 'term::printf "%(brightblue)"' "0" "$(tput setaf 12)" "Check the foreground color brightblue."
    assert_run 'term::printf "%(brightmagenta)"' "0" "$(tput setaf 13)" "Check the foreground color brightmagenta."
    assert_run 'term::printf "%(brightcyan)"' "0" "$(tput setaf 14)" "Check the foreground color brightcyan."
    assert_run 'term::printf "%(brightwhite)"' "0" "$(tput setaf 15)" "Check the foreground color brightwhite."

    assert_run 'term::printf "%(BLACK)"' "0" "$(tput setab 0)" "Check the background color black."
    assert_run 'term::printf "%(RED)"' "0" "$(tput setab 1)" "Check the background color red."
    assert_run 'term::printf "%(GREEN)"' "0" "$(tput setab 2)" "Check the background color green."
    assert_run 'term::printf "%(YELLOW)"' "0" "$(tput setab 3)" "Check the background color yellow."
    assert_run 'term::printf "%(BLUE)"' "0" "$(tput setab 4)" "Check the background color blue."
    assert_run 'term::printf "%(MAGENTA)"' "0" "$(tput setab 5)" "Check the background color magenta."
    assert_run 'term::printf "%(CYAN)"' "0" "$(tput setab 6)" "Check the background color cyan."
    assert_run 'term::printf "%(WHITE)"' "0" "$(tput setab 7)" "Check the background color white."
    assert_run 'term::printf "%(BRIGHTBLACK)"' "0" "$(tput setab 8)" "Check the background color brightblack."
    assert_run 'term::printf "%(BRIGHTRED)"' "0" "$(tput setab 9)" "Check the background color brightred."
    assert_run 'term::printf "%(BRIGHTGREEN)"' "0" "$(tput setab 10)" "Check the background color brightgreen."
    assert_run 'term::printf "%(BRIGHTYELLOW)"' "0" "$(tput setab 11)" "Check the background color brightyellow."
    assert_run 'term::printf "%(BRIGHTBLUE)"' "0" "$(tput setab 12)" "Check the background color brightblue."
    assert_run 'term::printf "%(BRIGHTMAGENTA)"' "0" "$(tput setab 13)" "Check the background color brightmagenta."
    assert_run 'term::printf "%(BRIGHTCYAN)"' "0" "$(tput setab 14)" "Check the background color brightcyan."
    assert_run 'term::printf "%(BRIGHTWHITE)"' "0" "$(tput setab 15)" "Check the background color brightwhite."
}

# Test short codes..
test::short_codes(){
    assert_run 'term::printf "%[-]"' "0" "${test_attr_sgr0}" "Check the short code (-) Reset attributes."
    assert_run 'term::printf "%[d]"' "0" "${test_attr_dim}" "Check the short code (d) Dim mode."
    assert_run 'term::printf "%[h]"' "0" "${test_attr_hide}" "Check the short code (h) Hide the cursor."
    assert_run 'term::printf "%[H]"' "0" "${test_attr_home}" "Check the short code (H) Moe the cursor home."
    assert_run 'term::printf "%[i]"' "0" "${test_attr_smir}" "Check the short code (i) Insert mode."
    assert_run 'term::printf "%[I]"' "0" "${test_attr_rmir}" "Check the short code (I) Exit insert."
    assert_run 'term::printf "%[l]"' "0" "${test_attr_bold}" "Check the short code (l) Bold mode."
    assert_run 'term::printf "%[L]"' "0" "${test_attr_clear}" "Check the short code (L) Clear the screen."
    assert_run 'term::printf "%[s]"' "0" "${test_attr_smso}" "Check the short code (s) Standout mode."
    assert_run 'term::printf "%[S]"' "0" "${test_attr_rmso}" "Check the short code (S) Exit standout mode."
    assert_run 'term::printf "%[t]"' "0" "${test_attr_sitm}" "Check the short code (t) Italics Mode."
    assert_run 'term::printf "%[T]"' "0" "${test_attr_ritm}" "Check the short code (T) Exit Italics mode."
    assert_run 'term::printf "%[u]"' "0" "${test_attr_smul}" "Check the short code (u) Underline mode."
    assert_run 'term::printf "%[U]"' "0" "${test_attr_rmul}" "Check the short code (U) Exit underline mode."
    assert_run 'term::printf "%[v]"' "0" "${test_attr_rev}" "Check the short code (v) Reverse mode."
    assert_run 'term::printf "%[V]"' "0" "${test_attr_invis}" "Check the short code (V) Invisible mode."
    assert_run 'term::printf "%[z]"' "0" "${test_attr_cnorm}" "Check the short code (z) Show the cursor."
    assert_run 'term::printf "%[o]"' "0" "${test_attr_op}" "Check the short code (o) Original colors."

    assert_run 'term::printf "%[k]"' "0" "$(tput setaf 0)" "Check the foreground color black."
    assert_run 'term::printf "%[r]"' "0" "$(tput setaf 1)" "Check the foreground color red."
    assert_run 'term::printf "%[g]"' "0" "$(tput setaf 2)" "Check the foreground color green."
    assert_run 'term::printf "%[y]"' "0" "$(tput setaf 3)" "Check the foreground color yellow."
    assert_run 'term::printf "%[b]"' "0" "$(tput setaf 4)" "Check the foreground color blue."
    assert_run 'term::printf "%[m]"' "0" "$(tput setaf 5)" "Check the foreground color magenta."
    assert_run 'term::printf "%[c]"' "0" "$(tput setaf 6)" "Check the foreground color cyan."
    assert_run 'term::printf "%[w]"' "0" "$(tput setaf 7)" "Check the foreground color white."

    assert_run 'term::printf "%[K]"' "0" "$(tput setab 0)" "Check the background color black."
    assert_run 'term::printf "%[R]"' "0" "$(tput setab 1)" "Check the background color red."
    assert_run 'term::printf "%[G]"' "0" "$(tput setab 2)" "Check the background color green."
    assert_run 'term::printf "%[Y]"' "0" "$(tput setab 3)" "Check the background color yellow."
    assert_run 'term::printf "%[B]"' "0" "$(tput setab 4)" "Check the background color blue."
    assert_run 'term::printf "%[M]"' "0" "$(tput setab 5)" "Check the background color magenta."
    assert_run 'term::printf "%[C]"' "0" "$(tput setab 6)" "Check the background color cyan."
    assert_run 'term::printf "%[W]"' "0" "$(tput setab 7)" "Check the background color white."
}

