.DEFAULT_GOAL := all

.PHONY: all prepare build fmt lint

all: prepare fmt lint build fmt

prepare:
	(pnpm i)

build:
	(./scripts/build-image.sh web-app-image)

fmt:
	(fd -e nix -X nixfmt {} \; -X alejandra -q {})
	(pnpm exec oxfmt)
	(fd -e sh -X shfmt -l -w --simplify --indent 2 --case-indent --space-redirects)
	(caddy fmt --overwrite)

lint:
	(fd -e sh -x shellcheck --external-sources)
	(caddy validate)
	(pnpm -r run typecheck)
	(pnpm -r run lint)
