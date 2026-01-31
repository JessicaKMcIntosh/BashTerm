# This requires bash version 4.
if ((BASH_VERSINFO[0] < 4)); then
    echo "This script requires Bash 4 or later."
    echo "Current version: ${BASH_VERSION}"
    exit 1
fi
