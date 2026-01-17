#!/usr/bin/env bash
# shellcheck source=../boxes.sh

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Draw boxes

# Load the library.
declare -a library_list=("boxes.sh")
find_library(){
    local library="${1}"
    for file_name in {../,./}${library} ; do
        if [[ -f  "${file_name}" ]] ; then
            echo "${file_name}"
        fi
done
}
#TERM_VERBOSE=0 # Uncomment for verbose library loading.
for library in "${library_list[@]}"; do
    source "$(find_library "${library}")" || exit 1
done

# Thoughts for later:
# Strip non-printable characters: foo="$(echo -e "This is a \ntest.")"; echo ">>${foo}<<"; echo "${foo//[[:cntrl:]]/}"
