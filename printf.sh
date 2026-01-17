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
declare -a library_list=("attr.sh" "boxes.sh" "color.sh" "cursor.sh")
find_library(){
    local library="${1}"
    local file_name
    for file_name in {./,../}${library} ; do
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

term::printf(){
    printf "%s\n" "${@}" | $_TERM_AWK_COMMAND -f "${_TERM_AWK_FILE}"
}
