# This requires bash version 4.4 or later.
if [ -z "$BASH_VERSION" ]; then
    echo "Error: Bash version 4.4 or higher is required."
    exit 1
fi
if ((BASH_VERSINFO[0] < 4)) || ((BASH_VERSINFO[0] == 4 && BASH_VERSINFO[1] < 4)); then
    echo "Error: Bash version 4.4 or higher is required."
    echo "Current version: ${BASH_VERSION}"
    exit 1
fi
