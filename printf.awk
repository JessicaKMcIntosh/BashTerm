#!/usr/bin/env awk -f

BEGIN {
    # Global variables.
    character = ""      # Current character being handled.
    input_count = 0     # The number of input records.
    input_pointer = 0   # The input record last used.
    new_string = ""     # The new string to be printed.
    position = 0        # The position in the format string.
    string_len = 0      # The length of the format string.

    # Used to search for processing printf formats.
    all_letters = "abcdefghijklmnopqrstuvwxyz"
    all_letters = all_letters toupper(all_letters)

    # Setup the colors.
    all_colors="black,red,green,yellow,blue,magenta,cyan,white,brightblack,brightred,brightgreen,brightyellow,brightblue,brightmagenta,brightcyan,brightwhite"
    delete colors
    setup_colors()

    # Setup the sort attributes.
    short_attrs="-,reset:d,dim:h,hide:H,home:i,insert:I,exit insert:l,bold:L,clear:o,orig:s,standout:S,exit_standout:t,italics:T,exit_italics:u,underline:U,exit_underline:v,reverse:V,invisible:z,visible:k,black:r,red:g,green:y,yellow:b,blue:m,magenta:c,cyan:w,white:K,BLACK:R,RED:G,GREEN:Y,YELLOW:B,BLUE:M,MAGENTA:C,CYAN:W,WHITE"
    delete attributes
    setup_short_attributes()

    # The format string.
    format_string = ""
    getline format_string
}

# All remaining input is records for sprintf.
{
    input_records[++input_count] = $0
}

# Format the input.
END {
    my_printf()
    printf("%s", new_string)
}

function my_printf() {
    new_string = ""
    string_len = length(format_string)
    for (position = 1; position <= string_len; position++) {
        character = substr(format_string, position, 1)
        if (character == "\\") {
            handle_backslash()
        } else if (character == "%") {
            handle_percent()
        }
        new_string = new_string character
    }
}

# Process a backslash character.
function handle_backslash() {
    if (position == string_len)
        error("handle_backslash", "End of format string")
    character = substr(format_string, ++position, 1)
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
        position = position + 2
        if (position > string_len)
            error("handle_backslash-01", "End of format string")
        character = sprintf("%c", oct_to_dec(substr(format_string, position - 2, 3)))
    } else
    if (character == "x") {
        position = position + 2
        if (position > string_len)
            error("handle_backslash-x", "End of format string")
        character = sprintf("%c", hex_to_dec(substr(format_string, position - 1, 2)))
    }
}

# Dispatch the handler for a % format string.
function handle_percent() {
    if (position == string_len)
        error("handle_percent", "End of format string")
    character = substr(format_string, ++position, 1)
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
function handle_attribute(    attr, attr_list) {
    ++position
    attr = find_char_substr("\051", 0) # ()
    split(attr, attr_list, ",")
    character = ""
    for (attr in attr_list) {
        character = character get_attribute(attr_list[attr])
    }
}

# Process short codes.
function handle_short(    attr, pos) {
    ++position
    attr = find_char_substr("\135", 0) # []
    character = ""
    for (pos = 1; pos <= length(attr); pos++) {
        character = character get_short_attribute(substr(attr, pos, 1))
    }
}

# Call tput directly for the given input.
function handle_tput(    attr, attr_list) {
    ++position
    attr = find_char_substr("\175", 0) # {}
    split(attr, attr_list, ",")
    character = ""
    for (attr in attr_list) {
        character = character call_tput(attr_list[attr])
    }
}

# Handles the normal printf format statements.
function handle_printf(    attr) {
    attr = "%" find_char_substr(all_letters, 1)
    if (input_pointer == input_count)
        error("handle_printf", "Ran out of input!")
    character = sprintf(attr, input_records[++input_pointer])
}

# Return a substring from position to the given search string.
# If inclusive is 1 the ending character is included.
function find_char_substr(search_string, inclusive,    found_pos, found_string) {
    for (found_pos = position; found_pos <= string_len; found_pos++) {
        if (index(search_string, substr(format_string, found_pos, 1)))
            break
    }
    if (found_pos > string_len)
        error("find_char_substr", "End of format string!")
    found_string = substr(format_string, position, (found_pos - position) + inclusive)
    position = found_pos
    return found_string
}

# Get the attribute escape code from the environment variables.
# Colors are converted.
# All uppercase have "exit_" prepended for friendliness.
function get_attribute(attr) {
    if (attr in colors) {
        return ENVIRON["TERM_" colors[attr]]
    }
    if (attr == toupper(attr))
        attr = "exit_" attr
    return ENVIRON["TERM_ATTR_" toupper(attr)]
}

# Convert a short attribute code to an escape code.
function get_short_attribute(attr) {
    if (attr in attributes) {
        return get_attribute(attributes[attr])
    }
    return ""
}

# Directly call tput with the given attribute string.
function call_tput(attr,    escape_code) {
    attr = "tput " attr
    attr | getline escape_code
    close(attr)
    return escape_code
}

# Helpful debug text.
function error(caller, error_text,  record) {
    print "ERROR!"
    print "Caller: " caller
    print "Error: " error_text
    print "New String: \042" new_string "\042"
    print "Character: \042" character "\042"
    print "Format String: \042" format_string "\042"
    print "Position: " position
    print "Format Left: \042" substr(format_string, position) "\042"
    print "Input Pointer: " input_pointer
    print "Input:"
    for (record in input_records)
        printf("    \042%s\042\n", input_records[record])
    exit(1)
}

# Convert a hexadecimal string to decimal.
function hex_to_dec(string,    pos, number) {
    number = 0
    for (pos = 1; pos <= length(string); pos++) {
        number = (number * 16) + (index("0123456789ABCDEF", toupper(substr(string, pos, 1))) - 1)
    }
    return number
}

# Convert an octal string to decimal.
function oct_to_dec(string,    pos, number) {
    number = 0
    for (pos = 1; pos <= length(string); pos++) {
        number = (number * 8) + (index("01234567", toupper(substr(string, pos, 1))) - 1)
    }
    return number
}

# Build the color array to get the right environment variable.
function setup_colors(    color_list, color) {
    split(all_colors, color_list, ",")
    for (color in color_list) {
        colors[color_list[color]] = sprintf("FG_%s", toupper(color_list[color]))
        colors[toupper(color_list[color])] = sprintf("BG_%s", toupper(color_list[color]))
    }
}

# Build an array to translate short attributes to the environment variable.
function setup_short_attributes(    attr, attr_list, sub_list) {
    split(short_attrs, attr_list, ":")
    for (attr in attr_list) {
        split(attr_list[attr], sub_list, ",")
        attributes[sub_list[1]] = sub_list[2]
    }
}
