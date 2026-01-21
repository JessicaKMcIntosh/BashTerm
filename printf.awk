#!/usr/bin/env -S awk -f

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Printf implementation that is aware of the BashTerm shortcut environment variables.

# There is some debug code to make development easier.
# Alter the function error to change the output.
# Currently state information is printed to STDERR.

# ----~~~~++++====#### Setup ####====++++~~~~----

BEGIN {
    # Global variables.
    format_length = 0   # The length of the format string.
    format_position = 0 # The position in the format string.
    format_string = ""  # The format string.

    # Setup the translation from color to environment variable.
    delete color_lookup
    color_lookup["black"] = "FG_BLACK"
    color_lookup["red"] = "FG_RED"
    color_lookup["green"] = "FG_GREEN"
    color_lookup["yellow"] = "FG_YELLOW"
    color_lookup["blue"] = "FG_BLUE"
    color_lookup["magenta"] = "FG_MAGENTA"
    color_lookup["cyan"] = "FG_CYAN"
    color_lookup["white"] = "FG_WHITE"
    color_lookup["brightblack"] = "FG_BRIGHTBLACK"
    color_lookup["brightred"] = "FG_BRIGHTRED"
    color_lookup["brightgreen"] = "FG_BRIGHTGREEN"
    color_lookup["brightyellow"] = "FG_BRIGHTYELLOW"
    color_lookup["brightblue"] = "FG_BRIGHTBLUE"
    color_lookup["brightmagenta"] = "FG_BRIGHTMAGENTA"
    color_lookup["brightcyan"] = "FG_BRIGHTCYAN"
    color_lookup["brightwhite"] = "FG_BRIGHTWHITE"
    color_lookup["BLACK"] = "BG_BLACK"
    color_lookup["RED"] = "BG_RED"
    color_lookup["GREEN"] = "BG_GREEN"
    color_lookup["YELLOW"] = "BG_YELLOW"
    color_lookup["BLUE"] = "BG_BLUE"
    color_lookup["MAGENTA"] = "BG_MAGENTA"
    color_lookup["CYAN"] = "BG_CYAN"
    color_lookup["WHITE"] = "BG_WHITE"
    color_lookup["BRIGHTBLACK"] = "BG_BRIGHTBLACK"
    color_lookup["BRIGHTRED"] = "BG_BRIGHTRED"
    color_lookup["BRIGHTGREEN"] = "BG_BRIGHTGREEN"
    color_lookup["BRIGHTYELLOW"] = "BG_BRIGHTYELLOW"
    color_lookup["BRIGHTBLUE"] = "BG_BRIGHTBLUE"
    color_lookup["BRIGHTMAGENTA"] = "BG_BRIGHTMAGENTA"
    color_lookup["BRIGHTCYAN"] = "BG_BRIGHTCYAN"
    color_lookup["BRIGHTWHITE"] = "BG_BRIGHTWHITE"

    # Setup the translation from short code to attribute.
    delete short_attributes
    short_attributes["-"] = "reset"
    short_attributes["d"] = "dim"
    short_attributes["h"] = "hide"
    short_attributes["H"] = "home"
    short_attributes["i"] = "insert"
    short_attributes["I"] = "exit_insert"
    short_attributes["l"] = "bold"
    short_attributes["L"] = "clear"
    short_attributes["o"] = "orig"
    short_attributes["s"] = "standout"
    short_attributes["S"] = "exit_standout"
    short_attributes["t"] = "italics"
    short_attributes["T"] = "exit_italics"
    short_attributes["u"] = "underline"
    short_attributes["U"] = "exit_underline"
    short_attributes["v"] = "reverse"
    short_attributes["V"] = "invisible"
    short_attributes["z"] = "normal"
    short_attributes["k"] = "black"
    short_attributes["r"] = "red"
    short_attributes["g"] = "green"
    short_attributes["y"] = "yellow"
    short_attributes["b"] = "blue"
    short_attributes["m"] = "magenta"
    short_attributes["c"] = "cyan"
    short_attributes["w"] = "white"
    short_attributes["K"] = "BLACK"
    short_attributes["R"] = "RED"
    short_attributes["G"] = "GREEN"
    short_attributes["Y"] = "YELLOW"
    short_attributes["B"] = "BLUE"
    short_attributes["M"] = "MAGENTA"
    short_attributes["C"] = "CYAN"
    short_attributes["W"] = "WHITE"

    # Process input.
    read_format_print_loop()
}

