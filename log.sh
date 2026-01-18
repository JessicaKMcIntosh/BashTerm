#!/usr/bin/env bash
# shellcheck source=attr.sh
# shellcheck source=color.sh

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# A library for logging.

# This requires bash version 4.
if [[ "${BASH_VERSINFO[0]}" -lt "4" ]] ; then
    echo "This script requires Bash 4 or later."
    echo "Current version: ${BASH_VERSION}"
    exit 1
fi

# Only load the library once.
declare -A _TERM_LOADED # Track loaded files.
declare _TERM_FILE_NAME="${BASH_SOURCE[0]##*/}"
if [[ -v _TERM_LOADED[${_TERM_FILE_NAME}] ]] ; then
    [[ -v TERM_VERBOSE ]] && echo "Already loaded '${_TERM_FILE_NAME}'."
    return 0
fi
_TERM_LOADED[${_TERM_FILE_NAME}]="${BASH_SOURCE[0]}"
[[ -v TERM_VERBOSE ]] && echo "Loading '${_TERM_FILE_NAME}'..."
unset _TERM_FILE_NAME

# Load the libraries.
declare -a library_list=("attr.sh" "color.sh")
find_library(){
    local library="${1}"
    local file_name
    for file_name in {../,./}${library} ; do
        if [[ -f  "${file_name}" ]] ; then
            echo "${file_name}"
            exit
        fi
    done
    echo "Unable to locate the library '${library}'." >&2
    exit 1
}
#TERM_VERBOSE=0 # Uncomment for verbose library loading.
declare _TERM_LOAD_LIBRARY
for _TERM_LOAD_LIBRARY in "${library_list[@]}"; do
    source "$(find_library "${_TERM_LOAD_LIBRARY}")" || exit 1
done
unset _TERM_LOAD_LIBRARY

# Default settings.
declare _TERM_LOG_FILE="${BASH_SOURCE[0]##*/}"
declare _TERM_LOG_LEVEL=${TERM_LOG_LEVEL:-1} # This would normally be INFO.
declare _TERM_LOG_DATE_FORMAT="${TERM_LOG_DATE:-"%Y-%m-%d_%H:%M:%S"}"
declare -a _TERM_LOG_LEVELS=("Debug" "Info" "Warn" "Error")
declare _TERM_LOG_MAX_LEVEL="${#_TERM_LOG_LEVELS[@]}"
((_TERM_LOG_MAX_LEVEL--)) || true

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
        echo "Insufficient arguments."
        return 1
    fi
    local log_level="${1}"
    shift
    local log_text="${*}"
    local log_level_color=""
    local log_level_file=""

    # Make sure the log level is valid.
    log_level="$(term::_log_to_number "${log_level}")"

    # Print the message if the log level is high enough.
    if [[ "${log_level}" -ge "${_TERM_LOG_LEVEL}" ]] ; then
        # Set the logging colors.
        log_level_color="${_TERM_LOG_COLORS[$log_level]}"
        if [[ -n "${_TERM_LOG_FILE}" ]] ; then
            printf -v log_level_file "<%s%s%s> " "${TERM_FG[$_TERM_LOG_FILE_COLOR]}" "${_TERM_LOG_FILE}" "${_TERM_LOG_COLOR_RESET}"
        fi
        printf "[%s%-5s%s] %s(%s%s%s): %s\n" \
               "${TERM_FG[$log_level_color]}" "${_TERM_LOG_LEVELS[$log_level]}" "${_TERM_LOG_COLOR_RESET}" \
               "${log_level_file}" \
               "${TERM_FG[$_TERM_LOG_DATE_COLOR]}" "$(date +"${_TERM_LOG_DATE_FORMAT}")" "${_TERM_LOG_COLOR_RESET}" \
               "${log_text}"
    fi
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

