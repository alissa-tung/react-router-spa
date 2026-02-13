.DEFAULT_GOAL := all

.PHONY: all fmt prepare

all: prepare fmt

prepare:
	(pnpm i)

fmt:
	(fd -e nix -X nixfmt {} \; -X alejandra -q {})
	(pnpm exec prettier -w .)