# ----~~~~++++====#### RFPL (Read, Format, Print, Loop) ####====++++~~~~----

function read_format_print_loop(    character) {
    while (getline format_string == 1) {
        format_length = length(format_string)
        for (format_position = 1; format_position <= format_length; format_position++) {
            character = substr(format_string, format_position, 1)
            if (character == "\\")
                handle_backslash()
            else if (character == "%")
                handle_percent()
            else
                printf "%s", character
        }
    }
}

# ----~~~~++++====#### Formatting Functions ####====++++~~~~----

# Process a backslash character.
function handle_backslash(    character) {
    if (format_position == format_length)
        error("handle_backslash", "Unexpected end of format string!")
    character = substr(format_string, ++format_position, 1)
    if (character == "\\") { printf "\\"   } else
    if (character == "a" ) { printf "\a"   } else
    if (character == "b" ) { printf "\b"   } else
    if (character == "e" ) { printf "\033" } else
    if (character == "E" ) { printf "\033" } else
    if (character == "f" ) { printf "\f"   } else
    if (character == "n" ) { printf "\n"   } else
    if (character == "r" ) { printf "\r"   } else
    if (character == "t" ) { printf "\t"   } else
    if (character == "v" ) { printf "\v"   } else
    if (character == "0" || character == "1") {
        format_position += 2
        if (format_position > format_length)
            error("handle_backslash-01", "Unexpected end of format string!")
        printf "%c", string_to_decimal(substr(format_string, format_position - 2, 3), 8)
    } else
    if (character == "x") {
        format_position += 2
        if (format_position > format_length)
            error("handle_backslash-x", "Unexpected end of format string!")
        printf "%c", string_to_decimal(substr(format_string, format_position - 1, 2), 16)
    }
}

# Dispatch the handler for a % format string.
# The search characters are given in octal because otherwise syntax highlighting breaks.
function handle_percent(    character) {
    if (format_position == format_length)
        error("handle_percent", "Unexpected end of format string!")
    character = substr(format_string, ++format_position, 1)
    if (character == "\050")      # ()
        handle_attribute()
    else if (character == "\133") # []
        handle_short()
    else if (character == "\173") # {}
        handle_tput()
    else if (character == "\074") # <>
        handle_box()
    else if (character != "%")
        handle_printf()
    else
        printf "%s", character
}

# Process attributes.
function handle_attribute(    attribute, attr_list) {
    attribute = get_string("\051") # ()
    split(attribute, attr_list, / *, */)
    for (attribute in attr_list)
        get_attribute(attr_list[attribute])
}

# Process box characters.
function handle_box(    attribute, box_character, attr_list, repeat, lookup) {
    attribute = get_string("\076") # <>
    split(attribute, attr_list, / *, */)
    for (attribute in attr_list) {
        box_character = attr_list[attribute]

        # Set the repeat if requested.
        if (match(box_character, /@/)) {
            repeat = substr(box_character, (RSTART + 1))
            box_character = substr(box_character, 1, (RSTART - 1))
        } else
            repeat = 0

        # Get the box character.
        if (box_character == "_")
            box_character=" "
        else {
            lookup = "TERM_BOX_" toupper(box_character)

            if (!(lookup in ENVIRON))
                error("handle_box", sprintf("Unknown box (%s).", box_character))

            box_character = ENVIRON[lookup]
        }

        # Print the box character at least once if no repeat is requested.
        do {
            printf "%s", box_character
            repeat--
        } while (repeat > 0)
    }
}

