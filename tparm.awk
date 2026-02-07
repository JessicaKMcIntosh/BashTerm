#!/usr/bin/env -S gawk -f

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Print a terminfo string.
# Handle the parameters in the string.

# For more information see:
# man 5 terminfo # Describes the capability database.
# man 3 terminfo # Describes the API.
# man 1 infocmp  # How the capabilities are retrieved.
# https://invisible-island.net/ncurses/man/terminfo.5.html
# https://github.com/ThomasDickey/ncurses-snapshots/tree/master

# Documentation from this section was copied where relevant.
# https://invisible-island.net/ncurses/man/terminfo.5.html#h3-Parameterized-Strings

# WARNING: This file requires GAWK since it uses bitwise operations.
# Or some other AWK implementation that supports and(), compl(), or(), and xor().

BEGIN {
    # Stack and variables for processing the capability value.
    delete stack
    stack_pointer=0
    delete vars
    if (var_file)
        load_variables()

    # Check that there are enough arguments.
    if (ARGC < 2) {
        error("Provide the capability string and parameter(s).")
    }

    # Process the format string.
    format_string = ARGV[1]
    format_length = length(format_string)
    format_position = 0
    output_string = ""
    character = ""
    while (next_character(0)) {
        if (character == "%") {
            handle_percent()
        } else {
            output_string = output_string character
        }
    }
    printf "%s", output_string

    # Save the variables back to the file.
    if (var_file)
        save_variables()
    exit
}

# Get the next character from the format string.
# Set the variable 'character' and return the character.
# If fatal is true die if at the end of the format string.
function next_character(fatal) {
    if (format_position >= format_length) {
        if (fatal) {
            error("Unexpected end of format string.")
        } else {
            return ""
        }
    }
    return (character = substr(format_string, ++format_position, 1))
}

