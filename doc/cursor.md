# `cursor.sh` Terminal Cursor movement

Escape codes and functions for working with the cursor.

## Interface

The primary interface for the cursor library is the associative array `$TERM_CURSOR`.

```shell
declare -A TERM_CURSOR  # Stores terminal cursor escape sequences.
```

## Functions

The following are functions because they call `tput` dynamically or return values.

Fetching the cursor position is a bit of a hack.
This is a known issue with multiple solutions.
I used one that should be portable with modern Bash.

* `term::move()` -
  Move the cursor to an row and column position.

* `term::pos()` -
  Report the cursor position. row;col

* `term::row()` -
  Report the cursor row.

* `term::col()` -
  Report the cursor column.

* `term::cols()` -
  Report the number of columns the terminal has.

* `term::lines()` -
  Report the number of lines the terminal has.

## Shortcuts

Shortcut variables to make code a bit more friendly.

| Variable | Attribute | Name | Meaning |
| --- | --- | --- | --- |
| $TERM_CLR_BOL | el1 | clr_bol | Clear to beginning of line |
| $TERM_CLR_EOL | el | clr_eol | clear to end of line |
| $TERM_CLR_EOS | ed | clr_eos | clear to end of screen |
| $TERM_DELETE_CHAR | dch1 | delete_character | delete character |
| $TERM_DELETE_LINE | dl1 | delete_line | delete line |
| $TERM_DOWN | cud1 | down | down one line |
| $TERM_HIDE | civis | hide | make cursor invisible |
| $TERM_HOME | home | home | home cursor (if no cup) |
| $TERM_INSERT_CHAR | ich1 | insert_character | insert character (DISABLED, rarely present) |
| $TERM_INSERT_LINE | il1 | insert_line | insert line |
| $TERM_LEFT | cub1 | left | move left one space |
| $TERM_NORMAL | cnorm | normal | make cursor appear normal (undo civis/cvvis) |
| $TERM_RESTORE | rc | restore | restore cursor to position of last |
| $TERM_RIGHT | cuf1 | right | non-destructive space (move right one space) |
| $TERM_SAVE | sc | save | save current cursor |
| $TERM_SHOW | cvvis | show | make cursor very visible |
| $TERM_TO_LL | ll | to_ll | last line, first column (if no cup) (DISABLED, rarely present) |
| $TERM_UP | cuu1 | up | up one line |
| $TERM_VISIBLE | cvvis | visible | make cursor very visible |

## Internal variables

Variables used to build the associative array.
Change these to customize the escape codes retrieved using `tput`.

* `$_TERM_CURSOR_ATTRIBUTES` -
  The attributes to fetch escape codes for.
  These are taken directly from the `terminfo` man page.
  When this array is processed both the capability name and attribute are set in `$TERM_CURSOR`.

* `$_TERM_CURSOR_SHORTCUTS` -
  Shortcut variables to create.
  Creating environment variables this way makes it easier for you to customize.s

## RAW File

`src/raw_cursor.sh`

## Used By

These scripts make use of `cursor.sh`:

* [function.sh](../README.md#functionsh---functional-interface)
* [printf.sh](printf.md) and `printf.awk`
* [spinner.sh](spinner.md)
* [examples/cursor_example.sh](../README.md#examplescursor_examplesh---cursor)
* [examples/export.sh](../README.md#examplesexportsh---export)
