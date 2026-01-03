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


term::printf "This %{rev}is%{sgr0} a (%% for no reason) %(underline)format%(UNDERLINE) %s.%(reset)\n" "test"
term::printf "Color %(green)Green%(reset) Normal %(CYAN)More%(reset)\n"
term::printf "Short %[m]color%[r] codes%[o] and %[byB]Attributes%[-]\n"
# Be careful with backslashes in double quotes.
# The downside of using this.
# '\x22\\\x3d\x22' == "\x22\\\\\x3d\x22"
term::printf 'Backslash escapes: \x7e \x22\\\x3d\x22 => \042\075\042 \176\012'
echo "Box drawing characters:"
term::printf "%<L_TL>%<L_LH>%<L_TC>%<L_TR>\n"
term::printf "%<L_ML>%<L_LH>%<L_MC>%<L_MR>\n"
term::printf "%<L_LV> %<L_LV>%<L_LV>\n"
term::printf "%<L_BL>%<L_LH>%<L_BC>%<L_BR>\n"

term::printf "%<L_TL>%<L_LH>%<L_TC>%<L_LH>%<L_TC>%<L_LH>%<L_LH>%<L_TR>\n"
term::printf "%<L_ML>%<L_LH>%<L_MC>%<L_LH>%<L_MR>  %<L_LV>\n"
term::printf "%<L_LV> %<L_ML>%<L_LH>%<L_MR>  %<L_LV>\n"
term::printf "%<L_BL>%<L_LH>%<L_BC>%<L_LH>%<L_BC>%<L_LH>%<L_LH>%<L_BR>\n"
