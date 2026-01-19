#!/usr/bin/env bash
# shellcheck source=../spinner.sh
# shellcheck disable=SC2162 # Backspaces will not be read.

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Example of using the spinner library.

# Load the libraries.
declare -a library_list=("spinner.sh" "menu.sh")
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
#TERM_VERBOSE=0 # Uncomment for verbose library loading.
declare _TERM_LOAD_LIBRARY
# shellcheck disable=SC2167 # Go home Shellcheck, you are drunk.
for _TERM_LOAD_LIBRARY in "${library_list[@]}"; do
    source "$(find_library "${_TERM_LOAD_LIBRARY}")" || exit 1
done
unset _TERM_LOAD_LIBRARY

declare -a SPINNER_FRAMES   # Frame set to use.
declare -a SPINNER_MENU     # User menu.
SPINNER_MENU=(
    "||Six dots (${TERM_SPIN_FRAMES_SIX[*]})"
    "||Six dots in and out (${TERM_SPIN_FRAMES_SIX_IN_OUT[*]})"
    "||Eight dots (${_TERM_SPIN_TERM_SPIN_FRAMES_EIGHT[*]})"
    "||Eight dots in and out (${_TERM_SPIN_TERM_SPIN_FRAMES_EIGHT_IN_OUT[*]})"
    "||Arrows (${TERM_SPIN_FRAMES_ARROWS[*]})"
    "||Lines (${TERM_SPIN_FRAMES_LINES[*]})"
    "||ASCII (${TERM_SPIN_FRAMES_ASCII[*]})"
    "0|0|Exit"
    "+|100|Faster frame rate (+0.1s)"
    "-|101|Slower frame rate (-0.1s)"
    "q|0|~" # Secret key to quit.
    "x|0|~" # Another secret key to quit.
    "~||" # Replaced later with the current frame rate.
)
declare SPINNER_OPTIONS="clear|promptSelect the frame set [~]: "

# Make sure the cursor returns.
# Otherwise if Ctrl-C is pressed while spinning
# the cursor would stay hiding.
reset_cursor(){
    echo "${TERM_NORMAL}"
    exit
}
trap reset_cursor EXIT

# Simple floating point math.
float_math(){
    echo "${@}" | awk '$1=="+" {print $2 + $3;} $1=="-" {print $2 - $3;}'
}

# Run the example.
while true; do
    # Present the menu.
    SPINNER_MENU[-1]="~||Frame rate currently: ${TERM_SPIN_SLEEP}s"
    term::menu "Spinner Example" "${SPINNER_OPTIONS}" "${SPINNER_MENU[@]}"
    RC="${?}"

    # Process the result.
    case "${RC}" in
        1) SPINNER_FRAMES=("${TERM_SPIN_FRAMES_SIX[@]}");;
        2) SPINNER_FRAMES=("${TERM_SPIN_FRAMES_SIX_IN_OUT[@]}");;
        3) SPINNER_FRAMES=("${TERM_SPIN_FRAMES_EIGHT[@]}");;
        4) SPINNER_FRAMES=("${TERM_SPIN_FRAMES_EIGHT_IN_OUT[@]}");;
        5) SPINNER_FRAMES=("${TERM_SPIN_FRAMES_ARROWS[@]}");;
        6) SPINNER_FRAMES=("${TERM_SPIN_FRAMES_LINES[@]}");;
        7) SPINNER_FRAMES=("${TERM_SPIN_FRAMES_ASCII[@]}");;
        100|=) TERM_SPIN_SLEEP="$(float_math "+" "${TERM_SPIN_SLEEP}" "0.1")"; continue;;
        101) TERM_SPIN_SLEEP="$(float_math "-" "${TERM_SPIN_SLEEP}" "0.1")"; continue;;
        0|""|" ") exit;;
    esac
    echo ""
    echo "Press any key to stop the demo."

    # Spin the spinner.
    term::spin_spin "${SPINNER_FRAMES[@]}"
done
