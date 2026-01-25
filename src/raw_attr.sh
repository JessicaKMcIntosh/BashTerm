# These are the main variables for the Library.
declare -A TERM_ATTR    # Stores terminal attribute escape sequences.

# Temporary variables that are unset at the end of the script.
declare _TERM_TEMP_ATTR
declare _TERM_TEMP_CODE

# Typical terminal attributes.
declare -A _TERM_ATTRIBUTES
_TERM_ATTRIBUTES=(
    [clear_screen]="clear"          # clear screen and home cursor
    [enter_bold_mode]="bold"        # turn on bold (extra bright) mode
    [enter_dim_mode]="dim"          # turn on half-bright mode
    [enter_insert_mode]="smir"      # enter insert mode
    [enter_italics_mode]="sitm"     # Enter italic mode
    [enter_reverse_mode]="rev"      # turn on reverse video mode
    [enter_secure_mode]="invis"     # turn on blank mode (characters invisible)
    [enter_standout_mode]="smso"    # begin standout mode
    [enter_underline_mode]="smul"   # begin underline mode
    [exit_attribute_mode]="sgr0"    # turn off all attributes
    [exit_insert_mode]="rmir"       # exit insert mode
    [exit_italics_mode]="ritm"      # End italic mode
    [exit_standout_mode]="rmso"     # exit standout mode
    [exit_underline_mode]="rmul"    # exit underline mode
    [orig_pair]="op"                # Set default pair to its original value
)
for _TERM_TEMP_ATTR in "${!_TERM_ATTRIBUTES[@]}"; do
    if _TERM_TEMP_CODE="$(tput "${_TERM_ATTRIBUTES[$_TERM_TEMP_ATTR]}")" ; then
        TERM_ATTR[$_TERM_TEMP_ATTR]="${_TERM_TEMP_CODE}"
        TERM_ATTR[${_TERM_ATTRIBUTES[$_TERM_TEMP_ATTR]}]="${_TERM_TEMP_CODE}"
    else
        echo "WARNING: This terminal does not support the capability: ${_TERM_ATTRIBUTES[$_TERM_TEMP_ATTR]}"
        unset "TERM_ATTR[$_TERM_TEMP_ATTR]"
    fi
done

# Attribute aliases.
declare -A _TERM_ATTRIBUTE_ALIASES
_TERM_ATTRIBUTE_ALIASES=(
    [INSERT]="rmir"
    [ITALICS]="ritm"
    [STANDOUT]="rmso"
    [UNDERLINE]="rmul"
    [orig]="op"
    [insert]="smir"
    [invisible]="invis"
    [italics]="sitm"
    [reset]="sgr0"
    [reverse]="rev"
    [standout]="smso"
    [underline]="smul"
)
for _TERM_TEMP_ATTR in "${!_TERM_ATTRIBUTE_ALIASES[@]}"; do
    TERM_ATTR["${_TERM_TEMP_ATTR}"]="${TERM_ATTR[${_TERM_ATTRIBUTE_ALIASES[$_TERM_TEMP_ATTR]}]}"
done

# Create the shortcut variables.
declare -A _TERM_ATTRIBUTE_SHORTCUTS
_TERM_ATTRIBUTE_SHORTCUTS=(
    [EXIT_INSERT]="rmir"
    [EXIT_ITALICS]="ritm"
    [EXIT_STANDOUT]="rmso"
    [EXIT_UNDERLINE]="rmul"
    [BOLD]="bold"
    [CLEAR]="clear"
    [DIM]="dim"
    [ORIG]="op"
    [INSERT]="smir"
    [INVISIBLE]="invis"
    [ITALICS]="sitm"
    [RESET]="sgr0"
    [REVERSE]="rev"
    [STANDOUT]="smso"
    [UNDERLINE]="smul"
)
for _TERM_TEMP_ATTR in "${!_TERM_ATTRIBUTE_SHORTCUTS[@]}"; do
    declare -x "TERM_${_TERM_TEMP_ATTR}=${TERM_ATTR[${_TERM_ATTRIBUTE_SHORTCUTS[$_TERM_TEMP_ATTR]}]}"
done

# Remove the temporary variables.
unset _TERM_TEMP_ATTR
unset _TERM_TEMP_CODE
