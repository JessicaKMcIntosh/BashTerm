_TERM_CREATE_SHORTCUTS_CURSOR() {
    # Temporary variables that are unset at the end of the script.
    local attribute

    # Some handy shortcuts for less typing.
    declare -A _TERM_CURSOR_SHORTCUTS
    _TERM_CURSOR_SHORTCUTS=(
        [CLR_BOL]="el1"
        [CLR_EOL]="el"
        [CLR_EOS]="ed"
        [DELETE_CHAR]="dch1"
        [DELETE_LINE]="dl1"
        [DOWN]="cud1"
        [HIDE]="civis"
        [HOME]="home"
        # [INSERT_CHAR]="ich1" # (Rarely present.)
        [INSERT_LINE]="il1"
        [LEFT]="cub1"
        [NORMAL]="cnorm"
        [RESTORE]="rc"
        [RIGHT]="cuf1"
        [SAVE]="sc"
        [SHOW]="cvvis"
        # [TO_LL]="ll" # (Rarely present.)
        [UP]="cuu1"
        [VISIBLE]="cvvis"
    )
    for attribute in "${!_TERM_CURSOR_SHORTCUTS[@]}"; do
        declare -x "TERM_${attribute}=$(tput "${_TERM_CURSOR_SHORTCUTS[$attribute]}")"
    done
}
_TERM_CREATE_SHORTCUTS_CURSOR