# Figure out what to do with a '%' in the format string.
function handle_percent() {
    next_character(1)
    if (character == "%") {
        #  %% - outputs “%”
        output_string = output_string "%"
    } else if (character == "c") {
        # %c - print pop() like %c in printf
        output_string = output_string sprintf("%c", pop())
    } else if (character == "s") {
        # %s - print pop() like %s in printf
        output_string = output_string sprintf("%s", pop())
    } else if (character == "p") {
        # %p[1-9] - push i'th parameter
        if (next_character(1) ~ /[1-9]/) {
            if ((character + 1) >= ARGC)
                error("Insufficient parameters.")
            push(ARGV[character + 1])
        }
    } else if (character == "P") {
        # %P[a-z] - set dynamic variable [a-z] to pop()
        # %P[A-Z] - set static variable [a-z] to pop()
        if (next_character(1) ~ /[a-zA-Z]/) {
            set(character, pop())
        }
    } else if (character == "g") {
        # %g[a-z] - get dynamic variable [a-z] and push it
        # %g[A-Z] - get static variable [a-z] and push it
        if (next_character(1) ~ /[a-zA-Z]/) {
            push(get(character))
        }
    } else if (character == "\047") { # single quote
        # %"c" - char constant c
        handle_character_constant()
    } else if (character == "\173") {
        # %{nn} - integer constant nn
        handle_integer_constant()
    } else if (character == "l") {
        # %l - push strlen(pop)
        push(length(pop()))
    } else if (character == "!") {
        # %! - unary operations (logical complement): push(op pop())
        push((pop() == 0 ? 1 : 0))
    } else if (character == "~") {
        # %~ - unary operations (bit complement): push(op pop())
        push(compl(pop()))
    } else if (character == "i") {
        # %i - add 1 to first two parameters (for ANSI terminals)
        # Also push the values. Some capabilities assume this.
        push(++ARGV[2])
        push(++ARGV[3])
    } else if (character ~ /[AO+*\/m&|^=<>-]/) {
        handle_math_and_logic()
    } else if (character ~ /[?te;]/) {
        handle_if_then_else()
    } else if (match(substr(format_string, format_position)i, /^(:-)?[+#]?[0-9]*(\.[0-9]*)?[doxX]/)) {
        # %[[:]flags][width[.precision]][doxXs]
        # as in printf(3), flags are [-+#] and space.
        # Use a “:” to allow the next character to be a “-” flag,
        # avoiding interpreting “%-” as an operator.

        # match() is used here to the function can make use of RLENGTH.
        handle_sprintf()
    }
}

# Convert the character to a numer then push it to the stack.
function handle_character_constant(    value) {
    value = index(  " !\"#$%&'()*+,-./0123456789:;<=>?@" \
                    "ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`" \
                    "abcdefghijklmnopqrstuvwxyz{|}~ ",
                    next_character(1))
    if (next_character(1) != "\047")
        error("Expecting closing single quote.")
    push(value + 31)
}

function handle_integer_constant(    number) {
    number = ""
    while (1) {
        if ((next_character(1)) == "\175")
            break
        number = number character
    }
    push(number)
}

function handle_if_then_else(    level) {
    # %? expr %t thenpart %e elsepart %;
    # This  forms  an if-then-else.
    # The %e elsepart is optional.
    # Usually the %? expr part pushes a value onto the stack,
    # and %t pops it from the stack, testing if it is nonzero (true).
    # If it is zero (false), control
    # passes to the %e (else) part.

    # This is mostly copied from:
    # https://github.com/ThomasDickey/ncurses-snapshots/blob/master/ncurses/tinfo/lib_tparm.c

    # Even the ncurses source just skips over these. :shrug:
    if (character == "?" || character == ";") {
        return
    }

    # Then part.
    if (character == "t") {
        if (pop() == 0) {
            # Search for a matching %e or %;.
            level = 0
            while (next_character(1)) {
                if (character == "%") {
                    next_character(1)
                    if (character == "?")
                        level++
                    else if (character == ";") {
                        if (level > 0)
                            level --
                        else
                            return
                    } else if (character == "e" && level == 0) {
                        return
                    }
                }
            }
        }
        return
    }

    # Else part.
    if (character == "e") {
        # Search for a matching %e or %;.
        level = 0
        while (next_character(1)) {
            if (character == "%") {
                next_character(1)
                if (character == "?")
                    level++
                else if (character == ";") {
                    if (level > 0)
                        level --
                    else
                        return
                }
            }
        }
        return
    }
}

function handle_math_and_logic(    a, b) {
    a = pop()
    b = pop()

    # Binary operations are in postfix form with the operands in the usual order.
    # That is, to get x-5 one would use “%gx%{5}%-”.
    if (character == "A") {
        # %A - logical “and” operations (for conditionals)
        push(((b != 0) && (a != 0) ? 1 : 0))
    } else if (character == "O") {
        # %O - logical “or” operations (for conditionals)
        push(((b != 0) || (a != 0) ? 1 : 0))
    } else if (character == "+") {
         # %+ - arithmetic: push(pop() op pop())
         push(b + a)
    } else if (character == "-") {
         # %- - arithmetic: push(pop() op pop())
         push(b - a)
    } else if (character == "*") {
         #%* - arithmetic: push(pop() op pop())
         push(b * a)
    } else if (character == "/") {
         # %/ - arithmetic: push(pop() op pop())
         push((a == 0 ? 0 : int(b / a)))
    } else if (character == "m") {
         # %m - arithmetic (%m is mod): push(pop() op pop())
         push(b % a)
    } else if (character == "&") {
        # %& - bit operations (“and”): push(pop() op pop())
         push(and(b, a))
    } else if (character == "|") {
        # %| - bit operations (“or”): push(pop() op pop())
         push(or(b, a))
    } else if (character == "^") {
        # %^ - bit operations (exclusive “or”): push(pop() op pop())
         push(xor(b, a))
    } else if (character == "=") {
        # %= - logical operations: push(pop() op pop())
         push((b == a ? 1 : 0))
    } else if (character == ">") {
        # %> - logical operations: push(pop() op pop())
         push((b > a ? 1 : 0))
    } else if (character == "<") {
        # %< - logical operations: push(pop() op pop())
         push((b < a ? 1 : 0))
    }
}

# Take care of a real format string.
# Expectes RLENGTH to hold the length of the format string.
function handle_sprintf(string) {
    # as in printf(3), flags are [-+#] and space.
    # Use a ":" to allow the next character to be a "-" flag,
    # avoiding interpreting "%-" as an operator.
    string = substr(format_string, (format_position - 1), (RLENGTH + 1))
    sub(/^%:/, "%", string)
    format_position += RLENGTH - 1
    output_string = output_string sprintf(string, pop())
}

# Print an error to STDERR then exit.
function error(string) {
    printf "ERROR: %s\n", string | "cat 1>&2"
    close("cat 1>&2")
    exit 1
}

# This is for debugging. Otherwise leave commented out.
# function trace(caller,    stack_item, stack_print) {
#     stack_print = ""
#     for (stack_item = 1; stack_item <= stack_pointer; stack_item++) {
#         stack_print = stack_print " \047" stack[stack_item] "\047"
#     }
#     printf  "{%s} %-10s [%03d] %s (%s) %s : %-10s {%d%s}\n",
#             character,
#             caller,
#             format_position,
#             substr(format_string, 1, format_position - 1),
#             substr(format_string, format_position, 1),
#             substr(format_string, format_position + 1),
#             output_string,
#             stack_pointer,
#             stack_print | "cat 1>&2"
# }

# Work with variables.
function get(variable) {
    if (!(variable in vars)) {
        vars[variable] = 0
    }
    return vars[variable]
}
function set(variable, value) {
    return (vars[variable] = value)
}
function load_variables(    input) {
    while (getline input < var_file) {
        vars[substr(input, 1, 1)] = substr(input, 2)
    }
    close(var_file)
}
function save_variables(    variable) {
    printf "" > var_file
    for (variable in vars) {
        printf("%s%s\n", variable, vars[variable]) > var_file
    }
    fflush(var_file)
    close(var_file)
}

# Work with the stack.
function push(value) {
    stack[++stack_pointer] = value
}
function pop() {
    if (stack_pointer == 0)
        error("Stack underflow")
    return stack[stack_pointer--]
}
