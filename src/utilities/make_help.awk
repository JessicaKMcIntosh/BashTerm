#!/usr/bin/env -S awk -f

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Print help information for the Makefile.

BEGIN {
    printf "Please specify the target:\n"
    printf "\n"
    printf " %-10s | %s\n", "Target", "Description"
    print "------------+------------------------------"
}

/: #/ {
    command=substr($0, 1, (index($0, ":") - 1))
    description=$0
    sub(/^[^#]*# */, "", description)
    printf " %-10s | %s\n", command, description
}
