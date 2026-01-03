#!/usr/bin/env bash
# shellcheck source=../printf.sh

# Test the printf library.

# Load the library.
find_library(){
    local library="${1}"
    for file_name in {./,../}${library} ; do
        if [[ -f  "${file_name}" ]] ; then
            echo "${file_name}"
        fi
done
}
source "$(find_library "printf.sh")"


term::printf "This %{rev}is%{sgr0} a (%% for no reason) %(underline)format%(UNDERLINE) %s.%(reset)\n" "test"
term::printf "Color %(green)Green%(reset) Normal %(CYAN)More%(reset)\n"
term::printf "Short %[m]color%[r] codes%[o] and %[byB]Attributes%[-]\n"
# Be careful with backslashes in double quotes.
# The downside of using this.
# '\x22\\\x3d\x22' == "\x22\\\\\x3d\x22"
term::printf 'Backslash escapes: \x7e \x22\\\x3d\x22 => \042\075\042 \176\012'
