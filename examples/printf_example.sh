#!/usr/bin/env bash
# shellcheck source=../printf.sh

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Example of using the printf library.

# Load the libraries.
declare -a library_list=("printf.sh")
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
# shellcheck disable=SC2167 # Go home Shellcheck, you are drunk.
for _TERM_LOAD_LIBRARY in "${library_list[@]}"; do
    source "$(find_library "${_TERM_LOAD_LIBRARY}")" || exit 1
done
unset _TERM_LOAD_LIBRARY

# Call tput directly.
term::printf "This %{rev}is%{sgr0} a (%% for no reason) %(underline)format%(UNDERLINE) %s.%(reset)\n" "test"

# Lookup environment variables.
term::printf "Color %(green)Green%(orig) Normal %(GREEN,red)Red on Green%(reset)\n"

# Short codes. These lookup environment variables.
term::printf "Short %[m]color %[r]codes%[o] and %[byB]Attributes%[-]\n"

# Be careful with backslashes in double quotes.
# The downside of using this.
# '\x22\\\x3d\x22' == "\x22\\\\\x3d\x22"
term::printf 'Backslash escapes: \x7e \x22\\\x3d\x22 => \042\134\075\042 \176\012'

# Have some fun.
# Use the part of the box variable name after "$TERM_BOX_".
# For example "%<D_BC>" becomes "$TERM_BOX_D_BC" and will draw the character `╩`.
echo "Box drawing characters:"

# Each box character in a separate "%<>".
term::printf "%<LTL>%<LLH>%<LTC>%<LTR>\n"
term::printf "%<LML>%<LLH>%<LMC>%<LMR>\n"
term::printf "%<LBL>%<LLH>%<LBC>%<LBR>\n"

# Multiple box characters separated by a comma.
# Spaces are ignored so you can line things up.
# Use "_" to print a space.
# Append @COUNT to repeat the character COUNT times.
term::printf "%<LTL,LLH,LTC,LLH,LTC,LLH@2,LTR>\n"
term::printf "%<LML,LLH,LMC,LLH,LMR,  _@2,LLV>\n"
term::printf "%<LLV,_  ,LML,LLH,LMR,  _@2,LLV>\n"
term::printf "%<LBL,LLH,LBC,LLH,LBC,LLH@2,LBR>\n"
