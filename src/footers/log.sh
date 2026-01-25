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

    echo "Usage: $0 [OPTIONS] MESSAGE"
    echo ""
    echo "Logs MESSAGE with a timestamp, log level and optional file name."
    echo ""
    echo "Options:"
    echo "    -C        Disable color."
    echo "    -d FORMAT Set the date format string. Try '%c'."
    echo "              Default: ${_TERM_LOG_DATE_FORMAT}"
    echo "    -E        Print several examples."
    echo "    -F FILE   Add an optional file name to the log message."
    echo "    -h        This text."
    echo "    -L LEVEL  Set the current log level."
    echo "    -l LEVEL  Log level for the message."
    echo ""
    echo "Log Levels:"
    for log_level in "${!_TERM_LOG_LEVELS[@]}" ; do
        printf "    [%d] %s" "${log_level}" "${_TERM_LOG_LEVELS[$log_level]}"
        [[ "${log_level}" == "${_TERM_LOG_LEVEL}" ]] && echo -n " (Default)"
        echo ""
    done
    echo ""
    echo "Environment variables:"
    echo "    TERM_LOG_DATE=FORMAT - Set the date format string. The same as '-d FORMAT'."
    echo "    TERM_LOG_LEVEL=LEVEL - Set the log level. The same as '-L LEVEL'."
    echo "    TERM_LOG_FILE=foo.sh - Set the lof file. The same as '-f foo.sh'."
    echo ""
    echo "Examples:"
    echo '    # ./log.sh -L "debug" -l "info" -f "foo.sh" -d "%c" "This is a test."'
    echo '    [Info ] <foo.sh> (Sat 1 Jan 2000 01:00:00 PM EST): This is a test.'
    echo ""
    echo '    # TERM_LOG_LEVEL=0 TERM_LOG_DATE="%c" TERM_LOG_FILE="bar.sh" ./log.sh -l "DEBUG" "This is a different test."'
    echo '    [Debug] <bar.sh> (Sat 1 Jan 2000 01:00:00 PM EST): This is a different test.'
    exit 1
}

# Some examples.
term::log_examples(){
    echo "Examples:"
    local command

    echo ""
    command="${0} "
    command+='"This is a simple example."'
    echo "Defaults."
    echo "# ${command}"
    eval "${command}"

    echo ""
    command="${0} "
    command+='-L "debug" -l "info" -f "foo.sh" -d "%c" "ALL THE OPTIONS!!!"'
    echo "Use all the options."
    echo "# ${command}"
    eval "${command}"

    echo ""
    command='TERM_LOG_LEVEL=0 TERM_LOG_DATE="%c" TERM_LOG_FILE="bar.sh" '
    command+="${0} "
    command+='-l "DEBUG" "This is a complex debug example."'
    echo "Settings in the environment."
    echo "# ${command}"
    eval "${command}"

    echo ""
    command='TERM_LOG_LEVEL=0 '
    command+="${0} "
    command+='-l "WARN" -f "B-9" -d "%Y-%m-%dT%H:%M:%S%z" "Warning! Warning! Danger Will Robinson!"'
    echo "More realistic."
    echo "# ${command}"
    eval "${command}"

    echo ""
    command="${0} "
    command+='-l "error" "This is a CRITICAL ERROR!"'
    echo "And an error."
    echo "# ${command}"
    eval "${command}"
}

# Do the logging thing.
term::log_main(){
    local log_level="1"
    local option
    _TERM_LOG_FILE="${TERM_LOG_FILE:-}" # No file by default since this script would be used.

    # Check command line args.
    while getopts ":Cd:Ef:hL:l:" option ; do
        case $option in
            C)  term::log_disable_color;;
            d)  _TERM_LOG_DATE_FORMAT="${OPTARG}";;
            E)  term::log_examples;;
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
        declare example_file="${0##*/}"
        example_file="${example_file%.*}"
        echo "For an example try:"
        printf "./examples/%s_example.sh\n" "${example_file}"
        echo ""
        echo "For help:"
        echo "${0} -h"
    else
        term::log_main "${@}"
    fi
fi
