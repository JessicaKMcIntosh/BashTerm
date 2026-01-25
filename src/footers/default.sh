# If called directly then suggest the example.
if [[ "${0}" == "${BASH_SOURCE[0]}" ]] ; then
    declare example_file="${0##*/}"
    example_file="${example_file%.*}"
    echo "For an example try:"
    printf "./examples/%s_example.sh\n" "${example_file}"
fi
