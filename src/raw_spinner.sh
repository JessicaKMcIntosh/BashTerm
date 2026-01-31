# These are the main variables for the Library.
declare -g TERM_SPIN_SLEEP="0.1"
declare -a TERM_SPIN_FRAMES_SIX
declare -a TERM_SPIN_FRAMES_SIX_IN_OUT
declare -a TERM_SPIN_FRAMES_EIGHT
declare -a TERM_SPIN_FRAMES_EIGHT_IN_OUT
declare -a TERM_SPIN_FRAMES_ARROWS
declare -a TERM_SPIN_FRAMES_ASCII
declare -a TERM_SPIN_FRAMES_LINES

# _TERM_SPIN_SIX_SOLID=$'\u283F' # ⠿ Braille Pattern Dots-123456
TERM_SPIN_FRAMES_SIX=(
    $'\u2837' # ⠷ Braille Pattern Dots-12356
    $'\u282F' # ⠯ Braille Pattern Dots-12346
    $'\u281F' # ⠟ Braille Pattern Dots-12345
    $'\u283B' # ⠻ Braille Pattern Dots-12456
    $'\u283D' # ⠽ Braille Pattern Dots-13456
    $'\u283E' # ⠾ Braille Pattern Dots-23456
)

TERM_SPIN_FRAMES_SIX_IN_OUT=(
    $'\u283F' # ⠿ Braille Pattern Dots-123456
    $'\u2837' # ⠷ Braille Pattern Dots-12356
    $'\u2827' # ⠧ Braille Pattern Dots-1236
    $'\u2807' # ⠇ Braille Pattern Dots-123
    $'\u2803' # ⠃ Braille Pattern Dots-12
    $'\u2801' # ⠁ Braille Pattern Dots-1
    $'\u2800' # ⠀ Braille Pattern Blank
    $'\u2808' # ⠈ Braille Pattern Dots-4
    $'\u2818' # ⠘ Braille Pattern Dots-45
    $'\u2838' # ⠸ Braille Pattern Dots-456
    $'\u283C' # ⠼ Braille Pattern Dots-3456
    $'\u283E' # ⠾ Braille Pattern Dots-23456
)

# _TERM_SPIN_EIGHT_SOLID=$'\u28FF' # ⣿ Braille Pattern Dots-12345678
TERM_SPIN_FRAMES_EIGHT=(
    $'\u28F7' # ⣷ Braille Pattern Dots-1235678
    $'\u28EF' # ⣯ Braille Pattern Dots-1234678
    $'\u28DF' # ⣟ Braille Pattern Dots-1234578
    $'\u287F' # ⡿ Braille Pattern Dots-1234567
    $'\u28BF' # ⢿ Braille Pattern Dots-1234568
    $'\u28FB' # ⣻ Braille Pattern Dots-1245678
    $'\u28FD' # ⣽ Braille Pattern Dots-1345678
    $'\u28FE' # ⣾ Braille Pattern Dots-2345678
)

TERM_SPIN_FRAMES_EIGHT_IN_OUT=(
    $'\u28FF' # ⣿ Braille Pattern Dots-12345678
    $'\u28F7' # ⣷ Braille Pattern Dots-1235678
    $'\u28E7' # ⣧ Braille Pattern Dots-123678
    $'\u28C7' # ⣇ Braille Pattern Dots-12378
    $'\u2847' # ⡇ Braille Pattern Dots-1237
    $'\u2807' # ⠇ Braille Pattern Dots-123
    $'\u2803' # ⠃ Braille Pattern Dots-12
    $'\u2801' # ⠁ Braille Pattern Dots-1
    $'\u2800' # ⠀ Braille Pattern Blank
    $'\u2808' # ⠈ Braille Pattern Dots-4
    $'\u2818' # ⠘ Braille Pattern Dots-45
    $'\u2838' # ⠸ Braille Pattern Dots-456
    $'\u28B8' # ⢸ Braille Pattern Dots-4568
    $'\u28F8' # ⣸ Braille Pattern Dots-45678
    $'\u28FC' # ⣼ Braille Pattern Dots-345678
    $'\u28FE' # ⣾ Braille Pattern Dots-2345678
)

