# `printf.sh` and `printf.awk` - Printf

This is a custom implementation of printf in AWK.
With the ability to set attributes and call `tput`.

This library is composed of two files:

* `printf.awk` -
  The implementation of printf.
* `printf.sh` -
  Bash function to call `printf.awk`.

## Interface

The interface for the printf library are the functions `term::printf` and `term::printf-v`.

* `term::printf` acts like the shell `printf` command.
  The first parameter is the format string.
  Remaining parameters are for the format statements.

* `term::printf-v` is the same, but sets a variable, like the shell `printf -v VAR` command.
  Pass the variable name to set first.
  For example `term::printf-v "MyVariable" "This is %s.\n" "My Variable"` sets the variable `MyVariable` to the value `This is My Variable.\n`.

## Features

* Backslash characters are properly interpreted.

  Provided the backslash characters make it to AWK intact.
  See the table [Backslashes](#backslashes) below for details.

* Normal `%` based format statements.

  These are passed to the AWK `sprintf()` function.

* Call `tput` directly.

  Using `%{STRING}` will call `tput` with the contents of `STRING`.
  The string can contain multiple attributes separated by a comma.

  For example: `"%{sgr0,clear}"` will reset all attributes then clear the screen using tput.

* Lookup the environment variable for an attribute.

  Using `%(STRING)` will attempt to fetch the attribute from the `$TERM_` shortcut environment variables.
  The string can contain multiple attributes separated by a comma.

  Some special allowances are made:

  * If the attribute is a color name such as `red` or `BRIGHTBLUE` they will be translated to the correct color variable.
    In this example they translate to `$TERM_FG_RED` and `$TERM_BG_BRIGHTBLUE`.
    Note the case.

  * Upper and lower case attribute names have different meanings.
    Lowercase means to set the attribute, uppercase means to unset it (use the variable `$TERM_EXIT_ATTRIBUTE`)
    Lowercase color means foreground, uppercase color means background.

    For example the string `"Color %(green, YELLOW, bold)Green%(orig)"` renders `Green` in green and bold on yellow.

* Lookup the environment variable for an attribute using single letter short codes.

  Using `%[CHARS]` to specify attributes using single characters.
  See the table [Short Attribute Codes](#short-attribute-codes) below for details.

  For example the string `"Short %[m]color %[rl]codes%[o]"` renders `colors` in magenta and `codes` in red and bold.

* Draw with the Unicode box drawing characters from `boxes.sh`.

  Using `%<STRING>` will attempt to fetch the attribute from the `$TERM_BOX_` shortcut environment variables.
  The string can contain multiple attributes separated by a comma.
  Use the part of the box variable name after `$TERM_BOX_`.
  For example `%<DBC>` will draw the character `╩`.
  Use underscore, `_`, for a single space.

  For example the string `"%<LML,LLH,LMC,LLH,LMR,_,_,LLV>"` translates into `├─┼─┤  │`.

For the strings in `%()`, `${}`, `$<>` leading and trailing whitespace is ignored.
For example the format strings `$(bold,underline)` and `$( bold , underline )` are equivalent.

## Limitations

Unfortunately there are limitations with this library:

* Backslashes are a nightmare, just use single quotes.
  Be careful and don't put more than one set together.
  This is a Bash thing. Sorry.
* The AWK implementation of `sprintf()` is used.
  This limits what can be done depending on your version of AWK.
* Every time the function `term::printf` is called the AWK program is parsed and lookup tables are built.

## Backslashes

All of the supported backslash escape codes.

| Code | Meaning |
| --- | --- |
| \\\\ | A single backslash character. |
| \\a | Alert, bell. |
| \\b | Backspace. |
| \\e | Escape. |
| \\E | Escape. |
| \\f | Form feed. |
| \\n | Newline. |
| \\r | Carriage return. |
| \\t | Tab. |
| \\v | Vertical tab. |
| \\0dd or \\1dd | Convert three octal digits `0dd` or `1dd` into an ASCII character. |
| \\xhh | Converts the two hexadecimal digits `hh` into an ASCII character. |

## Short Attribute Codes

These are single characters that translate to an attribute.
Put as many characters inside `$[]` as desired.

| Code | Attribute | Code | Attribute |
| --- | --- | --- | --- |
| - | Reset attributes. (sgr0) | o | Original colors. (orig) |
| d | Dim mode. (dim) | k | Black Foreground |
| h | Hide the cursor. (hide) | r | Red Foreground |
| H | Moe the cursor home. (home) | g | Green Foreground |
| i | Insert mode. (smir) | y | Yellow Foreground |
| I | Exit insert. (rmir) | b | Blue Foreground |
| l | Bold mode. (bold) | m | Magenta Foreground |
| L | Clear the screen. (clear) | c | Cyan Foreground |
| s | Standout mode (smso) | w | White Foreground |
| S | Exit standout mode. (rmso) | K | Black Background |
| t | Italics Mode. (sitm) | R | Red Background |
| T | Exit Italics mode. (ritm) | G | Green Background |
| u | Underline mode. (smul) | Y | Yellow Background |
| U | Exit underline mode. (rmul) | B | Blue Background |
| v | Reverse mode. (rev) | M | Magenta Background |
| V | Invisible mode. (invis) | C | Cyan Background |
| z | Show the cursor. (cnorm) | W | White Background |

## RAW File

`src/raw_printf.sh`

## Used By

These scripts make use of `printf.sh`:

* [examples/printf_example.sh](../README.md#examplesprintf_examplesh---printf)
