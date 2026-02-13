.DEFAULT_GOAL := all

.PHONY: all fmt

all: fmt

fmt:
	(fd -e nix -X nixfmt {} \; -X alejandra -q {})
