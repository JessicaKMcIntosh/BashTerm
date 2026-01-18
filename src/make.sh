#!/usr/bin/env bash

# Make the files in the main directory.

# Configuration:

# Files to create.
# Values are the dependencies.
declare -A FILE_LIST
FILE_LIST=(
    [attr]=""
    [boxes]=""
    [color]=""
    [cursor]=""
    [function]="attr.sh,boxes.sh,color.sh,cursor.sh"
    [log]="attr.sh,color.sh"
    [menu]="attr.sh"
    [printf]="attr.sh,boxes.sh,color.sh,cursor.sh"
    [spinner]="attr.sh,cursor.sh"
)

# File Descriptions.
declare -A FILE_DESCR
FILE_DESCR=(
[attr]="# A library of useful code for working with terminal attributes.

# See 'man 5 terminfo' for more information."
[boxes]="# A library of unicode box drawing characters.

# See the following resources:
# https://www.compart.com/en/unicode/block/U+2500
# https://en.wikipedia.org/wiki/Box-drawing_characters"
[color]="# A library of useful code for working with terminal colors.

# See 'man 5 terminfo' for more information."
[cursor]="# A library of useful code for working with terminal cursors.

# See 'man 5 terminfo' for more information."
[function]="# This is a functional interface to the variables.
# If that is something you want... :shrug:

# I recommend picking and choosing what you want."
[log]="# A library for logging."
[menu]="# A library for making menus."
[printf]="# A printf implementation with terminal attributes.

# This is really only an example.
# Adapt to your needs."
[spinner]="# A simple spinner using Unicode characters.

# See 'man 5 terminfo' for more information."
)

build_dependencies(){
    local dependencies="${1}"
    local -a list

    # Return of there are no dependencies.
    if [[ -z "${dependencies}" ]] ; then
        return
    fi

    IFS="," read -r -a list <<< "${dependencies}"
    echo "# Load the libraries."
    echo "declare -a library_list=("
    printf '"%s"\n' "${list[@]}"
    echo ")"
    cat "load_libraries.sh"
    echo ""
}

create_files(){
    echo "Creating the main files..."
    local library
    local file_raw
    local file_header
    local file_footer
    local file_new
    local dependencies

    # Make sure we are in the src/ directory.
    if [[ -d "src" ]] ; then
        cd src || exit 1
    fi
    if [[ ! -f "make.sh" ]] ; then
        echo "Run this from the 'BashTerm' or 'BashTerm/src' directories."
        echo "Aborting!!!"
        exit 1
    fi

    # Loop over the files creating the new files.
    mkdir -p new
    for library in "${!FILE_LIST[@]}" ; do
        printf "\nCreating Library %s...\n" "${library}"

        # Figure out the source files.
        printf -v file_raw "raw_%s.sh" "${library}"
        printf -v file_header "header_%s.sh" "${library}"
        [[ -f "${file_header}" ]] || file_header="header.sh"
        printf -v file_footer "footer_%s.sh" "${library}"
        [[ -f "${file_footer}" ]] || file_footer="footer.sh"
        dependencies="${FILE_LIST[$library]}"

        # Make sure the raw file exists.
        if [[ ! -f "${file_raw}" ]] ; then
            echo "WARNING! Missing raw file: ${file_raw}"
            exit 1
        fi

        # Feedback.
        printf "      Raw File: %s\n" "${file_raw}"
        printf "   Header File: %s\n" "${file_header}"
        printf "   Footer File: %s\n" "${file_footer}"
        printf "  Dependencies: %s\n" "${dependencies}"

        # Build the file.
        file_new="new/${library}.sh"
        {
            cat shebang.sh
            echo ""
            if [[ -v FILE_DESCR[$library]`` ]] ; then
                echo "${FILE_DESCR[$library]}"
                echo ""
            fi
            cat "${file_header}"
            echo ""
            build_dependencies "${dependencies}"
            cat "${file_raw}"
            echo ""
            cat "${file_footer}"
        } > "${file_new}"
        chmod +x "${file_new}"
    done
}

create_files "${@}"