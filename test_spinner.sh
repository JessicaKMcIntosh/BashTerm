#!/usr/bin/env bash
# shellcheck disable=SC2162

# Test the spinner library.

source "./spinner.sh"
source "./function.sh"

echo "Spinner demo!"

declare -a SPINNER_FRAMES
declare -a SPINNER_OPTIONS
SPINNER_OPTIONS=(
    "Six dots (${_TERM_SPIN_FRAMES_SIX[*]})"
    "Six dots in and out (${_TERM_SPIN_FRAMES_SIX_IN_OUT[*]})"
    "Eight dots (${_TERM_SPIN__TERM_SPIN_FRAMES_EIGHT[*]})"
    "Eight dots in and out (${_TERM_SPIN__TERM_SPIN_FRAMES_EIGHT_IN_OUT[*]})"
    "Arrows (${_TERM_SPIN_FRAMES_ARROWS[*]})"
    "Lines (${_TERM_SPIN_FRAMES_LINES[*]})"
    "ASCII (${_TERM_SPIN_FRAMES_ASCII[*]})"
)

# Make sure the cursor returns.
trap_exit(){
    echo ""
    term::show
    exit
}
trap trap_exit SIGINT

# Run the demo.
while true; do
    # What frame type do they want to demo?
    term::clear
    echo "Available frame types:"
    for option in "${!SPINNER_OPTIONS[@]}"; do
        echo "$((option + 1)): ${SPINNER_OPTIONS[$option]}"
    done
    echo "0: Exit"
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
        *) echo "Invalid option: '${REPLY}'"; exit;;
    esac
    echo ""
    echo "Press any kep to stop the demo."

    # Spin the spinner.
    term::spin_spin "${SPINNER_FRAMES[@]}"
    term::reset
    echo ""
done
