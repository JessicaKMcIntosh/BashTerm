# Source files

These files are the source of the library files in the main directory.
If you want to make use of these libraries then include the contents of these files in your code.
You are responsible for making sure dependencies are included.

**Note:** Shellcheck will complain about most of the files. Please don't fix the errors.

## Files

* `footer_log.sh` - Footer just for `log.sh`.
* `footer_printf.sh` - Footer just for `printf.sh`.
* `footer.sh` - Generic footer.
* `header_function.sh` - Header for `function.sh`.
* `header.sh` - Generic header.
* `load_libraries.sh` - For loading dependencies.
* `make.sh` - Generates the complete files.
* `raw_attr.sh` - Attribute library.
* `raw_boxes.sh` - Box library.
* `raw_color.sh` - Color library.
* `raw_cursor.sh` - Cursor library.
* `raw_function.sh` - Function library.
* `raw_log.sh` - Logging library.
* `raw_menu.sh` - Menu library.
* `raw_printf.sh` - Printf library.
* `raw_spinner.sh` - Spinner library.
* `shebang.sh` - The very top of the file.
  Includes the shebang line, ShellCheck help and the dedication to the public domain.

These are for creating standalone versions of the utilities.
Include these in your scripts to get just the shortcut environment variables.
The shortcuts are created in a function that is automatically called.
For boxes just use `raw_boxes.sh`.
For a demonstration of using these see the file `make.sh`.

* `shortcuts_attr.sh` - The function `_TERM_CREATE_SHORTCUTS_ATTR()` creates the attribute shortcut environment variables.
* `shortcuts_color.sh` - The function `_TERM_CREATE_SHORTCUTS_COLOR()` creates the color shortcut environment variables.
* `shortcuts_cursor.sh*` - The function `_TERM_CREATE_SHORTCUTS_CURSOR()` creates the cursor shortcut environment variables.
* `standalone_printf.sh` - A version of `raw_printf.sh` with the AWK script included.

## Utilities

There are some utilities located in the subdirectory `utilities/`.

* `m1.awk` - Macroprocessor in AWK as found in the O'Reilly boo awk & sed..
* `make_help.awk` - Print help text for `Makefile`.

## Using vim to diff the files?

```shell
vimdiff new/attr.sh ../attr.sh
vimdiff new/boxes.sh ../boxes.sh
vimdiff new/color.sh ../color.sh
vimdiff new/cursor.sh ../cursor.sh
vimdiff new/function.sh ../function.sh
vimdiff new/log.sh ../log.sh
vimdiff new/menu.sh ../menu.sh
vimdiff new/printf.sh ../printf.sh
vimdiff new/spinner.sh ../spinner.sh
```
