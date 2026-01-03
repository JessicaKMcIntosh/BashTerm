#!/usr/bin/env bash
# shellcheck source=../function.sh
# shellcheck source=../spinner.sh
# shellcheck disable=SC2162 # Backspaces will not be read.

# Example of using the spinner library.

# Load libraries.
# Load the libraries.
find_library(){
    local library="${1}"
    for file_name in {./,../}${library} ; do
        if [[ -f  "${file_name}" ]] ; then
            echo "${file_name}"
        fi
done
}
source "$(find_library "function.sh")"
source "$(find_library "spinner.sh")"

echo "Spinner demo!"

declare -a SPINNER_FRAMES   # Frame set to use.
declare -a SPINNER_MENU     # User menu.
SPINNER_MENU=(
    "Six dots (${_TERM_SPIN_FRAMES_SIX[*]})"
    "Six dots in and out (${_TERM_SPIN_FRAMES_SIX_IN_OUT[*]})"
    "Eight dots (${_TERM_SPIN__TERM_SPIN_FRAMES_EIGHT[*]})"
    "Eight dots in and out (${_TERM_SPIN__TERM_SPIN_FRAMES_EIGHT_IN_OUT[*]})"
    "Arrows (${_TERM_SPIN_FRAMES_ARROWS[*]})"
    "Lines (${_TERM_SPIN_FRAMES_LINES[*]})"
    "ASCII (${_TERM_SPIN_FRAMES_ASCII[*]})"
)

# Make sure the cursor returns.
# Otherwise if Ctrl-C is pressed while spinning
# the cursor would stay hidden.
trap_exit(){
    echo ""
    term::normal
    exit
}
trap trap_exit SIGINT

# Simple floating point math.
float_math(){
    echo "${@}" | awk '$1=="+" {print $2 + $3;} $1=="-" {print $2 - $3;}'
}

# Run the demo.
while true; do
    # What frame type do they want to demo?
    term::clear
    echo "Available frame types:"
    for option in "${!SPINNER_MENU[@]}"; do
        echo "$((option + 1)): ${SPINNER_MENU[$option]}"
    done
    echo "0: Exit"
    echo "+ / -: Faster / Slower frame rate (0.1s). Currently: ${TERM_SPIN_SLEEP}s"
    read -n 1 -p "Select the frame set to demo: "
    echo ""
    case "${REPLY}" in
        1) SPINNER_FRAMES=("${_TERM_SPIN_FRAMES_SIX[@]}");;
        2) SPINNER_FRAMES=("${_TERM_SPIN_FRAMES_SIX_IN_OUT[@]}");;
        3) SPINNER_FRAMES=("${_TERM_SPIN_FRAMES_EIGHT[@]}");;
        4) SPINNER_FRAMES=("${_TERM_SPIN_FRAMES_EIGHT_IN_OUT[@]}");;
        5) SPINNER_FRAMES=("${_TERM_SPIN_FRAMES_ARROWS[@]}");;
        6) SPINNER_FRAMES=("${_TERM_SPIN_FRAMES_LINES[@]}");;
        7) SPINNER_FRAMES=("${_TERM_SPIN_FRAMES_ASCII[@]}");;
        0|""|" ") exit;;
        +) TERM_SPIN_SLEEP="$(float_math "+" "${TERM_SPIN_SLEEP}" "0.1")"; continue;;
        -) TERM_SPIN_SLEEP="$(float_math "-" "${TERM_SPIN_SLEEP}" "0.1")"; continue;;
        *) echo "Invalid option: '${REPLY}'"; exit;;
    esac
    echo ""
    echo "Press any kep to stop the demo."

    # Spin the spinner.
    term::spin_spin "${SPINNER_FRAMES[@]}"
    term::reset
    echo ""
done
