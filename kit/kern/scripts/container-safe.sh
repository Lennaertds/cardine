#!/bin/bash
# container-safe.sh — shell-functies voor npm/pip/cargo in Podman-containers
#
# Dit script wordt aangeroepen door make container-setup en schrijft de
# functies naar ~/.config/shell/container-safe.sh. De agent gebruikt deze
# functies in plaats van npm/pip/cargo direct op de host.
#
# Gebruik (door de agent, niet door de mens):
#   npm-safe install
#   pip-install-safe -r requirements.txt
#   cargo-safe build
#
# Zie docs/how-to/container-safe.md
set -euo pipefail

FUNC_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/shell"
FUNC_FILE="$FUNC_DIR/container-safe.sh"
MARKER="# container-safe.sh — gegenereerd, niet handmatig wijzigen"

# Alleen schrijven als het nog niet bestaat of verouderd is
if [ -f "$FUNC_FILE" ] && grep -q "$MARKER" "$FUNC_FILE" 2>/dev/null; then
	echo "container-safe.sh: functies staan al in $FUNC_FILE"
	exit 0
fi

mkdir -p "$FUNC_DIR"

cat > "$FUNC_FILE" << 'SHELLFUNCTIONS'
# container-safe.sh — gegenereerd, niet handmatig wijzigen
# Source in je shell rc: source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/container-safe.sh"
# npm/pip/cargo in Podman-containers — nooit op de host.

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

# Offline varianten (geen netwerk in container)
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

echo "container-safe.sh: functies geschreven naar $FUNC_FILE"
echo ""
echo "  Voeg dit toe aan je shell rc om ze beschikbaar te maken:"
echo "    source $FUNC_FILE"
echo ""
echo "  Of als Podman niet geïnstalleerd is, installeer het eerst:"
echo "    sudo pacman -S podman   # Arch"
echo "    brew install podman     # macOS"
echo "    sudo apt install podman # Debian/Ubuntu"