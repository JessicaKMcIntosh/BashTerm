#!/usr/bin/env bash
# shellcheck disable=2034 # These variables will remain unused in this file.
# shellcheck disable=2154 # These variables will remain unused in this file.

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# A library of unicode box drawing characters.
#
# See the file 'boxes.sh' for more details.

# Complete set of characters using the names from:
# https://www.compart.com/en/unicode/block/U+2500

# This requires bash version 4.
if ((BASH_VERSINFO[0] < 4)); then
    echo "This script requires Bash 4 or later."
    echo "Current version: ${BASH_VERSION}"
    exit 1
fi

# Only load the library once.
declare -A _TERM_LOADED # Track loaded files.
declare _TERM_FILE_NAME="${BASH_SOURCE[0]##*/}"
if [[ -v _TERM_LOADED[${_TERM_FILE_NAME}] ]]; then
    [[ -v TERM_VERBOSE ]] && echo "Already loaded '${_TERM_FILE_NAME}'."
    return 0
fi
_TERM_LOADED[${_TERM_FILE_NAME}]="${BASH_SOURCE[0]}"
[[ -v TERM_VERBOSE ]] && echo "Loading '${_TERM_FILE_NAME}'..."
unset _TERM_FILE_NAME

export TERM_BOX_Box_Drawings_Light_Horizontal=$'\u2500'                         # ─ Box Drawings Light Horizontal
export TERM_BOX_Box_Drawings_Heavy_Horizontal=$'\u2501'                         # ━ Box Drawings Heavy Horizontal
export TERM_BOX_Box_Drawings_Light_Vertical=$'\u2502'                           # │ Box Drawings Light Vertical
export TERM_BOX_Box_Drawings_Heavy_Vertical=$'\u2503'                           # ┃ Box Drawings Heavy Vertical
export TERM_BOX_Box_Drawings_Light_Triple_Dash_Horizontal=$'\u2504'             # ┄ Box Drawings Light Triple Dash Horizontal
export TERM_BOX_Box_Drawings_Heavy_Triple_Dash_Horizontal=$'\u2505'             # ┅ Box Drawings Heavy Triple Dash Horizontal
export TERM_BOX_Box_Drawings_Light_Triple_Dash_Vertical=$'\u2506'               # ┆ Box Drawings Light Triple Dash Vertical
export TERM_BOX_Box_Drawings_Heavy_Triple_Dash_Vertical=$'\u2507'               # ┇ Box Drawings Heavy Triple Dash Vertical
export TERM_BOX_Box_Drawings_Light_Quadruple_Dash_Horizontal=$'\u2508'          # ┈ Box Drawings Light Quadruple Dash Horizontal
export TERM_BOX_Box_Drawings_Heavy_Quadruple_Dash_Horizontal=$'\u2509'          # ┉ Box Drawings Heavy Quadruple Dash Horizontal
export TERM_BOX_Box_Drawings_Light_Quadruple_Dash_Vertical=$'\u250A'            # ┊ Box Drawings Light Quadruple Dash Vertical
export TERM_BOX_Box_Drawings_Heavy_Quadruple_Dash_Vertical=$'\u250B'            # ┋ Box Drawings Heavy Quadruple Dash Vertical
export TERM_BOX_Box_Drawings_Light_Down_and_Right=$'\u250C'                     # ┌ Box Drawings Light Down and Right
export TERM_BOX_Box_Drawings_Down_Light_and_Right_Heavy=$'\u250D'               # ┍ Box Drawings Down Light and Right Heavy
export TERM_BOX_Box_Drawings_Down_Heavy_and_Right_Light=$'\u250E'               # ┎ Box Drawings Down Heavy and Right Light
export TERM_BOX_Box_Drawings_Heavy_Down_and_Right=$'\u250F'                     # ┏ Box Drawings Heavy Down and Right
export TERM_BOX_Box_Drawings_Light_Down_and_Left=$'\u2510'                      # ┐ Box Drawings Light Down and Left
export TERM_BOX_Box_Drawings_Down_Light_and_Left_Heavy=$'\u2511'                # ┑ Box Drawings Down Light and Left Heavy
export TERM_BOX_Box_Drawings_Down_Heavy_and_Left_Light=$'\u2512'                # ┒ Box Drawings Down Heavy and Left Light
export TERM_BOX_Box_Drawings_Heavy_Down_and_Left=$'\u2513'                      # ┓ Box Drawings Heavy Down and Left
export TERM_BOX_Box_Drawings_Light_Up_and_Right=$'\u2514'                       # └ Box Drawings Light Up and Right
export TERM_BOX_Box_Drawings_Up_Light_and_Right_Heavy=$'\u2515'                 # ┕ Box Drawings Up Light and Right Heavy
export TERM_BOX_Box_Drawings_Up_Heavy_and_Right_Light=$'\u2516'                 # ┖ Box Drawings Up Heavy and Right Light
export TERM_BOX_Box_Drawings_Heavy_Up_and_Right=$'\u2517'                       # ┗ Box Drawings Heavy Up and Right
export TERM_BOX_Box_Drawings_Light_Up_and_Left=$'\u2518'                        # ┘ Box Drawings Light Up and Left
export TERM_BOX_Box_Drawings_Up_Light_and_Left_Heavy=$'\u2519'                  # ┙ Box Drawings Up Light and Left Heavy
export TERM_BOX_Box_Drawings_Up_Heavy_and_Left_Light=$'\u251A'                  # ┚ Box Drawings Up Heavy and Left Light
export TERM_BOX_Box_Drawings_Heavy_Up_and_Left=$'\u251B'                        # ┛ Box Drawings Heavy Up and Left
export TERM_BOX_Box_Drawings_Light_Vertical_and_Right=$'\u251C'                 # ├ Box Drawings Light Vertical and Right
export TERM_BOX_Box_Drawings_Vertical_Light_and_Right_Heavy=$'\u251D'           # ┝ Box Drawings Vertical Light and Right Heavy
export TERM_BOX_Box_Drawings_Up_Heavy_and_Right_Down_Light=$'\u251E'            # ┞ Box Drawings Up Heavy and Right Down Light
export TERM_BOX_Box_Drawings_Down_Heavy_and_Right_Up_Light=$'\u251F'            # ┟ Box Drawings Down Heavy and Right Up Light
export TERM_BOX_Box_Drawings_Vertical_Heavy_and_Right_Light=$'\u2520'           # ┠ Box Drawings Vertical Heavy and Right Light
export TERM_BOX_Box_Drawings_Down_Light_and_Right_Up_Heavy=$'\u2521'            # ┡ Box Drawings Down Light and Right Up Heavy
export TERM_BOX_Box_Drawings_Up_Light_and_Right_Down_Heavy=$'\u2522'            # ┢ Box Drawings Up Light and Right Down Heavy
export TERM_BOX_Box_Drawings_Heavy_Vertical_and_Right=$'\u2523'                 # ┣ Box Drawings Heavy Vertical and Right
export TERM_BOX_Box_Drawings_Light_Vertical_and_Left=$'\u2524'                  # ┤ Box Drawings Light Vertical and Left
export TERM_BOX_Box_Drawings_Vertical_Light_and_Left_Heavy=$'\u2525'            # ┥ Box Drawings Vertical Light and Left Heavy
export TERM_BOX_Box_Drawings_Up_Heavy_and_Left_Down_Light=$'\u2526'             # ┦ Box Drawings Up Heavy and Left Down Light
export TERM_BOX_Box_Drawings_Down_Heavy_and_Left_Up_Light=$'\u2527'             # ┧ Box Drawings Down Heavy and Left Up Light
export TERM_BOX_Box_Drawings_Vertical_Heavy_and_Left_Light=$'\u2528'            # ┨ Box Drawings Vertical Heavy and Left Light
export TERM_BOX_Box_Drawings_Down_Light_and_Left_Up_Heavy=$'\u2529'             # ┩ Box Drawings Down Light and Left Up Heavy
export TERM_BOX_Box_Drawings_Up_Light_and_Left_Down_Heavy=$'\u252A'             # ┪ Box Drawings Up Light and Left Down Heavy
export TERM_BOX_Box_Drawings_Heavy_Vertical_and_Left=$'\u252B'                  # ┫ Box Drawings Heavy Vertical and Left
export TERM_BOX_Box_Drawings_Light_Down_and_Horizontal=$'\u252C'                # ┬ Box Drawings Light Down and Horizontal
export TERM_BOX_Box_Drawings_Left_Heavy_and_Right_Down_Light=$'\u252D'          # ┭ Box Drawings Left Heavy and Right Down Light
export TERM_BOX_Box_Drawings_Right_Heavy_and_Left_Down_Light=$'\u252E'          # ┮ Box Drawings Right Heavy and Left Down Light
export TERM_BOX_Box_Drawings_Down_Light_and_Horizontal_Heavy=$'\u252F'          # ┯ Box Drawings Down Light and Horizontal Heavy
export TERM_BOX_Box_Drawings_Down_Heavy_and_Horizontal_Light=$'\u2530'          # ┰ Box Drawings Down Heavy and Horizontal Light
export TERM_BOX_Box_Drawings_Right_Light_and_Left_Down_Heavy=$'\u2531'          # ┱ Box Drawings Right Light and Left Down Heavy
export TERM_BOX_Box_Drawings_Left_Light_and_Right_Down_Heavy=$'\u2532'          # ┲ Box Drawings Left Light and Right Down Heavy
export TERM_BOX_Box_Drawings_Heavy_Down_and_Horizontal=$'\u2533'                # ┳ Box Drawings Heavy Down and Horizontal
export TERM_BOX_Box_Drawings_Light_Up_and_Horizontal=$'\u2534'                  # ┴ Box Drawings Light Up and Horizontal
export TERM_BOX_Box_Drawings_Left_Heavy_and_Right_Up_Light=$'\u2535'            # ┵ Box Drawings Left Heavy and Right Up Light
export TERM_BOX_Box_Drawings_Right_Heavy_and_Left_Up_Light=$'\u2536'            # ┶ Box Drawings Right Heavy and Left Up Light
export TERM_BOX_Box_Drawings_Up_Light_and_Horizontal_Heavy=$'\u2537'            # ┷ Box Drawings Up Light and Horizontal Heavy
export TERM_BOX_Box_Drawings_Up_Heavy_and_Horizontal_Light=$'\u2538'            # ┸ Box Drawings Up Heavy and Horizontal Light
export TERM_BOX_Box_Drawings_Right_Light_and_Left_Up_Heavy=$'\u2539'            # ┹ Box Drawings Right Light and Left Up Heavy
export TERM_BOX_Box_Drawings_Left_Light_and_Right_Up_Heavy=$'\u253A'            # ┺ Box Drawings Left Light and Right Up Heavy
export TERM_BOX_Box_Drawings_Heavy_Up_and_Horizontal=$'\u253B'                  # ┻ Box Drawings Heavy Up and Horizontal
export TERM_BOX_Box_Drawings_Light_Vertical_and_Horizontal=$'\u253C'            # ┼ Box Drawings Light Vertical and Horizontal
export TERM_BOX_Box_Drawings_Left_Heavy_and_Right_Vertical_Light=$'\u253D'      # ┽ Box Drawings Left Heavy and Right Vertical Light
export TERM_BOX_Box_Drawings_Right_Heavy_and_Left_Vertical_Light=$'\u253E'      # ┾ Box Drawings Right Heavy and Left Vertical Light
export TERM_BOX_Box_Drawings_Vertical_Light_and_Horizontal_Heavy=$'\u253F'      # ┿ Box Drawings Vertical Light and Horizontal Heavy
export TERM_BOX_Box_Drawings_Up_Heavy_and_Down_Horizontal_Light=$'\u2540'       # ╀ Box Drawings Up Heavy and Down Horizontal Light
export TERM_BOX_Box_Drawings_Down_Heavy_and_Up_Horizontal_Light=$'\u2541'       # ╁ Box Drawings Down Heavy and Up Horizontal Light
export TERM_BOX_Box_Drawings_Vertical_Heavy_and_Horizontal_Light=$'\u2542'      # ╂ Box Drawings Vertical Heavy and Horizontal Light
export TERM_BOX_Box_Drawings_Left_Up_Heavy_and_Right_Down_Light=$'\u2543'       # ╃ Box Drawings Left Up Heavy and Right Down Light
export TERM_BOX_Box_Drawings_Right_Up_Heavy_and_Left_Down_Light=$'\u2544'       # ╄ Box Drawings Right Up Heavy and Left Down Light
export TERM_BOX_Box_Drawings_Left_Down_Heavy_and_Right_Up_Light=$'\u2545'       # ╅ Box Drawings Left Down Heavy and Right Up Light
export TERM_BOX_Box_Drawings_Right_Down_Heavy_and_Left_Up_Light=$'\u2546'       # ╆ Box Drawings Right Down Heavy and Left Up Light
export TERM_BOX_Box_Drawings_Down_Light_and_Up_Horizontal_Heavy=$'\u2547'       # ╇ Box Drawings Down Light and Up Horizontal Heavy
export TERM_BOX_Box_Drawings_Up_Light_and_Down_Horizontal_Heavy=$'\u2548'       # ╈ Box Drawings Up Light and Down Horizontal Heavy
export TERM_BOX_Box_Drawings_Right_Light_and_Left_Vertical_Heavy=$'\u2549'      # ╉ Box Drawings Right Light and Left Vertical Heavy
export TERM_BOX_Box_Drawings_Left_Light_and_Right_Vertical_Heavy=$'\u254A'      # ╊ Box Drawings Left Light and Right Vertical Heavy
export TERM_BOX_Box_Drawings_Heavy_Vertical_and_Horizontal=$'\u254B'            # ╋ Box Drawings Heavy Vertical and Horizontal
export TERM_BOX_Box_Drawings_Light_Double_Dash_Horizontal=$'\u254C'             # ╌ Box Drawings Light Double Dash Horizontal
export TERM_BOX_Box_Drawings_Heavy_Double_Dash_Horizontal=$'\u254D'             # ╍ Box Drawings Heavy Double Dash Horizontal
export TERM_BOX_Box_Drawings_Light_Double_Dash_Vertical=$'\u254E'               # ╎ Box Drawings Light Double Dash Vertical
export TERM_BOX_Box_Drawings_Heavy_Double_Dash_Vertical=$'\u254F'               # ╏ Box Drawings Heavy Double Dash Vertical
export TERM_BOX_Box_Drawings_Double_Horizontal=$'\u2550'                        # ═ Box Drawings Double Horizontal
export TERM_BOX_Box_Drawings_Double_Vertical=$'\u2551'                          # ║ Box Drawings Double Vertical
export TERM_BOX_Box_Drawings_Down_Single_and_Right_Double=$'\u2552'             # ╒ Box Drawings Down Single and Right Double
export TERM_BOX_Box_Drawings_Down_Double_and_Right_Single=$'\u2553'             # ╓ Box Drawings Down Double and Right Single
export TERM_BOX_Box_Drawings_Double_Down_and_Right=$'\u2554'                    # ╔ Box Drawings Double Down and Right
export TERM_BOX_Box_Drawings_Down_Single_and_Left_Double=$'\u2555'              # ╕ Box Drawings Down Single and Left Double
export TERM_BOX_Box_Drawings_Down_Double_and_Left_Single=$'\u2556'              # ╖ Box Drawings Down Double and Left Single
export TERM_BOX_Box_Drawings_Double_Down_and_Left=$'\u2557'                     # ╗ Box Drawings Double Down and Left
export TERM_BOX_Box_Drawings_Up_Single_and_Right_Double=$'\u2558'               # ╘ Box Drawings Up Single and Right Double
export TERM_BOX_Box_Drawings_Up_Double_and_Right_Single=$'\u2559'               # ╙ Box Drawings Up Double and Right Single
export TERM_BOX_Box_Drawings_Double_Up_and_Right=$'\u255A'                      # ╚ Box Drawings Double Up and Right
export TERM_BOX_Box_Drawings_Up_Single_and_Left_Double=$'\u255B'                # ╛ Box Drawings Up Single and Left Double
export TERM_BOX_Box_Drawings_Up_Double_and_Left_Single=$'\u255C'                # ╜ Box Drawings Up Double and Left Single
export TERM_BOX_Box_Drawings_Double_Up_and_Left=$'\u255D'                       # ╝ Box Drawings Double Up and Left
export TERM_BOX_Box_Drawings_Vertical_Single_and_Right_Double=$'\u255E'         # ╞ Box Drawings Vertical Single and Right Double
export TERM_BOX_Box_Drawings_Vertical_Double_and_Right_Single=$'\u255F'         # ╟ Box Drawings Vertical Double and Right Single
export TERM_BOX_Box_Drawings_Double_Vertical_and_Right=$'\u2560'                # ╠ Box Drawings Double Vertical and Right
export TERM_BOX_Box_Drawings_Vertical_Single_and_Left_Double=$'\u2561'          # ╡ Box Drawings Vertical Single and Left Double
export TERM_BOX_Box_Drawings_Vertical_Double_and_Left_Single=$'\u2562'          # ╢ Box Drawings Vertical Double and Left Single
export TERM_BOX_Box_Drawings_Double_Vertical_and_Left=$'\u2563'                 # ╣ Box Drawings Double Vertical and Left
export TERM_BOX_Box_Drawings_Down_Single_and_Horizontal_Double=$'\u2564'        # ╤ Box Drawings Down Single and Horizontal Double
export TERM_BOX_Box_Drawings_Down_Double_and_Horizontal_Single=$'\u2565'        # ╥ Box Drawings Down Double and Horizontal Single
export TERM_BOX_Box_Drawings_Double_Down_and_Horizontal=$'\u2566'               # ╦ Box Drawings Double Down and Horizontal
export TERM_BOX_Box_Drawings_Up_Single_and_Horizontal_Double=$'\u2567'          # ╧ Box Drawings Up Single and Horizontal Double
export TERM_BOX_Box_Drawings_Up_Double_and_Horizontal_Single=$'\u2568'          # ╨ Box Drawings Up Double and Horizontal Single
export TERM_BOX_Box_Drawings_Double_Up_and_Horizontal=$'\u2569'                 # ╩ Box Drawings Double Up and Horizontal
export TERM_BOX_Box_Drawings_Vertical_Single_and_Horizontal_Double=$'\u256A'    # ╪ Box Drawings Vertical Single and Horizontal Double
export TERM_BOX_Box_Drawings_Vertical_Double_and_Horizontal_Single=$'\u256B'    # ╫ Box Drawings Vertical Double and Horizontal Single
export TERM_BOX_Box_Drawings_Double_Vertical_and_Horizontal=$'\u256C'           # ╬ Box Drawings Double Vertical and Horizontal
export TERM_BOX_Box_Drawings_Light_Arc_Down_and_Right=$'\u256D'                 # ╭ Box Drawings Light Arc Down and Right
export TERM_BOX_Box_Drawings_Light_Arc_Down_and_Left=$'\u256E'                  # ╮ Box Drawings Light Arc Down and Left
export TERM_BOX_Box_Drawings_Light_Arc_Up_and_Left=$'\u256F'                    # ╯ Box Drawings Light Arc Up and Left
export TERM_BOX_Box_Drawings_Light_Arc_Up_and_Right=$'\u2570'                   # ╰ Box Drawings Light Arc Up and Right
export TERM_BOX_Box_Drawings_Light_Diagonal_Upper_Right_to_Lower_Left=$'\u2571' # ╱ Box Drawings Light Diagonal Upper Right to Lower Left
export TERM_BOX_Box_Drawings_Light_Diagonal_Upper_Left_to_Lower_Right=$'\u2572' # ╲ Box Drawings Light Diagonal Upper Left to Lower Right
export TERM_BOX_Box_Drawings_Light_Diagonal_Cross=$'\u2573'                     # ╳ Box Drawings Light Diagonal Cross
export TERM_BOX_Box_Drawings_Light_Left=$'\u2574'                               # ╴ Box Drawings Light Left
export TERM_BOX_Box_Drawings_Light_Up=$'\u2575'                                 # ╵ Box Drawings Light Up
export TERM_BOX_Box_Drawings_Light_Right=$'\u2576'                              # ╶ Box Drawings Light Right
export TERM_BOX_Box_Drawings_Light_Down=$'\u2577'                               # ╷ Box Drawings Light Down
export TERM_BOX_Box_Drawings_Heavy_Left=$'\u2578'                               # ╸ Box Drawings Heavy Left
export TERM_BOX_Box_Drawings_Heavy_Up=$'\u2579'                                 # ╹ Box Drawings Heavy Up
export TERM_BOX_Box_Drawings_Heavy_Right=$'\u257A'                              # ╺ Box Drawings Heavy Right
export TERM_BOX_Box_Drawings_Heavy_Down=$'\u257B'                               # ╻ Box Drawings Heavy Down
export TERM_BOX_Box_Drawings_Light_Left_and_Heavy_Right=$'\u257C'               # ╼ Box Drawings Light Left and Heavy Right
export TERM_BOX_Box_Drawings_Light_Up_and_Heavy_Down=$'\u257D'                  # ╽ Box Drawings Light Up and Heavy Down
export TERM_BOX_Box_Drawings_Heavy_Left_and_Light_Right=$'\u257E'               # ╾ Box Drawings Heavy Left and Light Right
export TERM_BOX_Box_Drawings_Heavy_Up_and_Light_Down=$'\u257F'                  # ╿ Box Drawings Heavy Up and Light Down
