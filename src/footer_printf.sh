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

    echo "Usage: $0 FORMAT [ARGUMENT]"
    echo ""
    echo "Prints the format string using any given ARGUMENT(S)."
    echo ""
    echo "Options:"
    echo "    -h        This text."
    exit 1
}

# Act like a useful script.
term::printf_main(){
    local option

    # Check command line args.
    while getopts ":h" option ; do
        case $option in
            h)  term::log_usage;;
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
        term::printf "${@}"
    fi
}

# If called directly then run printf or reference the example.
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
        # term::printf "${@}"
        term::printf_main "${@}"
    fi
fi
