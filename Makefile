# BashTerm by Jessica K McIntosh is marked CC0 1.0.
# To view a copy of this mark, visit:
# https://creativecommons.org/publicdomain/zero/1.0/

# Build the various files.

# Build using this very wonderful website:
# https://makefiletutorial.com/

SHELL=/bin/bash

.PHONY: default all clean demo help replace shellcheck shfmt test tests

default: help

all: # Build all files.
	@src/make.sh

clean: # Clean temporary files.
	rm -rf src/new

demo: # Run the BashTerm Demo.
	@bash demo.sh

help: # Print all available options.
	@awk -f src/utilities/make_help.awk Makefile

replace: all # Replace the library files with the generated ones.
	@echo ""
	@echo "Updating main library files."
	cp -v src/new/*.sh .

shellcheck: # Run shellcheck.
	@echo "This will take a moment..."
	@shellcheck -P .:examples:tests -x *.sh examples/*.sh tests/*.sh src/make.sh

shfmt: # Check for formatting issues. See: .editorconfig
	@shfmt --apply-ignore -s -d . src/make.sh

test: # Run the tests.
	@./run_tests.sh
tests: test
