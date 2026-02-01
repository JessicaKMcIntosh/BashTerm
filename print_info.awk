#!/usr/bin/env -S awk -f

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Print a terminfo string.
# Handle the parameters in the string.

BEGIN {
    # Stack and variables for processing the capability value.
    delete stack
    stack_pointer=0
    delete vars

    # Check that there are enough arguments.
    if (ARGC < 2) {
        error("Provide the capability string.")
    }

    # Process the string.
    format_string = ARGV[1]
    format_length = length(format_string)
    format_position = 0
    process()
    exit
}

function process(    character, output) {
    output = ""
    while ((character = next_character(0)) != "") {
        if (character == "%") {
            output = output handle_percent(next_character(1))
        } else {
            output = output character
        }
    }
    printf "%s", output
}

function next_character(fatal) {
    if (format_position >= format_length) {
        if (fatal) {
            error("Unexpected end of format string.")
        } else {
            return ""
        }
    }
    return substr(format_string, ++format_position, 1)
}

#  rep=
# %p1
# %c
# \E[
# %p2
# %{1}
# %-
# %d
# b

#
function handle_percent(character,  a, b) {
    if (character == "%") {
        #  %% - outputs “%”
        return "%"
    } else if (character == "c") {
        # %c - print pop() like %c in printf
        return sprintf("%c", pop())
    } else if (character == "i") {
        # %i - add 1 to first two parameters (for ANSI terminals)
        ARGV[2]++
        ARGV[3]++
    } else if (character == "g") {
        # %g[a-z] - get dynamic variable [a-z] and push it
        # %g[A-Z] - get static variable [a-z] and push it
        character = next_character(1)
        if (character ~ /[a-zA-Z]/) {
            push(get(character))
        }
    } else if (character == "p") {
        # %p[1-9] - push i'th parameter
        character = next_character(1)
        if (character ~ /[0-9]/) {
            push(ARGV[character + 1])
        }
    } else if (character == "P") {
        # %P[a-z] - set dynamic variable [a-z] to pop()
        # %P[A-Z] - set static variable [a-z] to pop()
        character = next_character(1)
        if (character ~ /[a-zA-Z]/) {
            set(character, pop())
        }
    } else if (character == "s") {
        # %s - print pop() like %s in printf
        return sprintf("%s", pop())
    } else if (character == "l") {
        # %l - push strlen(pop)
        push(length(pop()))
    } else if (character == "\173") { # {}
        # %{nn} - integer constant nn
        push(handle_integer_constant())
    } else if (character == "\047") { # {}
        # %{nn} - integer constant nn
        push(handle_character_constant())
    } else if (character == "d") {
        # TODO: This is wrong!
        return sprintf("%d", pop())
    } else if (character == "!") { # {}
        # %! - unary operations (logical complement): push(op pop())
        push((pop() == 0 ? 1 : 0))
    } else if (character == "~") { # {}
        # %~ - unary operations (bit complement): push(op pop())
        push(compl(pop()))
    } else if (character == "A") { # {}
        # %A - logical “and” operations (for conditionals)
        push(((pop() == 0) && (pop() == 0) ? 1 : 0))
    } else if (character == "O") { # {}
        # %O - logical “or” operations (for conditionals)
        push(((pop() == 0) || (pop() == 0) ? 1 : 0))
    } else if (character ~ /[+*\/m&|^=<>-]/) { # {}
        handle_math(character)
    }
    return ""
}

function handle_integer_constant(    number, character) {
    number = ""
    while (1) {
        if ((character = next_character(1)) == "\175") # {
            return number
        number = number character
    }
}

function handle_character_constant(    character) {
    character = next_character(1)
    if (next_character(1) == "\047")
        error("Expecting closing single quote.")
    return character
}

function handle_math(character,  a, b) {
    a = pop()
    b = pop()

    if (character == "+") { # {}
         # %+ - arithmetic: push(pop() op pop())
         push(a + b)
    } else if (character == "-") { # {}
         # %- - arithmetic: push(pop() op pop())
         push(b - a)
    } else if (character == "*") { # {}
         #%* - arithmetic: push(pop() op pop())
         push(a * b)
    } else if (character == "/") { # {}
         # %/ - arithmetic: push(pop() op pop())
         push(int(b / a))
    } else if (character == "m") { # {}
         # %m - arithmetic (%m is mod): push(pop() op pop())
         push(b % a)
    } else if (character == "&") { # {}
        # %& - bit operations (“and”): push(pop() op pop())
         push(and(b, a))
    } else if (character == "|") { # {}
        # %| - bit operations (“or”): push(pop() op pop())
         push(or(b, a))
    } else if (character == "^") { # {}
        # %^ - bit operations (exclusive “or”): push(pop() op pop())
         push(xor(b, a))
    } else if (character == "=") { # {}
        # %= - logical operations: push(pop() op pop())
         push((b < a ? 1 : 0))
    } else if (character == ">") { # {}
        # %> - logical operations: push(pop() op pop())
         push((b < a ? 1 : 0))
    } else if (character == "<") { # {}
        # %< - logical operations: push(pop() op pop())
         push((b == a ? 1 : 0))
    }
}

function error(string) {
    printf "ERROR: %s\n", string | "cat 1>&2"
    close("cat 1>&2")
    exit 1
}

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
