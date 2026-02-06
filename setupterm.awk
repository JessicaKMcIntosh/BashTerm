#!/usr/bin/env -S awk -f

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Reads output from infocmp and transforms it
# into something easier to handle in BASH.

NR == 1 {
    # Special handling for the first line.
    # It contains the terminal name and description.
    sub(/,*$/, "", $0)
    fields = split($0, info, /\|/)
    printf "_name=%s,\n", info[1]
    printf "_descr=%s,\n", info[fields]
    next
}

{
    # Strip the leading tab.
    sub(/^\t/, "")

    # Make reading numeric capabilities easier to deal with.
    if (sub(/#/, "=")) {
        print
        next
    }

    # Boolean capabilities.
    if (index($0, "=") == 0) {
        printf "%s=%s\n", $0, $0
        next
    }

    # Strip delays. We are not dealing with them.
    # TODO: Deal with delays.
    gsub(/\$<[0-9][0-9]*[\/*]*>/,"")

    input = $0
    output = input
    if (input ~ /\^/) {
        # Replace ^ with the corresponding control characters.
        output = ""
        while (match(input, /\^/)) {
            # If the ^ is escaped include only the ^.
            if (substr(input, (RSTART - 1), 1) == "\\") {
                output = output substr(input, 1, (RSTART - 2)) "^"
                input = substr(input, (RSTART + 1))
                continue
            }
            output = output substr(input, 1, (RSTART -1))
            character = substr(input, (RSTART + 1), 1)
            if (character == "?") {
                # Special case for DEL.
                output = output "\\177"
            } else {
                # Convert a character to a control character in octal.
                # The spaces skip over the numbers 8 and 9, which are invalid for octal.
                output = output sprintf("\\%03d", index("ABCDEFG  HIJKLMNO  PQRSTUVW  XYZ[\\]^_", toupper(character)))
            }
            input = ((RSTART + 1) >= length(input) ? "" : substr(input, (RSTART + 2)))
        }
        output = output input
    }

    # Terminfo uses some uncommon escape sequences.
    gsub(/\\,/, ",", output)
    gsub(/\\:/, ":", output)
    gsub(/\\s/, " ", output)
    gsub(/\\l/, "\\n", output)

    # Finally.
    print output
}
