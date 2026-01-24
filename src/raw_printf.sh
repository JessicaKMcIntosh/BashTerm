# Configuration.
declare -g _TERM_AWK_COMMAND="awk"
term::printf_setup(){
    local awk_command
    # mawk is generally faster than gawk.
    for awk_command in {m,}awk gawk ; do
        if command -v "${awk_command}" > /dev/null ; then
            declare -g _TERM_AWK_COMMAND="${awk_command}"
            break
        fi
    done
}
term::printf_setup
#_TERM_AWK_COMMAND="gawk --lint" # For development.

# Find the file printf.awk.
_TERM_AWK_FILE="$(find_library "printf.awk" 2>/dev/null)"
if [[ ! -f "${_TERM_AWK_FILE}" ]] ; then
    echo "Unable to locate 'printf.awk' in the current or parent directories."
    echo "ABORTING!!"
    exit 1
fi

# Print to STDOUT.
term::printf(){
    printf "%s\n" "${@}" | $_TERM_AWK_COMMAND -f "${_TERM_AWK_FILE}"
}

# Print to a variable.
term::printf-v(){
    local -n variable="${1}"
    shift
    # shellcheck disable=SC2034
    variable="$(term::printf "${@}")"
}
