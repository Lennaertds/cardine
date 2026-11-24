#!/bin/bash
# ──────────────────────────────────────────────────────
# install-container-safe.sh
# Installeert Podman + shell-functies voor container-safe
# npm/pip/cargo op Arch Linux.
#
# Gebruik: bash install-container-safe.sh
# Droppen op je echte Arch-systeem en runnen.
# ──────────────────────────────────────────────────────

set -euo pipefail

echo "==> Container-safe package installer voor Arch Linux"
echo ""

# ── 1. Podman installeren ──
if command -v podman &>/dev/null; then
    echo "[OK] Podman is al geïnstalleerd: $(podman --version)"
else
    echo "==> Podman installeren..."
    sudo pacman -S --noconfirm podman
    echo "[OK] Podman geïnstalleerd"
fi

# ── 2. Basis images pullen ──
IMAGES=(
    "docker.io/library/node:23-slim"
    "docker.io/library/python:3.12-slim"
    "docker.io/library/rust:latest"
)

echo ""
echo "==> Container images pullen (één keer, kan even duren)..."
for img in "${IMAGES[@]}"; do
    name="$(basename "$img" | cut -d: -f1)"
    if podman image exists "$img" 2>/dev/null; then
        echo "   [OK] $name image bestaat al"
    else
        echo "   -> $name pullen..."
        podman pull "$img"
        echo "   [OK] $name pulled"
    fi
done

# ── 3. Apart functiebestand aanmaken ──
FUNC_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/shell"
FUNC_FILE="$FUNC_DIR/container-safe.sh"
mkdir -p "$FUNC_DIR"

cat > "$FUNC_FILE" << 'SHELLFUNCTIONS'
# container-safe functies — gegenereerd door install-container-safe.sh
# npm/pip/cargo in Podman containers — nooit op de host.
# Source dit bestand in je shell rc: source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/container-safe.sh"

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

echo ""
echo "==> Container-safe functies geschreven naar $FUNC_FILE"
echo ""
echo "  Voeg dit toe aan je shell rc (bv. ~/sync/dotfiles/zshrc):"
echo ""
echo "    source $FUNC_FILE"
echo ""

# ── 4. Test ──
echo ""
echo "==> Testen of podman werkt..."
if podman run --rm docker.io/library/hello-world 2>&1 | grep -q "Hello from Docker!"; then
    echo "[OK] Podman werkt correct"
else
    echo "[WAARSCHUWING] Podman test liep anders dan verwacht. Check 'podman run --rm docker.io/library/hello-world'"
fi

# ── 5. Afronden ──
echo ""
echo "============================================"
echo "  Installatie compleet!"
echo "============================================"
echo ""
echo "Wat nu?"
echo "  1. Herlaad je shell: source ~/.zshrc  (of .bashrc)"
echo "  2. Gebruik:"
echo "     cd my-project && npm-safe install"
echo "     cd my-project && pip-install-safe -r requirements.txt"
echo "     cd my-project && cargo-safe build"
echo ""
echo "  3. Voor AUR packages in container:"
echo "     sudo pacman -S distrobox"
echo "     distrobox create --name aurbox --image docker.io/library/archlinux:latest"
echo ""
echo "  Volledige docs: data/howto-container-sandbox.md"
echo "============================================"
