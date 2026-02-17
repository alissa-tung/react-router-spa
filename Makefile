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
	(fd Caddyfile -X caddy fmt --overwrite --config)

lint:
	(fd -e sh -X shellcheck --external-sources)
	(fd Caddyfile -X caddy validate --config)
	(pnpm -r run typecheck)
	(pnpm -r run lint)
