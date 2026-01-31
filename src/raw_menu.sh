# Default settings.
declare _TERM_MENU_SEPARATOR=":"
declare _TERM_MENU_PROMPT="Select the option [~]: "

term::menu() {
    if (($# < 3)); then
        echo "MENU ERROR: Insufficient parameters passed!" >&2
        exit 252
    fi
    local title="${1}"
    local options="${2}"
    shift 2
    local menu_items=("$@")

    # Internal variables.
    local item              # Current array element or option being processed.
    local key               # The pressed key, also used for building the menu.
    local rc                # Return code.
    local text              # Text for the menu or an error message.
    local valid_keys=""     # The list of valid keys.
    local -a menu_list      # The rendered menu list to print.
    local -A key_list       # Translate key to return code.
    local -A option_list    # The various options set for the menu.

    # Setup the options.
    option_list[sep]="${_TERM_MENU_SEPARATOR}"
    option_list[prompt]="${_TERM_MENU_PROMPT}"
    option_list[attr]="" # Attributes for the key character in the menu.
    while IFS="" read -r item; do
        [[ -z ${item} ]] && continue
        case "${item}" in
            sep*)       option_list[sep]="${item:3}" ;;
            prompt*)    option_list[prompt]="${item:6}" ;;
            bold)       option_list[attr]+="${TERM_BOLD}" ;;
            reverse)    option_list[attr]+="${TERM_REVERSE}" ;;
            underline)  option_list[attr]+="${TERM_UNDERLINE}" ;;
            *)          option_list[${item}]="${item}" ;;
        esac
    done <<< "${options//|/$'\n'}"

    # Build the menu.
    for item in "${!menu_items[@]}"; do
        # Empty string is a special case.
        if [[ -z ${menu_items[$item]} ]]; then
            menu_list+=("")
            continue
        fi

        # Check for parameters to the menu item.
        IFS="|" read -r key rc text <<< "${menu_items[$item]}"
        if [[ -z ${rc} && -z ${text} ]]; then
            # No parameters so use the defaults.
            key="$((item + 1))"
            rc="$((item + 1))"
            text="${menu_items[$item]}"
        else
            # Check for empty parameters.
            if [[ -z ${rc} ]]; then
                rc="$((item + 1))"
            fi
            if [[ -z ${key} ]]; then
                key="$((item + 1))"
            fi
        fi

        # Check that the return code is a number in range.
        if [[ ${rc} != "~" && (${rc} -gt "250" || "$((rc + 0))" != "${rc}") ]]; then
            echo "MENU ERROR: Return code (${rc}) invalid! Must be a number 250 or less." >&2
            echo "Menu item: ${menu_items[$item]}"
            return 254
        fi

        # Check that the key is one character.
        if [[ ${#key} -gt "1" ]]; then
            echo "MENU ERROR: Key (${key}) is not a single character." >&2
            echo "Menu item: ${menu_items[$item]}"
            return 253
        fi

        # Save the menu item.
        if [[ ${key} == "~" ]]; then
            if [[ ${text} != "~" ]]; then
                # No key, just the text.
                menu_list+=("${text}")
            fi
        else
            if [[ ${rc} != "~" ]]; then
                # Save the key and return code.
                key_list[$key]=$rc
            fi
            if [[ ${text} != "~" ]]; then
                # There is text to print so save the menu item.
                valid_keys+="${key}"
                if [[ -v option_list[attr] ]]; then
                    key="${option_list[attr]}${key}${TERM_RESET}"
                fi
                menu_list+=("${key}${option_list[sep]} ${text}")
            fi
        fi
    done

    # Debug data.
    if [[ -v option_list[debug] ]]; then
        echo -n "DEBUG (Options): " >&2
        declare -p option_list >&2
        echo -n "DEBUG (Menu List): " >&2
        declare -p menu_list >&2
        echo -n "DEBUG (Key RC List): " >&2
        declare -p key_list >&2
        read -rsn1 -p "Press any key to continue..." >&2
    fi

    # Menu loop.
    text=""
    while true; do
        # Print the menu.
        if [[ -v option_list[clear] ]]; then
            echo -n "${TERM_CLEAR}"
        fi
        echo "${title}"
        for item in "${menu_list[@]}"; do
            echo "$item"
        done

        # Print the error text if present and quiet is not set.
        if [[ -n ${text} && ! (-v option_list[quiet]) ]]; then
            echo "ERROR: ${text}"
        fi

        # Handle user input.
        read -r -n 1 -p "${option_list[prompt]/\~/${valid_keys}}"
        echo ""
        if [[ -v key_list[${REPLY}] ]]; then
            return "${key_list["${REPLY}"]}"
        else
            if [[ -n ${REPLY} ]]; then
                echo ""
                text="Invalid option ($REPLY)."
            else
                text="Please select a key."
            fi
            if [[ -v option_list[one] ]]; then
                if [[ ! (-v option_list[quiet]) ]]; then
                    echo "${text}"
                fi
                return 251
            fi
        fi
    done
}
