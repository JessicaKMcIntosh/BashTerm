#!/usr/bin/env bash
# shellcheck source=../log.sh
# shellcheck source=../menu.sh

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# An example of using the log library.

# The logging internals are abused in a few places.

# This requires bash version 4.
if ((BASH_VERSINFO[0] < 4)); then
    echo "This script requires Bash 4 or later."
    echo "Current version: ${BASH_VERSION}"
    exit 1
fi

# Load the libraries.
declare -a library_list=("log.sh" "menu.sh")
find_library() {
    local library="${1}"
    local file_name
    for file_name in {../,./}${library}; do
        if [[ -f ${file_name} ]]; then
            echo "${file_name}"
            exit
        fi
    done
    echo "Unable to locate the library '${library}'." >&2
    exit 1
}
#TERM_VERBOSE=0 # Uncomment for verbose library loading.
declare _TERM_LOAD_LIBRARY
# shellcheck disable=SC2167 # Go home Shellcheck, you are drunk.
for _TERM_LOAD_LIBRARY in "${library_list[@]}"; do
    source "$(find_library "${_TERM_LOAD_LIBRARY}")" || exit 1
done
unset _TERM_LOAD_LIBRARY

# Logging example menu.
declare -a LOG_MENU
LOG_MENU=(
    "d|100|Debug log message."
    "i|101|Inform log message."
    "w|102|Warning log message."
    "e|103|Error log message."
    ""
    "l|110|Advance to the next log level."
    "f|111|Change the log file name."
    "t|112|Change the date format."
    ""
    "q|0|Exit"
    # Common keys to exit the menu.
    "0|0|~"
    "x|0|~"
    # Replaced with the logging settings later.
    ""
    ""
    ""
)

# Array of log date formats.
declare DATE_FORMAT_CURRENT="0"
declare -a DATE_FORMAT_LIST
DATE_FORMAT_LIST=(
    "%c"
    "${_TERM_LOG_DATE_FORMAT}"
)

# Array of log file examples.
declare FILE_CURRENT
declare -a FILE_LIST
FILE_LIST=(
    "${0}"
    ""
    "B-9"
    "R2-D2"
    "C-3PO"
    "WALL-E"
    "Eve"
)

# Array of messages.
declare MESSAGE_CURRENT
declare -a MESSAGE_LIST
MESSAGE_LIST=(
    "This is a test."
    "Help, I'm trapped in a menu factory."
    "Biddy-biddy-biddy!"
    "Warning! Warning! Danger Will Robinson!"
    "sudo root"
    "Hack the Gibson."
)

# Select the next date format.
next_date_format() {
    DATE_FORMAT_CURRENT=$(((DATE_FORMAT_CURRENT + 1) % ${#DATE_FORMAT_LIST[@]}))
    _TERM_LOG_DATE_FORMAT="${DATE_FORMAT_LIST[DATE_FORMAT_CURRENT]}"
}

# Select the next file.
next_file() {
    FILE_CURRENT=$(((FILE_CURRENT + 1) % ${#FILE_LIST[@]}))
    if [[ -z ${FILE_LIST[FILE_CURRENT]} ]]; then
        term::log_file "-"
    else
        term::log_file "${FILE_LIST[FILE_CURRENT]}"
    fi
}

# Select the next log level.
next_log_level() {
    local log_level

    log_level="$(term::log_level)"
    log_level=$(((log_level + 1) % ${#_TERM_LOG_LEVELS[@]}))
    term::log_level "${log_level}"
}

# Select the next message.
next_message() {
    MESSAGE_CURRENT=$(((MESSAGE_CURRENT + 1) % ${#MESSAGE_LIST[@]}))
}

# Wait for a key press.
wait_key() {
    read -rsn1 -p "Press any key to continue..."
}
# A rather contrived example. :shrug:
log_menu() {
    local rc
    local options="clear"

    while true; do
        # Present the menu.
        LOG_MENU[-3]="~||Log Level: ${TERM_UNDERLINE}${_TERM_LOG_LEVELS[_TERM_LOG_LEVEL]}${TERM_RESET}"
        LOG_MENU[-2]="~||Log File: ${TERM_UNDERLINE}${FILE_LIST[FILE_CURRENT]}${TERM_RESET}"
        LOG_MENU[-1]="~||Date Format: ${TERM_UNDERLINE}${DATE_FORMAT_LIST[DATE_FORMAT_CURRENT]}${TERM_RESET}"
        term::menu "Logging" "${options}" "${LOG_MENU[@]}"
        rc="${?}"

        # Process the result.
        case "${rc}" in
            100)
                next_message
                term::log "Debug" "${MESSAGE_LIST[MESSAGE_CURRENT]}"
                wait_key
                ;;
            101)
                next_message
                term::log "Info" "${MESSAGE_LIST[MESSAGE_CURRENT]}"
                wait_key
                ;;
            102)
                next_message
                term::log "Warn" "${MESSAGE_LIST[MESSAGE_CURRENT]}"
                wait_key
                ;;
            103)
                next_message
                term::log "Error" "${MESSAGE_LIST[MESSAGE_CURRENT]}"
                wait_key
                ;;
            110) next_log_level ;;
            111) next_file ;;
            112) next_date_format ;;
            0) exit ;;
        esac
    done
}

log_menu
