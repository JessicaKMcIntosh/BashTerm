#!/usr/bin/env bash
# shellcheck source=../spinner.sh
# shellcheck disable=SC2162 # Backspaces will not be read.

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Example of using the spinner library.

# Load the libraries.
declare -a library_list=("spinner.sh")
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
for library in "${library_list[@]}"; do
    source "$(find_library "${library}")" > /dev/null 2>&1 || exit 1
done

echo "Spinner demo!"

declare -a SPINNER_FRAMES   # Frame set to use.
declare -a SPINNER_MENU     # User menu.
SPINNER_MENU=(
    "Six dots (${TERM_SPIN_FRAMES_SIX[*]})"
    "Six dots in and out (${TERM_SPIN_FRAMES_SIX_IN_OUT[*]})"
    "Eight dots (${_TERM_SPIN_TERM_SPIN_FRAMES_EIGHT[*]})"
    "Eight dots in and out (${_TERM_SPIN_TERM_SPIN_FRAMES_EIGHT_IN_OUT[*]})"
    "Arrows (${TERM_SPIN_FRAMES_ARROWS[*]})"
    "Lines (${TERM_SPIN_FRAMES_LINES[*]})"
    "ASCII (${TERM_SPIN_FRAMES_ASCII[*]})"
)

# Make sure the cursor returns.
# Otherwise if Ctrl-C is pressed while spinning
# the cursor would stay hidden.
reset_cursor(){
    echo "${TERM_NORMAL}"
    exit
}
trap reset_cursor EXIT

# Simple floating point math.
float_math(){
    echo "${@}" | awk '$1=="+" {print $2 + $3;} $1=="-" {print $2 - $3;}'
}

# Run the demo.
while true; do
    # What frame type do they want to demo?
    echo -n "${TERM_CLEAR}"
    echo "Available frame types:"
    for option in "${!SPINNER_MENU[@]}"; do
        echo "$((option + 1)): ${SPINNER_MENU[$option]}"
    done
    echo "0: Exit"
    echo "+ / -: Faster / Slower frame rate (0.1s). Currently: ${TERM_SPIN_SLEEP}s"
    read -n 1 -p "Select the frame set to demo: "
    echo ""
    case "${REPLY}" in
        1) SPINNER_FRAMES=("${TERM_SPIN_FRAMES_SIX[@]}");;
        2) SPINNER_FRAMES=("${TERM_SPIN_FRAMES_SIX_IN_OUT[@]}");;
        3) SPINNER_FRAMES=("${TERM_SPIN_FRAMES_EIGHT[@]}");;
        4) SPINNER_FRAMES=("${TERM_SPIN_FRAMES_EIGHT_IN_OUT[@]}");;
        5) SPINNER_FRAMES=("${TERM_SPIN_FRAMES_ARROWS[@]}");;
        6) SPINNER_FRAMES=("${TERM_SPIN_FRAMES_LINES[@]}");;
        7) SPINNER_FRAMES=("${TERM_SPIN_FRAMES_ASCII[@]}");;
        0|""|" ") exit;;
        +|=) TERM_SPIN_SLEEP="$(float_math "+" "${TERM_SPIN_SLEEP}" "0.1")"; continue;;
        -) TERM_SPIN_SLEEP="$(float_math "-" "${TERM_SPIN_SLEEP}" "0.1")"; continue;;
        *) echo "Invalid option: '${REPLY}'"; exit;;
    esac
    echo ""
    echo "Press any kep to stop the demo."

    # Spin the spinner.
    term::spin_spin "${SPINNER_FRAMES[@]}"
    echo ""
done