TERM_SPIN_FRAMES_ARROWS=(
    $'\u2191' # ↑ Upwards Arrow
    $'\u2197' # ↗ North East Arrow
    $'\u2192' # → Rightwards Arrow
    $'\u2198' # ↘ South East Arrow
    $'\u2193' # ↓ Downwards Arrow
    $'\u2199' # ↙ South West Arrow
    $'\u2190' # ← Leftwards Arrow
    $'\u2196' # ↖ North West Arrow
)

TERM_SPIN_FRAMES_LINES=(
    ' '
    $'\u2575' # ╵ Box Drawings Light Up
    $'\u2514' # └ Box Drawings Light Up and Right
    $'\u251C' # ├ Box Drawings Light Vertical and Right
    $'\u253C' # ┼ Box Drawings Light Vertical and Horizontal
    $'\u2540' # ╀ Box Drawings Up Heavy and Down Horizontal Light
    $'\u2544' # ╄ Box Drawings Right Up Heavy and Left Down Light
    $'\u254A' # ╊ Box Drawings Left Light and Right Vertical Heavy
    $'\u254B' # ╋ Box Drawings Heavy Vertical and Horizontal
    $'\u2548' # ╈ Box Drawings Up Light and Down Horizontal Heavy
    $'\u2545' # ╅ Box Drawings Left Down Heavy and Right Up Light
    $'\u253D' # ┽ Box Drawings Left Heavy and Right Vertical Light
    $'\u253C' # ┼ Box Drawings Light Vertical and Horizontal
    $'\u252C' # ┬ Box Drawings Light Down and Horizontal
    $'\u2510' # ┐ Box Drawings Light Down and Left
    $'\u2574' # ╴ Box Drawings Light Left
)

TERM_SPIN_FRAMES_ASCII=(
    "|"
    "/"
    "-"
    $'\\'
)

# State variables used internally.
declare -a _TERM_SPIN_FRAMES
declare -g _TERM_SPIN_NEXT_FRAME
declare -g _TERM_SPIN_TOTAL_FRAMES
declare -g _TERM_SPIN_PID

# This is just an example of how to use these.
# Adjust to suit your own needs.
# NOTE: This code only works with single character spinner frames.

# Initialize the spinner state variables.
# If an array of frames is not passed then default to TERM_SPIN_FRAMES_SIX.
term::spin_init() {
    if (($# > 0)); then
        _TERM_SPIN_FRAMES=("${@}")
    else
        _TERM_SPIN_FRAMES=("${TERM_SPIN_FRAMES_SIX[@]}")
    fi
    _TERM_SPIN_TOTAL_FRAMES="${#_TERM_SPIN_FRAMES[@]}"
    _TERM_SPIN_NEXT_FRAME=0
}

# Print the next spinner character.
# Moves the cursor left after printing the character.
# You would call this for each step to make the spinner advance.
term::spin_step() {
    echo -n "${_TERM_SPIN_FRAMES[${_TERM_SPIN_NEXT_FRAME}]}${TERM_LEFT}"
    # Doing the math this way eliminates pauses in the spinner.
    # Make sure the exact same work is done for each loop for consistent timing.
    _TERM_SPIN_NEXT_FRAME=$(((_TERM_SPIN_NEXT_FRAME + 1) % _TERM_SPIN_TOTAL_FRAMES))
}

# Spin until a key is pressed.
# Modify this to suit your needs.
term::spin_spin() {
    echo -n "${TERM_HIDE}"
    term::spin_init "${@}"
    while true; do
        term::spin_step
        if read -r -n 1 -s -t "${TERM_SPIN_SLEEP}"; then
            break
        fi
    done
    echo -n "${TERM_NORMAL}"
}
