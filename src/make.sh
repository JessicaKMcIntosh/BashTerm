#!/usr/bin/env bash
# shellcheck source=shortcuts_attr.sh
# shellcheck source=raw_boxes.sh
# shellcheck source=shortcuts_color.sh
# shellcheck source=raw_printf.sh

# Make the files in the main directory.

# Configuration:

# Files to create.
# Values are the dependencies.
declare -a FILE_LIST
FILE_LIST=("attr" "boxes" "color" "cursor" "function" "log" "menu" "printf" "spinner")

# Figure out the AWK command.
declare -g _TERM_AWK_COMMAND="awk"
term::find_awk(){
    local awk_command
    # mawk is generally faster than gawk.
    for awk_command in {m,}awk gawk ; do
        if command -v "${awk_command}" > /dev/null ; then
            declare -g _TERM_AWK_COMMAND="${awk_command}"
            break
        fi
    done
}

build_file(){
    local library="${1}"
    local file_new="new/${library}.sh"
    ${_TERM_AWK_COMMAND} -f utilities/m1.awk -- -DNEW_FILE=1 "${library}.m1"
    ${_TERM_AWK_COMMAND} -f utilities/m1.awk -- -DSTANDLONE=1 "${library}.m1"
    chmod +x "${file_new}"

    # Compare the old and new files.
    if ! diff "${file_new}" "../${library}.sh" > /dev/null 2>&1; then
        echo "The new and main files differ: ${file_new} ../${library}.sh"
    fi
}

create_files(){
    echo "Creating the main files..."
    local library

    # Loop over the files creating the new files.
    mkdir -p new
    mkdir -p ../standalone
    for library in "${FILE_LIST[@]}" ; do
        build_file "${library}"
    done
}

get_file_descr(){
    local library="${1}"
    ${_TERM_AWK_COMMAND} -f utilities/m1.awk -- -DPRINT_DESCR=1 "${library}.m1"
}

# Print some help text.
usage(){
    local library
    # Print any messages passed in.
    if [[ "$#" -gt 0 ]] ; then
        while [[ "$#" -gt 0 ]]; do
            echo "$1"
            shift
        done
        echo ""
    fi

    # Some extra box characters. See '../alt_boxes.sh'.
    export TERM_BOX_BDVDLS=$'\u2562'   # ╢ Box Drawings Vertical Double and Left Single
    export TERM_BOX_BDVDRS=$'\u255F'   # ╟ Box Drawings Vertical Double and Right Single
    export TERM_BOX_BDVDHS=$'\u256B'   # ╫ Box Drawings Vertical Double and Horizontal Single

    # Load the attribute, box and printf libraries.
    source "shortcuts_attr.sh"
    source "raw_boxes.sh"
    #source "shortcuts_color.sh" # Color is not currently used.
    source "raw_printf.sh"

    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Builds the main library files from the pieces in the src directory."
    echo "To build a single file give the file base name from the list below."
    echo ""
    echo "Options:"
    echo "    -h        This text."
    echo ""
    echo "Files:"

    term::printf "%<DTL,DLH@12,DTC,DLH@67,DTR>\n"
    term::printf "%<DLV> %(bold)%-10s%(reset) %<DLV> %(bold)%-65s%(reset) %<DLV>\n" "File" "Description"
    term::printf "%<BDVDRS,LLH@12,BDVDHS,LLH@67,BDVDLS>\n"
    for library in "${FILE_LIST[@]}" ; do
        term::printf "%<DLV> %-10s %<DLV> %-65s %<DLV>\n" \
           "${library}" \
            "$(get_file_descr "${library}")"
    done
    term::printf "%<DBL,DLH@12,DBC,DLH@67,DBR>\n"
    exit 1
}

# Main routine.
main(){
    local option

    # Make sure we are in the src/ directory.
    if [[ -d "src" ]] ; then
        cd src || exit 1
    fi
    if [[ ! -f "make.sh" ]] ; then
        echo "Run this from the 'BashTerm' or 'BashTerm/src' directories."
        echo "Aborting!!!"
        exit 1
    fi

    # Locate the AWK command.
    term::find_awk

    # Check command line args.
    while getopts ":h" option ; do
        case $option in
            h)  usage;;
            *)  if [ "${OPTARG}" = "-" ] ; then
                    usage # They probably only want help. Catches --help.
                else
                    usage "Invalid option '${OPTARG}'." # Illegal option.
                fi;;
        esac
    done
    shift $((OPTIND - 1))

    if [[ "${#}" -gt "0" ]] ; then
        # Build a list of files.
        while [[ "$#" -gt 0 ]]; do
            if [[ -v FILE_LIST[$1] ]] ; then
                build_file "${1}"
            else
                echo "Unknown library '${1}'."
            fi
            shift
            [[ "$#" -gt 0 ]] && echo ""
        done
    else
        # Build all of the files.
        create_files "${@}"
    fi
}

main "${@}"
