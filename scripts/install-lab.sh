#!/usr/bin/env bash
# install-lab: reproduceerbare lab-omgeving op een verse Arch Linux / Hyprland-machine.
# Idempotent: een tweede run wijzigt alleen wat nog niet klopt.
set -euo pipefail

###############################################################################
# Configuratie
###############################################################################
DSH_VERSION="@deepseek-ai/dsh@0.2.2-rc.1"
DSH_PREFIX="${HOME}/.local"
DSH_BIN="${DSH_PREFIX}/bin/dsh"
JARVIS_BIN="${HOME}/.local/bin/jarvis-server"
DSH_ENV_FILE="${HOME}/.dsh/.env"
DSH_PROFILE_DIR="${HOME}/.dsh/profiles/acp"
ZED_SETTINGS="${HOME}/.config/zed/settings.json"

# Bepaal repo-root (waar deze script in scripts/ staat)
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && git rev-parse --show-toplevel 2>/dev/null || pwd)"

# Helper: groen/rood/geel
green() { tput setaf 2 2>/dev/null || true; echo "$*"; tput sgr0 2>/dev/null || true; }
red()   { tput setaf 1 2>/dev/null || true; echo "$*" >&2; tput sgr0 2>/dev/null || true; }
yellow() { tput setaf 3 2>/dev/null || true; echo "$*"; tput sgr0 2>/dev/null || true; }

###############################################################################
# Controleer vereiste tools
###############################################################################
echo "=== Dependencies check ==="

MISSING=0

check_tool() {
    local name="$1"
    local binary="$2"
    local hint="${3:-}"
    if command -v "$binary" &>/dev/null; then
        green "  ✓ $name ($(command -v "$binary"))"
    else
        red "  ✗ $name — niet gevonden${hint:+ ($hint)}"
        MISSING=1
    fi
}

check_tool "zeditor" "zeditor" "Installeer bv. via pacman -S zeditor of flatpak"
check_tool "bwrap"   "bwrap"   "pacman -S bubblewrap"
check_tool "node"    "node"

# Node-versie ≥ 24.9
if command -v node &>/dev/null; then
    NODE_VER="$(node --version | sed 's/^v//')"
    # Vergelijk major.minor
    NODE_MAJOR="${NODE_VER%%.*}"
    NODE_MINOR="${NODE_VER#*.}"
    NODE_MINOR="${NODE_MINOR%%.*}"
    if [ "$NODE_MAJOR" -lt 24 ] || { [ "$NODE_MAJOR" -eq 24 ] && [ "$NODE_MINOR" -lt 9 ]; }; then
        red "  ✗ node v$NODE_VER — ≥ 24.9 vereist"
        MISSING=1
    else
        green "  ✓ node v$NODE_VER (≥ 24.9)"
    fi
fi

# jarvis-server
if [ -x "$JARVIS_BIN" ]; then
    green "  ✓ jarvis-server ($JARVIS_BIN)"
else
    red "  ✗ jarvis-server — niet gevonden op $JARVIS_BIN. Installeer via het jarvis-setup-script."
    MISSING=1
fi

if [ "$MISSING" -eq 1 ]; then
    red "\n=== Ontbrekende tools gevonden. Los ze op en draai het script opnieuw. ==="
    exit 1
fi

###############################################################################
# DSH installeren (alleen als de gepinde versie nog niet staat)
###############################################################################
echo ""
echo "=== DeepSeek Harness ==="

INSTALLED_DSH=""
if [ -x "$DSH_BIN" ]; then
    INSTALLED_DSH="$("$DSH_BIN" --version 2>/dev/null || true)"
fi

# Check of de juiste versie geïnstalleerd is (kijk naar @0.2.2-rc.1)
if echo "$INSTALLED_DSH" | grep -q "0.2.2-rc.1"; then
    green "  ✓ dsh $INSTALLED_DSH al geïnstalleerd"
else
    echo "  → dsh installeren: npm install -g --prefix \"$DSH_PREFIX\" $DSH_VERSION"
    npm install -g --prefix "$DSH_PREFIX" "$DSH_VERSION"
    green "  ✓ dsh geïnstalleerd"
fi

###############################################################################
# ~/.dsh/.env aanmaken (nooit overschrijven)
###############################################################################
echo ""
echo "=== Credentials placeholder ==="

mkdir -p "${HOME}/.dsh"

if [ -f "$DSH_ENV_FILE" ]; then
    yellow "  ~ bestaat al: $DSH_ENV_FILE (niet overschreven)"
    if grep -q '^DEEPSEEK_API_KEY=' "$DSH_ENV_FILE" 2>/dev/null; then
        EXISTING_KEY="$(grep '^DEEPSEEK_API_KEY=' "$DSH_ENV_FILE" | head -1 | cut -d= -f2)"
        if [ -n "$EXISTING_KEY" ]; then
            green "  ✓ DEEPSEEK_API_KEY staat al ingevuld"
        else
            yellow "  ! DEEPSEEK_API_KEY= staat leeg — vul de key in"
        fi
    fi
