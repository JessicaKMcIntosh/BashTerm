# `menu.sh` - Menu

Creates interactive menus.

## TODO

From the source file:

```shell
# Display a menu.
# Args:
#   $1 - Menu title.
#   $2 - Options!
#   $@ - Menu Item array.
# Menu item array:
#   These are composed of three fields separated by the vertical tab ("|") character.
#   ( "Key|Return|Text" )
#   Text -  The text to print for the menu item. Required!
#           If Text is "~" then the item is not printed.
#           Use this for the sideeffect of a key and return code.
#   Key -   The optional key the user should press.
#           If not present the key is the positional number + 1.
#           If Key is "~" then the key is ignored and the text is printed verbatim.
#           If the key is more than one character an error is thrown.
#           This can happen if you use the positional number.
#   Return - The optional return code. The default is the positional number.
#   If a menu item is completely blank then a blank line is printed.
# Options:
#   These change how the menu is built and operates.
#   Options are separated by the vertical tab ("|") character.
#   clear       - Clear the screen before displaying the menu.
#   bold        - The key text is printed in bold.
#   debug       - Print some debug information.
#   one         - Exit after the first attempt. Returns 251 if a key was not selected.
#   prompt      - The user prompt. "~" is replaced with the valid keys.
#   quiet       - Do not print error text.
#   reverse     - The key text is printed in reverse.
#   sep         - The key and text separator text follows.
#                 For example "sep =>" results in "0 => Menu Text."
#   underline   - The key text is printed underlined.
# Returns:'
#   The item selected in the exit status.
#   All return codes MUST be less than or equal to 250.
#   If you need more than 250 menu items consider Whiptail.
#   https://en.wikibooks.org/wiki/Bash_Shell_Scripting/Whiptail
#   251 - Invalid key entered and option "one" was given.
#   252 - Insufficient args passed.
#   253 - Key is not a single character.
#   254 - Return code is not a number or more than 250.
#   255 - Error while building the menu.
# Notes:
#   The character "~" is used because it is uncommon and unlikely to appear in menu text.
```

## RAW File

`src/raw_menu.sh`

## Used By

These scripts make use of `menu.sh`:

* [spinner.sh](spinner.md)
* [examples/menu_example.sh](../README.md#examplesmenu_examplesh---menu)
