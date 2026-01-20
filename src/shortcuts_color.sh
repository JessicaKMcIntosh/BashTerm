_TERM_CREATE_SHORTCUTS_COLOR(){
    local color

    # Terminal colors.
    declare -a _TERM_COLORS
    _TERM_COLORS=(
        "black"
        "red"
        "green"
        "yellow"
        "blue"
        "magenta"
        "cyan"
        "white"
        "brightblack"
        "brightred"
        "brightgreen"
        "brightyellow"
        "brightblue"
        "brightmagenta"
        "brightcyan"
        "brightwhite"
    )

    # Some handy shortcuts for less typing.
    for color in "${!_TERM_COLORS[@]}"; do
        declare -gx "TERM_FG_${_TERM_COLORS[color]^^}=$(tput setaf "${color}")"
        declare -gx "TERM_BG_${_TERM_COLORS[color]^^}=$(tput setab "${color}")"
    done
}
_TERM_CREATE_SHORTCUTS_COLOR

