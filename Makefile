# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Build the various files.

# Build using this very wonderful website:
# https://makefiletutorial.com/

SHELL=/bin/bash

.PHONY: all demo help
all: help

demo: # Run the BashTerm Demo.
	@bash demo.sh

help: # Print all available options.
	@awk -f src/utilities/make_help.awk Makefile
