#!/bin/bash
# container-safe.sh — shell functions for npm/pip/cargo in Podman containers
#
# Called by make container-setup; writes the functions to
# ~/.config/shell/container-safe.sh. The agent uses these functions
# instead of npm/pip/cargo directly on the host.
#
# Usage (by the agent, not by the human):
#   npm-safe install
#   pip-install-safe -r requirements.txt
#   cargo-safe build
#
# See docs/how-to/container-safe.md
set -euo pipefail

FUNC_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/shell"
FUNC_FILE="$FUNC_DIR/container-safe.sh"
MARKER="# container-safe.sh — generated, do not edit by hand"

# Only write if it does not exist yet or is out of date
if [ -f "$FUNC_FILE" ] && grep -q "$MARKER" "$FUNC_FILE" 2>/dev/null; then
	echo "container-safe.sh: functions are already in $FUNC_FILE"
	exit 0
fi

mkdir -p "$FUNC_DIR"

cat > "$FUNC_FILE" << 'SHELLFUNCTIONS'
# container-safe.sh — generated, do not edit by hand
# Source in your shell rc: source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/container-safe.sh"
# npm/pip/cargo in Podman containers — never on the host.

npm-safe() {
  local img="${NPM_IMAGE:-docker.io/library/node:23-slim}"
  podman run --rm -it --network host -v "$PWD:/app:Z" -w /app "$img" npm "$@"
}

pnpm-safe() {
  local img="${PNPM_IMAGE:-docker.io/library/node:23-slim}"
  podman run --rm -it --network host -v "$PWD:/app:Z" -w /app "$img" sh -c "corepack enable && pnpm $*"
}

pip-safe() {
  local img="${PIP_IMAGE:-docker.io/library/python:3.12-slim}"
  podman run --rm -it --network host -v "$PWD:/app:Z" -w /app "$img" pip "$@"
}

pip-install-safe() {
  local img="${PIP_IMAGE:-docker.io/library/python:3.12-slim}"
  podman run --rm -it --network host -v "$PWD:/app:Z" -w /app "$img" sh -c "pip install $*"
}

cargo-safe() {
  local img="${CARGO_IMAGE:-docker.io/library/rust:latest}"
  podman run --rm -it --network host -v "$PWD:/app:Z" -w /app "$img" cargo "$@"
}

cargo-build-safe() {
  local img="${CARGO_IMAGE:-docker.io/library/rust:latest}"
  podman run --rm -it --network host -v "$PWD:/app:Z" -w /app "$img" cargo build "$@"
}

node-safe() {
  local img="${NODE_IMAGE:-docker.io/library/node:23-slim}"
  podman run --rm -it --network host -v "$PWD:/app:Z" -w /app "$img" node "$@"
}

python-safe() {
  local img="${PYTHON_IMAGE:-docker.io/library/python:3.12-slim}"
  podman run --rm -it --network host -v "$PWD:/app:Z" -w /app "$img" python "$@"
}

# Offline variants (no network in the container)
npm-safe-offline() {
  local img="${NPM_IMAGE:-docker.io/library/node:23-slim}"
  podman run --rm -it --network none -v "$PWD:/app:Z" -w /app "$img" npm "$@"
}

pip-safe-offline() {
  local img="${PIP_IMAGE:-docker.io/library/python:3.12-slim}"
  podman run --rm -it --network none -v "$PWD:/app:Z" -w /app "$img" pip "$@"
}

cargo-safe-offline() {
  local img="${CARGO_IMAGE:-docker.io/library/rust:latest}"
  podman run --rm -it --network none -v "$PWD:/app:Z" -w /app "$img" cargo "$@"
}
SHELLFUNCTIONS

echo "container-safe.sh: functions written to $FUNC_FILE"
echo ""
echo "  Add this to your shell rc to make them available:"
echo "    source $FUNC_FILE"
echo ""
echo "  Or, if Podman is not installed, install it first:"
echo "    sudo pacman -S podman   # Arch"
echo "    brew install podman     # macOS"
echo "    sudo apt install podman # Debian/Ubuntu"