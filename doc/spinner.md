# `spinner.sh` - Spinner

A simple spinner to tell the user something is going on.
This is more of an example than a complete solution.

## Available Frames

These are the defined frames.
They are just arrays, so adding your own is easy.

**NOTE:**
The code assumes the characters are single width.

| Variable | Description | Characters |
| --- | --- | --- |
| $TERM_SPIN_FRAMES_SIX | Six brail dots. Blank dot chasing counter clockwise. | `⠷⠯⠟⠻⠽⠾` |
| $TERM_SPIN_FRAMES_SIX_IN_OUT | Six brail dots. Disappearing then appearing. | `⠿⠷⠧⠇⠃⠁⠀⠈⠘⠸⠼⠾` |
| $TERM_SPIN_FRAMES_EIGHT | Eight brail dots. Blank dot chasing counter clockwise. | `⣷⣯⣟⡿⢿⣻⣽⣾` |
| $TERM_SPIN_FRAMES_EIGHT_IN_OUT | Eight brail dots. Disappearing then appearing. | `⣿⣷⣧⣇⡇⠇⠃⠁⠀⠈⠘⠸⢸⣸⣼⣾` |
| $TERM_SPIN_FRAMES_ARROWS | An arrow spinning clockwise. | `↑↗→↘↓↙←↖` |
| $TERM_SPIN_FRAMES_LINES | A silly example. | `╵└├┼╀╄╊╋╈╅┽┼┬┐╴` |
| $TERM_SPIN_FRAMES_ASCII | Simple ASCII characters. | `\|/-\` |

## Configuration

The variable `$TERM_SPIN_SLEEP` sets the sleep time between frames.
The default is `0.1`.
The value is passed to the Bash `read` command using the option `-t`.

Full command:

```shell
read -n 1 -s -t "${TERM_SPIN_SLEEP}"
```

## Internal variables

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

* `term::spin_init()` -
  Sets the internal state variables.
  Pass in the frame array.

  Example: `term::spin_init "${_TERM_SPIN_FRAMES_SIX[@]}"`

* `term::spin_step()` -
  Prints the next frame.

* `term::spin_spin` -
  Runs the spinner until a key is pressed.
  Calls `term::spin_init()` then loops forever calling `term::spin_step()`.
  Pass in the frame array to use.

  Example: `term::spin_spin "${_TERM_SPIN_FRAMES_SIX[@]}"`

## RAW File

`src/raw_spinner.sh`

## Used By

These scripts make use of `spinner.sh`:

* [examples/spinner_example.sh](../README.md#examplesspinner_examplesh---spinner)
