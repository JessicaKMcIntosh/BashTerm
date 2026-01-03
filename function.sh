#!/usr/bin/env bash
# shellcheck source=attr.sh
# shellcheck source=boxes.sh
# shellcheck source=color.sh
# shellcheck source=cursor.sh

# This is a functional interface to the variables.
# If that is something you want... :shrug:

# I recommend picking and choosing what you want.

# Load the libraries.
find_library(){
    local library="${1}"
    for file_name in {./,../}${library} ; do
        if [[ -f  "${file_name}" ]] ; then
            echo "${file_name}"
        fi
done
}
source "$(find_library "attr.sh")"
source "$(find_library "boxes.sh")"
source "$(find_library "color.sh")"
source "$(find_library "cursor.sh")"

# Directly call 'tput'
term::tput() {
    tput "$@"
}

# Associative arrays:
term::attr() {
    echo -n "${TERM_ATTR[$1]}"
}

term::fg() {
    echo -n "${TERM_FG[$1]}"
}

term::bg() {
    echo -n "${TERM_BG[$1]}"
}

term::box() {
    echo -n "${TERM_BOX[$1]}"
}

term::cursor() {
    echo -n "${TERM_CURSOR[$1]}"
}

# Attributes:
term::ITALICS()     { echo -n "${TERM_ATTR["ritm"]}" ; }
term::STANDOUT()    { echo -n "${TERM_ATTR["rmso"]}" ; }
term::UNDERLINE()   { echo -n "${TERM_ATTR["rmul"]}" ; }
term::bold()        { echo -n "${TERM_ATTR["bold"]}" ; }
term::clear()       { echo -n "${TERM_ATTR["clear"]}" ; }
term::dim()         { echo -n "${TERM_ATTR["dim"]}" ; }
term::invis()       { echo -n "${TERM_ATTR["invis"]}" ; }
term::italics()     { echo -n "${TERM_ATTR["italics"]}" ; }
term::orig()        { echo -n "${TERM_ATTR["op"]}" ; }
term::reset()       { echo -n "${TERM_ATTR["reset"]}" ; }
term::reverse()     { echo -n "${TERM_ATTR["reverse"]}" ; }
term::standout()    { echo -n "${TERM_ATTR["standout"]}" ; }
term::underline()   { echo -n "${TERM_ATTR["underline"]}" ; }

# Colors:
term::black()       { echo -n "${TERM_FG["black"]}" ; }
term::blue()        { echo -n "${TERM_FG["blue"]}" ; }
term::cyan()        { echo -n "${TERM_FG["cyan"]}" ; }
term::green()       { echo -n "${TERM_FG["green"]}" ; }
term::magenta()     { echo -n "${TERM_FG["magenta"]}" ; }
term::red()         { echo -n "${TERM_FG["red"]}" ; }
term::white()       { echo -n "${TERM_FG["white"]}" ; }
term::yellow()      { echo -n "${TERM_FG["yellow"]}" ; }
term::BLACK()       { echo -n "${TERM_BG["black"]}" ; }
term::BLUE()        { echo -n "${TERM_BG["blue"]}" ; }
term::CYAN()        { echo -n "${TERM_BG["cyan"]}" ; }
term::GREEN()       { echo -n "${TERM_BG["green"]}" ; }
term::MAGENTA()     { echo -n "${TERM_BG["magenta"]}" ; }
term::RED()         { echo -n "${TERM_BG["red"]}" ; }
term::YELLOW()      { echo -n "${TERM_BG["yellow"]}" ; }

# Cursor:
term::clr_bol()             { echo -n "${TERM_CURSOR["clr_bol"]}" ; }
term::clr_eol()             { echo -n "${TERM_CURSOR["clr_eol"]}" ; }
term::clr_eos()             { echo -n "${TERM_CURSOR["clr_eos"]}" ; }
term::delete_character()    { echo -n "${TERM_CURSOR["delete_character"]}" ; }
term::delete_line()         { echo -n "${TERM_CURSOR["delete_line"]}" ; }
term::down()                { echo -n "${TERM_CURSOR["down"]}" ; }
term::hide()                { echo -n "${TERM_CURSOR["hide"]}" ; }
term::home()                { echo -n "${TERM_CURSOR["home"]}" ; }
# term::insert_character()    { echo -n "${TERM_CURSOR["insert_character"]}" ; }
term::insert_line()         { echo -n "${TERM_CURSOR["insert_line"]}" ; }
term::invisible()           { echo -n "${TERM_CURSOR["invisible"]}" ; }
term::left()                { echo -n "${TERM_CURSOR["left"]}" ; }
term::normal()              { echo -n "${TERM_CURSOR["normal"]}" ; }
term::restore()             { echo -n "${TERM_CURSOR["restore"]}" ; }
term::right()               { echo -n "${TERM_CURSOR["right"]}" ; }
term::save()                { echo -n "${TERM_CURSOR["save"]}" ; }
term::show()                { echo -n "${TERM_CURSOR["show"]}" ; }
# term::to_ll()               { echo -n "${TERM_CURSOR["to_ll"]}" ; }
term::up()                  { echo -n "${TERM_CURSOR["up"]}" ; }
term::visible()             { echo -n "${TERM_CURSOR["visible"]}" ; }

