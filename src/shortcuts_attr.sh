_TERM_CREATE_SHORTCUTS_ATTR(){
    local attribute

    # Create the shortcut variables.
    local -A _TERM_ATTRIBUTE_SHORTCUTS
    _TERM_ATTRIBUTE_SHORTCUTS=(
        [EXIT_INSERT]="rmir"
        [EXIT_ITALICS]="ritm"
        [EXIT_STANDOUT]="rmso"
        [EXIT_UNDERLINE]="rmul"
        [BOLD]="bold"
        [CLEAR]="clear"
        [DIM]="dim"
        [ORIG]="op"
        [INSERT]="smir"
        [INVISIBLE]="invis"
        [ITALICS]="sitm"
        [RESET]="sgr0"
        [REVERSE]="rev"
        [STANDOUT]="smso"
        [UNDERLINE]="smul"
    )

    for attribute in "${!_TERM_ATTRIBUTE_SHORTCUTS[@]}"; do
        declare -gx "TERM_${attribute}=$(tput "${_TERM_ATTRIBUTE_SHORTCUTS[$attribute]}")"
    done
}
_TERM_CREATE_SHORTCUTS_ATTR

