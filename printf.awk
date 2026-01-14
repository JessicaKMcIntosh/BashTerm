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
    character = ""      # Current character being handled.
    format_length = 0   # The length of the format string.
    format_position = 0 # The position in the format string.
    input_count = 0     # The number of input records.
    input_pointer = 0   # The input record last used.
    output_string = ""  # The new string to be printed.
    delete input_records# For sprintf.

    # Setup the translation from color to environment variable.
    all_colors="black,red,green,yellow,blue,magenta,cyan,white,brightblack,brightred,brightgreen,brightyellow,brightblue,brightmagenta,brightcyan,brightwhite"
    delete color_lookup
    setup_color_lookup()

    # Setup the translation from short code to attribute.
    short_attrs="-,reset:d,dim:h,hide:H,home:i,insert:I,exit_insert:l,bold:L,clear:o,orig:s,standout:S,exit_standout:t,italics:T,exit_italics:u,underline:U,exit_underline:v,reverse:V,invisible:z,normal:k,black:r,red:g,green:y,yellow:b,blue:m,magenta:c,cyan:w,white:K,BLACK:R,RED:G,GREEN:Y,YELLOW:B,BLUE:M,MAGENTA:C,CYAN:W,WHITE"
    delete short_attributes
    setup_short_attributes()

    # The format string.
    format_string = ""
    getline format_string
    format_length = length(format_string)
}

# All remaining input is for sprintf.
{
    input_records[++input_count] = $0
}

# Format the input.
END {
    my_printf()
    printf("%s", output_string)
}

# ----~~~~++++====#### Printf Function ####====++++~~~~----

# Transform the format string into the output_string.
function my_printf() {
    for (format_position = 1; format_position <= format_length; format_position++) {
        character = substr(format_string, format_position, 1)
        if (character == "\\")
            handle_backslash()
        else if (character == "%")
            handle_percent()
        output_string = output_string character
    }
}

# ----~~~~++++====#### Formatting Functions ####====++++~~~~----

# Process a backslash character.
function handle_backslash() {
    if (format_position == format_length)
        error("handle_backslash", "Unexpected end of format string!")
    character = substr(format_string, ++format_position, 1)
    if (character == "\\") { character = "\\"   } else
    if (character == "a" ) { character = "\a"   } else
    if (character == "b" ) { character = "\b"   } else
    if (character == "e" ) { character = "\033" } else
    if (character == "E" ) { character = "\033" } else
    if (character == "f" ) { character = "\f"   } else
    if (character == "n" ) { character = "\n"   } else
    if (character == "r" ) { character = "\r"   } else
    if (character == "t" ) { character = "\t"   } else
    if (character == "v" ) { character = "\v"   } else
    if (character == "0" || character == "1") {
        format_position += 2
        if (format_position > format_length)
            error("handle_backslash-01", "Unexpected end of format string!")
        character = sprintf("%c", string_to_decimal(substr(format_string, format_position - 2, 3), 8))
    } else
    if (character == "x") {
        format_position += 2
        if (format_position > format_length)
            error("handle_backslash-x", "Unexpected end of format string!")
        character = sprintf("%c", string_to_decimal(substr(format_string, format_position - 1, 2), 16))
    }
}

# Dispatch the handler for a % format string.
# The search characters are given in octal because otherwise syntax highlighting breaks.
function handle_percent() {
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
    # If it is % fall through so it is added to the output string.
}

# Process attributes.
# Retrieve the escape code from the environment variables.
function handle_attribute(    attribute, attr_list, new_character) {
    attribute = get_string("\051", "handle_attribute") # ()
    split(attribute, attr_list, / *, */)
    new_character = "" # Preserve the global character for error messages.
    for (attribute in attr_list)
        new_character = new_character get_attribute(attr_list[attribute], "handle_attribute")
    character = new_character
}

# Process box characters.
# Retrieve the escape code from the environment variables.
function handle_box(    attribute, attr_list, new_character) {
    attribute = get_string("\076", "handle_box") # <>
    split(attribute, attr_list, / *, */)
    new_character = "" # Preserve the global character for error messages.
    for (attribute in attr_list) {
        if (attr_list[attribute] == "_")
            new_character = new_character " "
        else
            new_character = new_character get_box(attr_list[attribute])
    }
    character = new_character
}

# Process short attribute codes.
# Convert to an attribute then retrieve the
# escape code from the environment variables.
function handle_short(    attribute, attr_position, new_character, lookup) {
    attribute = get_string("\135", "handle_short") # []
    new_character = "" # Preserve the global character for error messages.
    for (attr_position = 1; attr_position <= length(attribute); attr_position++) {
        lookup = substr(attribute, attr_position, 1)
        if (!(lookup in short_attributes))
            error("handle_short", sprintf("Unknown short code '%s'.", lookup))
        new_character = new_character get_attribute(short_attributes[lookup], "handle_short")
    }
    character = new_character
}

# Call tput directly for the given input.
function handle_tput(    attribute, attr_list, new_character) {
    attribute = get_string("\175", "handle_tput") # {}
    split(attribute, attr_list, / *, */)
    new_character = "" # Preserve the global character for error messages.
    for (attribute in attr_list)
        new_character = new_character call_tput(attr_list[attribute])
    character = new_character
}