else
    echo "DEEPSEEK_API_KEY=" > "$DSH_ENV_FILE"
    chmod 600 "$DSH_ENV_FILE"
    green "  ✓ $DSH_ENV_FILE aangemaakt (chmod 600)"
fi

###############################################################################
# DSH ACP-profiel ~/.dsh/profiles/acp/cordis.patch.yml
###############################################################################
echo ""
echo "=== DSH ACP-profiel ==="

mkdir -p "$DSH_PROFILE_DIR"

# Dynamische paden
DASH_SLICE_CHECK="${REPO_ROOT}/scripts/cardine-slice-check"
DASH_BWRAP="${REPO_ROOT}/scripts/cardine-bwrap"

cat > "${DSH_PROFILE_DIR}/cordis.patch.yml" <<PATCHEOF
# Gegenereerd door install-lab.sh — overschrijf niet handmatig.
# Provider: DeepInfra, model deepseek-ai/DeepSeek-V4-Flash.

llm-pi-ai:
  -
    provider: deepinfra
    baseURL: "https://api.deepinfra.com/v1/openai"
    api: openai-completions
    apiKeyEnv: DEEPSEEK_API_KEY
    model: deepseek-ai/DeepSeek-V4-Flash

acp:
  agent-default-model:
    provider: deepinfra
    model: deepseek-ai/DeepSeek-V4-Flash

tool-web:
  disabled: true

mcp-jarvis:
  plugin: "@deepseek-ai/dsh-mcp-client"
  command: "${HOME}/.local/bin/jarvis-server"
  cwd: "${REPO_ROOT}"
  env:
    PATH: "${HOME}/.jarvis/bin:${PATH}"

sandbox-policy:
  mode: "workspace-write"

approval:
  mode: "ask"

sandbox:
  plugin: "@deepseek-ai/dsh-sandbox-bubblewrap"
  runner: "${DASH_BWRAP}"

cardine-slice-check:
  plugin: "@deepseek-ai/dsh-slice-check"
  runner: "${DASH_SLICE_CHECK}"
PATCHEOF

green "  ✓ ${DSH_PROFILE_DIR}/cordis.patch.yml gegenereerd"

###############################################################################
# Zed-configuratie ~/.config/zed/settings.json
###############################################################################
echo ""
echo "=== Zed-configuratie ==="

mkdir -p "$(dirname "$ZED_SETTINGS")"

# Gebruik node om settings.json te patchen (behoudt bestaande user-settings)
NODE_SCRIPT='
const fs = require("fs");
const path = require("path");
const filePath = process.argv[1];
const home = process.env.HOME;
const dshPath = home + "/.local/bin/dsh";

let settings = {};
if (fs.existsSync(filePath)) {
    try {
        settings = JSON.parse(fs.readFileSync(filePath, "utf-8"));
    } catch (e) {
        console.error("Fout bij lezen " + filePath + ": " + e.message + " — start met leeg object");
        settings = {};
    }
}

if (!settings.agent_servers) {
    settings.agent_servers = {};
}

const key = "DeepSeek Harness";
settings.agent_servers[key] = {
    "type": "custom",
    "command": dshPath,
    "args": ["--profile", "acp"],
    "env": {
        "DSH_TELEMETRY_MODE": "OFF"
    }
};

fs.writeFileSync(filePath, JSON.stringify(settings, null, 2) + "\n", "utf-8");
console.log("✓ agent-server \"" + key + "\" ingesteld in " + filePath);
'

node -e "$NODE_SCRIPT" "$ZED_SETTINGS"

green "  ✓ $ZED_SETTINGS bijgewerkt"

###############################################################################
# Gereed
###############################################################################
echo ""
echo "============================================================"
green "  install-lab — klaar!"
echo "============================================================"
echo ""
echo "Nog één handmatige stap:"
echo ""
echo "  1. Open ~/.dsh/.env en vul je DeepInfra API-key in:"
echo ""
echo "       DEEPSEEK_API_KEY=sk-..."
echo ""
echo "  2. Herlaad Zed en start een nieuwe thread 'DeepSeek Harness'"
echo "     in het Agent-paneel."
echo ""
echo "  3. Optioneel: indexeer deze repo met:"
echo ""
echo "       cd ${REPO_ROOT}"
echo "       ~/.local/bin/jarvis index"
echo ""
echo "Het lab-pad is nu klaar. Veel succes!"
echo ""