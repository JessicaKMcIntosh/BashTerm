# Bash Terminal Library

A library to simplify working with the terminal in bash.

* [TODO](#todo)
* [Requirements](#requirements)
* [Overview](#overview)
* [Why?](#why)
* [Terminal Attributes - `attr.sh`](#terminal-attributes---attrsh)
  * [Primary interface](#primary-interface)
  * [Shortcuts](#shortcuts)
  * [Internal variables](#internal-variables)
* [Terminal Colors - `color.sh`](#terminal-colors---colorsh)
  * [Primary interface](#primary-interface-1)
  * [Shortcuts](#shortcuts-1)
  * [Colors](#colors)
  * [Internal variables](#internal-variables-1)
* [Terminal Cursor movement - `cursor.sh`](#terminal-cursor-movement---cursorsh)
  * [Primary interface](#primary-interface-2)
  * [Functions](#functions)
  * [Shortcuts](#shortcuts-2)
  * [Internal variables](#internal-variables-2)
* [Spinner - `spinner.sh`](#spinner---spinnersh)
  * [Available Frames](#available-frames)
  * [Configuration](#configuration)
  * [Internal variables](#internal-variables-3)
* [Functions](#functions-1)
* [Box drawing Unicode characters - `boxes.sh`](#box-drawing-unicode-characters---boxessh)
  * [Primary interface](#primary-interface-3)
  * [Variable meaning](#variable-meaning)
* [Functional Interface - `function.sh`](#functional-interface---functionsh)
* [Export - `export.sh`](#export---exportsh)
  * [Usage](#usage)
* [Examples](#examples)
  * [Attributes - `examples/attr_example.sh`](#attributes---examplesattr_examplesh)
  * [Colors - `examples/color_example.sh`](#colors---examplescolor_examplesh)
  * [Color and Attribute Table - `examples/table.sh`](#color-and-attribute-table---examplestablesh)
  * [Boxes - `examples/boxes_example.sh`](#boxes---examplesboxes_examplesh)
  * [Cursor - `examples/cursor_example.sh`](#cursor---examplescursor_examplesh)
  * [Function - `examples/function_example.sh`](#function---examplesfunction_examplesh)
  * [Spinner - `examples/spinner_example.sh`](#spinner---examplesspinner_examplesh)
* [Reference](#reference)
* [Other Projects](#other-projects)
* [LICENSE](#license)

## TODO

* Draw boxes. Could do this with AWK.
* Unit tests.
* Write an actual test for the cursor library.

## Requirements

This library requires Bash 4.
There are some features that only work with 4.
For example Unicode characters `$'\u2500'` and associative arrays.

MacOS still ships with Bash 3.
For MacOS check out [Homebrew](https://brew.sh/) for a modern version of bash.

## Overview

This library provides a variable interface with a few functions.
When the library loads it calls `tput` to get the escape codes for terminal functionality.

The primary interface is using associative arrays.
For example the following will draw the word `Underline` underlined.
In this example the associative array `$TERM_ATTR` contains escape codes for setting terminal attributes.

```shell
source "./attr.sh"
echo "Normal ${TERM_ATTR[underline]}Underline${TERM_ATTR[UNDERLINE]} not underlined"
```

There are also shortcuts variables.
For example the following will draw the word `Bold` in bold.
Instead of using the associative array this uses variables just for those attributes.

```shell
source "./attr.sh"
echo "Normal ${TERM_ATTR_BOLD}Bold${TERM_ATTR_RESET} not bold"
```

This us done by using the command `tput` to generate the escape codes.
First the associative arrays are built.
Then the shortcut variables are created.
See the file `attr.sh` for more details.

## Why?

Because there isn't a simple solution out there that can be easily customized for a project.
There are more complicated libraries that don't cover many cases.
And plenty of snippets and Gists.
But nothing with broad coverage that is easy to use.
I created this after having to dig up all of this for a simple world clock.

The goal is not to provide an all encompassing library that solves all of your problems.

The goal is to make something simple that can be easily customized to suit YOUR needs.

To that end I recommend picking and choosing the bits and pieces you want in your script.

## Terminal Attributes - `attr.sh`

Escape codes for setting various terminal attributes.
For example setting text **BOLD**.

### Primary interface

The primary interface for the attributes library is the associative array `$TERM_ATTR`.

```shell
declare -A TERM_ATTR    # Stores terminal attribute escape sequences.
```

### Shortcuts

Shortcut variables to make code a bit more friendly.

| Variable | Attribute | Name | Meaning |
| --- | --- | --- | --- |
| $TERM_ATTR_BOLD | bold | enter_bold_mode | turn on bold (extra bright) mode |
| $TERM_ATTR_CLEAR | clear | clear_screen | clear screen and home cursor |
| $TERM_ATTR_DIM | dim | enter_dim_mode | turn on half-bright mode |
| $TERM_ATTR_INSERT | smir | enter_insert_mode | enter insert mode |
| $TERM_ATTR_INVISIBLE | invis | enter_secure_mode | turn on blank mode (characters invisible) |
| $TERM_ATTR_EXIT_INSERT | rmir | exit_insert_mode | exit insert mode |
| $TERM_ATTR_EXIT_ITALICS | ritm | exit_italics_mode | End italic mode |
| $TERM_ATTR_EXIT_STANDOUT | rmso | exit_standout_mode | exit standout mode |
| $TERM_ATTR_EXIT_UNDERLINE | rmul | exit_underline_mode | exit underline mode |
| $TERM_ATTR_ITALICS | sitm | enter_italics_mode | Enter italic mode |
| $TERM_ATTR_ORIG | op | orig_pair | Set default pair to its original value |
| $TERM_ATTR_RESET | sgr0 | exit_attribute_mode | turn off all attributes |
| $TERM_ATTR_REVERSE | rev | enter_reverse_mode | turn on reverse video mode |
| $TERM_ATTR_STANDOUT | smso | enter_standout_mode | begin standout mode |
| $TERM_ATTR_UNDERLINE | smul | enter_underline_mode | begin underline mode |

The `Variable` column is the variable name from the terminfo manpage.

**NOTE:**
The attribute `invis` doesn't always work.
For example, it is not working on my Putty install.

### Internal variables

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

## Terminal Colors - `color.sh`

Escape codes for setting foreground and background.

This only uses the old 16 color interface.

**NOTE:**
The bright foreground colors are usually the same as the foreground color and the bold attribute.

**IMPORTANT:**
The default foreground and background colors are **NOT** always the same as `white` and `black`.
To get the default foreground and background colors use `$TERM_ATTR_ORIG` from `attr.sh` or `tput op`.

### Primary interface

The primary interface for the color library are the associative arrays `$TERM_FG` and `$TERM_BG`.

```shell
declare -A TERM_FG      # Stores terminal foreground color escape sequences.
declare -A TERM_BG      # Stores terminal background color escape sequences.
```

### Shortcuts

Shortcut variables to make code a bit more friendly.

| Variable | Color |
| --- | --- |
| $TERM_BG_BLACK | black background |
| $TERM_BG_BLUE | blue background |
| $TERM_BG_BRIGHT_BLACK | brightblack |
| $TERM_BG_BRIGHT_BLUE | brightblue |
| $TERM_BG_BRIGHT_CYAN | brightcyan |
| $TERM_BG_BRIGHT_GREEN | brightgreen |
| $TERM_BG_BRIGHT_MAGENTA | brightmagenta |
| $TERM_BG_BRIGHT_RED | brightred |
| $TERM_BG_BRIGHT_WHITE | brightwhite |
| $TERM_BG_BRIGHT_YELLOW | brightyellow |
| $TERM_BG_CYAN | cyan background |
| $TERM_BG_GREEN | green background |
| $TERM_BG_MAGENTA | magenta background |
| $TERM_BG_RED | red background |
| $TERM_BG_WHITE | white background |
| $TERM_BG_YELLOW | yellow background |
| $TERM_FG_BLACK | black  foreground |
| $TERM_FG_BLUE | blue  foreground |
| $TERM_FG_BRIGHT_BLACK | brightblack |
| $TERM_FG_BRIGHT_BLUE | brightblue |
| $TERM_FG_BRIGHT_CYAN | brightcyan |
| $TERM_FG_BRIGHT_GREEN | brightgreen |
| $TERM_FG_BRIGHT_MAGENTA | brightmagenta |
| $TERM_FG_BRIGHT_RED | brightred |
| $TERM_FG_BRIGHT_WHITE | brightwhite |
| $TERM_FG_BRIGHT_YELLOW | brightyellow |
| $TERM_FG_CYAN | cyan  foreground |
| $TERM_FG_GREEN | green  foreground |
| $TERM_FG_MAGENTA | magenta  foreground |
| $TERM_FG_RED | red  foreground |
| $TERM_FG_WHITE | white background |
| $TERM_FG_YELLOW | yellow  foreground |

### Colors

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
| brightblack/grey | 8 |
| brightred | 9 |
| brightgreen | 10 |
| brightyellow | 11 |
| brightblue | 12 |
| brightmagenta | 13 |
| brightcyan | 14 |
| brightwhite | 15 |

**NOTE:**
On some terminals red and blue may be swapped.

### Internal variables

Variables used to build the associative arrays.

* `$_TERM_COLORS` -
  All available colors index by the color number.
  When this array is processed both the color name and color number are set in the arrays `$TERM_FG` and `$TERM_BG`.

* `$_TERM_COLOR_ALIASES` -
  Color aliases.
  Currently only mapping `grey` and `gray` to `brightblack`.

## Terminal Cursor movement - `cursor.sh`

### Primary interface

The primary interface for the cursor library is the associative array `$TERM_CURSOR`.

```shell
declare -A TERM_CURSOR  # Stores terminal cursor escape sequences.
```

### Functions

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

### Shortcuts

Shortcut variables to make code a bit more friendly.

| Variable | Attribute | Name | Meaning |
| --- | --- | --- | --- |
| $TERM_ATTR_CLR_BOL | el1 | clr_bol | Clear to beginning of line |
| $TERM_ATTR_CLR_EOL | el | clr_eol | clear to end of line |
| $TERM_ATTR_CLR_EOS | ed | clr_eos | clear to end of screen |
| $TERM_ATTR_DELETE_CHAR | dch1 | delete_character | delete character |
| $TERM_ATTR_DELETE_LINE | dl1 | delete_line | delete line |
| $TERM_ATTR_DOWN | cud1 | down | down one line |
| $TERM_ATTR_HIDE | civis | hide | make cursor invisible |
| $TERM_ATTR_HOME | home | home | home cursor (if no cup) |
| $TERM_ATTR_INSERT_CHAR | ich1 | insert_character | insert character (DISABLED, rarely present) |
| $TERM_ATTR_INSERT_LINE | il1 | insert_line | insert line |
| $TERM_ATTR_INVISIBLE | civis | invisible | make cursor invisible |
| $TERM_ATTR_LEFT | cub1 | left | move left one space |
| $TERM_ATTR_NORMAL | cnorm | normal | make cursor appear normal (undo civis/cvvis) |
| $TERM_ATTR_RESTORE | rc | restore | restore cursor to position of last |
| $TERM_ATTR_RIGHT | cuf1 | right | non-destructive space (move right one space) |
| $TERM_ATTR_SAVE | sc | save | save current cursor |
| $TERM_ATTR_SHOW | cvvis | show | make cursor very visible |
| $TERM_ATTR_TO_LL | ll | to_ll | last line, first column (if no cup) (DISABLED, rarely present) |
| $TERM_ATTR_UP | cuu1 | up | up one line |
| $TERM_ATTR_VISIBLE | cvvis | visible | make cursor very visible |

### Internal variables

Variables used to build the associative array.
Change these to customize the escape codes retrieved using `tput`.

* `$_TERM_CURSOR_ATTRIBUTES` -
  The attributes to fetch escape codes for.
  These are taken directly from the `terminfo` man page.
  When this array is processed both the capability name and attribute are set in `$TERM_CURSOR`.

* `$_TERM_CURSOR_SHORTCUTS` -
  Shortcut variables to create.
  Creating environment variables this way makes it easier for you to customize.s

## Spinner - `spinner.sh`

A simple spinner to tell the user something is going on.
This is more of an example than a complete solution.

### Available Frames

These are the defined frames.
They are just arrays, so adding your own is easy.

**NOTE:**
The code assumes the characters are single width.

| Variable | Description | Characters |
| --- | --- | --- |
| $_TERM_SPIN_FRAMES_SIX | Six brail dots. Blank dot chasing counter clockwise. | `⠷⠯⠟⠻⠽⠾` |
| $_TERM_SPIN_FRAMES_SIX_IN_OUT | Six brail dots. Disappearing then appearing. | `⠿⠷⠧⠇⠃⠁⠀⠈⠘⠸⠼⠾` |
| $_TERM_SPIN_FRAMES_EIGHT | Eight brail dots. Blank dot chasing counter clockwise. | `⣷⣯⣟⡿⢿⣻⣽⣾` |
| $_TERM_SPIN_FRAMES_EIGHT_IN_OUT | Eight brail dots. Disappearing then appearing. | `⣿⣷⣧⣇⡇⠇⠃⠁⠀⠈⠘⠸⢸⣸⣼⣾` |
| $_TERM_SPIN_FRAMES_ARROWS | An arrow spinning clockwise. | `↑↗→↘↓↙←↖` |
| $_TERM_SPIN_FRAMES_LINES | A silly example. | `╵└├┼╀╄╊╋╈╅┽┼┬┐╴` |
| $_TERM_SPIN_FRAMES_ASCII | Simple ASCII characters. | `\|/-\` |

### Configuration

The variable `$TERM_SPIN_SLEEP` sets the sleep time between frames.
The default is `0.1`.
The value is passed to the Bash `read` command using the option `-t`.

Full command:

```shell
read -n 1 -s -t "${TERM_SPIN_SLEEP}"
```

### Internal variables

These are used to track the state of the spinner.

* `$_TERM_SPIN_FRAMES` -
  Keeps track of the current frames.

* `$_TERM_SPIN_NEXT_FRAME` -
  Keeps track of the next frame number to print.

* `$_TERM_SPIN_TOTAL_FRAMES` -
  The total number of frames in `$_TERM_SPIN_FRAMES`.

## Functions

Again, this is just an example.
Adapt this code to your needs.

* `term::spin_start()` -
  Starts the spinner.
  Pass in the frame array.
  Sets the internal variables.

  Example: `term::spin_start "${_TERM_SPIN_FRAMES_SIX[@]}"`

* `term::spin_step()` -
  Prints the next frame.w

* `term::spin_spin` -
  Runs the spinner until a key is pressed.
  Calls `term::spin_start()` then loops forever calling `term::spin_step()`.
  Pass in the frame array.

  Example: `term::spin_spin "${_TERM_SPIN_FRAMES_SIX[@]}"`

## Box drawing Unicode characters - `boxes.sh`

Unicode box drawing characters.

I created a custom naming scheme to make drawing boxes a little easier.
This is a bit odd, but it kinda makes sense if you squint.

There are two additional files:

* `all_boxes.sh` - All Unicode box drawing characters with long names from the Unicode standard.
* `alt_boxes.sh` - The same thing, but shorter names.

### Primary interface

The primary interface for the boxes library are the variables starting with `$TERM_BOX_`.
See the file `boxes.sh` for the variables.
There are too many to fit here.

### Variable meaning

Each of the box characters has a name that indicates the type of line then the position in the box.

For example the name `L_MC` means Light line, Middle and Center position, `┼`.

This is what I came up with to make drawing boxes a little easier.

The first character indicates the type.
Rounded is the same as Light, but the corners are rounded.

| Character | Line type   | Examples |
| --------- | ----------- | -------- |
| L         | Light       | `│┐┘┌└`  |
| H         | Heavy       | `┃┓┛┏┗`  |
| D         | Double line | `║╗╝╔╚`  |
| R         | Rounded     | `│╮╯╭╰`  |

These two are just lines in the given orientation.

* `L_LH` - Light Line Horizontal `─`
* `H_LV` - Heavy Line Vertical   `┃`

For the box parts the second two characters indicate the position.

* The first characters is the vertical orientation. \
  T = Top,  M = Middle, B = Bottom
* The second character is the horizontal orientation. \
  L = Left, C = Center, R = Right

Examples of box parts.

| Line Type  | VAR  | Meaning         | Var  | Meaning           | Var  | Meaning          |
| ---------- | ---- | --------------- | ---- | ----------------- | ---- | ---------------- |
| Light      | L_TL |    Top Left `┌` | L_TC |    Top Center `┬` | L_TR |    Top Right `┐` |
| Heavy      | H_ML | Middle Left `┣` | H_MC | Middle Center `╋` | H_MR | Middle Right `┫` |
| Double     | D_BL | Bottom Left `╚` | D_BC | Bottom Center `╩` | D_BR | Bottom Right `╝` |
| Rounded    | R_BL | Bottom Left `╰` | R_BC | Bottom Center `┴` | R_BR | Bottom Right `╯` |

## Functional Interface - `function.sh`

Think of this as a little bonus.
It is just functions to print the various escape codes.
This is more a suggestion instead of something to use directly.

## Export - `export.sh`

This script will print variable declarations that Bash can read back.
All of the environment variables for the above libraries are output.

**NOTE:**
Functions are not included in the export!

This is really only useful for adding the escape codes for a specific terminal directly to your script.

### Usage

Run the script and redirect the output.
Optionally set the environment variable `$TERM`.

```shell
TERM=xterm ./export.sh > env_xterm.sh
```

## Examples

Here is some example output of the various test scripts.
These were captured using Putty on Windows using the [Consolas font](https://en.wikipedia.org/wiki/Consolas).
The only change in Putty was to make Blue readable.

### Attributes - `examples/attr_example.sh`

Exercises the attributes for Bold, Dim, Invisible (doesn't work in putty), Italics (probably will not work), Reversed, Standout, and Underline .

![Attribute Test](images/attributes.png)

### Colors - `examples/color_example.sh`

Demonstrates the colors, including with the attributes Dim, Bold and Underline.

![Color Test](images/colors.png)

### Color and Attribute Table - `examples/table.sh`

Draws a table showing off colors and attributes.

![Color and Attribute Table](images/table.png)

### Boxes - `examples/boxes_example.sh`

Draws a few boxes.

![Boxes Test](images/boxes.png)

### Cursor - `examples/cursor_example.sh`

**TODO!**
A bad demo of cursor functionality.
This needs to be fixed.

### Function - `examples/function_example.sh`

Demonstrates the function interface by duplicating `examples/attr_example.sh`, `examples/boxes_example.sh`, and `examples/color_example.sh`.

### Spinner - `examples/spinner_example.sh`

A simple demo of the spinner.
Presents a menu to pick from the available animations.
This is meant as an example, not a complete solution.

## Reference

Most of the details in these files have come from Google searches and the `terminfo` manpage.

`terminfo` man page:

* `man 5 terminfo`
* <https://man7.org/linux/man-pages/man5/terminfo.5.html>

`tput` man page:

* `man 5 tput`
* <https://man7.org/linux/man-pages/man1/tput.1.html>

Unicode Box drawing characters:

* [Box Drawing Characters](https://www.compart.com/en/unicode/block/U+2500)
* [Brail Characters](https://www.compart.com/en/unicode/block/U+2800)
* [Wikipedia article on Box Drawing Characters](https://en.wikipedia.org/wiki/Box-drawing_characters)

The following subdirectories:

* `doc/unicode/` -
  Contains lists of Brail and Box Drawing Unicode characters.
* `doc/capability/` -
  Terminal capabilities with terminfo names from the command:
  `infocmp -I TERMINAL > TERMINAL.txt`
  These are useful for looking up capabilities for a specific terminal or finding what an escape code is for.

## Other Projects

Other projects out there that would be interesting to look at.

I have not tried any of these.
I browsed through them to get some ideas.

* <https://github.com/timo-reymann/bash-tui-toolkit> \
  **Toolkit to create interactive and shiny terminal UIs using plain bash builtins** \
  Uses hardcoded escape sequences

* <https://github.com/fidian/ansi> \
  **This bash script will generate the proper ANSI escape sequences to move the cursor around the screen, make text bold, add colors and do much more. It is designed to help you colorize words and bits of text.** \
  Similar concept to this in a single library. \
  Uses hardcoded escape sequences

* <https://github.com/dylanaraps/writing-a-tui-in-bash> \
   **Through my travels I've discovered it's possible to write a fully functional Terminal User Interface in BASH. The object of this guide is to document and teach the concepts in a simple way. To my knowledge they aren't documented anywhere so this is essential.** \
  Uses hardcoded escape sequences

* <https://en.wikibooks.org/wiki/Bash_Shell_Scripting/Whiptail> \
  Whiptail, dialog, and some other options are out there that probably do what you want.

* <https://boxes.thomasjensen.com/> \
  **Boxes is a command line program which draws, removes, and repairs ASCII art boxes.** \
  It draws boxes around text.

* <https://github.com/bhavanki/abom> \
  **A TUI (text UI) framework for bash.** \
  Uses hardcoded escape sequences

* <https://github.com/gavinlyonsrepo/bashmultitool> \
  **A Bash Shell library file for commonly used functions can be imported into shell scripts to create functional and colorful scripts and Terminal users interfaces(TUI). The library allows user to redefine commonly used functions every time you write a shell script, the library may save a part of the development time.** \
  Looks rather useful. Does much more than this library.
  Uses hardcoded escape sequences

* <https://github.com/Silejonu/bash_loading_animations> \
  **Ready-to-use loading animations in ASCII and UTF-8 for easy integration into your Bash scripts.**

## LICENSE

[CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/)

See the file `LICENSE` for details.

BashTerm - Bash Terminal Library \
Written in 2025 by Jessica K McIntosh AT gmail \
To the extent possible under law, the author(s) have dedicated all copyright
and related and neighboring rights to this software to the public domain
worldwide. This software is distributed without any warranty.

You should have received a copy of the CC0 Public Domain Dedication along
with this software in the file `LICENSE`. \
If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
