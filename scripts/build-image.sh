#!/usr/bin/env bash
set -euo pipefail

NIX="nix --extra-experimental-features nix-command --extra-experimental-features flakes"
ATTR=".#${1?}"

if [[ "$(uname)" == "Linux" ]]; then
  $NIX build "$ATTR"
  docker load < result
  exit
fi

VM="${ORBSTACK_VM:-nixos}"
# shellcheck disable=SC2029
IMAGE_OUT_PATH=$(ssh "$VM@orb" "cd '$(pwd)' && $NIX build $ATTR --print-out-paths --no-link")
IMAGE_TMP_PATH=$(mktemp)
trap 'rm -f "$IMAGE_TMP_PATH"' EXIT
scp "$VM@orb:$IMAGE_OUT_PATH" "$IMAGE_TMP_PATH"
docker load < "$IMAGE_TMP_PATH"
