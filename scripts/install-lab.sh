#!/usr/bin/env bash
# install-lab: reproduceerbare lab-omgeving op een verse Arch Linux / Hyprland-machine.
# Idempotent: een tweede run wijzigt alleen wat nog niet klopt.
#
# Automatische installatie van dependencies via sudo pacman (indien beschikbaar).
# In een container/sandbox zonder sudo worden alleen checks gedraaid + instructies.
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
JARVIS_PYTHON="3.13"
NODE_MIN_MAJOR=24
NODE_MIN_MINOR=9

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && git rev-parse --show-toplevel 2>/dev/null || pwd)"

green()  { tput setaf 2 2>/dev/null || true; echo "$*"; tput sgr0 2>/dev/null || true; }
red()    { tput setaf 1 2>/dev/null || true; echo "$*" >&2; tput sgr0 2>/dev/null || true; }
yellow() { tput setaf 3 2>/dev/null || true; echo "$*"; tput sgr0 2>/dev/null || true; }

# Detecteer of we sudo kunnen gebruiken (op een echte Arch-machine).
SUDO=""
if command -v sudo &>/dev/null; then
    if sudo -n true 2>/dev/null; then
        SUDO="sudo"
    else
        yellow "  ~ sudo is niet beschikbaar zonder wachtwoord — handmatige installatie nodig"
    fi
fi

PACMAN_FAILED=0

