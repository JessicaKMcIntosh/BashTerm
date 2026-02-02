#!/usr/bin/env -S awk -f

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Reads output from infocmp and transforms it
# into something easier to handle in BASH.

{
    # Strip the leading tab.
    sub(/^\t/, "")

    # Make reading numeric capabilities easier.
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

    value = $0
    if (value ~ /\^/) {
        # Replace ^ with the corresponding control characters.
        output = ""
        while (match(value, /\^/)) {
            # If the ^ is escaped include only the ^.
            if (substr(value, (RSTART - 1), 1) == "\\") {
                output = output substr(value, 1, (RSTART - 2)) "^"
                value = substr(value, (RSTART + 1))
                continue
            }
            output = output substr(value, 1, (RSTART -1))
            character = substr(value, (RSTART + 1), 1)
            if (character == "?") {
                # Special case for DEL.
                output = output "\\177"
            } else {
                # Convert a character to a control character in octal.
                # The spaces skip over the numbers 8 and 9, which are invalid for octal.
                output = output sprintf("\\%03d", index("ABCDEFG  HIJKLMNO  PQRSTUVW  XYZ[\\]^_", toupper(character)))
            }
            value = ((RSTART + 1) >= length(value) ? "" : substr(value, (RSTART + 2)))
            # value = substr(value, (RSTART + 2))
        }
        value =  output value
    }
    gsub(/\\,/, ",", value)
    gsub(/\\:/, ":", value)
    gsub(/\\\\/, "\\,", value)
    print value
}
