#!/usr/bin/env bash
# shellcheck source=../function.sh

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Example of using the function library.

# Load the libraries.
declare -a library_list=("function.sh")
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
# shellcheck disable=SC2167 # Go home Shellcheck, you are drunk.
declare _TERM_LOAD_LIBRARY
for _TERM_LOAD_LIBRARY in "${library_list[@]}"; do
    source "$(find_library "${_TERM_LOAD_LIBRARY}")" || exit 1
done
unset _TERM_LOAD_LIBRARY

echo "Testing the functional interface from 'functions.sh'."
echo ""

echo "Testing attributes:"
echo "Normal $(term::underline)Underline$(term::UNDERLINE) not underlined"
echo "Normal $(term::bold)Bold$(term::reset) not bold"
echo "Normal $(term::dim)Dim$(term::reset) not dim"
echo ""

echo "Testing colors:"
for color in "${_TERM_COLORS[@]}"; do
    echo -n "Color ${color} "
    echo -n "$(term::fg "${color}")Foreground$(term::orig) "
    echo -n "$(term::fg "${color}")$(term::dim)Dim$(term::reset) "
    echo -n "$(term::fg "${color}")$(term::bold)Bold$(term::reset) "
    echo -n "$(term::fg "${color}")$(term::underline)Underline$(term::reset) "
    echo -n "$(term::bg "${color}")Background$(term::orig) "
    echo    "Normal text"
done
echo ""

echo "Boxes:"
echo "Light   Heavy   Double   Rounded"

# First row.
echo -n "$(term::box_l_tl)$(term::box_l_tc)$(term::box_l_lh)$(term::box_l_tr)"
echo -n "    "
echo -n "$(term::box_h_tl)$(term::box_h_tc)$(term::box_h_lh)$(term::box_h_tr)"
echo -n "    "
echo -n "$(term::box_d_tl)$(term::box_d_tc)$(term::box_d_lh)$(term::box_d_tr)"
echo -n "    "
echo "$(term::box_r_tl)$(term::box_r_tc)$(term::box_r_lh)$(term::box_r_tr)"

# Second row.
echo -n "$(term::box_l_ml)$(term::box_l_mc)$(term::box_l_lh)$(term::box_l_mr)"
echo -n "    "
echo -n "$(term::box_h_ml)$(term::box_h_mc)$(term::box_h_lh)$(term::box_h_mr)"
echo -n "    "
echo -n "$(term::box_d_ml)$(term::box_d_mc)$(term::box_d_lh)$(term::box_d_mr)"
echo -n "    "
echo "$(term::box_r_ml)$(term::box_r_mc)$(term::box_r_lh)$(term::box_r_mr)"

# Third row.
echo -n "$(term::box_l_lv)$(term::box_l_lv) $(term::box_l_lv)"
echo -n "    "
echo -n "$(term::box_h_lv)$(term::box_h_lv) $(term::box_h_lv)"
echo -n "    "
echo -n "$(term::box_d_lv)$(term::box_d_lv) $(term::box_d_lv)"
echo -n "    "
echo "$(term::box_r_lv)$(term::box_r_lv) $(term::box_r_lv)"

# Fourth row.
echo -n "$(term::box_l_bl)$(term::box_l_bc)$(term::box_l_lh)$(term::box_l_br)"
echo -n "    "
echo -n "$(term::box_h_bl)$(term::box_h_bc)$(term::box_h_lh)$(term::box_h_br)"
echo -n "    "
echo -n "$(term::box_d_bl)$(term::box_d_bc)$(term::box_d_lh)$(term::box_d_br)"
echo -n "    "
echo "$(term::box_r_bl)$(term::box_r_bc)$(term::box_r_lh)$(term::box_r_br)"