pacman_install() {
    # Installeer een lijst pakketten als sudo+pacman beschikbaar is.
    # Anders alleen een melding; PACMAN_FAILED=1 — de rest van het script gaat door.
    local pkgs=("$@")
    local missing=()
    for pkg in "${pkgs[@]}"; do
        if ! pacman -Qi "$pkg" &>/dev/null; then
            missing+=("$pkg")
        fi
    done
    if [ ${#missing[@]} -eq 0 ]; then
        return 0
    fi
    if [ -n "$SUDO" ]; then
        echo "  → pacman -S --needed --noconfirm ${missing[*]}"
        $SUDO pacman -S --needed --noconfirm "${missing[@]}"
    else
        red "  ✗ ontbrekende pakketten: ${missing[*]}"
        red "    Installeer ze handmatig: sudo pacman -S --needed ${missing[*]}"
        PACMAN_FAILED=1
    fi
    return 0
}

is_arch() {
    # Check of dit een Arch Linux machine is (of afgeleide).
    [ -f /etc/arch-release ] || grep -qi '^ID=arch' /etc/os-release 2>/dev/null
    return $?
}

###############################################################################
# 1. Pacman-dependencies — alles in één sudo-aanroep
###############################################################################
echo "=== Arch Linux systeempakketten ==="

if is_arch; then
    # Lijst van mogelijke pakketten; pacman negeert wat al geïnstalleerd is.
    ARCH_PKGS=()
    # zeditor heet in pacman meestal 'zed' of 'zeditor'
    if ! command -v zeditor &>/dev/null && ! command -v zed &>/dev/null; then
        for p in zed zeditor; do
            if pacman -Si "$p" &>/dev/null 2>&1; then
                ARCH_PKGS+=("$p")
                break
            fi
        done
        if [ ${#ARCH_PKGS[@]} -eq 0 ]; then
            # We weten niet zeker hoe het heet, probeer 'zed' als default
            ARCH_PKGS+=("zed")
        fi
    else
        green "  ✓ zeditor/zed al aanwezig"
    fi
    if ! command -v bwrap &>/dev/null; then
        ARCH_PKGS+=("bubblewrap")
    else
        green "  ✓ bwrap al aanwezig"
    fi
    # node — check of pacman >= 24.9 heeft
    NEED_NODE=0
    if command -v node &>/dev/null; then
        NODE_VER="$(node --version | sed 's/^v//')"
        NODE_MAJOR="${NODE_VER%%.*}"
        NODE_MINOR="${NODE_VER#*.}"
        NODE_MINOR="${NODE_MINOR%%.*}"
        if [ "$NODE_MAJOR" -lt "$NODE_MIN_MAJOR" ] || \
           { [ "$NODE_MAJOR" -eq "$NODE_MIN_MAJOR" ] && [ "$NODE_MINOR" -lt "$NODE_MIN_MINOR" ]; }; then
            red "  ✗ node v$NODE_VER — ≥ $NODE_MIN_MAJOR.$NODE_MIN_MINOR vereist"
            NEED_NODE=1
        else
            green "  ✓ node v$NODE_VER (≥ $NODE_MIN_MAJOR.$NODE_MIN_MINOR)"
        fi
    else
        NEED_NODE=1
    fi
    if [ "$NEED_NODE" -eq 1 ]; then
        ARCH_PKGS+=("nodejs" "npm")
    fi
    # uv (Python package manager, nodig voor jarvis-mcp)
    if ! command -v uv &>/dev/null; then
        ARCH_PKGS+=("uv")
    else
        green "  ✓ uv al aanwezig"
    fi
    # jq (hulpprogramma voor setup.sh)
    if ! command -v jq &>/dev/null; then
        ARCH_PKGS+=("jq")
    else
        green "  ✓ jq al aanwezig"
    fi
    # base-devel (cargo/rustc/make/gcc — nodig voor Zoekt/scip build)
    if ! command -v cargo &>/dev/null || ! command -v go &>/dev/null; then
        ARCH_PKGS+=("base-devel" "go")
    else
        green "  ✓ build-tools (cargo, go) al aanwezig"
    fi

    if [ ${#ARCH_PKGS[@]} -gt 0 ]; then
        pacman_install "${ARCH_PKGS[@]}"
    fi
    if [ "$PACMAN_FAILED" -eq 1 ]; then
        yellow "  ~ Sommige pakketten konden niet geïnstalleerd worden (geen sudo)."
        yellow "    De rest van de setup gaat door — installeer de ontbrekende pakketten later."
    fi
else
    yellow "  ~ geen Arch Linux — sla pacman-stap over, check alleen binaries"
fi

###############################################################################
# 2. Node-versie controle (opnieuw na mogelijke installatie)
###############################################################################
echo ""
echo "=== Node.js ≥ $NODE_MIN_MAJOR.$NODE_MIN_MINOR ==="

NODE_OK=0
NODE_INSTALLED=""
if command -v node &>/dev/null; then
    NODE_VER="$(node --version | sed 's/^v//')"
    NODE_MAJOR="${NODE_VER%%.*}"
    NODE_MINOR="${NODE_VER#*.}"
    NODE_MINOR="${NODE_MINOR%%.*}"
    if [ "$NODE_MAJOR" -lt "$NODE_MIN_MAJOR" ] || \
       { [ "$NODE_MAJOR" -eq "$NODE_MIN_MAJOR" ] && [ "$NODE_MINOR" -lt "$NODE_MIN_MINOR" ]; }; then
        red "  ✗ node v$NODE_VER — te oud"
    else
        green "  ✓ node v$NODE_VER (≥ $NODE_MIN_MAJOR.$NODE_MIN_MINOR)"
        NODE_OK=1
        NODE_INSTALLED="$NODE_VER"
    fi
else
    red "  ✗ node niet op PATH"
fi

# Fallback: als pacman een te oude versie had, probeer dan fnm
if [ "$NODE_OK" -eq 0 ]; then
    INSTALLED_FALLBACK=0
    # Probeer fnm
    if command -v fnm &>/dev/null; then
        echo "  → fnm install $NODE_MIN_MAJOR"
        fnm install "$NODE_MIN_MAJOR" 2>/dev/null || true
        if command -v node &>/dev/null; then
            green "  ✓ node via fnm"
            NODE_OK=1
            INSTALLED_FALLBACK=1
        fi
    fi
    # Probeer nvm (langzamer, maar vaak aanwezig)
    if [ "$NODE_OK" -eq 0 ] && [ -d "${HOME}/.nvm" ]; then
        echo "  → nvm gebruiken voor node $NODE_MIN_MAJOR"
        export NVM_DIR="${HOME}/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        nvm install "$NODE_MIN_MAJOR" 2>/dev/null || true
        nvm use "$NODE_MIN_MAJOR" 2>/dev/null || true
        if command -v node &>/dev/null; then
            green "  ✓ node via nvm"
            NODE_OK=1
            INSTALLED_FALLBACK=1
        fi
    fi
    # Laatste redmiddel: n (simpele Node version manager)
    if [ "$NODE_OK" -eq 0 ] && command -v n &>/dev/null; then
        echo "  → n $NODE_MIN_MAJOR"
        n "$NODE_MIN_MAJOR" 2>/dev/null || true
        if command -v node &>/dev/null; then
            green "  ✓ node via n"
            NODE_OK=1
            INSTALLED_FALLBACK=1
        fi
    fi
    if [ "$NODE_OK" -eq 0 ]; then
        red "  ✗ Geen manier gevonden om Node ≥ $NODE_MIN_MAJOR.$NODE_MIN_MINOR te installeren."
        red "    Installeer handmatig: https://nodejs.org of via fnm/nvm/n"
    fi
fi

###############################################################################
# 3. jarvis-server installeren (als hij nog niet op PATH staat)
###############################################################################
echo ""
echo "=== jarvis-server ==="

if [ -x "$JARVIS_BIN" ]; then
    green "  ✓ jarvis-server ($JARVIS_BIN)"
else
    echo "  → jarvis-server installeren via uv tool install --python $JARVIS_PYTHON jarvis-mcp"

    # Eerst check of uv beschikbaar is
    if ! command -v uv &>/dev/null; then
        red "  ✗ uv niet gevonden. Installeer uv: curl -LsSf https://astral.sh/uv/install.sh | sh"
        red "    of via: sudo pacman -S uv"
        exit 1
    fi

    # Python 3.13 nodig — check of uv die kan vinden
    if ! uv python find "$JARVIS_PYTHON" &>/dev/null; then
        echo "  → Python $JARVIS_PYTHON niet gevonden, installeren via uv python install"
        uv python install "$JARVIS_PYTHON" 2>&1 || {
            red "  ✗ kon Python $JARVIS_PYTHON niet installeren via uv"
            red "    Installeer python3.13 handmatig"
            exit 1
        }
    fi

    # Installeer jarvis-mcp
    uv tool install --python "$JARVIS_PYTHON" jarvis-mcp 2>&1 || {
        red "  ✗ uv tool install jarvis-mcp mislukt"
        exit 1
    }

    # Controleer of jarvis nu op PATH staat (uv tool install zet in ~/.local/bin)
    if ! command -v jarvis &>/dev/null || ! [ -x "$JARVIS_BIN" ]; then
        # uv tools zitten in ~/.local/bin, voeg toe aan PATH voor de rest van dit script
        export PATH="${HOME}/.local/bin:${PATH}"
    fi
    if [ -x "$JARVIS_BIN" ]; then
        green "  ✓ jarvis-server geïnstalleerd ($JARVIS_BIN)"
    else
        red "  ✗ jarvis-server nog niet gevonden op $JARVIS_BIN na installatie"
        exit 1
    fi

    # Nu de Zoekt/SCIP setup draaien (buildt Zoekt binary en scip binary)
    echo "  → setup.sh --only zoekt --only scip (buildt Zoekt + SCIP, duurt even)"
    # setup.sh zit in de jarvis-mcp package
    JARVIS_SETUP="$(uv tool list 2>/dev/null | grep jarvis-mcp | head -1 | awk '{print $NF}')/setup.sh" || true
    if [ -z "$JARVIS_SETUP" ] || [ ! -f "$JARVIS_SETUP" ]; then
        # Alternatief: vind setup.sh via python -m jarvis_mcp
        JARVIS_SETUP="$(python3 -m jarvis_mcp.setup 2>/dev/null || true)"
        if [ -z "$JARVIS_SETUP" ] || [ ! -f "$JARVIS_SETUP" ]; then
            # Zoek in de uv tool install dir
            JARVIS_SETUP="$(find "${HOME}/.local/share/uv" -name setup.sh -path '*/jarvis*' 2>/dev/null | head -1)" || true
        fi
    fi
    if [ -n "$JARVIS_SETUP" ] && [ -f "$JARVIS_SETUP" ]; then
        echo "    - setup.sh gevonden: $JARVIS_SETUP"
        bash "$JARVIS_SETUP" --only zoekt --only scip 2>&1 || {
            red "  ✗ setup.sh --only zoekt --only scip mislukt"
            red "    (Controleer of build-dependencies (base-devel, go) correct zijn geïnstalleerd)"
            exit 1
        }
        green "  ✓ Zoekt + SCIP build voltooid"
    else
        yellow "  ~ setup.sh niet gevonden; Zoekt/SCIP mogelijk al aanwezig of handmatig nodig"
        yellow "    jarvis-server werkt ook zonder — alleen searchCode via Zoekt niet"
    fi
fi

###############################################################################
# 4. DeepSeek Harness (alleen als de gepinde versie nog niet staat)
###############################################################################
echo ""
echo "=== DeepSeek Harness ==="

if [ -x "$DSH_BIN" ] && "$DSH_BIN" --version 2>/dev/null | grep -q "0.2.2-rc.1"; then
    green "  ✓ dsh al geïnstalleerd op $DSH_BIN"
else
    echo "  → dsh installeren: npm install -g --prefix \"$DSH_PREFIX\" $DSH_VERSION"
    mkdir -p "$DSH_PREFIX/bin"
    npm install -g --prefix "$DSH_PREFIX" "$DSH_VERSION"
    if [ -x "$DSH_BIN" ]; then
        green "  ✓ dsh geïnstalleerd op $DSH_BIN"
    else
        # Probeer npm link als de binary niet in bin/ staat
        DSH_ALT="$(find "$DSH_PREFIX/lib/node_modules/@deepseek-ai/dsh" -name 'dsh' -type f 2>/dev/null | head -1)"
        if [ -n "$DSH_ALT" ] && [ ! -x "$DSH_BIN" ]; then
            ln -sf "$DSH_ALT" "$DSH_BIN"
            green "  ✓ dsh gelinkt naar $DSH_BIN"
        else
            red "  ✗ dsh binary niet gevonden na installatie"
        fi
    fi
fi

###############################################################################
# 5. ~/.dsh/.env aanmaken (nooit overschrijven)
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
# 6. DSH ACP-profiel ~/.dsh/profiles/acp/cordis.patch.yml
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
# 7. Zed-configuratie ~/.config/zed/settings.json (JSONC-veilig)
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
echo "  3. Optioneel: indexeer deze repo met:"
echo ""
echo "       cd ${REPO_ROOT}"
echo "       ~/.local/bin/jarvis index"
echo ""