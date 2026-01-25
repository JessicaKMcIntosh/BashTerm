# Print some help text.
term::menu_usage(){
    # Print any messages passed in.
    if [[ "$#" -gt 0 ]] ; then
        while [[ "$#" -gt 0 ]]; do
            echo "$1"
            shift
        done
        echo ""
    fi

    echo "Usage: $0 TITLE OPTIONS [MENU_LIST]"
    echo ""
    echo "Displays a menu with the given options."
    echo "See the file doc/menu.md' for usage."
    echo ""
    echo "Options:"
    echo "    -h        This text."
    echo ""
    echo "Example:"
    echo '# ./menu.sh "Test Menu" "" "Error?" "0|0|Exit"'
    echo ""
    echo "Output:"
    echo 'Test Menu'
    echo '1: Error?'
    echo '0: Exit'
    echo 'Select the option [10]:'
    exit 1
}

# Act like a useful script.
term::menu_main(){
    local option

    # Check command line args.
    while getopts ":h" option ; do
        case $option in
            h)  term::menu_usage;;
            *)  if [ "${OPTARG}" = "-" ] ; then
                    term::menu_usage # They probably only want help. Catches --help.
                else
                    term::menu_usage "Invalid option '${OPTARG}'." # Illegal option.
                fi;;
        esac
    done
    shift $((OPTIND - 1))

    # Print the message.
    if [[ "${#}" -gt "0" ]] ; then
        term::menu "${@}"
    fi
}

# If called directly then run menu or reference the example.
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
        # term::menu "${@}"
        term::menu_main "${@}"
    fi
fi
