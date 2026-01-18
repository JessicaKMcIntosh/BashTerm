find_library(){
    local library="${1}"
    local file_name
    for file_name in {../,./}${library} ; do
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
