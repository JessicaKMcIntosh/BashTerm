declare -g _TERM_AWK_COMMAND="awk"
term::find_awk() {
    local awk_command
    # mawk is generally faster than gawk.
    for awk_command in {m,}awk gawk; do
        if command -v "${awk_command}" > /dev/null; then
            declare -g _TERM_AWK_COMMAND="${awk_command}"
            break
        fi
    done
}
#_TERM_AWK_COMMAND="gawk --lint" # For development.
