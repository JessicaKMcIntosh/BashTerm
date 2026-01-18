# Default settings.
declare _TERM_LOG_FILE="${BASH_SOURCE[0]##*/}"
declare _TERM_LOG_LEVEL=${TERM_LOG_LEVEL:-1} # This would normally be INFO.
declare -a _TERM_LOG_LEVELS=("Debug" "Info" "Warn" "Error")
declare _TERM_LOG_MAX_LEVEL="$((${#_TERM_LOG_LEVELS[@]} - 1))"

# The formatting is broken up to assemble each piece with colors.
declare _TERM_LOG_FORMAT="%L%F%D: %M\n"
# %M is replaced with the log message.
# For these %s is replaced with the color escape codes then the value.
# Like this: printf "%s[%-5S%s] " $COLOR_CODE $LOG_LEVEL $COLOR_RESET
declare _TERM_LOG_FORMAT_DATE="(%s%s%s)"        # %D in _TERM_LOG_FORMAT
declare _TERM_LOG_FORMAT_FILE="<%s%s%s> "       # %F in _TERM_LOG_FORMAT
declare _TERM_LOG_FORMAT_LEVEL="[%s%-5s%s] "    # %L in _TERM_LOG_FORMAT
# The format string passed to the date command.
declare _TERM_LOG_DATE_COMMAND="${TERM_LOG_DATE:-"%Y-%m-%dT%H:%M:%S"}"

# Technicolor!
declare -a _TERM_LOG_COLORS=("blue" "green" "yellow" "red")
declare _TERM_LOG_COLOR_RESET="${TERM_RESET}"
declare _TERM_LOG_DATE_COLOR="magenta"
declare _TERM_LOG_FILE_COLOR="cyan"

# Create the shortcut log functions.
# Eg. term::log_info
declare _TERM_LOG_COMMAND
declare _TERM_LOG_LOG_LEVEL
for _TERM_LOG_LOG_LEVEL in "${!_TERM_LOG_LEVELS[@]}" ; do
    printf -v _TERM_LOG_COMMAND "term::log_%s() { term::log %d" "${_TERM_LOG_LEVELS[$_TERM_LOG_LOG_LEVEL],,}" "${_TERM_LOG_LOG_LEVEL}"
    # shellcheck disable=SC2016 # Duh...
    _TERM_LOG_COMMAND+=' "${@}"; }'
    eval "${_TERM_LOG_COMMAND}"
done
unset _TERM_LOG_TEMP

# Logging function.
term::log(){
    if [[ "${#}" -lt "2" ]] ; then
        echo "Insufficient arguments. Usage: term::log LOG_LEVEL LOG_MESSAGE"
        return 1
    fi
    local log_level="${1}"
    shift
    local log_message="${*}"

    # Make sure the log level is valid.
    log_level="$(term::_log_to_number "${log_level}")"

    # Print the message if the log level is high enough.
    if [[ "${log_level}" -ge "${_TERM_LOG_LEVEL}" ]] ; then
        term::_log_format "${log_level}" "${log_message}"
    fi
}

# Format the log output.
# shellcheck disable=SC2059 # I am abusing the format strings on purpose.
term::_log_format(){
    local log_level="${1}"
    local log_date=""
    local log_file=""
    local log_message="${2}"
    local log_level_color=""
    local log_output="${_TERM_LOG_FORMAT}"

    # Format the log date.
    printf -v log_date "${_TERM_LOG_FORMAT_DATE}" "${TERM_FG[$_TERM_LOG_DATE_COLOR]}" "$(date +"${_TERM_LOG_DATE_COMMAND}")" "${_TERM_LOG_COLOR_RESET}"
    log_output="${log_output/\%D/$log_date}"

    # Format the file name, if present.
    if [[ -n "${_TERM_LOG_FILE}" ]] ; then
        printf -v log_file "${_TERM_LOG_FORMAT_FILE}" "${TERM_FG[$_TERM_LOG_FILE_COLOR]}" "${_TERM_LOG_FILE}" "${_TERM_LOG_COLOR_RESET}"
        log_output="${log_output/\%F/$log_file}"
    fi

    # Format the log level.
    log_level_color="${_TERM_LOG_COLORS[$log_level]}"
    printf -v log_level "${_TERM_LOG_FORMAT_LEVEL}" "${TERM_FG[$log_level_color]}" "${_TERM_LOG_LEVELS[$log_level]}" "${_TERM_LOG_COLOR_RESET}"
    log_output="${log_output/\%L/$log_level}"

    # Print the log_message.
    log_output="${log_output/\%M/$log_message}"
    printf "${log_output}"
}

# Disable color output.
term::log_disable_color(){
    local color
    for color in "${!_TERM_LOG_COLORS[@]}" ; do
        # shellcheck disable=SC2004 # This isn't arithmetic.
        _TERM_LOG_COLORS[$color]=""
    done
    _TERM_LOG_COLOR_RESET=""
    _TERM_LOG_DATE_COLOR=""
    _TERM_LOG_FILE_COLOR=""
}

# Set or print _TERM_LOG_FILE.
# Set to '-' to clear the log file.
# Call with an argument to set the log file.
# Call without an argument to print the log file.
term::log_file(){
    if [[ "${#}" -ne "0" ]] ; then
        local log_file="${1}"
        if [[ -n "${log_file}" ]] ; then
            if [[ "${log_file}" == "-" ]] ; then
                _TERM_LOG_FILE=""
            else
                _TERM_LOG_FILE="${log_file}"
            fi
        fi
    else
        echo "${_TERM_LOG_FILE}"
    fi
}

# Set or print _TERM_LOG_LEVEL.
# Call with an argument to set the log level.
# Call without an argument to print the log level.
term::log_level(){
    if [[ "${#}" -ne "0" ]] ; then
        # Set the log level.
        local log_level="${1}"
        log_level="$(term::_log_to_number "${log_level}")"
        _TERM_LOG_LEVEL="${log_level}"
    else
        # Print the log level.
        echo "${_TERM_LOG_LEVEL}"
    fi
}

# Translate a log level string or number into a log level number.
# Handles:
#   Input                           | Output
#   Empty String                    | $_TERM_LOG_MAX_LEVEL
#   Number > $_TERM_LOG_MAX_LEVEL   | $_TERM_LOG_MAX_LEVEL
#   Number <= $_TERM_LOG_MAX_LEVEL  | Input
#   String in _TERM_LOG_LEVELS      | Corresponding number
#   String NOT in _TERM_LOG_LEVELS  | $_TERM_LOG_MAX_LEVEL
term::_log_to_number(){
    local log_level="${1:-}"
    local item

    # What was passed in?
    if [[ -z "${log_level}" ]] ; then
        # Empty string.
        log_level="${_TERM_LOG_MAX_LEVEL}"
    elif [[ "$((log_level + 0))" == "${log_level}" ]] ; then
        # A number.
        if [[ "${log_level}" -gt "${_TERM_LOG_MAX_LEVEL}" ]] ; then
            # The given log level is too large.
            log_level="${_TERM_LOG_MAX_LEVEL}"
        fi
    else
        # Search for the log level by string.
        for item in "${!_TERM_LOG_LEVELS[@]}" ; do
            if [[ "${log_level^^}" == "${_TERM_LOG_LEVELS[$item]^^}" ]] ; then
                log_level="${item}"
                item=""
                break
            fi
        done

        # Was the log level found?
        if [[ -n "${item}" ]] ; then
            log_level="${_TERM_LOG_MAX_LEVEL}"
        fi
    fi

    # Print the translated log level.
    echo "${log_level}"
}
