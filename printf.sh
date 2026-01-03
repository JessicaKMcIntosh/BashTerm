#!/usr/bin/env bash
# shellcheck source=attr.sh
# shellcheck source=boxes.sh
# shellcheck source=color.sh
# shellcheck source=cursor.sh

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# A printf implementation with terminal attributes.

# This is really only an example.
# Adapt to your needs.

# Load the libraries.
find_library(){
    local library="${1}"
    for file_name in {./,../}${library} ; do
        if [[ -f  "${file_name}" ]] ; then
            echo "${file_name}"
        fi
done
}
source "$(find_library "attr.sh")"
source "$(find_library "boxes.sh")"
source "$(find_library "color.sh")"
source "$(find_library "cursor.sh")"

# Find the printf.awk file.
AWK_FILE="$(find_library "printf.awk")"
if [[ ! -f "${AWK_FILE}" ]] ; then
    echo "Unable to locate 'printf.awk' in the current or parent directories."
    echo "ABORTING!!"
    exit 1
fi

term::printf(){
    while [[ "$#" -gt 0 ]]; do
        echo "${1}"
        shift
    done | awk -f "${AWK_FILE}"
    # done | gawk --lint -f "${AWK_FILE}" # For development.
}
