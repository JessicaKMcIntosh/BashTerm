# `attr.sh` - Terminal Attributes

Escape codes for setting various terminal attributes.
For example setting text **BOLD**.

## Interface

The primary interface for the attributes library is the associative array `$TERM_ATTR`.

```shell
declare -A TERM_ATTR    # Stores terminal attribute escape sequences.
```

## Shortcuts

Shortcut variables to make code a bit more friendly.

| Variable | Attribute | Name | Meaning |
| --- | --- | --- | --- |
| $TERM_BOLD | bold | enter_bold_mode | turn on bold (extra bright) mode |
| $TERM_CLEAR | clear | clear_screen | clear screen and home cursor |
| $TERM_DIM | dim | enter_dim_mode | turn on half-bright mode |
| $TERM_INSERT | smir | enter_insert_mode | enter insert mode |
| $TERM_INVISIBLE | invis | enter_secure_mode | turn on blank mode (characters invisible) |
| $TERM_EXIT_INSERT | rmir | exit_insert_mode | exit insert mode |
| $TERM_EXIT_ITALICS | ritm | exit_italics_mode | End italic mode |
| $TERM_EXIT_STANDOUT | rmso | exit_standout_mode | exit standout mode |
| $TERM_EXIT_UNDERLINE | rmul | exit_underline_mode | exit underline mode |
| $TERM_ITALICS | sitm | enter_italics_mode | Enter italic mode |
| $TERM_ORIG | op | orig_pair | Set default pair to its original value |
| $TERM_RESET | sgr0 | exit_attribute_mode | turn off all attributes |
| $TERM_REVERSE | rev | enter_reverse_mode | turn on reverse video mode |
| $TERM_STANDOUT | smso | enter_standout_mode | begin standout mode |
| $TERM_UNDERLINE | smul | enter_underline_mode | begin underline mode |

The `Variable` column is the variable name from the terminfo manpage.

**NOTE:**
The attribute `invis` doesn't always work.
For example, it is not working on my Putty install.

## Internal variables

Variables used to build the associative array.
Change these to customize the escape codes retrieved using `tput`.

* `$_TERM_ATTRIBUTES` -
  The attributes to fetch escape codes for.
  This associative array contains the capability name and attribute from the terminfo manpage.
  When this array is processed both the capability name and attribute are set in `$TERM_ATTR`

* `$_TERM_ATTRIBUTE_ALIASES` -
  Aliases to add to the TERM_ATTR array.
  These are more friendly names for the various capabilities.
  For example use `UNDERLINE` to exit underline mode instead of the more cryptic `rmul`.

* `$_TERM_ATTRIBUTE_SHORTCUTS` -
  Shortcut variables to create.
  Creating environment variables this way makes it easier for you to customize.

## RAW File

`src/raw_attr.sh`

## Used By

These scripts make use of `attr.sh`:

* [function.sh](../README.md#functionsh---functional-interface)
* [log.sh](log.md)
* [menu.sh](menu.md)
* [printf.sh](printf.md) and `printf.awk`
* [spinner.sh](spinner.md)
* [examples/attr_example.sh](../README.md#examplesattr_examplesh---attributes)
* [examples/color_example.sh](../README.md#examplescolor_examplesh---colors)
* [examples/cursor_example.sh](../README.md#examplescursor_examplesh---cursor)
* [examples/export.sh](../README.md#examplesexportsh---export)
* [examples/menu_example.sh](../README.md#examplesmenu_examplesh---menu)
* [examples/table.sh](../README.md#examplestablesh---color-and-attribute-table)
* `tests/attr.sh`
