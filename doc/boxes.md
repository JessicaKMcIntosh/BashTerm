# `boxes.sh` - Box drawing Unicode characters

Unicode box drawing characters.

I created a custom naming scheme to make drawing boxes a little easier.
This is a bit odd, but it kinda makes sense if you squint.

There are two additional files:

* `all_boxes.sh` - All Unicode box drawing characters with long names from the Unicode standard.
* `alt_boxes.sh` - The same thing, but shorter names.

## Interface

The primary interface for the boxes library are the variables starting with `$TERM_BOX_`.
See the file `boxes.sh` for the variables.
There are too many to fit here.

## Variable meaning

Each of the box characters has a name that indicates the type of line then the position in the box.

For example the name `LMC` means Light line, Middle and Center position, `┼`.

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

* `LLH` - Light Line Horizontal `─`
* `HLV` - Heavy Line Vertical   `┃`

For the box parts the second two characters indicate the position.

* The first characters is the vertical orientation. \
  T = Top,  M = Middle, B = Bottom
* The second character is the horizontal orientation. \
  L = Left, C = Center, R = Right

Examples of box parts.

| Line Type  | VAR | Meaning         | Var | Meaning           | Var | Meaning          |
| ---------- | --- | --------------- | --- | ----------------- | --- | ---------------- |
| Light      | LTL |    Top Left `┌` | LTC |    Top Center `┬` | LTR |    Top Right `┐` |
| Heavy      | HML | Middle Left `┣` | HMC | Middle Center `╋` | HMR | Middle Right `┫` |
| Double     | DBL | Bottom Left `╚` | DBC | Bottom Center `╩` | DBR | Bottom Right `╝` |
| Rounded    | RBL | Bottom Left `╰` | RBC | Bottom Center `┴` | RBR | Bottom Right `╯` |

## RAW File

`src/raw_boxes.sh`

## Used By

These scripts make use of `boxes.sh`:

* [function.sh](../README.md#functionsh---functional-interface)
* [printf](printf.md)
* [examples/boxes_example.sh](../README.md#examplesboxes_examplesh---boxes)
* [examples/export.sh](../README.md#examplesexportsh---export)
