#!/usr/bin/env awk -f

BEGIN {
    # Global variables.
    character = ""      # Current character being handled.
    format_length = 0   # The length of the format string.
    format_position = 0 # The format_position in the format string.
    input_count = 0     # The number of input records.
    input_pointer = 0   # The input record last used.
    output_string = ""  # The new string to be printed.

    # Setup the translation from color to environment variable.
    all_colors="black,red,green,yellow,blue,magenta,cyan,white,brightblack,brightred,brightgreen,brightyellow,brightblue,brightmagenta,brightcyan,brightwhite"
    delete color_lookup
    setup_color_lookup()

    # Setup the translation from short code to attribute.
    short_attrs="-,reset:d,dim:h,hide:H,home:i,insert:I,exit insert:l,bold:L,clear:o,orig:s,standout:S,exit_standout:t,italics:T,exit_italics:u,underline:U,exit_underline:v,reverse:V,invisible:z,visible:k,black:r,red:g,green:y,yellow:b,blue:m,magenta:c,cyan:w,white:K,BLACK:R,RED:G,GREEN:Y,YELLOW:B,BLUE:M,MAGENTA:C,CYAN:W,WHITE"
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

# Transform the format string into the output_string.
function my_printf() {
    for (format_position = 1; format_position <= format_length; format_position++) {
        character = substr(format_string, format_position, 1)
        if (character == "\\") {
            handle_backslash()
        } else if (character == "%") {
            handle_percent()
        }
        output_string = output_string character
    }
}

# Process a backslash character.
function handle_backslash() {
    if (format_position == format_length)
        error("handle_backslash", "End of format string!")
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
            error("handle_backslash-01", "End of format string!")
        character = sprintf("%c", string_to_dec(substr(format_string, format_position - 2, 3), 8))
    } else
    if (character == "x") {
        format_position += 2
        if (format_position > format_length)
            error("handle_backslash-x", "End of format string!")
        character = sprintf("%c", string_to_dec(substr(format_string, format_position - 1, 2), 16))
    }
}

# Dispatch the handler for a % format string.
function handle_percent() {
    if (format_position == format_length)
        error("handle_percent", "End of format string!")
    character = substr(format_string, ++format_position, 1)
    if (character == "\050") # ()
        handle_attribute()
    else if (character == "\133") # []
        handle_short()
    else if (character == "\173") # {}
        handle_tput()
    else if (character != "%")
        handle_printf()
}

# Process attributes.
# Retrieve the escape code from the environment variables.
function handle_attribute(    attribute, attr_list, new_position) {
    new_position = find_char("\051") # ()
    attribute = substr(format_string, (format_position + 1), ((new_position - format_position) - 1))
    format_position = new_position
    split(attribute, attr_list, ",")
    character = ""
    for (attribute in attr_list) {
        character = character get_attribute(attr_list[attribute])
    }
}

# Process short attribute codes.
function handle_short(    attribute, new_position) {
    new_position = find_char("\135") # []
    attribute = substr(format_string, (format_position + 1), ((new_position - format_position) - 1))
    format_position = new_position
    character = ""
    for (new_position = 1; new_position <= length(attribute); new_position++) {
        character = character get_short_attribute(substr(attribute, new_position, 1))
    }
}

# Call tput directly for the given input.
function handle_tput(    attribute, attr_list, new_position) {
    new_position = find_char("\175") # {}
    attribute = substr(format_string, (format_position + 1), ((new_position - format_position) - 1))
    format_position = new_position
    split(attribute, attr_list, ",")
    character = ""
    for (attribute in attr_list) {
        character = character call_tput(attr_list[attribute])
    }
}

# Handles the normal printf format statements.
function handle_printf(    attribute, new_position) {
    new_position = find_char("[a-zA-Z]")
    attribute = substr(format_string, (format_position - 1), (new_position - format_position + 2))
    format_position = new_position
    if (input_pointer == input_count)
        error("handle_printf", "Ran out of input records!")
    character = sprintf(attribute, input_records[++input_pointer])
}

# Search from format_position for a character matching search_pattern.
# Returns the position of the character.
function find_char(search_pattern,    found_position) {
    for (found_position = format_position; found_position <= format_length; found_position++) {
        if (substr(format_string, found_position, 1) ~ search_pattern)
            break
    }
    if (found_position > format_length)
        error("find_char", "End of format string!")
    return found_position
}

# Get the attribute escape code from the environment variables.
# Colors are converted.
# All uppercase have "exit_" prepended for friendliness.
function get_attribute(attribute) {
    if (attribute in color_lookup) {
        return ENVIRON["TERM_" color_lookup[attribute]]
    }
    if (attribute == toupper(attribute))
        attribute = "exit_" attribute
    return ENVIRON["TERM_ATTR_" toupper(attribute)]
}

# Convert a short attribute code to an escape code.
function get_short_attribute(attribute) {
    if (attribute in short_attributes) {
        return get_attribute(short_attributes[attribute])
    }
    return ""
}

# Directly call tput with the given attribute string.
function call_tput(attribute,    escape_code) {
    attribute = "tput " attribute
    attribute | getline escape_code
    close(attribute)
    return escape_code
}

# Helpful debug text.
function error(caller, error_text,  record) {
    print "ERROR!"
    print "Caller: " caller
    print "Error: " error_text
    print "New String: \042" output_string "\042"
    print "Character: \042" character "\042"
    print "Format String: \042" format_string "\042"
    print "Position: " format_position
    print "Format Left: \042" substr(format_string, format_position) "\042"
    print "Input Pointer: " input_pointer
    print "Input:"
    for (record in input_records)
        printf("    \042%s\042\n", input_records[record])
    exit(1)
}

# Convert a string of the given base to a decimal number.
function string_to_dec(string, base,    position, number) {
    number = 0
    for (position = 1; position <= length(string); position++) {
        number = (number * base) + (index("0123456789ABCDEF", toupper(substr(string, position, 1))) - 1)
    }
    return number
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
