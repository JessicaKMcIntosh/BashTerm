#!/usr/bin/env -S awk -f
#
# Changes have been made to the original to suit the needs of BashTerm.
# The original file has been included as 'orig_m1.awk'.
#
# NAME
#
# m1
#
# USAGE
#
# awk -f m1.awk -- [-Dvarname=value] [file...]
#
# DESCRIPTION
#
# M1 copies its input file(s) to its output unchanged except as modified by
# certain "macro expressions."  The following lines define macros for
# subsequent processing:
#
#   @comment Any text
#   @@                      Same as @comment
#   @append VARIABLE VALUE  Append VALUE to VARIABLE.
#   @define VARIABLE VALUE  Sets the VARIABLE to VALUE.
#   @default VARIABLE VALUE Set if VARIABLE to VALUE if it is undefined.
#   @include FILE_NAME      Includes the contents of the file.
#   @if VARIABLE            Include subsequent text if VARIABLE != 0.
#   @unless VARIABLE        Include subsequent text if VARIABLE == 0.
#   @fi                     Terminate @if or @unless.
#   @ignore DELIMITER       Ignore input until a line that begins with the delimiter.
#   @stderr stuff           Send diagnostics to standard error.
#   @undefine VARIABLE      Removes the variable.
#   @output FILE_NAME       Send all further output to file.
#                           Use '-' to reset to STDOUT.
#   @system command         Execute a system command.
#   @exit [status]          Stop processing and exit immediately.
#                           Include an optional exit status.
#   @echo VALUE             Explicitly echo the value.
#
# A definition may extend across many lines by ending each line with
# a backslash, thus quoting the following newline.
#
# Any occurrence of @name@ in the input is replaced in the output by
# the corresponding value.
#
# @name at beginning of line is treated the same as @name@.
#
# BUGS
#
# M1 is three steps lower than m4.  You'll probably miss something
# you have learned to expect.
#
# AUTHOR
#
# Jon L. Bentley, jlb@research.bell-labs.com
#

function error(s) {
    s = "m1 error: " s
    print s | "cat 1>&2"; exit 1
}

function dofile(file_name,  save_file, save_buffer, new_string) {
    if (file_name in active_files)
        error("recursively reading file: " file_name)
    active_files[file_name] = 1
    save_file = file; file = file_name
    save_buffer = buffer; buffer = ""
    while (readline() != EOF) {
        if (index($0, "@") == 0) {
            doprint($0)
        } else if (/^@append[ \t]/) {
            dodef()
        } else if (/^@define[ \t]/) {
            dodef()
        } else if (/^@default[ \t]/) {
            if (!($2 in symtab))
                dodef()
        } else if (/^@include[ \t]/) {
            if (NF != 2) error("bad include line")
            dofile(dosubs($2))
        } else if (/^@if[ \t]/) {
            if (NF != 2) error("bad if line")
            if (!($2 in symtab) || symtab[$2] == 0)
                gobble()
        } else if (/^@undefine[ \t]/) {
            if ($2 in symtab)
                delete symtab[$2]
        } else if (/^@unless[ \t]/) {
            if (NF != 2) error("bad unless line")
            if (($2 in symtab) && symtab[$2] != 0)
                gobble()
        } else if (/^@fi([ \t]?|$)/) { # Could do error checking here
        } else if (/^@stderr[ \t]?/) {
            doprint(substr($0, 9))
        } else if (/^@(comment|@)[ \t]?/) {
        } else if (/^@ignore[ \t]/) { # Dump input until $2
            doignore()
        } else if (/^@output[ \t]/) {
            if (NF != 2) error("bad output line")
            doclose()
            output = dosubs($2)
        } else if (/^@echo[ \t]/) {
            doprint(dosubs(substr($0, 7)))
        } else if (/^@exit/) {
            for (file in active_files)
                close(file)
            if (NF > 1)
                exit($2)
            else
                exit(0)
        } else if (/^@system[ \t]/) {
            system(dosubs(substr($0, 9)))
        } else {
            new_string = dosubs($0)
            if ($0 == new_string || index(new_string, "@") == 0)
                doprint(new_string)
            else
                buffer = new_string "\n" buffer
        }
    }
    close(file)
    delete active_files[file_name]
    file = save_file
    buffer = save_buffer
}

