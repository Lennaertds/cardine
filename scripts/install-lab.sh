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

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && git rev-parse --show-toplevel 2>/dev/null || pwd)"

green()  { tput setaf 2 2>/dev/null || true; echo "$*"; tput sgr0 2>/dev/null || true; }
red()    { tput setaf 1 2>/dev/null || true; echo "$*" >&2; tput sgr0 2>/dev/null || true; }
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

check_tool "zeditor" "zeditor" "pacman -S zed / zeditor"
check_tool "bwrap"   "bwrap"   "pacman -S bubblewrap"
check_tool "node"    "node"

if command -v node &>/dev/null; then
    NODE_VER="$(node --version | sed 's/^v//')"
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

if [ -x "$JARVIS_BIN" ]; then
    green "  ✓ jarvis-server ($JARVIS_BIN)"
else
    red "  ✗ jarvis-server — niet gevonden op $JARVIS_BIN"
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

cat > "${DSH_PROFILE_DIR}/cordis.patch.yml" <<PATCHEOF
# Gegenereerd door install-lab.sh — DeepSeek V4 Flash via DeepInfra (ADR 0008).
- id: llm-pi-ai
  config:
    providers:
      deepinfra:
        baseURL: https://api.deepinfra.com/v1/openai
        api: openai-completions
        apiKeyEnv: DEEPSEEK_API_KEY
        models:
          - id: deepseek-ai/DeepSeek-V4-Flash
            name: DeepSeek V4 Flash (DeepInfra)

- id: acp
  config:
    provider: deepinfra
    model: deepseek-ai/DeepSeek-V4-Flash

- id: agent-default-model
  config:
    provider: deepinfra
    model: deepseek-ai/DeepSeek-V4-Flash

- id: tool-web
  disabled: true

# jarvis op het agent-pad (ADR 0006). Tools heten mcp__jarvis__<naam>.
- insert:
    - id: mcp-jarvis
      name: '@deepseek-ai/dsh-mcp-client'
      config:
        serverName: jarvis
        transport: stdio
        command: ${HOME}/.local/bin/jarvis-server
        cwd: ${REPO_ROOT}
        env:
          PATH: ${HOME}/.jarvis/bin:${HOME}/.local/bin:/usr/bin:/bin
        failOnStartupError: true

# Workspace-allowlist (ADR 0007).
- id: sandbox-policy
  config:
    mode: workspace-write
    workspaceRoot: !!js process.cwd()

- id: approval
  config:
    policy: ask

# Shell onder onze bwrap.
- id: sandbox
  config:
    runnerCommand:
      - ${REPO_ROOT}/scripts/cardine-bwrap
    runnerFailureSignatures:
      - 'bwrap: '

# make check aan het einde van een turn.
- insert:
    - id: slice-check
      name: cardine-slice-check
PATCHEOF

green "  ✓ ${DSH_PROFILE_DIR}/cordis.patch.yml gegenereerd"

###############################################################################
# Zed-configuratie ~/.config/zed/settings.json (JSONC-veilig)
###############################################################################
echo ""
echo "=== Zed-configuratie ==="

mkdir -p "$(dirname "$ZED_SETTINGS")"

NODE_SCRIPT='
const fs = require("fs");
const filePath = process.argv[1];
const dshPath = process.env.HOME + "/.local/bin/dsh";

function stripJsonc(text) {
    let out = "";
    let inString = false;
    let escaped = false;
    for (let i = 0; i < text.length; i++) {
        const c = text[i];
        const next = text[i + 1];
        if (inString) {
            out += c;
            if (escaped) { escaped = false; }
            else if (c === "\\") { escaped = true; }
            else if (c === "\"") { inString = false; }
        } else if (c === "\"") {
            inString = true;
            out += c;
        } else if (c === "/" && next === "/") {
            while (i < text.length && text[i] !== "\n") i++;
            out += "\n";
        } else if (c === "/" && next === "*") {
            i += 2;
            while (i < text.length && !(text[i] === "*" && text[i + 1] === "/")) i++;
            i++;
        } else {
            out += c;
        }
    }
    return out.replace(/,\s*([}\]])/g, "$1");
}

let settings = {};
if (fs.existsSync(filePath)) {
    const raw = fs.readFileSync(filePath, "utf-8").trim();
    if (raw.length > 0) {
        try {
            settings = JSON.parse(stripJsonc(raw));
        } catch (e) {
            console.error("Fout bij parsen van " + filePath + ": " + e.message);
            console.error("Afgebroken om bestaande Zed-instellingen te beschermen.");
            process.exit(1);
        }
    }
}

if (!settings.agent_servers || typeof settings.agent_servers !== "object") {
    settings.agent_servers = {};
}

const key = "DeepSeek Harness";
const existing = settings.agent_servers[key] || {};
settings.agent_servers[key] = {
    ...existing,
    default_config_options: existing.default_config_options || { reasoning_effort: "medium" },
    type: "custom",
    command: dshPath,
    args: ["--profile", "acp"],
    env: {
        ...(existing.env || {}),
        DSH_TELEMETRY_MODE: "OFF"
    }
};

fs.writeFileSync(filePath, JSON.stringify(settings, null, 2) + "\n", "utf-8");
console.log("  ✓ agent-server \"" + key + "\" ingesteld in " + filePath);
'

node -e "$NODE_SCRIPT" "$ZED_SETTINGS"

###############################################################################
# Gereed
###############################################################################
echo ""
echo "============================================================"
green "  install-lab — klaar!"
echo "============================================================"
echo ""
echo "Nog één handmatige stap (als je key nog leeg is):"
echo ""
echo "  1. Open ~/.dsh/.env en vul je DeepInfra API-key in:"
echo ""
echo "       DEEPSEEK_API_KEY=sk-..."
echo ""
echo "  2. Start in Zed een nieuwe thread 'DeepSeek Harness' in het Agent-paneel."
echo ""
