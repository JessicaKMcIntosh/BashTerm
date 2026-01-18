# `log.sh` - Logging

Fancy logging, with color!

## Interface

## Configuration

```shell
declare _TERM_LOG_FILE="${BASH_SOURCE[0]##*/}"
declare _TERM_LOG_LEVEL=${TERM_LOG_LEVEL:-1} # This would normally be INFO.
declare _TERM_LOG_DATE_FORMAT="${TERM_LOG_DATE:-"%Y-%m-%d_%H:%M:%S"}"
declare -a _TERM_LOG_LEVELS=("Debug" "Info" "Warn" "Error")
declare _TERM_LOG_MAX_LEVEL="${#_TERM_LOG_LEVELS[@]}"
```

## RAW File

`src/raw_log.sh`
