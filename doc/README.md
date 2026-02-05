# Various bits of documentation and reference.

## BashTerm library documentation:

Documentation for each of the BashTerm libraries.

* `attr.md` - Terminal Attributes
* `boxes.md` - Box drawing Unicode characters
* `color.md` - Terminal Colors
* `cursor.md` - Terminal Cursor movement
* `log.md` - Logging
* `menu.md` - Interactive Menu
* `printf.md` - Printf aware of BashTerm shortcut variables.
* `run_tests.md` - Unit Tests
* `spinner.md` - Spinner
* `terminfo_man.txt` - Output from the command:
```shell
MANWIDTH=80 man 5 terminfo | uni2ascii -e > z.txt
```
* `terminfo.src` - Terminfo terminal description file.
Downloaded from: <https://raw.githubusercontent.com/ThomasDickey/ncurses-snapshots/refs/heads/master/misc/terminfo.src>

## Capabilities

These files have output from the command `infocmp -I TERMINAL > TERMINAL.txt`.
These are only for reference.

* `ansi.txt` - ANSI
* `vt102.txt` - DEC VT102
* `vt220.txt` - DEV VT220
* `xterm-256color.txt` - 256 Color XTERM
* `xterm.txt` - XTERM

## Unicode Characters.

These files have lists of characters taken from
<https://www.compart.com/en/unicode/block/U+2500>.

* `boxes.txt` - Box drawing characters.
* `brail.txt` - Brain characters useful for spinners.

