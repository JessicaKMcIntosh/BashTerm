# `color.sh` - Terminal Colors

Escape codes for setting foreground and background.

This only uses the old 16 color interface.

**NOTE:**
The bright foreground colors are usually the same as the foreground color and the bold attribute.

**IMPORTANT:**
The default foreground and background colors are **NOT** always the same as `white` and `black`.
To get the default foreground and background colors use `$TERM_ORIG` from `attr.sh` or `tput op`.

## Interface

The primary interface for the color library are the associative arrays `$TERM_FG` and `$TERM_BG`.

```shell
declare -A TERM_FG      # Stores terminal foreground color escape sequences.
declare -A TERM_BG      # Stores terminal background color escape sequences.
```

## Shortcuts

Shortcut variables to make code a bit more friendly.

| Variable | Color |
| --- | --- |
| $TERM_BG_BLACK | black background |
| $TERM_BG_BLUE | blue background |
| $TERM_BG_BRIGHTBLACK | bright black background |
| $TERM_BG_BRIGHTBLUE | bright blue background |
| $TERM_BG_BRIGHTCYAN | bright cyan background |
| $TERM_BG_BRIGHTGREEN | bright green background |
| $TERM_BG_BRIGHTMAGENTA | bright magenta background |
| $TERM_BG_BRIGHTRED | bright red background |
| $TERM_BG_BRIGHTWHITE | bright white background |
| $TERM_BG_BRIGHTYELLOW | bright yellow background |
| $TERM_BG_CYAN | cyan background |
| $TERM_BG_GREEN | green background |
| $TERM_BG_MAGENTA | magenta background |
| $TERM_BG_RED | red background |
| $TERM_BG_WHITE | white background |
| $TERM_BG_YELLOW | yellow background |
| $TERM_FG_BLACK | black  foreground |
| $TERM_FG_BLUE | blue foreground |
| $TERM_FG_BRIGHTBLACK | bright black foreground |
| $TERM_FG_BRIGHTBLUE | bright blue foreground |
| $TERM_FG_BRIGHTCYAN | bright cyan foreground |
| $TERM_FG_BRIGHTGREEN | bright green foreground |
| $TERM_FG_BRIGHTMAGENTA | bright magenta foreground |
| $TERM_FG_BRIGHTRED | bright red foreground |
| $TERM_FG_BRIGHTWHITE | bright white foreground |
| $TERM_FG_BRIGHTYELLOW | bright yellow foreground |
| $TERM_FG_CYAN | cyan  foreground |
| $TERM_FG_GREEN | green  foreground |
| $TERM_FG_MAGENTA | magenta  foreground |
| $TERM_FG_RED | red  foreground |
| $TERM_FG_WHITE | white foreground |
| $TERM_FG_YELLOW | yellow  foreground |

## Colors

Supported colors.

| Color | Number |
| --- | --- |
| black | 0 |
| red | 1 |
| green | 2 |
| yellow | 3 |
| blue | 4 |
| magenta | 5 |
| cyan | 6 |
| white | 7 |
| bright black / grey | 8 |
| bright red | 9 |
| bright green | 10 |
| bright yellow | 11 |
| bright blue | 12 |
| bright magenta | 13 |
| bright cyan | 14 |
| bright white | 15 |

**NOTE:**
On some terminals red and blue may be swapped.

## Internal variables

Variables used to build the associative arrays.

* `$_TERM_COLORS` -
  All available colors index by the color number.
  When this array is processed both the color name and color number are set in the arrays `$TERM_FG` and `$TERM_BG`.

* `$_TERM_COLOR_ALIASES` -
  Color aliases.
  Currently only mapping `grey` and `gray` to `brightblack`.

## RAW File

`src/raw_color.sh`

## Used By

These scripts make use of `color.sh`:

* [function.sh](../README.md#functionsh---functional-interface)
* [log.sh](log.md)
* [menu.sh](menu.md)
* [printf.sh](printf.md) and `printf.awk`
* [spinner.sh](spinner.md)
* [examples/color_example.sh](../README.md#examplescolor_examplesh---colors)
* [examples/export.sh](../README.md#examplesexportsh---export)
* [examples/table.sh](../README.md#examplestablesh---color-and-attribute-table)
* `tests/color.sh`