# Put next input line into global string "buffer"
# Return "EOF" or "" (null string)

function readline(  position, status) {
    status = ""
    if (buffer != "") {
        position = index(buffer, "\n")
        $0 = substr(buffer, 1, position-1)
        buffer = substr(buffer, position+1)
    } else {
        # Hume: special case for non v10: if (file == "/dev/stdin")
        status = getline < file
        if (status == 0)
            status = EOF
        else if (status < 0)
            error(sprintf("Read error (%s): %s\n", file, ERRNO))
    }
    # Hack: allow @name at start of line w/o closing @
    if ($0 ~ /^@[A-Z][a-zA-Z0-9]*[ \t]*$/)
        sub(/[ \t]*$/, "@")
    return status
}

function gobble(  if_depth) {
    if_depth = 1
    while (readline() != EOF) {
        if (/^@(if|unless)[ \t]/)
            if_depth++
        if (/^@fi[ \t]?/ && --if_depth <= 0)
            break
    }
}

function doignore(  l, delimiter) {
    delimiter = $2
    l = length(delimiter)
    while (readline() != EOF)
        if (substr($0, 1, l) == delimiter)
            break
}

function dosubs(s,  l, r, i, m) {
    if (index(s, "@") == 0)
        return s
    l = ""  # Left of current pos; ready for output
    r = s   # Right of current; unexamined at this time
    while ((i = index(r, "@")) != 0) {
        if (i != 1)
            l = l substr(r, 1, i-1)
        r = substr(r, i+1)  # Currently scanning @
        i = index(r, "@")
        if (i == 0) {
            l = l "@"
            break
        }
        m = substr(r, 1, i-1)
        r = (i == length(r) ? "" : substr(r, i+1))
        if (m in symtab) {
            r = symtab[m] r
        } else {
            l = l "@" m
            r = "@" r
        }
    }
    return l r
}

function dodef(  string, next_line, name) {
    macro = $1
    name = $2
    sub(/^[ \t]*[^ \t]+[ \t]+[^ \t]+[ \t]*/, "")  # OLD BUG: last * was +
    string = $0
    while (string ~ /\\$/) {
        if (readline() == EOF)
            error("EOF inside definition")
        next_line = $0
        sub(/^[ \t]+/, "", x)
        string = substr(string, 1, length(string)-1) "\n" next_line
    }

    if (macro == "@append")
        symtab[name] = sprintf("%s\n%s", symtab[name], string)
    else
        symtab[name] = string
}

function do_D(definition,  pos) {
    sub(/^-D/, "", definition)
    pos = index(definition, "=")
    if (pos == 0)
        print_usage(sprintf("Invalid -Dvarname=value definition: %s", definition))
    $0 = sprintf("@define\t%s\t%s",substr(definition, 1, (pos - 1)) , substr(definition, (pos + 1)))
    dodef()
}
function print_usage(message) {
    if (message)
        printf "%s\n", message | "cat 1>&2"
    print "Usage: awk -f m1.awk -- [-Dvarname=value] [file...]" | "cat 1>&2"
    fflush("cat 1>&2")
    close("cat 1>&2")
    exit 1
}

function doargs(  i) {
    if (ARGC >= 2) {
        for (i = 1; i < ARGC; i++) {
            if (ARGV[i] ~ /^-D/) {
                do_D(ARGV[i])
            } else
                dofile(ARGV[i])
        }
        doclose()
    } else
        print_usage()
}

function doprint(string) {
    if (output == "/dev/null")
        return 0
    if (output == "-")
        print string
    else
        print string > output
}

function doclose() {
    if (output != "-") {
        fflush(output)
        close(output)
    }
}

BEGIN {
    EOF = "EOF"
    output = "-"
    file = ""
    buffer = ""
    doargs()
}
