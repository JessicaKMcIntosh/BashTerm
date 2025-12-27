#!/usr/bin/env bash
# shellcheck disable=2034

# A library of unicode box drawing characters.
#
# See the file 'boxes.sh' for more details.

# Complete set of characters using the names from:
# https://www.compart.com/en/unicode/block/U+2500
# This file has the name abbeviated to just the first letter of the name.

# This requires bash version 4.
if [[ "${BASH_VERSINFO[0]}" -lt "4" ]] ; then
    echo "This script requires Bash 4 or later."
    echo "Current version: ${BASH_VERSION}"
    exit 1
fi

source "./boxes.sh"

TERM_BOX[BDLH]=$'\u2500'     # ─ Box Drawings Light Horizontal
TERM_BOX[BDHH]=$'\u2501'     # ━ Box Drawings Heavy Horizontal
TERM_BOX[BDLV]=$'\u2502'     # │ Box Drawings Light Vertical
TERM_BOX[BDHV]=$'\u2503'     # ┃ Box Drawings Heavy Vertical
TERM_BOX[BDLTDH]=$'\u2504'   # ┄ Box Drawings Light Triple Dash Horizontal
TERM_BOX[BDHTDH]=$'\u2505'   # ┅ Box Drawings Heavy Triple Dash Horizontal
TERM_BOX[BDLTDV]=$'\u2506'   # ┆ Box Drawings Light Triple Dash Vertical
TERM_BOX[BDHTDV]=$'\u2507'   # ┇ Box Drawings Heavy Triple Dash Vertical
TERM_BOX[BDLQDH]=$'\u2508'   # ┈ Box Drawings Light Quadruple Dash Horizontal
TERM_BOX[BDHQDH]=$'\u2509'   # ┉ Box Drawings Heavy Quadruple Dash Horizontal
TERM_BOX[BDLQDV]=$'\u250A'   # ┊ Box Drawings Light Quadruple Dash Vertical
TERM_BOX[BDHQDV]=$'\u250B'   # ┋ Box Drawings Heavy Quadruple Dash Vertical
TERM_BOX[BDLDR]=$'\u250C'    # ┌ Box Drawings Light Down and Right
TERM_BOX[BDDLRH]=$'\u250D'   # ┍ Box Drawings Down Light and Right Heavy
TERM_BOX[BDDHRL]=$'\u250E'   # ┎ Box Drawings Down Heavy and Right Light
TERM_BOX[BDHDR]=$'\u250F'    # ┏ Box Drawings Heavy Down and Right
TERM_BOX[BDLDL]=$'\u2510'    # ┐ Box Drawings Light Down and Left
TERM_BOX[BDDLLH]=$'\u2511'   # ┑ Box Drawings Down Light and Left Heavy
TERM_BOX[BDDHLL]=$'\u2512'   # ┒ Box Drawings Down Heavy and Left Light
TERM_BOX[BDHDL]=$'\u2513'    # ┓ Box Drawings Heavy Down and Left
TERM_BOX[BDLUR]=$'\u2514'    # └ Box Drawings Light Up and Right
TERM_BOX[BDULRH]=$'\u2515'   # ┕ Box Drawings Up Light and Right Heavy
TERM_BOX[BDUHRL]=$'\u2516'   # ┖ Box Drawings Up Heavy and Right Light
TERM_BOX[BDHUR]=$'\u2517'    # ┗ Box Drawings Heavy Up and Right
TERM_BOX[BDLUL]=$'\u2518'    # ┘ Box Drawings Light Up and Left
TERM_BOX[BDULLH]=$'\u2519'   # ┙ Box Drawings Up Light and Left Heavy
TERM_BOX[BDUHLL]=$'\u251A'   # ┚ Box Drawings Up Heavy and Left Light
TERM_BOX[BDHUL]=$'\u251B'    # ┛ Box Drawings Heavy Up and Left
TERM_BOX[BDLVR]=$'\u251C'    # ├ Box Drawings Light Vertical and Right
TERM_BOX[BDVLRH]=$'\u251D'   # ┝ Box Drawings Vertical Light and Right Heavy
TERM_BOX[BDUHRDL]=$'\u251E'  # ┞ Box Drawings Up Heavy and Right Down Light
TERM_BOX[BDDHRUL]=$'\u251F'  # ┟ Box Drawings Down Heavy and Right Up Light
TERM_BOX[BDVHRL]=$'\u2520'   # ┠ Box Drawings Vertical Heavy and Right Light
TERM_BOX[BDDLRUH]=$'\u2521'  # ┡ Box Drawings Down Light and Right Up Heavy
TERM_BOX[BDULRDH]=$'\u2522'  # ┢ Box Drawings Up Light and Right Down Heavy
TERM_BOX[BDHVR]=$'\u2523'    # ┣ Box Drawings Heavy Vertical and Right
TERM_BOX[BDLVL]=$'\u2524'    # ┤ Box Drawings Light Vertical and Left
TERM_BOX[BDVLLH]=$'\u2525'   # ┥ Box Drawings Vertical Light and Left Heavy
TERM_BOX[BDUHLDL]=$'\u2526'  # ┦ Box Drawings Up Heavy and Left Down Light
TERM_BOX[BDDHLUL]=$'\u2527'  # ┧ Box Drawings Down Heavy and Left Up Light
TERM_BOX[BDVHLL]=$'\u2528'   # ┨ Box Drawings Vertical Heavy and Left Light
TERM_BOX[BDDLLUH]=$'\u2529'  # ┩ Box Drawings Down Light and Left Up Heavy
TERM_BOX[BDULLDH]=$'\u252A'  # ┪ Box Drawings Up Light and Left Down Heavy
TERM_BOX[BDHVL]=$'\u252B'    # ┫ Box Drawings Heavy Vertical and Left
TERM_BOX[BDLDH]=$'\u252C'    # ┬ Box Drawings Light Down and Horizontal
TERM_BOX[BDLHRDL]=$'\u252D'  # ┭ Box Drawings Left Heavy and Right Down Light
TERM_BOX[BDRHLDL]=$'\u252E'  # ┮ Box Drawings Right Heavy and Left Down Light
TERM_BOX[BDDLHH]=$'\u252F'   # ┯ Box Drawings Down Light and Horizontal Heavy
TERM_BOX[BDDHHL]=$'\u2530'   # ┰ Box Drawings Down Heavy and Horizontal Light
TERM_BOX[BDRLLDH]=$'\u2531'  # ┱ Box Drawings Right Light and Left Down Heavy
TERM_BOX[BDLLRDH]=$'\u2532'  # ┲ Box Drawings Left Light and Right Down Heavy
TERM_BOX[BDHDH]=$'\u2533'    # ┳ Box Drawings Heavy Down and Horizontal
TERM_BOX[BDLUH]=$'\u2534'    # ┴ Box Drawings Light Up and Horizontal
TERM_BOX[BDLHRUL]=$'\u2535'  # ┵ Box Drawings Left Heavy and Right Up Light
TERM_BOX[BDRHLUL]=$'\u2536'  # ┶ Box Drawings Right Heavy and Left Up Light
TERM_BOX[BDULHH]=$'\u2537'   # ┷ Box Drawings Up Light and Horizontal Heavy
TERM_BOX[BDUHHL]=$'\u2538'   # ┸ Box Drawings Up Heavy and Horizontal Light
TERM_BOX[BDRLLUH]=$'\u2539'  # ┹ Box Drawings Right Light and Left Up Heavy
TERM_BOX[BDLLRUH]=$'\u253A'  # ┺ Box Drawings Left Light and Right Up Heavy
TERM_BOX[BDHUH]=$'\u253B'    # ┻ Box Drawings Heavy Up and Horizontal
TERM_BOX[BDLVH]=$'\u253C'    # ┼ Box Drawings Light Vertical and Horizontal
TERM_BOX[BDLHRVL]=$'\u253D'  # ┽ Box Drawings Left Heavy and Right Vertical Light
TERM_BOX[BDRHLVL]=$'\u253E'  # ┾ Box Drawings Right Heavy and Left Vertical Light
TERM_BOX[BDVLHH]=$'\u253F'   # ┿ Box Drawings Vertical Light and Horizontal Heavy
TERM_BOX[BDUHDHL]=$'\u2540'  # ╀ Box Drawings Up Heavy and Down Horizontal Light
TERM_BOX[BDDHUHL]=$'\u2541'  # ╁ Box Drawings Down Heavy and Up Horizontal Light
TERM_BOX[BDVHHL]=$'\u2542'   # ╂ Box Drawings Vertical Heavy and Horizontal Light
TERM_BOX[BDLUHRDL]=$'\u2543' # ╃ Box Drawings Left Up Heavy and Right Down Light
TERM_BOX[BDRUHLDL]=$'\u2544' # ╄ Box Drawings Right Up Heavy and Left Down Light
TERM_BOX[BDLDHRUL]=$'\u2545' # ╅ Box Drawings Left Down Heavy and Right Up Light
TERM_BOX[BDRDHLUL]=$'\u2546' # ╆ Box Drawings Right Down Heavy and Left Up Light
TERM_BOX[BDDLUHH]=$'\u2547'  # ╇ Box Drawings Down Light and Up Horizontal Heavy
TERM_BOX[BDULDHH]=$'\u2548'  # ╈ Box Drawings Up Light and Down Horizontal Heavy
TERM_BOX[BDRLLVH]=$'\u2549'  # ╉ Box Drawings Right Light and Left Vertical Heavy
TERM_BOX[BDLLRVH]=$'\u254A'  # ╊ Box Drawings Left Light and Right Vertical Heavy
TERM_BOX[BDHVH]=$'\u254B'    # ╋ Box Drawings Heavy Vertical and Horizontal
TERM_BOX[BDLDDH]=$'\u254C'   # ╌ Box Drawings Light Double Dash Horizontal
TERM_BOX[BDHDDH]=$'\u254D'   # ╍ Box Drawings Heavy Double Dash Horizontal
TERM_BOX[BDLDDV]=$'\u254E'   # ╎ Box Drawings Light Double Dash Vertical
TERM_BOX[BDHDDV]=$'\u254F'   # ╏ Box Drawings Heavy Double Dash Vertical
TERM_BOX[BDDH]=$'\u2550'     # ═ Box Drawings Double Horizontal
TERM_BOX[BDDV]=$'\u2551'     # ║ Box Drawings Double Vertical
TERM_BOX[BDDSRD]=$'\u2552'   # ╒ Box Drawings Down Single and Right Double
TERM_BOX[BDDDRS]=$'\u2553'   # ╓ Box Drawings Down Double and Right Single
TERM_BOX[BDDDR]=$'\u2554'    # ╔ Box Drawings Double Down and Right
TERM_BOX[BDDSLD]=$'\u2555'   # ╕ Box Drawings Down Single and Left Double
TERM_BOX[BDDDLS]=$'\u2556'   # ╖ Box Drawings Down Double and Left Single
TERM_BOX[BDDDL]=$'\u2557'    # ╗ Box Drawings Double Down and Left
TERM_BOX[BDUSRD]=$'\u2558'   # ╘ Box Drawings Up Single and Right Double
TERM_BOX[BDUDRS]=$'\u2559'   # ╙ Box Drawings Up Double and Right Single
TERM_BOX[BDDUR]=$'\u255A'    # ╚ Box Drawings Double Up and Right
TERM_BOX[BDUSLD]=$'\u255B'   # ╛ Box Drawings Up Single and Left Double
TERM_BOX[BDUDLS]=$'\u255C'   # ╜ Box Drawings Up Double and Left Single
TERM_BOX[BDDUL]=$'\u255D'    # ╝ Box Drawings Double Up and Left
TERM_BOX[BDVSRD]=$'\u255E'   # ╞ Box Drawings Vertical Single and Right Double
TERM_BOX[BDVDRS]=$'\u255F'   # ╟ Box Drawings Vertical Double and Right Single
TERM_BOX[BDDVR]=$'\u2560'    # ╠ Box Drawings Double Vertical and Right
TERM_BOX[BDVSLD]=$'\u2561'   # ╡ Box Drawings Vertical Single and Left Double
TERM_BOX[BDVDLS]=$'\u2562'   # ╢ Box Drawings Vertical Double and Left Single
TERM_BOX[BDDVL]=$'\u2563'    # ╣ Box Drawings Double Vertical and Left
TERM_BOX[BDDSHD]=$'\u2564'   # ╤ Box Drawings Down Single and Horizontal Double
TERM_BOX[BDDDHS]=$'\u2565'   # ╥ Box Drawings Down Double and Horizontal Single
TERM_BOX[BDDDH]=$'\u2566'    # ╦ Box Drawings Double Down and Horizontal
TERM_BOX[BDUSHD]=$'\u2567'   # ╧ Box Drawings Up Single and Horizontal Double
TERM_BOX[BDUDHS]=$'\u2568'   # ╨ Box Drawings Up Double and Horizontal Single
TERM_BOX[BDDUH]=$'\u2569'    # ╩ Box Drawings Double Up and Horizontal
TERM_BOX[BDVSHD]=$'\u256A'   # ╪ Box Drawings Vertical Single and Horizontal Double
TERM_BOX[BDVDHS]=$'\u256B'   # ╫ Box Drawings Vertical Double and Horizontal Single
TERM_BOX[BDDVH]=$'\u256C'    # ╬ Box Drawings Double Vertical and Horizontal
TERM_BOX[BDLADR]=$'\u256D'   # ╭ Box Drawings Light Arc Down and Right
TERM_BOX[BDLADL]=$'\u256E'   # ╮ Box Drawings Light Arc Down and Left
TERM_BOX[BDLAUL]=$'\u256F'   # ╯ Box Drawings Light Arc Up and Left
TERM_BOX[BDLAUR]=$'\u2570'   # ╰ Box Drawings Light Arc Up and Right
TERM_BOX[BDLDURLL]=$'\u2571' # ╱ Box Drawings Light Diagonal Upper Right to Lower Left
TERM_BOX[BDLDULLR]=$'\u2572' # ╲ Box Drawings Light Diagonal Upper Left to Lower Right
TERM_BOX[BDLDC]=$'\u2573'    # ╳ Box Drawings Light Diagonal Cross
TERM_BOX[BDLL]=$'\u2574'     # ╴ Box Drawings Light Left
TERM_BOX[BDLU]=$'\u2575'     # ╵ Box Drawings Light Up
TERM_BOX[BDLR]=$'\u2576'     # ╶ Box Drawings Light Right
TERM_BOX[BDLD]=$'\u2577'     # ╷ Box Drawings Light Down
TERM_BOX[BDHL]=$'\u2578'     # ╸ Box Drawings Heavy Left
TERM_BOX[BDHU]=$'\u2579'     # ╹ Box Drawings Heavy Up
TERM_BOX[BDHR]=$'\u257A'     # ╺ Box Drawings Heavy Right
TERM_BOX[BDHD]=$'\u257B'     # ╻ Box Drawings Heavy Down
TERM_BOX[BDLLHR]=$'\u257C'   # ╼ Box Drawings Light Left and Heavy Right
TERM_BOX[BDLUHD]=$'\u257D'   # ╽ Box Drawings Light Up and Heavy Down
TERM_BOX[BDHLLR]=$'\u257E'   # ╾ Box Drawings Heavy Left and Light Right
TERM_BOX[BDHULD]=$'\u257F'   # ╿ Box Drawings Heavy Up and Light Down