# Process short attribute codes.
# Convert to an attribute then retrieve the
# escape code from the environment variables.
function handle_short(    attribute, attr_position, lookup) {
    attribute = get_string("\135") # []
    for (attr_position = 1; attr_position <= length(attribute); attr_position++) {
        lookup = substr(attribute, attr_position, 1)
        if (!(lookup in short_attributes))
            error("handle_short", sprintf("Unknown short code (%s).", lookup))
        get_attribute(short_attributes[lookup])
    }
}

# Call tput directly for the given input.
function handle_tput(    attribute, attr_list) {
    attribute = get_string("\175") # {}
    split(attribute, attr_list, / *, */)
    for (attribute in attr_list)
        call_tput(attr_list[attribute])
}

# Handles the normal printf format statements.
function handle_printf(    new_position, format_input, rc) {
    new_position = match(substr(format_string, format_position), "[a-zA-Z]")
    if (new_position == 0)
        error("handle_printf", "Unexpected end of format string!")
    new_position = (new_position + format_position - 1)
    rc = getline format_input
    if (rc == 0)
        error("handle_printf", "Ran out of input for sprintf.")
    else if (rc == -1)
        error("handle_printf", sprintf("getline error: %s", ERRNO))
    printf substr(format_string, (format_position - 1), (new_position - format_position + 2)), format_input
    format_position = new_position
}

# ----~~~~++++====#### Utility Functions ####====++++~~~~----

# Directly call tput with the given attribute string.
# Check if the attribute has unsafe characters.
function call_tput(attribute) {
    if (attribute ~ /[^a-zA-Z0-9 ]/)
        error("call_tput", sprintf("Invalid characters being passed to tput. Input: %s", attribute))
    system("tput " attribute)
}

# Helpful debug text.
function error(caller, error_text) {
    printf "\nERROR Report\n" | "cat 1>&2"
    printf "Error: %s\n", error_text | "cat 1>&2"
    printf "Caller: %s\n", caller | "cat 1>&2"
    printf "Format String: \042%s\042\n", format_string | "cat 1>&2"
    printf "Position: %s\n", format_position | "cat 1>&2"
    printf "Format Left: \042%s\042\n", substr(format_string, format_position) | "cat 1>&2"
    printf "END Report\n\n" | "cat 1>&2"
    printf "Format Left: \042%s\042\n", substr(format_string, format_position) | "cat 1>&2"
    printf "END Report\n\n" | "cat 1>&2"
    close("cat 1>&2")
    exit(1)
}

# Get the attribute escape code from the environment variables.
# Colors are converted.
# All uppercase attributes have "exit_" prepended for friendliness.
function get_attribute(attribute,    lookup) {
    if (attribute in color_lookup)
        attribute = color_lookup[attribute]
    else if (attribute == toupper(attribute))
        attribute = "exit_" attribute

    lookup = "TERM_" toupper(attribute)
    if (!(lookup in ENVIRON))
        error("get_attribute", sprintf("Unknown attribute (%s).", attribute))

    printf "%s", ENVIRON[lookup]
}

# Get a string from the format string starting at the current position to a given character.
# The format string position is set to after the search character.
# Return the string with trailing and leading whitespace removed.
function get_string(search_character,    string, new_position) {
    new_position = index(substr(format_string, format_position), search_character)
    if (new_position == 0)
        error("get_string", "Unexpected end of format string!")
    new_position = (new_position + format_position - 1)
    string = substr(format_string, (format_position + 1), ((new_position - format_position) - 1))

    sub(/^  */, "", string)
    sub(/  *$/, "", string)
    format_position = new_position
    return string
}

# Convert a string of the given base to a decimal number.
function string_to_decimal(string, base,    position, number) {
    number = 0
    for (position = 1; position <= length(string); position++)
        number = (number * base) + (index("0123456789ABCDEF", toupper(substr(string, position, 1))) - 1)
    return number
}
