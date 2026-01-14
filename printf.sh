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

AWK_COMMAND="awk"
#AWK_COMMAND="gawk --lint" # For development.

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
for library in "${library_list[@]}"; do
    source "$(find_library "${library}")" > /dev/null 2>&1 || exit 1
done

# Find the file printf.awk.
AWK_FILE="$(find_library "printf.awk" 2>/dev/null)"
if [[ ! -f "${AWK_FILE}" ]] ; then
    echo "Unable to locate 'printf.awk' in the current or parent directories."
    echo "ABORTING!!"
    exit 1
fi

term::printf(){
    printf "%s\n" "${@}" | $AWK_COMMAND -f "${AWK_FILE}"
}
