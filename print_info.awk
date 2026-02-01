#!/usr/bin/env -S awk -f

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Print a terminfo string.
# Handle the parameters in the string.
# See: https://invisible-island.net/ncurses/man/terminfo.5.html#h3-Parameterized-Strings

BEGIN {
    # Stack and variables for processing the capability value.
    delete stack
    stack_pointer=0
    delete vars

    # Check that there are enough arguments.
    if (ARGC < 2) {
        error("Provide the capability string and parameter(s).")
    }

    # Process the string.
    format_string = ARGV[1]
    format_length = length(format_string)
    format_position = 0
    output = ""
    character = ""
    while (next_character(0)) {
        if (character == "%") {
            output = output handle_percent()
        } else {
            output = output character
        }
    }
    printf "%s", output
    exit
}

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

function handle_percent() {
    next_character(1)
    if (character == "%") {
        #  %% - outputs “%”
        return "%"
    } else if (character == "c") {
        # %c - print pop() like %c in printf
        return sprintf("%c", pop())
    } else if (character == "s") {
        # %s - print pop() like %s in printf
        return sprintf("%s", pop())
    } else if (character == "p") {
        # %p[1-9] - push i'th parameter
        if (next_character(1) ~ /[0-9]/) {
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
        push(handle_character_constant())
    } else if (character == "\173") { # {}
        # %{nn} - integer constant nn
        push(handle_integer_constant())
    } else if (character == "l") {
        # %l - push strlen(pop)
        push(length(pop()))
    } else if (character == "A") {
        # %A - logical “and” operations (for conditionals)
        push(((pop() == 0) && (pop() == 0) ? 1 : 0))
    } else if (character == "O") {
        # %O - logical “or” operations (for conditionals)
        push(((pop() == 0) || (pop() == 0) ? 1 : 0))
    } else if (character == "!") {
        # %! - unary operations (logical complement): push(op pop())
        push((pop() == 0 ? 1 : 0))
    } else if (character == "~") {
        # %~ - unary operations (bit complement): push(op pop())
        push(compl(pop()))
    } else if (character == "i") {
        # %i - add 1 to first two parameters (for ANSI terminals)
        ARGV[2]++
        ARGV[3]++
    } else if (character ~ /[+*\/m&|^=<>-]/) {
        handle_math()
    } else if (character ~ /[?te;]/) {
        handle_if_then_else()
    } else if (substr(format_string, format_position) ~ /^(:-)?[+#]?[0-9]*(\.[0-9]*)?[doxX]/) {
        # %[[:]flags][width[.precision]][doxXs]
        # as in printf(3), flags are [-+#] and space.
        # Use a “:” to allow the next character to be a “-” flag,
        # avoiding interpreting “%-” as an operator.
        return handle_sprintf()
    }
    return ""
}

function handle_character_constant(    save_character) {
    save_character = next_character(1)
    if (next_character(1) != "\047")
        error("Expecting closing single quote.")
    character = save_character
}

function handle_integer_constant(    number) {
    number = ""
    while (1) {
        if ((next_character(1)) == "\175") # {}
            return number
        number = number character
    }
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
            # Search for a matching e or ;.
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
        # Search for a matching e or ;.
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

    print "FOO"
}

function handle_math(    a, b) {
    a = pop()
    b = pop()

    # Binary operations are in postfix form with the operands in the usual order.
    # That is, to get x-5 one would use “%gx%{5}%-”.
    if (character == "+") {
         # %+ - arithmetic: push(pop() op pop())
         push(a + b)
    } else if (character == "-") {
         # %- - arithmetic: push(pop() op pop())
         push(b - a)
    } else if (character == "*") {
         #%* - arithmetic: push(pop() op pop())
         push(a * b)
    } else if (character == "/") {
         # %/ - arithmetic: push(pop() op pop())
         push(int(b / a))
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
         push((b < a ? 1 : 0))
    } else if (character == "<") {
        # %< - logical operations: push(pop() op pop())
         push((b < a ? 1 : 0))
    }
}

function handle_sprintf(string) {
    string = substr(format_string, (format_position - 1), (RLENGTH + 2))
    sub(/^%:/, "%", string)
    format_position += RLENGTH
    return sprintf(string, pop())
}

function error(string) {
    printf "ERROR: %s\n", string | "cat 1>&2"
    close("cat 1>&2")
    exit 1
}

# function trace(caller,    stack_item, stack_print) {
#     stack_print = ""
#     for (stack_item = 1; stack_item <= stack_pointer; stack_item++) {
#         stack_print = stack_print " " stack[stack_item]
#     }

#     printf  "{%s} %-10s [%03d] %s (%s) %s : %-10s {%d%s}\n",
#             character,
#             caller,
#             format_position,
#             substr(format_string, 1, format_position - 1),
#             substr(format_string, format_position, 1),
#             substr(format_string, format_position + 1),
#             output,
#             stack_pointer,
#             stack_print | "cat 1>&2"
# }

# Work with variables.
function get(variale) {
    if (!(variable in vars)) {
        vars[variable] = 0
    }
    return vars[variable]
}
function set(variale, value) {
    return (vars[variable] = value)
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
# function dump_stack(    pointer) {
#     for (pointer = 1; pointer <= stack_pointer; pointer++) {
#         print stack[pointer]
#     }
# }
