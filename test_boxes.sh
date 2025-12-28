#!/usr/bin/env bash

# Test the boxes library.

source "./boxes.sh"

#┌┬─┐
#├┼─┤
#││ │
#└┴─┘
echo "Light Boxes:"
echo "${TERM_BOX_L_TL}${TERM_BOX_L_TC}${TERM_BOX_L_LH}${TERM_BOX_L_TR}"
echo "${TERM_BOX_L_ML}${TERM_BOX_L_MC}${TERM_BOX_L_LH}${TERM_BOX_L_MR}"
echo "${TERM_BOX_L_LV}${TERM_BOX_L_LV} ${TERM_BOX_L_LV}"
echo "${TERM_BOX_L_BL}${TERM_BOX_L_BC}${TERM_BOX_L_LH}${TERM_BOX_L_BR}"

#┏┳━┓
#┣╋━┫
#┃┃ ┃
#┗┻━┛
echo "Heavy Boxes:"
echo "${TERM_BOX_H_TL}${TERM_BOX_H_TC}${TERM_BOX_H_LH}${TERM_BOX_H_TR}"
echo "${TERM_BOX_H_ML}${TERM_BOX_H_MC}${TERM_BOX_H_LH}${TERM_BOX_H_MR}"
echo "${TERM_BOX_H_LV}${TERM_BOX_H_LV} ${TERM_BOX_H_LV}"
echo "${TERM_BOX_H_BL}${TERM_BOX_H_BC}${TERM_BOX_H_LH}${TERM_BOX_H_BR}"

#╔╦═╗
#╠╬═╣
#║║ ║
#╚╩═╝
echo "Double Boxes:"
echo "${TERM_BOX_D_TL}${TERM_BOX_D_TC}${TERM_BOX_D_LH}${TERM_BOX_D_TR}"
echo "${TERM_BOX_D_ML}${TERM_BOX_D_MC}${TERM_BOX_D_LH}${TERM_BOX_D_MR}"
echo "${TERM_BOX_D_LV}${TERM_BOX_D_LV} ${TERM_BOX_D_LV}"
echo "${TERM_BOX_D_BL}${TERM_BOX_D_BC}${TERM_BOX_D_LH}${TERM_BOX_D_BR}"

#╭┬─╮
#├┼─┤
#││ │
#╰┴─╯
echo "Rounded Boxes:"
echo "${TERM_BOX_R_TL}${TERM_BOX_R_TC}${TERM_BOX_R_LH}${TERM_BOX_R_TR}"
echo "${TERM_BOX_R_ML}${TERM_BOX_R_MC}${TERM_BOX_R_LH}${TERM_BOX_R_MR}"
echo "${TERM_BOX_R_LV}${TERM_BOX_R_LV} ${TERM_BOX_R_LV}"
echo "${TERM_BOX_R_BL}${TERM_BOX_R_BC}${TERM_BOX_R_LH}${TERM_BOX_R_BR}"
