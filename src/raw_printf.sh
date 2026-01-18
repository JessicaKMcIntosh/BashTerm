# Configuration.
_TERM_AWK_COMMAND="awk"
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
    variable="$(printf "%s\n" "${@}" | $_TERM_AWK_COMMAND -f "${_TERM_AWK_FILE}")"
}
