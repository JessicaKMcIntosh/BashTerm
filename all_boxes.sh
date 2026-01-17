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
if __ "${BASH_VERSINFO_0}" -lt "4"  ; then
    echo "This script requires Bash 4 or later."
    echo "Current version: ${BASH_VERSION}"
    exit 1
fi

# Only load the library once.
declare -A _TERM_LOADED # Track loaded files.
declare _TERM_FILE_NAME="${BASH_SOURCE[0]##*/}"
if [[ -v _TERM_LOADED[${_TERM_FILE_NAME}] ]] ; then
    [[ -v TERM_VERBOSE ]] && echo "Already loaded '${_TERM_FILE_NAME}'."
    return 0
fi
_TERM_LOADED[${_TERM_FILE_NAME}]="${BASH_SOURCE[0]}"
[[ -v TERM_VERBOSE ]] && echo "Loading '${_TERM_FILE_NAME}'..."
unset _TERM_FILE_NAME

TERM_BOX_Box_Drawings_Light_Horizontal=$'\u2500' # ─
TERM_BOX_Box_Drawings_Heavy_Horizontal=$'\u2501' # ━
TERM_BOX_Box_Drawings_Light_Vertical=$'\u2502' # │
TERM_BOX_Box_Drawings_Heavy_Vertical=$'\u2503' # ┃
TERM_BOX_Box_Drawings_Light_Triple_Dash_Horizontal=$'\u2504' # ┄
TERM_BOX_Box_Drawings_Heavy_Triple_Dash_Horizontal=$'\u2505' # ┅
TERM_BOX_Box_Drawings_Light_Triple_Dash_Vertical=$'\u2506' # ┆
TERM_BOX_Box_Drawings_Heavy_Triple_Dash_Vertical=$'\u2507' # ┇
TERM_BOX_Box_Drawings_Light_Quadruple_Dash_Horizontal=$'\u2508' # ┈
TERM_BOX_Box_Drawings_Heavy_Quadruple_Dash_Horizontal=$'\u2509' # ┉
TERM_BOX_Box_Drawings_Light_Quadruple_Dash_Vertical=$'\u250A' # ┊
TERM_BOX_Box_Drawings_Heavy_Quadruple_Dash_Vertical=$'\u250B' # ┋
TERM_BOX_Box_Drawings_Light_Down_and_Right=$'\u250C' # ┌
TERM_BOX_Box_Drawings_Down_Light_and_Right_Heavy=$'\u250D' # ┍
TERM_BOX_Box_Drawings_Down_Heavy_and_Right_Light=$'\u250E' # ┎
TERM_BOX_Box_Drawings_Heavy_Down_and_Right=$'\u250F' # ┏
TERM_BOX_Box_Drawings_Light_Down_and_Left=$'\u2510' # ┐
TERM_BOX_Box_Drawings_Down_Light_and_Left_Heavy=$'\u2511' # ┑
TERM_BOX_Box_Drawings_Down_Heavy_and_Left_Light=$'\u2512' # ┒
TERM_BOX_Box_Drawings_Heavy_Down_and_Left=$'\u2513' # ┓
TERM_BOX_Box_Drawings_Light_Up_and_Right=$'\u2514' # └
TERM_BOX_Box_Drawings_Up_Light_and_Right_Heavy=$'\u2515' # ┕
TERM_BOX_Box_Drawings_Up_Heavy_and_Right_Light=$'\u2516' # ┖
TERM_BOX_Box_Drawings_Heavy_Up_and_Right=$'\u2517' # ┗
TERM_BOX_Box_Drawings_Light_Up_and_Left=$'\u2518' # ┘
TERM_BOX_Box_Drawings_Up_Light_and_Left_Heavy=$'\u2519' # ┙
TERM_BOX_Box_Drawings_Up_Heavy_and_Left_Light=$'\u251A' # ┚
TERM_BOX_Box_Drawings_Heavy_Up_and_Left=$'\u251B' # ┛
TERM_BOX_Box_Drawings_Light_Vertical_and_Right=$'\u251C' # ├
TERM_BOX_Box_Drawings_Vertical_Light_and_Right_Heavy=$'\u251D' # ┝
TERM_BOX_Box_Drawings_Up_Heavy_and_Right_Down_Light=$'\u251E' # ┞
TERM_BOX_Box_Drawings_Down_Heavy_and_Right_Up_Light=$'\u251F' # ┟
TERM_BOX_Box_Drawings_Vertical_Heavy_and_Right_Light=$'\u2520' # ┠
TERM_BOX_Box_Drawings_Down_Light_and_Right_Up_Heavy=$'\u2521' # ┡
TERM_BOX_Box_Drawings_Up_Light_and_Right_Down_Heavy=$'\u2522' # ┢
TERM_BOX_Box_Drawings_Heavy_Vertical_and_Right=$'\u2523' # ┣
TERM_BOX_Box_Drawings_Light_Vertical_and_Left=$'\u2524' # ┤
TERM_BOX_Box_Drawings_Vertical_Light_and_Left_Heavy=$'\u2525' # ┥
TERM_BOX_Box_Drawings_Up_Heavy_and_Left_Down_Light=$'\u2526' # ┦
TERM_BOX_Box_Drawings_Down_Heavy_and_Left_Up_Light=$'\u2527' # ┧
TERM_BOX_Box_Drawings_Vertical_Heavy_and_Left_Light=$'\u2528' # ┨
TERM_BOX_Box_Drawings_Down_Light_and_Left_Up_Heavy=$'\u2529' # ┩
TERM_BOX_Box_Drawings_Up_Light_and_Left_Down_Heavy=$'\u252A' # ┪
TERM_BOX_Box_Drawings_Heavy_Vertical_and_Left=$'\u252B' # ┫
TERM_BOX_Box_Drawings_Light_Down_and_Horizontal=$'\u252C' # ┬
TERM_BOX_Box_Drawings_Left_Heavy_and_Right_Down_Light=$'\u252D' # ┭
TERM_BOX_Box_Drawings_Right_Heavy_and_Left_Down_Light=$'\u252E' # ┮
TERM_BOX_Box_Drawings_Down_Light_and_Horizontal_Heavy=$'\u252F' # ┯
TERM_BOX_Box_Drawings_Down_Heavy_and_Horizontal_Light=$'\u2530' # ┰
TERM_BOX_Box_Drawings_Right_Light_and_Left_Down_Heavy=$'\u2531' # ┱
TERM_BOX_Box_Drawings_Left_Light_and_Right_Down_Heavy=$'\u2532' # ┲
TERM_BOX_Box_Drawings_Heavy_Down_and_Horizontal=$'\u2533' # ┳
TERM_BOX_Box_Drawings_Light_Up_and_Horizontal=$'\u2534' # ┴
TERM_BOX_Box_Drawings_Left_Heavy_and_Right_Up_Light=$'\u2535' # ┵
TERM_BOX_Box_Drawings_Right_Heavy_and_Left_Up_Light=$'\u2536' # ┶
TERM_BOX_Box_Drawings_Up_Light_and_Horizontal_Heavy=$'\u2537' # ┷
TERM_BOX_Box_Drawings_Up_Heavy_and_Horizontal_Light=$'\u2538' # ┸
TERM_BOX_Box_Drawings_Right_Light_and_Left_Up_Heavy=$'\u2539' # ┹
TERM_BOX_Box_Drawings_Left_Light_and_Right_Up_Heavy=$'\u253A' # ┺
TERM_BOX_Box_Drawings_Heavy_Up_and_Horizontal=$'\u253B' # ┻
TERM_BOX_Box_Drawings_Light_Vertical_and_Horizontal=$'\u253C' # ┼
TERM_BOX_Box_Drawings_Left_Heavy_and_Right_Vertical_Light=$'\u253D' # ┽
TERM_BOX_Box_Drawings_Right_Heavy_and_Left_Vertical_Light=$'\u253E' # ┾
TERM_BOX_Box_Drawings_Vertical_Light_and_Horizontal_Heavy=$'\u253F' # ┿
TERM_BOX_Box_Drawings_Up_Heavy_and_Down_Horizontal_Light=$'\u2540' # ╀
TERM_BOX_Box_Drawings_Down_Heavy_and_Up_Horizontal_Light=$'\u2541' # ╁
TERM_BOX_Box_Drawings_Vertical_Heavy_and_Horizontal_Light=$'\u2542' # ╂
TERM_BOX_Box_Drawings_Left_Up_Heavy_and_Right_Down_Light=$'\u2543' # ╃
TERM_BOX_Box_Drawings_Right_Up_Heavy_and_Left_Down_Light=$'\u2544' # ╄
TERM_BOX_Box_Drawings_Left_Down_Heavy_and_Right_Up_Light=$'\u2545' # ╅
TERM_BOX_Box_Drawings_Right_Down_Heavy_and_Left_Up_Light=$'\u2546' # ╆
TERM_BOX_Box_Drawings_Down_Light_and_Up_Horizontal_Heavy=$'\u2547' # ╇
TERM_BOX_Box_Drawings_Up_Light_and_Down_Horizontal_Heavy=$'\u2548' # ╈
TERM_BOX_Box_Drawings_Right_Light_and_Left_Vertical_Heavy=$'\u2549' # ╉
TERM_BOX_Box_Drawings_Left_Light_and_Right_Vertical_Heavy=$'\u254A' # ╊
TERM_BOX_Box_Drawings_Heavy_Vertical_and_Horizontal=$'\u254B' # ╋
TERM_BOX_Box_Drawings_Light_Double_Dash_Horizontal=$'\u254C' # ╌
TERM_BOX_Box_Drawings_Heavy_Double_Dash_Horizontal=$'\u254D' # ╍
TERM_BOX_Box_Drawings_Light_Double_Dash_Vertical=$'\u254E' # ╎
TERM_BOX_Box_Drawings_Heavy_Double_Dash_Vertical=$'\u254F' # ╏
TERM_BOX_Box_Drawings_Double_Horizontal=$'\u2550' # ═
TERM_BOX_Box_Drawings_Double_Vertical=$'\u2551' # ║
TERM_BOX_Box_Drawings_Down_Single_and_Right_Double=$'\u2552' # ╒
TERM_BOX_Box_Drawings_Down_Double_and_Right_Single=$'\u2553' # ╓
TERM_BOX_Box_Drawings_Double_Down_and_Right=$'\u2554' # ╔
TERM_BOX_Box_Drawings_Down_Single_and_Left_Double=$'\u2555' # ╕
TERM_BOX_Box_Drawings_Down_Double_and_Left_Single=$'\u2556' # ╖
TERM_BOX_Box_Drawings_Double_Down_and_Left=$'\u2557' # ╗
TERM_BOX_Box_Drawings_Up_Single_and_Right_Double=$'\u2558' # ╘
TERM_BOX_Box_Drawings_Up_Double_and_Right_Single=$'\u2559' # ╙
TERM_BOX_Box_Drawings_Double_Up_and_Right=$'\u255A' # ╚
TERM_BOX_Box_Drawings_Up_Single_and_Left_Double=$'\u255B' # ╛
TERM_BOX_Box_Drawings_Up_Double_and_Left_Single=$'\u255C' # ╜
TERM_BOX_Box_Drawings_Double_Up_and_Left=$'\u255D' # ╝
TERM_BOX_Box_Drawings_Vertical_Single_and_Right_Double=$'\u255E' # ╞
TERM_BOX_Box_Drawings_Vertical_Double_and_Right_Single=$'\u255F' # ╟
TERM_BOX_Box_Drawings_Double_Vertical_and_Right=$'\u2560' # ╠
TERM_BOX_Box_Drawings_Vertical_Single_and_Left_Double=$'\u2561' # ╡
TERM_BOX_Box_Drawings_Vertical_Double_and_Left_Single=$'\u2562' # ╢
TERM_BOX_Box_Drawings_Double_Vertical_and_Left=$'\u2563' # ╣
TERM_BOX_Box_Drawings_Down_Single_and_Horizontal_Double=$'\u2564' # ╤
TERM_BOX_Box_Drawings_Down_Double_and_Horizontal_Single=$'\u2565' # ╥
TERM_BOX_Box_Drawings_Double_Down_and_Horizontal=$'\u2566' # ╦
TERM_BOX_Box_Drawings_Up_Single_and_Horizontal_Double=$'\u2567' # ╧
TERM_BOX_Box_Drawings_Up_Double_and_Horizontal_Single=$'\u2568' # ╨
TERM_BOX_Box_Drawings_Double_Up_and_Horizontal=$'\u2569' # ╩
TERM_BOX_Box_Drawings_Vertical_Single_and_Horizontal_Double=$'\u256A' # ╪
TERM_BOX_Box_Drawings_Vertical_Double_and_Horizontal_Single=$'\u256B' # ╫
TERM_BOX_Box_Drawings_Double_Vertical_and_Horizontal=$'\u256C' # ╬
TERM_BOX_Box_Drawings_Light_Arc_Down_and_Right=$'\u256D' # ╭
TERM_BOX_Box_Drawings_Light_Arc_Down_and_Left=$'\u256E' # ╮
TERM_BOX_Box_Drawings_Light_Arc_Up_and_Left=$'\u256F' # ╯
TERM_BOX_Box_Drawings_Light_Arc_Up_and_Right=$'\u2570' # ╰
TERM_BOX_Box_Drawings_Light_Diagonal_Upper_Right_to_Lower_Left=$'\u2571' # ╱
TERM_BOX_Box_Drawings_Light_Diagonal_Upper_Left_to_Lower_Right=$'\u2572' # ╲
TERM_BOX_Box_Drawings_Light_Diagonal_Cross=$'\u2573' # ╳
TERM_BOX_Box_Drawings_Light_Left=$'\u2574' # ╴
TERM_BOX_Box_Drawings_Light_Up=$'\u2575' # ╵
TERM_BOX_Box_Drawings_Light_Right=$'\u2576' # ╶
TERM_BOX_Box_Drawings_Light_Down=$'\u2577' # ╷
TERM_BOX_Box_Drawings_Heavy_Left=$'\u2578' # ╸
TERM_BOX_Box_Drawings_Heavy_Up=$'\u2579' # ╹
TERM_BOX_Box_Drawings_Heavy_Right=$'\u257A' # ╺
TERM_BOX_Box_Drawings_Heavy_Down=$'\u257B' # ╻
TERM_BOX_Box_Drawings_Light_Left_and_Heavy_Right=$'\u257C' # ╼
TERM_BOX_Box_Drawings_Light_Up_and_Heavy_Down=$'\u257D' # ╽
TERM_BOX_Box_Drawings_Heavy_Left_and_Light_Right=$'\u257E' # ╾
TERM_BOX_Box_Drawings_Heavy_Up_and_Light_Down=$'\u257F' # ╿