# Handles the normal printf format statements.
function handle_printf(    attribute, new_position) {
    new_position = find_pattern("[a-zA-Z]", "handle_printf")
    attribute = substr(format_string, (format_position - 1), (new_position - format_position + 2))
    format_position = new_position
    if (input_pointer == input_count)
        error("handle_printf", "Ran out of input records!")
    character = sprintf(attribute, input_records[++input_pointer])
}

# ----~~~~++++====#### Utility Functions ####====++++~~~~----

# Directly call tput with the given attribute string.
# Check if the attribute has unsafe characters.
function call_tput(attribute, caller,    escape_code) {
    if (attribute ~ /[^a-zA-Z0-9 ]/)
        error(caller " => call_tput", sprintf("Invalid characters being passed to tput. Input: %s", attribute))
    attribute = "tput " attribute
    attribute | getline escape_code
    close(attribute)
    return escape_code
}

# Helpful debug text.
function error(caller, error_text,    record) {
    printf("\nERROR Report\n") | "cat 1>&2"
    printf("Error: %s\n", error_text) | "cat 1>&2"
    printf("Caller: %s\n", caller) | "cat 1>&2"
    printf("New String: \042%s%s\042\n", output_string, call_tput("op")) | "cat 1>&2"
    printf("Character: \042%s\042\n", character) | "cat 1>&2"
    printf("Format String: \042%s\042\n", format_string) | "cat 1>&2"
    printf("Position: %s\n", format_position) | "cat 1>&2"
    printf("Format Left: \042%s\042\n", substr(format_string, format_position)) | "cat 1>&2"
    printf("Input Pointer: %s\n", input_pointer) | "cat 1>&2"
    printf("Input:\n") | "cat 1>&2"
    for (record in input_records)
        printf("    \042%s\042\n", input_records[record]) | "cat 1>&2"
    printf("END Report\n\n") | "cat 1>&2"
    close("cat 1>&2")
    exit(1)
}

# Search from format_position for a character matching search_character.
# Returns the position of the character.
function find_character(search_character, caller,    found_position) {
    for (found_position = format_position; found_position <= format_length; found_position++) {
        if (substr(format_string, found_position, 1) == search_character)
            break
    }
    if (found_position > format_length)
        error(caller " => find_character", "Unexpected end of format string!")
    return found_position
}

# Search from format_position for a character matching search_pattern.
# Returns the position of the character.
function find_pattern(search_pattern, caller,    found_position) {
    for (found_position = format_position; found_position <= format_length; found_position++) {
        if (substr(format_string, found_position, 1) ~ search_pattern)
            break
    }

    if (found_position > format_length)
        error(caller " => find_pattern", "Unexpected end of format string!")

    return found_position
}

# Get the attribute escape code from the environment variables.
# Colors are converted.
# All uppercase attributes have "exit_" prepended for friendliness.
function get_attribute(attribute, caller,    lookup) {
    if (attribute in color_lookup)
        attribute = color_lookup[attribute]
    else if (attribute == toupper(attribute))
        attribute = "exit_" attribute

    lookup = "TERM_" toupper(attribute)
    if (!(lookup in ENVIRON))
        error(caller " => get_attribute", sprintf("Unknown attribute '%s'.", attribute))

    return ENVIRON[lookup]
}

# Get the box character from the environment variables.
function get_box(box,    lookup) {
    lookup = "TERM_BOX_" toupper(box)

    if (!(lookup in ENVIRON))
        error("get_box", sprintf("Unknown box '%s'.", box))

    return ENVIRON[lookup]
}

# Get a string from the format string starting at the current position to a given character.
# The format string position is set to after the search character.
# Return the string with trailing and leading whitespace removed.
function get_string(search_character, caller,    string, new_position) {
    new_position = find_character(search_character, caller " => get_string") # ()
    string = substr(format_string, (format_position + 1), ((new_position - format_position) - 1))
    sub(/^  */, "", string)
    sub(/  *$/, "", string)
    format_position = new_position
    return string
}

# Build the color array to get the right environment variable.
function setup_color_lookup(    color_list, color) {
    split(all_colors, color_list, ",")
    for (color in color_list) {
        color_lookup[color_list[color]] = sprintf("FG_%s", toupper(color_list[color]))
        color_lookup[toupper(color_list[color])] = sprintf("BG_%s", toupper(color_list[color]))
    }
}

# Build an array to translate short attributes to the environment variable.
function setup_short_attributes(    attribute, attr_list, sub_list) {
    split(short_attrs, attr_list, ":")
    for (attribute in attr_list) {
        split(attr_list[attribute], sub_list, ",")
        short_attributes[sub_list[1]] = sub_list[2]
    }
}

# Convert a string of the given base to a decimal number.
function string_to_decimal(string, base,    position, number) {
    number = 0
    for (position = 1; position <= length(string); position++)
        number = (number * base) + (index("0123456789ABCDEF", toupper(substr(string, position, 1))) - 1)
    return number
}
