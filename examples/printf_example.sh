#!/usr/bin/env bash
# shellcheck source=../printf.sh

# Example of using the printf library.

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

# Call tput directly.
term::printf "This %{rev}is%{sgr0} a (%% for no reason) %(underline)format%(UNDERLINE) %s.%(reset)\n" "test"

# Lookup environment variables.
term::printf "Color %(green)Green%(orig) Normal %(GREEN,red)More%(reset)\n"

# Short codes. These lookup environment variables.
term::printf "Short %[m]color %[r]codes%[o] and %[byB]Attributes%[-]\n"

# Be careful with backslashes in double quotes.
# The downside of using this.
# '\x22\\\x3d\x22' == "\x22\\\\\x3d\x22"
term::printf 'Backslash escapes: \x7e \x22\\\x3d\x22 => \042\075\042 \176\012'

# Have some fun.
# Use the part of the box variable name after "$TERM_BOX_".
# For example "%<D_BC>" becomes "$TERM_BOX_D_BC" and will draw the character `╩`.
echo "Box drawing characters:"

# Each box character in a separate "%<>".
term::printf "%<L_TL>%<L_LH>%<L_TC>%<L_TR>\n"
term::printf "%<L_ML>%<L_LH>%<L_MC>%<L_MR>\n"
term::printf "%<L_BL>%<L_LH>%<L_BC>%<L_BR>\n"

# Multiple box chatacters separated by a comma.
# Use "_" to print a space.
term::printf "%<L_TL,L_LH,L_TC,L_LH,L_TC,L_LH,L_LH,L_TR>\n"
term::printf "%<L_ML,L_LH,L_MC,L_LH,L_MR,_,_,L_LV>\n"
term::printf "%<L_LV,_,L_ML,L_LH,L_MR,_,_,L_LV>\n"
term::printf "%<L_BL,L_LH,L_BC,L_LH,L_BC,L_LH,L_LH,L_BR>\n"
