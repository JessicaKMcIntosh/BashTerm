#!/usr/bin/env bash
# shellcheck disable=2034

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# A library of unicode box drawing characters.
#
# See the file 'boxes.sh' for more details.

# Complete set of characters using the names from:
# https://www.compart.com/en/unicode/block/U+2500
# This file has the name abbreviated to just the first letter of the name.

# This requires bash version 4.
if __ "${BASH_VERSINFO_0}" -lt "4"  ; then
    echo "This script requires Bash 4 or later."
    echo "Current version: ${BASH_VERSION}"
    exit 1
fi

TERM_BOX_BDLH=$'\u2500'     # ─ Box Drawings Light Horizontal
TERM_BOX_BDHH=$'\u2501'     # ━ Box Drawings Heavy Horizontal
TERM_BOX_BDLV=$'\u2502'     # │ Box Drawings Light Vertical
TERM_BOX_BDHV=$'\u2503'     # ┃ Box Drawings Heavy Vertical
TERM_BOX_BDLTDH=$'\u2504'   # ┄ Box Drawings Light Triple Dash Horizontal
TERM_BOX_BDHTDH=$'\u2505'   # ┅ Box Drawings Heavy Triple Dash Horizontal
TERM_BOX_BDLTDV=$'\u2506'   # ┆ Box Drawings Light Triple Dash Vertical
TERM_BOX_BDHTDV=$'\u2507'   # ┇ Box Drawings Heavy Triple Dash Vertical
TERM_BOX_BDLQDH=$'\u2508'   # ┈ Box Drawings Light Quadruple Dash Horizontal
TERM_BOX_BDHQDH=$'\u2509'   # ┉ Box Drawings Heavy Quadruple Dash Horizontal
TERM_BOX_BDLQDV=$'\u250A'   # ┊ Box Drawings Light Quadruple Dash Vertical
TERM_BOX_BDHQDV=$'\u250B'   # ┋ Box Drawings Heavy Quadruple Dash Vertical
TERM_BOX_BDLDR=$'\u250C'    # ┌ Box Drawings Light Down and Right
TERM_BOX_BDDLRH=$'\u250D'   # ┍ Box Drawings Down Light and Right Heavy
TERM_BOX_BDDHRL=$'\u250E'   # ┎ Box Drawings Down Heavy and Right Light
TERM_BOX_BDHDR=$'\u250F'    # ┏ Box Drawings Heavy Down and Right
TERM_BOX_BDLDL=$'\u2510'    # ┐ Box Drawings Light Down and Left
TERM_BOX_BDDLLH=$'\u2511'   # ┑ Box Drawings Down Light and Left Heavy
TERM_BOX_BDDHLL=$'\u2512'   # ┒ Box Drawings Down Heavy and Left Light
TERM_BOX_BDHDL=$'\u2513'    # ┓ Box Drawings Heavy Down and Left
TERM_BOX_BDLUR=$'\u2514'    # └ Box Drawings Light Up and Right
TERM_BOX_BDULRH=$'\u2515'   # ┕ Box Drawings Up Light and Right Heavy
TERM_BOX_BDUHRL=$'\u2516'   # ┖ Box Drawings Up Heavy and Right Light
TERM_BOX_BDHUR=$'\u2517'    # ┗ Box Drawings Heavy Up and Right
TERM_BOX_BDLUL=$'\u2518'    # ┘ Box Drawings Light Up and Left
TERM_BOX_BDULLH=$'\u2519'   # ┙ Box Drawings Up Light and Left Heavy
TERM_BOX_BDUHLL=$'\u251A'   # ┚ Box Drawings Up Heavy and Left Light
TERM_BOX_BDHUL=$'\u251B'    # ┛ Box Drawings Heavy Up and Left
TERM_BOX_BDLVR=$'\u251C'    # ├ Box Drawings Light Vertical and Right
TERM_BOX_BDVLRH=$'\u251D'   # ┝ Box Drawings Vertical Light and Right Heavy
TERM_BOX_BDUHRDL=$'\u251E'  # ┞ Box Drawings Up Heavy and Right Down Light
TERM_BOX_BDDHRUL=$'\u251F'  # ┟ Box Drawings Down Heavy and Right Up Light
TERM_BOX_BDVHRL=$'\u2520'   # ┠ Box Drawings Vertical Heavy and Right Light
TERM_BOX_BDDLRUH=$'\u2521'  # ┡ Box Drawings Down Light and Right Up Heavy
TERM_BOX_BDULRDH=$'\u2522'  # ┢ Box Drawings Up Light and Right Down Heavy
TERM_BOX_BDHVR=$'\u2523'    # ┣ Box Drawings Heavy Vertical and Right
TERM_BOX_BDLVL=$'\u2524'    # ┤ Box Drawings Light Vertical and Left
TERM_BOX_BDVLLH=$'\u2525'   # ┥ Box Drawings Vertical Light and Left Heavy
TERM_BOX_BDUHLDL=$'\u2526'  # ┦ Box Drawings Up Heavy and Left Down Light
TERM_BOX_BDDHLUL=$'\u2527'  # ┧ Box Drawings Down Heavy and Left Up Light
TERM_BOX_BDVHLL=$'\u2528'   # ┨ Box Drawings Vertical Heavy and Left Light
TERM_BOX_BDDLLUH=$'\u2529'  # ┩ Box Drawings Down Light and Left Up Heavy
TERM_BOX_BDULLDH=$'\u252A'  # ┪ Box Drawings Up Light and Left Down Heavy
TERM_BOX_BDHVL=$'\u252B'    # ┫ Box Drawings Heavy Vertical and Left
TERM_BOX_BDLDH=$'\u252C'    # ┬ Box Drawings Light Down and Horizontal
TERM_BOX_BDLHRDL=$'\u252D'  # ┭ Box Drawings Left Heavy and Right Down Light
TERM_BOX_BDRHLDL=$'\u252E'  # ┮ Box Drawings Right Heavy and Left Down Light
TERM_BOX_BDDLHH=$'\u252F'   # ┯ Box Drawings Down Light and Horizontal Heavy
TERM_BOX_BDDHHL=$'\u2530'   # ┰ Box Drawings Down Heavy and Horizontal Light
TERM_BOX_BDRLLDH=$'\u2531'  # ┱ Box Drawings Right Light and Left Down Heavy
TERM_BOX_BDLLRDH=$'\u2532'  # ┲ Box Drawings Left Light and Right Down Heavy
TERM_BOX_BDHDH=$'\u2533'    # ┳ Box Drawings Heavy Down and Horizontal
TERM_BOX_BDLUH=$'\u2534'    # ┴ Box Drawings Light Up and Horizontal
TERM_BOX_BDLHRUL=$'\u2535'  # ┵ Box Drawings Left Heavy and Right Up Light
TERM_BOX_BDRHLUL=$'\u2536'  # ┶ Box Drawings Right Heavy and Left Up Light
TERM_BOX_BDULHH=$'\u2537'   # ┷ Box Drawings Up Light and Horizontal Heavy
TERM_BOX_BDUHHL=$'\u2538'   # ┸ Box Drawings Up Heavy and Horizontal Light
TERM_BOX_BDRLLUH=$'\u2539'  # ┹ Box Drawings Right Light and Left Up Heavy
TERM_BOX_BDLLRUH=$'\u253A'  # ┺ Box Drawings Left Light and Right Up Heavy
TERM_BOX_BDHUH=$'\u253B'    # ┻ Box Drawings Heavy Up and Horizontal
TERM_BOX_BDLVH=$'\u253C'    # ┼ Box Drawings Light Vertical and Horizontal
TERM_BOX_BDLHRVL=$'\u253D'  # ┽ Box Drawings Left Heavy and Right Vertical Light
TERM_BOX_BDRHLVL=$'\u253E'  # ┾ Box Drawings Right Heavy and Left Vertical Light
TERM_BOX_BDVLHH=$'\u253F'   # ┿ Box Drawings Vertical Light and Horizontal Heavy
TERM_BOX_BDUHDHL=$'\u2540'  # ╀ Box Drawings Up Heavy and Down Horizontal Light
TERM_BOX_BDDHUHL=$'\u2541'  # ╁ Box Drawings Down Heavy and Up Horizontal Light
TERM_BOX_BDVHHL=$'\u2542'   # ╂ Box Drawings Vertical Heavy and Horizontal Light
TERM_BOX_BDLUHRDL=$'\u2543' # ╃ Box Drawings Left Up Heavy and Right Down Light
TERM_BOX_BDRUHLDL=$'\u2544' # ╄ Box Drawings Right Up Heavy and Left Down Light
TERM_BOX_BDLDHRUL=$'\u2545' # ╅ Box Drawings Left Down Heavy and Right Up Light
TERM_BOX_BDRDHLUL=$'\u2546' # ╆ Box Drawings Right Down Heavy and Left Up Light
TERM_BOX_BDDLUHH=$'\u2547'  # ╇ Box Drawings Down Light and Up Horizontal Heavy
TERM_BOX_BDULDHH=$'\u2548'  # ╈ Box Drawings Up Light and Down Horizontal Heavy
TERM_BOX_BDRLLVH=$'\u2549'  # ╉ Box Drawings Right Light and Left Vertical Heavy
TERM_BOX_BDLLRVH=$'\u254A'  # ╊ Box Drawings Left Light and Right Vertical Heavy
TERM_BOX_BDHVH=$'\u254B'    # ╋ Box Drawings Heavy Vertical and Horizontal
TERM_BOX_BDLDDH=$'\u254C'   # ╌ Box Drawings Light Double Dash Horizontal
TERM_BOX_BDHDDH=$'\u254D'   # ╍ Box Drawings Heavy Double Dash Horizontal
TERM_BOX_BDLDDV=$'\u254E'   # ╎ Box Drawings Light Double Dash Vertical
TERM_BOX_BDHDDV=$'\u254F'   # ╏ Box Drawings Heavy Double Dash Vertical
TERM_BOX_BDDH=$'\u2550'     # ═ Box Drawings Double Horizontal
TERM_BOX_BDDV=$'\u2551'     # ║ Box Drawings Double Vertical
TERM_BOX_BDDSRD=$'\u2552'   # ╒ Box Drawings Down Single and Right Double
TERM_BOX_BDDDRS=$'\u2553'   # ╓ Box Drawings Down Double and Right Single
TERM_BOX_BDDDR=$'\u2554'    # ╔ Box Drawings Double Down and Right
TERM_BOX_BDDSLD=$'\u2555'   # ╕ Box Drawings Down Single and Left Double
TERM_BOX_BDDDLS=$'\u2556'   # ╖ Box Drawings Down Double and Left Single
TERM_BOX_BDDDL=$'\u2557'    # ╗ Box Drawings Double Down and Left
TERM_BOX_BDUSRD=$'\u2558'   # ╘ Box Drawings Up Single and Right Double
TERM_BOX_BDUDRS=$'\u2559'   # ╙ Box Drawings Up Double and Right Single
TERM_BOX_BDDUR=$'\u255A'    # ╚ Box Drawings Double Up and Right
TERM_BOX_BDUSLD=$'\u255B'   # ╛ Box Drawings Up Single and Left Double
TERM_BOX_BDUDLS=$'\u255C'   # ╜ Box Drawings Up Double and Left Single
TERM_BOX_BDDUL=$'\u255D'    # ╝ Box Drawings Double Up and Left
TERM_BOX_BDVSRD=$'\u255E'   # ╞ Box Drawings Vertical Single and Right Double
TERM_BOX_BDVDRS=$'\u255F'   # ╟ Box Drawings Vertical Double and Right Single
TERM_BOX_BDDVR=$'\u2560'    # ╠ Box Drawings Double Vertical and Right
TERM_BOX_BDVSLD=$'\u2561'   # ╡ Box Drawings Vertical Single and Left Double
TERM_BOX_BDVDLS=$'\u2562'   # ╢ Box Drawings Vertical Double and Left Single
TERM_BOX_BDDVL=$'\u2563'    # ╣ Box Drawings Double Vertical and Left
TERM_BOX_BDDSHD=$'\u2564'   # ╤ Box Drawings Down Single and Horizontal Double
TERM_BOX_BDDDHS=$'\u2565'   # ╥ Box Drawings Down Double and Horizontal Single
TERM_BOX_BDDDH=$'\u2566'    # ╦ Box Drawings Double Down and Horizontal
TERM_BOX_BDUSHD=$'\u2567'   # ╧ Box Drawings Up Single and Horizontal Double
TERM_BOX_BDUDHS=$'\u2568'   # ╨ Box Drawings Up Double and Horizontal Single
TERM_BOX_BDDUH=$'\u2569'    # ╩ Box Drawings Double Up and Horizontal
TERM_BOX_BDVSHD=$'\u256A'   # ╪ Box Drawings Vertical Single and Horizontal Double
TERM_BOX_BDVDHS=$'\u256B'   # ╫ Box Drawings Vertical Double and Horizontal Single
TERM_BOX_BDDVH=$'\u256C'    # ╬ Box Drawings Double Vertical and Horizontal
TERM_BOX_BDLADR=$'\u256D'   # ╭ Box Drawings Light Arc Down and Right
TERM_BOX_BDLADL=$'\u256E'   # ╮ Box Drawings Light Arc Down and Left
TERM_BOX_BDLAUL=$'\u256F'   # ╯ Box Drawings Light Arc Up and Left
TERM_BOX_BDLAUR=$'\u2570'   # ╰ Box Drawings Light Arc Up and Right
TERM_BOX_BDLDURLL=$'\u2571' # ╱ Box Drawings Light Diagonal Upper Right to Lower Left
TERM_BOX_BDLDULLR=$'\u2572' # ╲ Box Drawings Light Diagonal Upper Left to Lower Right
TERM_BOX_BDLDC=$'\u2573'    # ╳ Box Drawings Light Diagonal Cross
TERM_BOX_BDLL=$'\u2574'     # ╴ Box Drawings Light Left
TERM_BOX_BDLU=$'\u2575'     # ╵ Box Drawings Light Up
TERM_BOX_BDLR=$'\u2576'     # ╶ Box Drawings Light Right
TERM_BOX_BDLD=$'\u2577'     # ╷ Box Drawings Light Down
TERM_BOX_BDHL=$'\u2578'     # ╸ Box Drawings Heavy Left
TERM_BOX_BDHU=$'\u2579'     # ╹ Box Drawings Heavy Up
TERM_BOX_BDHR=$'\u257A'     # ╺ Box Drawings Heavy Right
TERM_BOX_BDHD=$'\u257B'     # ╻ Box Drawings Heavy Down
TERM_BOX_BDLLHR=$'\u257C'   # ╼ Box Drawings Light Left and Heavy Right
TERM_BOX_BDLUHD=$'\u257D'   # ╽ Box Drawings Light Up and Heavy Down
TERM_BOX_BDHLLR=$'\u257E'   # ╾ Box Drawings Heavy Left and Light Right
TERM_BOX_BDHULD=$'\u257F'   # ╿ Box Drawings Heavy Up and Light Down
