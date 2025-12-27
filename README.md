# Bash Terminal Library

A library to simplify working with the terminal in bash.

## Requirements

This library requires Bash 4.
There are some features that only work with 4.
For example Unicode characters `$'\u2500'` and associative arrays.
MacOS still ships with Bash 3.
For MacOS check out [Homebrew](https://brew.sh/)

## Overview

This library provides a variable interface.
When the library loads `tput` is used to get the escape codes for terminal functionality.

## Why?

Because there isn't a simple solution out there that can be easily customized for a simple project.
I created this after having to dig up all of this for a simple world clock.

The goal is not to provide an all encompassing library that solves all of your problems.
The goal is to make something simple that can be easily customized to suit YOUR needs.

## Terminal Attributes

## Terminal Colors

## Terminal Cursor movement

## Box drawing unicode characters using

## LICENSE

[CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/)

See the file `LICENSE` for details.

BASHTERM - Bash Terminal Library
Written in 2025 by Jessica K McIntosh AT gmail
To the extent possible under law, the author(s) have dedicated all copyright
and related and neighboring rights to this software to the public domain
worldwide. This software is distributed without any warranty.

You should have received a copy of the CC0 Public Domain Dedication along
with this software.
If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