# Set or print the _TERM_LOG_LEVEL.
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
        echo "${_TERM_LOG_MAX_LEVEL}"
        return
    elif [[ "$((log_level + 0))" == "${log_level}" ]] ; then
        # A number.
        if [[ "${log_level}" -gt "${_TERM_LOG_MAX_LEVEL}" ]] ; then
            # The given log level is too large.
            log_level="${_TERM_LOG_MAX_LEVEL}"
        fi
    else
        # Not a number search for it by string.
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

# Print some help text.
term::log_usage(){
    local log_level
    # Print any messages passed in.
    if [[ "$#" -gt 0 ]] ; then
        while [[ "$#" -gt 0 ]]; do
            echo "$1"
            shift
        done
        echo ""
    fi

    echo "Usage: $0 [ARGS] MESSAGE"
    echo ""
    echo "Logs MESSAGE with a date and time."
    echo "Default log level: ${_TERM_LOG_LEVEL}"
    echo ""
    echo "Args:"
    echo "    -C        Disable color."
    echo "    -d FORMAT Set the date format string. Try '%c'."
    echo "              Default: ${_TERM_LOG_DATE_FORMAT}"
    echo "    -F FILE   Add an optional file name to the log message."
    echo "    -h        This text."
    echo "    -L LEVEL  Set the current log level."
    echo "    -l LEVEL  Log level for the message."
    echo ""
    echo "Log Levels:"
    for log_level in "${!_TERM_LOG_LEVELS[@]}" ; do
        printf "    [%d] %s\n" "${log_level}" "${_TERM_LOG_LEVELS[$log_level]}"
    done
    echo ""
    echp "Environment variables:"
    echo "    TERM_LOG_DATE=FORMAT - Set the date format string. The same as '-d FORMAT'."
    echo "    TERM_LOG_LEVEL=LEVEL - Set the log level. The same as '-L LEVEL'."
    echo "    TERM_LOG_FILE=foo.sh - Set the lof file. The same as '-f foo.sh'."
    echo ""
    echo "Examples:"
    echo '    # ./log.sh -L "debug" -l "info" -f "foo.sh" -d "%c" "This is a test."'
    echo '    [Info ] <foo.sh> (Sat 1 Jan 2000 01:00:00 PM EST): This is a test.'
    echo '    # TERM_LOG_LEVEL=1 TERM_LOG_DATE="%c" TERM_LOG_FILE="bar.sh" ./log.sh -l "WARN" "This is a different test."'
    echo '    [Debug] <bar.sh> (Sat 1 Jan 2000 01:00:00 PM EST): This is a different test.'
    exit 1
}

# Do the logging thing.
term::log_main(){
    local log_level="1"
    local option
    _TERM_LOG_FILE="${TERM_LOG_FILE:-}" # No file by default since this script would be used.

    # Check command line args.
    while getopts ":Cd:f:hL:l:" option ; do
        case $option in
            C)  term::log_disable_color;;
            d)  _TERM_LOG_DATE_FORMAT="${OPTARG}";;
            f)  _TERM_LOG_FILE="${OPTARG}";;
            h)  term::log_usage;;
            L)  term::log_level "${OPTARG}";;
            l)  log_level="${OPTARG}";;
            *)  if [ "${OPTARG}" = "-" ] ; then
                    term::log_usage # They probably only want help. Catches --help.
                else
                    term::log_usage "Invalid option '${OPTARG}'." # Illegal option.
                fi;;
        esac
    done
    shift $((OPTIND - 1))

    # Print the message.
    if [[ "${#}" -gt "0" ]] ; then
        term::log "${log_level}" "${*}"
    fi
}

# If called directly then suggest the example or do some logging.
if [[ "${0}" == "${BASH_SOURCE[0]}" ]] ; then
    if [[ "${#}" -eq "0" ]] ; then
        echo "For an example try:"
        echo "./examples/log_example.sh"
        echo ""
        echo "For help:"
        echo "${0} -h"
    else
        term::log_main "${@}"
    fi
fi
