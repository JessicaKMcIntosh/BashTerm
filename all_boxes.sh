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

export TERM_BOX_Box_Drawings_Light_Horizontal=$'\u2500' # ─
export TERM_BOX_Box_Drawings_Heavy_Horizontal=$'\u2501' # ━
export TERM_BOX_Box_Drawings_Light_Vertical=$'\u2502' # │
export TERM_BOX_Box_Drawings_Heavy_Vertical=$'\u2503' # ┃
export TERM_BOX_Box_Drawings_Light_Triple_Dash_Horizontal=$'\u2504' # ┄
export TERM_BOX_Box_Drawings_Heavy_Triple_Dash_Horizontal=$'\u2505' # ┅
export TERM_BOX_Box_Drawings_Light_Triple_Dash_Vertical=$'\u2506' # ┆
export TERM_BOX_Box_Drawings_Heavy_Triple_Dash_Vertical=$'\u2507' # ┇
export TERM_BOX_Box_Drawings_Light_Quadruple_Dash_Horizontal=$'\u2508' # ┈
export TERM_BOX_Box_Drawings_Heavy_Quadruple_Dash_Horizontal=$'\u2509' # ┉
export TERM_BOX_Box_Drawings_Light_Quadruple_Dash_Vertical=$'\u250A' # ┊
export TERM_BOX_Box_Drawings_Heavy_Quadruple_Dash_Vertical=$'\u250B' # ┋
export TERM_BOX_Box_Drawings_Light_Down_and_Right=$'\u250C' # ┌
export TERM_BOX_Box_Drawings_Down_Light_and_Right_Heavy=$'\u250D' # ┍
export TERM_BOX_Box_Drawings_Down_Heavy_and_Right_Light=$'\u250E' # ┎
export TERM_BOX_Box_Drawings_Heavy_Down_and_Right=$'\u250F' # ┏
export TERM_BOX_Box_Drawings_Light_Down_and_Left=$'\u2510' # ┐
export TERM_BOX_Box_Drawings_Down_Light_and_Left_Heavy=$'\u2511' # ┑
export TERM_BOX_Box_Drawings_Down_Heavy_and_Left_Light=$'\u2512' # ┒
export TERM_BOX_Box_Drawings_Heavy_Down_and_Left=$'\u2513' # ┓
export TERM_BOX_Box_Drawings_Light_Up_and_Right=$'\u2514' # └
export TERM_BOX_Box_Drawings_Up_Light_and_Right_Heavy=$'\u2515' # ┕
export TERM_BOX_Box_Drawings_Up_Heavy_and_Right_Light=$'\u2516' # ┖
export TERM_BOX_Box_Drawings_Heavy_Up_and_Right=$'\u2517' # ┗
export TERM_BOX_Box_Drawings_Light_Up_and_Left=$'\u2518' # ┘
export TERM_BOX_Box_Drawings_Up_Light_and_Left_Heavy=$'\u2519' # ┙
export TERM_BOX_Box_Drawings_Up_Heavy_and_Left_Light=$'\u251A' # ┚
export TERM_BOX_Box_Drawings_Heavy_Up_and_Left=$'\u251B' # ┛
export TERM_BOX_Box_Drawings_Light_Vertical_and_Right=$'\u251C' # ├
export TERM_BOX_Box_Drawings_Vertical_Light_and_Right_Heavy=$'\u251D' # ┝
export TERM_BOX_Box_Drawings_Up_Heavy_and_Right_Down_Light=$'\u251E' # ┞
export TERM_BOX_Box_Drawings_Down_Heavy_and_Right_Up_Light=$'\u251F' # ┟
export TERM_BOX_Box_Drawings_Vertical_Heavy_and_Right_Light=$'\u2520' # ┠
export TERM_BOX_Box_Drawings_Down_Light_and_Right_Up_Heavy=$'\u2521' # ┡
export TERM_BOX_Box_Drawings_Up_Light_and_Right_Down_Heavy=$'\u2522' # ┢
export TERM_BOX_Box_Drawings_Heavy_Vertical_and_Right=$'\u2523' # ┣
export TERM_BOX_Box_Drawings_Light_Vertical_and_Left=$'\u2524' # ┤
export TERM_BOX_Box_Drawings_Vertical_Light_and_Left_Heavy=$'\u2525' # ┥
export TERM_BOX_Box_Drawings_Up_Heavy_and_Left_Down_Light=$'\u2526' # ┦
export TERM_BOX_Box_Drawings_Down_Heavy_and_Left_Up_Light=$'\u2527' # ┧
export TERM_BOX_Box_Drawings_Vertical_Heavy_and_Left_Light=$'\u2528' # ┨
export TERM_BOX_Box_Drawings_Down_Light_and_Left_Up_Heavy=$'\u2529' # ┩
export TERM_BOX_Box_Drawings_Up_Light_and_Left_Down_Heavy=$'\u252A' # ┪
export TERM_BOX_Box_Drawings_Heavy_Vertical_and_Left=$'\u252B' # ┫
export TERM_BOX_Box_Drawings_Light_Down_and_Horizontal=$'\u252C' # ┬
export TERM_BOX_Box_Drawings_Left_Heavy_and_Right_Down_Light=$'\u252D' # ┭
export TERM_BOX_Box_Drawings_Right_Heavy_and_Left_Down_Light=$'\u252E' # ┮
export TERM_BOX_Box_Drawings_Down_Light_and_Horizontal_Heavy=$'\u252F' # ┯
export TERM_BOX_Box_Drawings_Down_Heavy_and_Horizontal_Light=$'\u2530' # ┰
export TERM_BOX_Box_Drawings_Right_Light_and_Left_Down_Heavy=$'\u2531' # ┱
export TERM_BOX_Box_Drawings_Left_Light_and_Right_Down_Heavy=$'\u2532' # ┲
export TERM_BOX_Box_Drawings_Heavy_Down_and_Horizontal=$'\u2533' # ┳
export TERM_BOX_Box_Drawings_Light_Up_and_Horizontal=$'\u2534' # ┴
export TERM_BOX_Box_Drawings_Left_Heavy_and_Right_Up_Light=$'\u2535' # ┵
export TERM_BOX_Box_Drawings_Right_Heavy_and_Left_Up_Light=$'\u2536' # ┶
export TERM_BOX_Box_Drawings_Up_Light_and_Horizontal_Heavy=$'\u2537' # ┷
export TERM_BOX_Box_Drawings_Up_Heavy_and_Horizontal_Light=$'\u2538' # ┸
export TERM_BOX_Box_Drawings_Right_Light_and_Left_Up_Heavy=$'\u2539' # ┹
export TERM_BOX_Box_Drawings_Left_Light_and_Right_Up_Heavy=$'\u253A' # ┺
export TERM_BOX_Box_Drawings_Heavy_Up_and_Horizontal=$'\u253B' # ┻
export TERM_BOX_Box_Drawings_Light_Vertical_and_Horizontal=$'\u253C' # ┼
export TERM_BOX_Box_Drawings_Left_Heavy_and_Right_Vertical_Light=$'\u253D' # ┽
export TERM_BOX_Box_Drawings_Right_Heavy_and_Left_Vertical_Light=$'\u253E' # ┾
export TERM_BOX_Box_Drawings_Vertical_Light_and_Horizontal_Heavy=$'\u253F' # ┿
export TERM_BOX_Box_Drawings_Up_Heavy_and_Down_Horizontal_Light=$'\u2540' # ╀
export TERM_BOX_Box_Drawings_Down_Heavy_and_Up_Horizontal_Light=$'\u2541' # ╁
export TERM_BOX_Box_Drawings_Vertical_Heavy_and_Horizontal_Light=$'\u2542' # ╂
export TERM_BOX_Box_Drawings_Left_Up_Heavy_and_Right_Down_Light=$'\u2543' # ╃
export TERM_BOX_Box_Drawings_Right_Up_Heavy_and_Left_Down_Light=$'\u2544' # ╄
export TERM_BOX_Box_Drawings_Left_Down_Heavy_and_Right_Up_Light=$'\u2545' # ╅
export TERM_BOX_Box_Drawings_Right_Down_Heavy_and_Left_Up_Light=$'\u2546' # ╆
export TERM_BOX_Box_Drawings_Down_Light_and_Up_Horizontal_Heavy=$'\u2547' # ╇
export TERM_BOX_Box_Drawings_Up_Light_and_Down_Horizontal_Heavy=$'\u2548' # ╈
export TERM_BOX_Box_Drawings_Right_Light_and_Left_Vertical_Heavy=$'\u2549' # ╉
export TERM_BOX_Box_Drawings_Left_Light_and_Right_Vertical_Heavy=$'\u254A' # ╊
export TERM_BOX_Box_Drawings_Heavy_Vertical_and_Horizontal=$'\u254B' # ╋
export TERM_BOX_Box_Drawings_Light_Double_Dash_Horizontal=$'\u254C' # ╌
export TERM_BOX_Box_Drawings_Heavy_Double_Dash_Horizontal=$'\u254D' # ╍
export TERM_BOX_Box_Drawings_Light_Double_Dash_Vertical=$'\u254E' # ╎
export TERM_BOX_Box_Drawings_Heavy_Double_Dash_Vertical=$'\u254F' # ╏
export TERM_BOX_Box_Drawings_Double_Horizontal=$'\u2550' # ═
export TERM_BOX_Box_Drawings_Double_Vertical=$'\u2551' # ║
export TERM_BOX_Box_Drawings_Down_Single_and_Right_Double=$'\u2552' # ╒
export TERM_BOX_Box_Drawings_Down_Double_and_Right_Single=$'\u2553' # ╓
export TERM_BOX_Box_Drawings_Double_Down_and_Right=$'\u2554' # ╔
export TERM_BOX_Box_Drawings_Down_Single_and_Left_Double=$'\u2555' # ╕
export TERM_BOX_Box_Drawings_Down_Double_and_Left_Single=$'\u2556' # ╖
export TERM_BOX_Box_Drawings_Double_Down_and_Left=$'\u2557' # ╗
export TERM_BOX_Box_Drawings_Up_Single_and_Right_Double=$'\u2558' # ╘
export TERM_BOX_Box_Drawings_Up_Double_and_Right_Single=$'\u2559' # ╙
export TERM_BOX_Box_Drawings_Double_Up_and_Right=$'\u255A' # ╚
export TERM_BOX_Box_Drawings_Up_Single_and_Left_Double=$'\u255B' # ╛
export TERM_BOX_Box_Drawings_Up_Double_and_Left_Single=$'\u255C' # ╜
export TERM_BOX_Box_Drawings_Double_Up_and_Left=$'\u255D' # ╝
export TERM_BOX_Box_Drawings_Vertical_Single_and_Right_Double=$'\u255E' # ╞
export TERM_BOX_Box_Drawings_Vertical_Double_and_Right_Single=$'\u255F' # ╟
export TERM_BOX_Box_Drawings_Double_Vertical_and_Right=$'\u2560' # ╠
export TERM_BOX_Box_Drawings_Vertical_Single_and_Left_Double=$'\u2561' # ╡
export TERM_BOX_Box_Drawings_Vertical_Double_and_Left_Single=$'\u2562' # ╢
export TERM_BOX_Box_Drawings_Double_Vertical_and_Left=$'\u2563' # ╣
export TERM_BOX_Box_Drawings_Down_Single_and_Horizontal_Double=$'\u2564' # ╤
export TERM_BOX_Box_Drawings_Down_Double_and_Horizontal_Single=$'\u2565' # ╥
export TERM_BOX_Box_Drawings_Double_Down_and_Horizontal=$'\u2566' # ╦
export TERM_BOX_Box_Drawings_Up_Single_and_Horizontal_Double=$'\u2567' # ╧
export TERM_BOX_Box_Drawings_Up_Double_and_Horizontal_Single=$'\u2568' # ╨
export TERM_BOX_Box_Drawings_Double_Up_and_Horizontal=$'\u2569' # ╩
export TERM_BOX_Box_Drawings_Vertical_Single_and_Horizontal_Double=$'\u256A' # ╪
export TERM_BOX_Box_Drawings_Vertical_Double_and_Horizontal_Single=$'\u256B' # ╫
export TERM_BOX_Box_Drawings_Double_Vertical_and_Horizontal=$'\u256C' # ╬
export TERM_BOX_Box_Drawings_Light_Arc_Down_and_Right=$'\u256D' # ╭
export TERM_BOX_Box_Drawings_Light_Arc_Down_and_Left=$'\u256E' # ╮
export TERM_BOX_Box_Drawings_Light_Arc_Up_and_Left=$'\u256F' # ╯
export TERM_BOX_Box_Drawings_Light_Arc_Up_and_Right=$'\u2570' # ╰
export TERM_BOX_Box_Drawings_Light_Diagonal_Upper_Right_to_Lower_Left=$'\u2571' # ╱
export TERM_BOX_Box_Drawings_Light_Diagonal_Upper_Left_to_Lower_Right=$'\u2572' # ╲
export TERM_BOX_Box_Drawings_Light_Diagonal_Cross=$'\u2573' # ╳
export TERM_BOX_Box_Drawings_Light_Left=$'\u2574' # ╴
export TERM_BOX_Box_Drawings_Light_Up=$'\u2575' # ╵
export TERM_BOX_Box_Drawings_Light_Right=$'\u2576' # ╶
export TERM_BOX_Box_Drawings_Light_Down=$'\u2577' # ╷
export TERM_BOX_Box_Drawings_Heavy_Left=$'\u2578' # ╸
export TERM_BOX_Box_Drawings_Heavy_Up=$'\u2579' # ╹
export TERM_BOX_Box_Drawings_Heavy_Right=$'\u257A' # ╺
export TERM_BOX_Box_Drawings_Heavy_Down=$'\u257B' # ╻
export TERM_BOX_Box_Drawings_Light_Left_and_Heavy_Right=$'\u257C' # ╼
export TERM_BOX_Box_Drawings_Light_Up_and_Heavy_Down=$'\u257D' # ╽
export TERM_BOX_Box_Drawings_Heavy_Left_and_Light_Right=$'\u257E' # ╾
export TERM_BOX_Box_Drawings_Heavy_Up_and_Light_Down=$'\u257F' # ╿
