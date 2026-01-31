#!/usr/bin/env bash
# shellcheck source=shortcuts_attr.sh
# shellcheck source=raw_boxes.sh
# shellcheck source=shortcuts_color.sh
# shellcheck source=raw_printf.sh
# shellcheck source=find_awk.sh

# Build the various libraries and files..

# This requires bash version 4.4 or later.
if [ -z "$BASH_VERSION" ]; then
    echo "Error: Bash version 4.4 or higher is required."
    exit 1
fi
if ((BASH_VERSINFO[0] < 4)) || ((BASH_VERSINFO[0] == 4 && BASH_VERSINFO[1] < 4)); then
    echo "Error: Bash version 4.4 or higher is required."
    echo "Current version: ${BASH_VERSION}"
    exit 1
fi

# Make sure we are in the src/ directory.
if [[ -d "src" ]]; then
    if ! cd src; then
        echo "Unable to CD to the directory 'src/'."
        echo "Aborting!!!"
        exit 1
    fi
fi
if [[ ! -f "make.sh" ]]; then
    echo "Run this from the 'BashTerm' or 'BashTerm/src' directories."
    echo "Aborting!!!"
    exit 1
fi

# This sequence is important or the file will not be loaded globally.
source "find_awk.sh"

# Create a single file.
build_file() {
    local library="${1}"
    local file_new="new/${library}.sh"

    # Build the file.
    ${_TERM_AWK_COMMAND} -f utilities/m1.awk -- "macros/${library}.m1" "macros/_library.m1" "macros/_example.m1" "macros/_standalone.m1"

    # Compare the old and new files.
    if [[ -f "${file_new}" ]]; then
        if ! diff "${file_new}" "../${library}.sh" > /dev/null 2>&1; then
            echo "The new and main files differ: ${file_new} ../${library}.sh"
        fi
    fi
}

# Create all of the files available.
create_files() {
    echo "Creating the files..."
    local library

    # Loop over the files creating the new files.
    for library in $(get_library_list); do
        build_file "${library}"
    done
}

# Create files from the command line args.
create_file_args() {
    local library

    for library in "${@}"; do
        if [[ -f "macros/${library}.m1" ]]; then
            build_file "${library}"
        else
            echo "Unknown library '${library}'."
        fi
    done
}

create_output_directories() {
    local -a directory_list=("new" "../standalone")
    local directory

    for directory in "${directory_list[@]}"; do
        if ! mkdir -p "${directory}"; then
            echo "Error creating the directory '${directory}'."
            echo "Aborting!!!"
            exit 1
        fi
    done
}

# Get the description of a library.
get_file_description() {
    local library="${1}"
    ${_TERM_AWK_COMMAND} -f utilities/m1.awk -- "macros/${library}.m1" "macros/_description.m1"
}

# Print the library names one per line.
get_library_list() {
    local library_file
    local library_name
    for library_file in macros/[a-z]*.m1; do
        library_name=${library_file##*/}
        library_name=${library_name%.*}
        echo "${library_name}"
    done
}

# Print some help text.
usage() {
    local library
    # Print any messages passed in.
    if (($# > 0)); then
        while (($# > 0)); do
            echo "$1"
            shift
        done
        echo ""
    fi

    # Some extra box characters. See '../alt_boxes.sh'.
    # Variables that start with 'TERM_BOX_' can be used in term::printf.
    # For example to print '╫' use the command 'term::printf "%<BDVDHS>"'.
    export TERM_BOX_BDVDLS=$'\u2562' # ╢ Box Drawings Vertical Double and Left Single
    export TERM_BOX_BDVDRS=$'\u255F' # ╟ Box Drawings Vertical Double and Right Single
    export TERM_BOX_BDVDHS=$'\u256B' # ╫ Box Drawings Vertical Double and Horizontal Single

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
    for library in $(get_library_list); do
        term::printf "%<DLV> %-10s %<DLV> %-65s %<DLV>\n" \
            "${library}" \
            "$(get_file_description "${library}")"
    done
    term::printf "%<DBL,DLH@12,DBC,DLH@67,DBR>\n"
    exit 1
}

# Main routine.
main() {
    local option

    # Locate the AWK command.
    term::find_awk
    if [[ -z ${_TERM_AWK_COMMAND} ]]; then
        echo "Unable to locate the AWK command."
        echo "Aborting!!!"
        exit 1
    fi

    # Check command line args.
    while getopts ":h" option; do
        case $option in
            h) usage ;;
            *) if [ "${OPTARG}" = "-" ]; then
                usage # They probably only want help. Catches --help.
            else
                usage "Invalid option '${OPTARG}'." # Illegal option.
            fi ;;
        esac
    done
    shift $((OPTIND - 1))

    # Make sure the output directories exist.
    create_output_directories

    if (($# > 0)); then
        create_file_args "${@}"
    else
        # Build all of the files.
        create_files "${@}"
    fi
}

main "${@}"
