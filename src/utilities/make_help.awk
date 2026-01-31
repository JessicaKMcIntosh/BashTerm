#!/usr/bin/env -S awk -f

# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Print help information for the Makefile.

BEGIN {
    delete targets          # Targets to print.
    delete descriptions     # Descriptions for the targets.
    targets_index=0         # Index into the above arrays.
    max_target_width=0      # For formatting.
    max_description_width=0
}

/^[[:alnum:]._][[:alnum:]._]*:.*#/ {
    # Get the target and description.
    target=substr($0, 1, (index($0, ":") - 1))
    description=$0
    sub(/^[^#]*# */, "", description)

    # Save them.
    targets[targets_index] = target
    descriptions[targets_index] = description
    targets_index++

    # For formatting.
    if (length(target) > max_target_width)
        max_target_width = length(target)
    if (length(description) > max_description_width)
        max_description_width = length(description)
}

END {
    # Set the format then draw the headers.
    format_string=" %-" max_target_width "s | %s\n"
    printf "Please specify the target:\n"
    printf "\n"
    printf format_string, "Target", "Description"

    # Separator line.
    for (i = 0; i <= max_target_width; i++)
        printf "-"
    printf "-+"
    for (i = 0; i <= max_description_width; i++)
        printf "-"
    printf "-\n"

    # Print each of the targets.
    for (i = 0; i < targets_index; i++) {
        printf format_string, targets[i], descriptions[i]
    }

    print ""
}
