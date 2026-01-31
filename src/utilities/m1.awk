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
#   @append varname value   Append value to varname.
#   @define varname value   Sets the varname to value.
#   @default varname value  Set if varname to value if it is undefined.
#   @include filename       Includes the contents of the file.
#   @if varname             Include subsequent text if varname != 0.
#   @unless varname         Include subsequent text if varname == 0.
#   @fi                     Terminate @if or @unless.
#   @ignore DELIM           Ignore input until line that begins with DELIM.
#   @stderr stuff           Send diagnostics to standard error.
#   @undefine varname       Removes the variable.
#   @output filename        Send all further output to filename.
#   @system COMMAND         Execute a system command.
#                           Use - to reset to STDOUT.
#   @exit                   Stop processing and exit immediately.
#   @echo value             Explicitly echo the value.
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

function dofile(fname,  savefile, savebuffer, newstring) {
    if (fname in activefiles)
        error("recursively reading file: " fname)
    activefiles[fname] = 1
    savefile = file; file = fname
    savebuffer = buffer; buffer = ""
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
            exit(0)
        } else if (/^@system[ \t]/) {
            system(dosubs(substr($0, 9)))
        } else {
            newstring = dosubs($0)
            if ($0 == newstring || index(newstring, "@") == 0)
                doprint(newstring)
            else
                buffer = newstring "\n" buffer
        }
    }
    close(fname)
    delete activefiles[fname]
    file = savefile
    buffer = savebuffer
}

# Put next input line into global string "buffer"
# Return "EOF" or "" (null string)

function readline(  i, status) {
    status = ""
    if (buffer != "") {
        i = index(buffer, "\n")
        $0 = substr(buffer, 1, i-1)
        buffer = substr(buffer, i+1)
    } else {
        # Hume: special case for non v10: if (file == "/dev/stdin")
        status = getline < file
        if (status == 0)
            status = EOF
        else if (status < 0)
            error(sprintf("Read error (%s): %s\n", file, ERRNO))
    }
    # Hack: allow @Mname at start of line w/o closing @
    if ($0 ~ /^@[A-Z][a-zA-Z0-9]*[ \t]*$/)
        sub(/[ \t]*$/, "@")
    return status
}

function gobble(  ifdepth) {
    ifdepth = 1
    while (readline() != EOF) {
        if (/^@(if|unless)[ \t]/)
            ifdepth++
        if (/^@fi[ \t]?/ && --ifdepth <= 0)
            break
    }
}

function doignore(  l, delim) {
    delim = $2
    l = length(delim)
    while (readline() != EOF)
        if (substr($0, 1, l) == delim)
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

function dodef(fname,  str, x, name) {
    macro = $1
    name = $2
    sub(/^[ \t]*[^ \t]+[ \t]+[^ \t]+[ \t]*/, "")  # OLD BUG: last * was +
    str = $0
    while (str ~ /\\$/) {
        if (readline() == EOF)
            error("EOF inside definition")
        x = $0
        sub(/^[ \t]+/, "", x)
        str = substr(str, 1, length(str)-1) "\n" x
    }

    if (macro == "@append")
        symtab[name] = sprintf("%s\n%s", symtab[name], str)
    else
        symtab[name] = str
}

function do_D(definition,  pos, name, value) {
    sub(/^-D/, "", definition)
    pos = index(definition, "=")
    if (pos == 0)
        print_usage(sprintf("Invalid -D definition: %s", definition))
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
