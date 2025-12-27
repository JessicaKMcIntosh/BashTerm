#!/usr/bin/env bash

# Test the boxes library.

source "./boxes.sh"

#┌┬─┐
#├┼─┤
#││ │
#└┴─┘
echo "Light Boxes:"
echo "${TERM_BOX["L_TL"]}${TERM_BOX["L_TC"]}${TERM_BOX["L_LH"]}${TERM_BOX["L_TR"]}"
echo "${TERM_BOX["L_ML"]}${TERM_BOX["L_MC"]}${TERM_BOX["L_LH"]}${TERM_BOX["L_MR"]}"
echo "${TERM_BOX["L_LV"]}${TERM_BOX["L_LV"]} ${TERM_BOX["L_LV"]}"
echo "${TERM_BOX["L_BL"]}${TERM_BOX["L_BC"]}${TERM_BOX["L_LH"]}${TERM_BOX["L_BR"]}"

#┏┳━┓
#┣╋━┫
#┃┃ ┃
#┗┻━┛
echo "Heavy Boxes:"
echo "${TERM_BOX["H_TL"]}${TERM_BOX["H_TC"]}${TERM_BOX["H_LH"]}${TERM_BOX["H_TR"]}"
echo "${TERM_BOX["H_ML"]}${TERM_BOX["H_MC"]}${TERM_BOX["H_LH"]}${TERM_BOX["H_MR"]}"
echo "${TERM_BOX["H_LV"]}${TERM_BOX["H_LV"]} ${TERM_BOX["H_LV"]}"
echo "${TERM_BOX["H_BL"]}${TERM_BOX["H_BC"]}${TERM_BOX["H_LH"]}${TERM_BOX["H_BR"]}"

#╔╦═╗
#╠╬═╣
#║║ ║
#╚╩═╝
echo "Double Boxes:"
echo "${TERM_BOX["D_TL"]}${TERM_BOX["D_TC"]}${TERM_BOX["D_LH"]}${TERM_BOX["D_TR"]}"
echo "${TERM_BOX["D_ML"]}${TERM_BOX["D_MC"]}${TERM_BOX["D_LH"]}${TERM_BOX["D_MR"]}"
echo "${TERM_BOX["D_LV"]}${TERM_BOX["D_LV"]} ${TERM_BOX["D_LV"]}"
echo "${TERM_BOX["D_BL"]}${TERM_BOX["D_BC"]}${TERM_BOX["D_LH"]}${TERM_BOX["D_BR"]}"

#╭┬─╮
#├┼─┤
#││ │
#╰┴─╯
echo "Rounded Boxes:"
echo "${TERM_BOX["R_TL"]}${TERM_BOX["R_TC"]}${TERM_BOX["R_LH"]}${TERM_BOX["R_TR"]}"
echo "${TERM_BOX["R_ML"]}${TERM_BOX["R_MC"]}${TERM_BOX["R_LH"]}${TERM_BOX["R_MR"]}"
echo "${TERM_BOX["R_LV"]}${TERM_BOX["R_LV"]} ${TERM_BOX["R_LV"]}"
echo "${TERM_BOX["R_BL"]}${TERM_BOX["R_BC"]}${TERM_BOX["R_LH"]}${TERM_BOX["R_BR"]}"
