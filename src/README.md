# Source files

These files are the source of the library files in the main directory.
If you want to make use of these libraries then include the contents of these files in your code.
You are responsible for making sure dependencies are included.

**Note:** Shellcheck will complain about most of the files. Please don't fix the errors.

## Files

General files used to create generated files.

* `footers/default.sh` - Generic footer.
* `footers/log.sh` - Footer just for `log.sh`.
* `footers/printf.sh` - Footer just for `printf.sh`.
* `headers/default.sh` - Generic header.
* `headers/function.sh` - Header for `function.sh`.
* `find_awk.sh` - Try to locate the correct AWK command. Favoring Mawk.
* `load_libraries.sh` - For loading dependencies.
* `make.sh` - Generates the complete files.
* `printf.awk` - The awk code for `term::printf`.
* `raw_attr.sh` - Attribute library.
* `raw_boxes.sh` - Box library.
* `raw_color.sh` - Color library.
* `raw_cursor.sh` - Cursor library.
* `raw_function.sh` - Function library.
* `raw_log.sh` - Logging library.
* `raw_menu.sh` - Menu library.
* `raw_printf.sh` - Printf library.
* `raw_spinner.sh` - Spinner library.
* `shebang.sh` - The very top of the files.
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

The macro files located in the subdirectory `macros/` are used to build the library, standalone and example files.

Templates files used for creating the individual files.

* `_description.m1` - Prints the description. Only used for the help text in `make.sh`.
* `_example.m1` - Creates an example file in `../examples/`.
* `_library.m1` - Creates a library file for the main directory.
* `_standalone.m1` - Creates a file in `../standalone/`.

Settings for each of the files to be created.

* `attr.m1` - Attribute library.
* `boxes.m1` - Boxes library.
* `color.m1` - Color library.
* `cursor.m1` - Cursor library.
* `export.m1` - Export all BashTerm variables and functions.
* `function.m1` - A functional interface to the  libraries.
* `log.m1` - Logging library.
* `menu.m1` - Menu library.
* `printf.m1` - Printf library.
* `spinner.m1` - Spinner library.
* `table.m1` - Prints a table of attributes and colors as a demonstration.

## Utilities

There are some utilities located in the subdirectory `utilities/`.

* `m1.awk` - A customized version of the original `m1.awk` just for this project.
* `make_help.awk` - Print help text for `Makefile`.
* `orig_m1.awk` - The original m1.awk file from chapter 13 of the book `sed & awk`. \
  [Dougherty, D., & Robbins, A. (1997). sed & awk (2nd ed.). O'Reilly Media.](https://www.oreilly.com/library/view/sed-and-awk/0596003528/ch01.html)

## Using vim to diff the new files?

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
