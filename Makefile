# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Build the various files.

# Build using this very wonderful website:
# https://makefiletutorial.com/

SHELL=/bin/bash

.PHONY: all clean demo help test

help: # Print all available options.
	@echo "Please specify the target:"
	@echo ""
	@awk -f src/utilities/make_help.awk Makefile

all: # Build all files.
	@src/make.sh

clean: # Clean temporary files.
	rm -rf src/new

demo: # Run the BashTerm Demo.
	@bash demo.sh

test: # Run the tests.
	@./run_tests.sh