# Boxes:
term::box_l_lh() { echo -n "${TERM_BOX_L_LH}" ; } # ─ Box Drawings Light Horizontal
term::box_l_lv() { echo -n "${TERM_BOX_L_LV}" ; } # │ Box Drawings Light Vertical
term::box_l_tc() { echo -n "${TERM_BOX_L_TC}" ; } # ┬ Box Drawings Light Down and Horizontal
term::box_l_tl() { echo -n "${TERM_BOX_L_TL}" ; } # ┌ Box Drawings Light Down and Right
term::box_l_tr() { echo -n "${TERM_BOX_L_TR}" ; } # ┐ Box Drawings Light Down and Left
term::box_l_ml() { echo -n "${TERM_BOX_L_ML}" ; } # ├ Box Drawings Light Vertical and Right
term::box_l_mc() { echo -n "${TERM_BOX_L_MC}" ; } # ┼ Box Drawings Light Vertical and Horizontal
term::box_l_mr() { echo -n "${TERM_BOX_L_MR}" ; } # ┤ Box Drawings Light Vertical and Left
term::box_l_bc() { echo -n "${TERM_BOX_L_BC}" ; } # ┴ Box Drawings Light Up and Horizontal
term::box_l_bl() { echo -n "${TERM_BOX_L_BL}" ; } # └ Box Drawings Light Up and Right
term::box_l_br() { echo -n "${TERM_BOX_L_BR}" ; } # ┘ Box Drawings Light Up and Left
term::box_h_lh() { echo -n "${TERM_BOX_H_LH}" ; } # ━ Box Drawings Heavy Horizontal
term::box_h_lv() { echo -n "${TERM_BOX_H_LV}" ; } # ┃ Box Drawings Heavy Vertical
term::box_h_tc() { echo -n "${TERM_BOX_H_TC}" ; } # ┳ Box Drawings Heavy Down and Horizontal
term::box_h_tl() { echo -n "${TERM_BOX_H_TL}" ; } # ┏ Box Drawings Heavy Down and Right
term::box_h_tr() { echo -n "${TERM_BOX_H_TR}" ; } # ┓ Box Drawings Heavy Down and Left
term::box_h_ml() { echo -n "${TERM_BOX_H_ML}" ; } # ┣ Box Drawings Heavy Vertical and Right
term::box_h_mc() { echo -n "${TERM_BOX_H_MC}" ; } # ╋ Box Drawings Heavy Vertical and Horizontal
term::box_h_mr() { echo -n "${TERM_BOX_H_MR}" ; } # ┫ Box Drawings Heavy Vertical and Left
term::box_h_bc() { echo -n "${TERM_BOX_H_BC}" ; } # ┻ Box Drawings Heavy Up and Horizontal
term::box_h_bl() { echo -n "${TERM_BOX_H_BL}" ; } # ┗ Box Drawings Heavy Up and Right
term::box_h_br() { echo -n "${TERM_BOX_H_BR}" ; } # ┛ Box Drawings Heavy Up and Left
term::box_d_lh() { echo -n "${TERM_BOX_D_LH}" ; } # ═ Box Drawings Double Horizontal
term::box_d_lv() { echo -n "${TERM_BOX_D_LV}" ; } # ║ Box Drawings Double Vertical
term::box_d_tc() { echo -n "${TERM_BOX_D_TC}" ; } # ╦ Box Drawings Double Down and Horizontal
term::box_d_tl() { echo -n "${TERM_BOX_D_TL}" ; } # ╔ Box Drawings Double Down and Right
term::box_d_tr() { echo -n "${TERM_BOX_D_TR}" ; } # ╗ Box Drawings Double Down and Left
term::box_d_ml() { echo -n "${TERM_BOX_D_ML}" ; } # ╠ Box Drawings Double Vertical and Right
term::box_d_mc() { echo -n "${TERM_BOX_D_MC}" ; } # ╬ Box Drawings Double Vertical and Horizontal
term::box_d_mr() { echo -n "${TERM_BOX_D_MR}" ; } # ╣ Box Drawings Double Vertical and Left
term::box_d_bc() { echo -n "${TERM_BOX_D_BC}" ; } # ╩ Box Drawings Double Up and Horizontal
term::box_d_bl() { echo -n "${TERM_BOX_D_BL}" ; } # ╚ Box Drawings Double Up and Right
term::box_d_br() { echo -n "${TERM_BOX_D_BR}" ; } # ╝ Box Drawings Double Up and Left
term::box_r_lh() { echo -n "${TERM_BOX_R_LH}" ; } # ─ Box Drawings Light Horizontal
term::box_r_lv() { echo -n "${TERM_BOX_R_LV}" ; } # │ Box Drawings Light Vertical
term::box_r_tc() { echo -n "${TERM_BOX_R_TC}" ; } # ┬ Box Drawings Light Down and Horizontal
term::box_r_tl() { echo -n "${TERM_BOX_R_TL}" ; } # ╭ Box Drawings Light Arc Down and Right
term::box_r_tr() { echo -n "${TERM_BOX_R_TR}" ; } # ╮ Box Drawings Light Arc Down and Left
term::box_r_ml() { echo -n "${TERM_BOX_R_ML}" ; } # ├ Box Drawings Light Vertical and Right
term::box_r_mc() { echo -n "${TERM_BOX_R_MC}" ; } # ┼ Box Drawings Light Vertical and Horizontal
term::box_r_mr() { echo -n "${TERM_BOX_R_MR}" ; } # ┤ Box Drawings Light Vertical and Left
term::box_r_bc() { echo -n "${TERM_BOX_R_BC}" ; } # ┴ Box Drawings Light Up and Horizontal
term::box_r_bl() { echo -n "${TERM_BOX_R_BL}" ; } # ╰ Box Drawings Light Arc Up and Right
term::box_r_br() { echo -n "${TERM_BOX_R_BR}" ; } # ╯ Box Drawings Light Arc Up and Left
