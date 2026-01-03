#!/usr/bin/env bash
# shellcheck source=../boxes.sh

# Example of using the boxes library.

# Load the library
find_library(){
    local library="${1}"
    for file_name in {./,../}${library} ; do
        if [[ -f  "${file_name}" ]] ; then
            echo "${file_name}"
        fi
done
}
source "$(find_library "boxes.sh")"

#┌┬─┐
#├┼─┤
#││ │
#└┴─┘
echo "Light Boxes:"
echo "${TERM_BOX_LTL}${TERM_BOX_LTC}${TERM_BOX_LLH}${TERM_BOX_LTR}"
echo "${TERM_BOX_LML}${TERM_BOX_LMC}${TERM_BOX_LLH}${TERM_BOX_LMR}"
echo "${TERM_BOX_LLV}${TERM_BOX_LLV} ${TERM_BOX_LLV}"
echo "${TERM_BOX_LBL}${TERM_BOX_LBC}${TERM_BOX_LLH}${TERM_BOX_LBR}"

#┏┳━┓
#┣╋━┫
#┃┃ ┃
#┗┻━┛
echo "Heavy Boxes:"
echo "${TERM_BOX_HTL}${TERM_BOX_HTC}${TERM_BOX_HLH}${TERM_BOX_HTR}"
echo "${TERM_BOX_HML}${TERM_BOX_HMC}${TERM_BOX_HLH}${TERM_BOX_HMR}"
echo "${TERM_BOX_HLV}${TERM_BOX_HLV} ${TERM_BOX_HLV}"
echo "${TERM_BOX_HBL}${TERM_BOX_HBC}${TERM_BOX_HLH}${TERM_BOX_HBR}"

#╔╦═╗
#╠╬═╣
#║║ ║
#╚╩═╝
echo "Double Boxes:"
echo "${TERM_BOX_DTL}${TERM_BOX_DTC}${TERM_BOX_DLH}${TERM_BOX_DTR}"
echo "${TERM_BOX_DML}${TERM_BOX_DMC}${TERM_BOX_DLH}${TERM_BOX_DMR}"
echo "${TERM_BOX_DLV}${TERM_BOX_DLV} ${TERM_BOX_DLV}"
echo "${TERM_BOX_DBL}${TERM_BOX_DBC}${TERM_BOX_DLH}${TERM_BOX_DBR}"

#╭┬─╮
#├┼─┤
#││ │
#╰┴─╯
echo "Rounded Boxes:"
echo "${TERM_BOX_RTL}${TERM_BOX_RTC}${TERM_BOX_RLH}${TERM_BOX_RTR}"
echo "${TERM_BOX_RML}${TERM_BOX_RMC}${TERM_BOX_RLH}${TERM_BOX_RMR}"
echo "${TERM_BOX_RLV}${TERM_BOX_RLV} ${TERM_BOX_RLV}"
echo "${TERM_BOX_RBL}${TERM_BOX_RBC}${TERM_BOX_RLH}${TERM_BOX_RBR}"
