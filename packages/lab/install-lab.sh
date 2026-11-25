#!/usr/bin/env bash
# install-lab: reproducible lab environment on a fresh Arch Linux / Hyprland machine.
# Idempotent: a second run only changes what is not right yet.
#
# Automatic installation of dependencies via sudo pacman (if available).
# In a container/sandbox without sudo, only checks run + instructions are printed.
set -euo pipefail

###############################################################################
# Configuration
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

# Determine REPO_ROOT = the project you install the lab for.
# That is the git root of the cwd (the project that is open), not this script's
# folder: after `npm i -g` the script sits in the npm prefix, and ../.. would
# point at the prefix — then workspaceRoot, cwd and the plugins would land there.
REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

green()  { tput setaf 2 2>/dev/null || true; echo "$*"; tput sgr0 2>/dev/null || true; }
red()    { tput setaf 1 2>/dev/null || true; echo "$*" >&2; tput sgr0 2>/dev/null || true; }
yellow() { tput setaf 3 2>/dev/null || true; echo "$*"; tput sgr0 2>/dev/null || true; }

# Detect whether we can use sudo (on a real Arch machine).
SUDO=""
if command -v sudo &>/dev/null; then
    if [ -t 0 ]; then
        # Interactive TTY: we can use sudo — pacman_install will ask for a
        # password if needed (--noconfirm is set).
        SUDO="sudo"
    else
        # No TTY (CI/CD, pipe, etc.) — only a NOPASSWD rule works.
        if sudo -n true 2>/dev/null; then
            SUDO="sudo"
        else
            yellow "  ~ sudo is not available without a password — manual install needed"
        fi
    fi
fi

PACMAN_FAILED=0

pacman_install() {
    # Install a list of packages if sudo+pacman is available.
    # Otherwise just a message; PACMAN_FAILED=1 — the rest of the script continues.
    local pkgs=("$@")
    local missing=()
    local pkg
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
        # A failed pacman run must not let the script through silently.
        if ! $SUDO pacman -S --needed --noconfirm "${missing[@]}"; then
            red "  ✗ pacman -S failed for: ${missing[*]}"
            PACMAN_FAILED=1
        fi
    else
        red "  ✗ missing packages: ${missing[*]}"
        red "    Install them by hand: sudo pacman -S --needed ${missing[*]}"
        PACMAN_FAILED=1
    fi
    return 0
}

is_arch() {
    # Check whether this is an Arch Linux machine (or a derivative).
    [ -f /etc/arch-release ] || grep -qi '^ID=arch' /etc/os-release 2>/dev/null
    return $?
}

###############################################################################
# 1. Pacman dependencies — everything in one sudo call
###############################################################################
echo "=== Arch Linux system packages ==="

if is_arch; then
    # List of candidate packages; pacman ignores what is already installed.
    ARCH_PKGS=()
    # zeditor is usually called 'zed' or 'zeditor' in pacman
    if ! command -v zeditor &>/dev/null && ! command -v zed &>/dev/null; then
        for p in zed zeditor; do
            if pacman -Si "$p" &>/dev/null 2>&1; then
                ARCH_PKGS+=("$p")
                break
            fi
        done
        if [ ${#ARCH_PKGS[@]} -eq 0 ]; then
            # We are not sure of the name, try 'zed' as the default
            ARCH_PKGS+=("zed")
        fi
    else
        green "  ✓ zeditor/zed already present"
    fi
    if ! command -v bwrap &>/dev/null; then
        ARCH_PKGS+=("bubblewrap")
    else
        green "  ✓ bwrap already present"
    fi
    # node — check whether pacman has >= 24.9
    NEED_NODE=0
    if command -v node &>/dev/null; then
        NODE_VER="$(node --version | sed 's/^v//')"
        NODE_MAJOR="${NODE_VER%%.*}"
        NODE_MINOR="${NODE_VER#*.}"
        NODE_MINOR="${NODE_MINOR%%.*}"
        if [ "$NODE_MAJOR" -lt "$NODE_MIN_MAJOR" ] || \
           { [ "$NODE_MAJOR" -eq "$NODE_MIN_MAJOR" ] && [ "$NODE_MINOR" -lt "$NODE_MIN_MINOR" ]; }; then
            red "  ✗ node v$NODE_VER — ≥ $NODE_MIN_MAJOR.$NODE_MIN_MINOR required"
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
    # uv (Python package manager, needed for jarvis-mcp)
    if ! command -v uv &>/dev/null; then
        ARCH_PKGS+=("uv")
    else
        green "  ✓ uv already present"
    fi
    # jq (helper for setup.sh)
    if ! command -v jq &>/dev/null; then
        ARCH_PKGS+=("jq")
    else
        green "  ✓ jq already present"
    fi
    # base-devel (cargo/rustc/make/gcc — needed for the Zoekt/scip build)
    if ! command -v cargo &>/dev/null || ! command -v go &>/dev/null; then
        ARCH_PKGS+=("base-devel" "go")
    else
        green "  ✓ build tools (cargo, go) already present"
    fi

    if [ ${#ARCH_PKGS[@]} -gt 0 ]; then
        pacman_install "${ARCH_PKGS[@]}"
    fi
    if [ "$PACMAN_FAILED" -eq 1 ]; then
        yellow "  ~ Some packages could not be installed (no sudo)."
        yellow "    The rest of the setup continues — install the missing packages later."
    fi
else
    yellow "  ~ not Arch Linux — skipping the pacman step, checking binaries only"
fi

###############################################################################
# 2. Node version check (again after a possible install)
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
        red "  ✗ node v$NODE_VER — too old"
    else
        green "  ✓ node v$NODE_VER (≥ $NODE_MIN_MAJOR.$NODE_MIN_MINOR)"
        NODE_OK=1
        NODE_INSTALLED="$NODE_VER"
    fi
else
    red "  ✗ node not on PATH"
fi

# Fallback: if pacman had too old a version, try fnm
if [ "$NODE_OK" -eq 0 ]; then
    INSTALLED_FALLBACK=0
    # Try fnm
    if command -v fnm &>/dev/null; then
        echo "  → fnm install $NODE_MIN_MAJOR"
        fnm install "$NODE_MIN_MAJOR" 2>/dev/null || true
        if command -v node &>/dev/null; then
            green "  ✓ node via fnm"
            NODE_OK=1
            INSTALLED_FALLBACK=1
        fi
    fi
    # Try nvm (slower, but often present)
    if [ "$NODE_OK" -eq 0 ] && [ -d "${HOME}/.nvm" ]; then
        echo "  → using nvm for node $NODE_MIN_MAJOR"
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
    # Last resort: n (a simple Node version manager)
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
        red "  ✗ No way found to install Node ≥ $NODE_MIN_MAJOR.$NODE_MIN_MINOR."
        red "    Install by hand: https://nodejs.org or via fnm/nvm/n"
    fi
fi

###############################################################################
# 3. Install jarvis-server (if it is not on PATH yet)
###############################################################################
echo ""
echo "=== jarvis-server ==="

if [ -x "$JARVIS_BIN" ]; then
    green "  ✓ jarvis-server ($JARVIS_BIN)"
else
    echo "  → installing jarvis-server via uv tool install --python $JARVIS_PYTHON jarvis-mcp"

    # First check that uv is available
    if ! command -v uv &>/dev/null; then
        red "  ✗ uv not found. Install uv: curl -LsSf https://astral.sh/uv/install.sh | sh"
        red "    or via: sudo pacman -S uv"
        exit 1
    fi

    # Python 3.13 needed — check that uv can find it
    if ! uv python find "$JARVIS_PYTHON" &>/dev/null; then
        echo "  → Python $JARVIS_PYTHON not found, installing via uv python install"
        uv python install "$JARVIS_PYTHON" 2>&1 || {
            red "  ✗ could not install Python $JARVIS_PYTHON via uv"
            red "    Install python3.13 by hand"
            exit 1
        }
    fi

    # Install jarvis-mcp
    uv tool install --python "$JARVIS_PYTHON" jarvis-mcp 2>&1 || {
        red "  ✗ uv tool install jarvis-mcp failed"
        exit 1
    }

    # Check that jarvis is on PATH now (uv tool install writes to ~/.local/bin)
    if ! command -v jarvis &>/dev/null || ! [ -x "$JARVIS_BIN" ]; then
        # uv tools live in ~/.local/bin, add it to PATH for the rest of this script
        export PATH="${HOME}/.local/bin:${PATH}"
    fi
    if [ -x "$JARVIS_BIN" ]; then
        green "  ✓ jarvis-server installed ($JARVIS_BIN)"
    else
        red "  ✗ jarvis-server still not found at $JARVIS_BIN after install"
        exit 1
    fi

    # Create a wrapper for jarvis-server (bwrap cannot follow symlinks)
    # Find the real jarvis-server binary via uv tool list
    JARVIS_REAL_PATH=""
    if command -v uv &>/dev/null; then
        JARVIS_REAL_PATH="$(uv tool list 2>/dev/null | grep jarvis-mcp | head -1 | awk '{print $NF}' || true)"
    fi
    if [ -z "$JARVIS_REAL_PATH" ] || [ ! -f "$JARVIS_REAL_PATH" ]; then
        # Fallback: search with find
        JARVIS_REAL_PATH="$(find "${HOME}/.local/share/uv/tools" -name 'jarvis-server' -type f 2>/dev/null | head -1 || true)"
    fi
    if [ -z "$JARVIS_REAL_PATH" ]; then
        # Last attempt: use realpath on the symlink
        JARVIS_REAL_PATH="$(realpath "${HOME}/.local/bin/jarvis-server" 2>/dev/null || echo "")"
    fi
    if [ -n "$JARVIS_REAL_PATH" ] && [ ! -f "${HOME}/.local/bin/jarvis-server-wrapper.sh" ]; then
        echo "  → creating the jarvis-server wrapper for ${JARVIS_REAL_PATH}"
        cat > "${HOME}/.local/bin/jarvis-server-wrapper.sh" << WRAPPEREOF
#!/usr/bin/env bash
# Wrapper for jarvis-server — resolves symlinks for bwrap.
exec ${JARVIS_REAL_PATH} "\$@"
WRAPPEREOF
        chmod +x "${HOME}/.local/bin/jarvis-server-wrapper.sh"
        green "  ✓ jarvis-server-wrapper.sh created (→ ${JARVIS_REAL_PATH})"
    else
        green "  ✓ jarvis-server-wrapper.sh already exists"
    fi

    # Now run the Zoekt/SCIP setup (builds the Zoekt and scip binaries)
    JARVIS_BIN_DIR="${HOME}/.jarvis/bin"
    mkdir -p "$JARVIS_BIN_DIR"

    # setup.sh ships inside the jarvis-mcp package — unfortunately uv tool install
    # does not always include it. Try to find it; if that fails, build Zoekt
    # and SCIP by hand.
    JARVIS_SETUP=""
    for candidate in \
        "$(uv tool list 2>/dev/null | grep jarvis-mcp | head -1 | awk '{print $NF}')/setup.sh" \
        "$(python3 -m jarvis_mcp.setup 2>/dev/null || true)" \
        "$(find "${HOME}/.local/share/uv" -name setup.sh -path '*/jarvis*' 2>/dev/null | head -1)"; do
        if [ -n "$candidate" ] && [ -f "$candidate" ]; then
            JARVIS_SETUP="$candidate"
            break
        fi
    done

    if [ -n "$JARVIS_SETUP" ]; then
        echo "  → setup.sh --only zoekt --only scip (builds Zoekt + SCIP, takes a while)"
        echo "    - setup.sh found: $JARVIS_SETUP"
        bash "$JARVIS_SETUP" --only zoekt --only scip 2>&1 || {
            red "  ✗ setup.sh --only zoekt --only scip failed"
            red "    (Check that the build dependencies (base-devel, go) are installed correctly)"
            exit 1
        }
        green "  ✓ Zoekt + SCIP build finished"
    else
        yellow "  ~ setup.sh not found — building Zoekt/SCIP by hand"
        # ---------- Zoekt (git-index + webserver) ----------
        if [ ! -x "${JARVIS_BIN_DIR}/zoekt-git-index" ] || [ ! -x "${JARVIS_BIN_DIR}/zoekt-webserver" ]; then
            echo "    → building Zoekt (go install github.com/zoekt/zoekt/...@33f1f18af292)"
            GOBIN="$JARVIS_BIN_DIR" go install \
              github.com/zoekt/zoekt/cmd/zoekt-git-index@33f1f18af292 \
              github.com/zoekt/zoekt/cmd/zoekt-webserver@33f1f18af292 2>&1 || {
                red "  ✗ Zoekt build failed"
                exit 1
            }
            green "  ✓ zoekt-git-index, zoekt-webserver built"
        else
            green "  ✓ zoekt binaries already present"
        fi
        # ---------- SCIP (Go) ----------
        if [ ! -x "${JARVIS_BIN_DIR}/scip" ]; then
            echo "    → building SCIP (git clone sourcegraph/scip)"
            SCIP_TMP="$(mktemp -d)"
            git clone --depth 1 https://github.com/sourcegraph/scip.git "$SCIP_TMP" 2>&1 || {
                red "  ✗ scip git clone failed"
                rm -rf "$SCIP_TMP"
                exit 1
            }
            GOWORK=off GOBIN="$JARVIS_BIN_DIR" go build -o "$JARVIS_BIN_DIR/scip" ./cmd/scip 2>&1 || {
                red "  ✗ scip build failed"
                rm -rf "$SCIP_TMP"
                exit 1
            }
            rm -rf "$SCIP_TMP"
            green "  ✓ scip built"
        else
            green "  ✓ scip binary already present"
        fi
        # ---------- scip-python (npm) ----------
        if [ ! -x "${JARVIS_BIN_DIR}/scip-python" ]; then
            echo "    → installing scip-python (npm)"
            npm install -g --prefix "$JARVIS_BIN_DIR" @sourcegraph/scip-python 2>&1 || {
                yellow "  ~ scip-python npm install failed (can be done by hand later)"
            }
            # npm --prefix writes to bin/node_modules/.bin, symlink it into bin/
            if [ -f "${JARVIS_BIN_DIR}/bin/scip-python" ] && [ ! -e "${JARVIS_BIN_DIR}/scip-python" ]; then
                ln -sf "${JARVIS_BIN_DIR}/bin/scip-python" "${JARVIS_BIN_DIR}/scip-python"
            fi
            if [ -x "${JARVIS_BIN_DIR}/scip-python" ]; then
                green "  ✓ scip-python installed"
            else
                yellow "  ~ scip-python not available"
            fi
        else
            green "  ✓ scip-python already present"
        fi
    fi
fi

###############################################################################
# 4. DeepSeek Harness (only if the pinned version is not there yet)
###############################################################################
echo ""
echo "=== DeepSeek Harness ==="

if [ -x "$DSH_BIN" ] && "$DSH_BIN" --version 2>/dev/null | grep -q "0.2.2-rc.1"; then
    green "  ✓ dsh already installed at $DSH_BIN"
else
    echo "  → installing dsh: npm install -g --prefix \"$DSH_PREFIX\" $DSH_VERSION"
    mkdir -p "$DSH_PREFIX/bin"
    # In npm v11+ (Node 26) postinstall scripts are blocked by default.
    # Give explicit permission for the five packages that need postinstall.
    npm install -g --prefix "$DSH_PREFIX" \
      --allow-scripts='@deepseek-ai/dsh-subprocess-local,koffi,node-pty,@google/genai,protobufjs' \
      "$DSH_VERSION"
    if [ -x "$DSH_BIN" ]; then
        green "  ✓ dsh installed at $DSH_BIN"
    else
        # Try npm link if the binary is not in bin/
        DSH_ALT="$(find "$DSH_PREFIX/lib/node_modules/@deepseek-ai/dsh" -name 'dsh' -type f 2>/dev/null | head -1)"
        if [ -n "$DSH_ALT" ] && [ ! -x "$DSH_BIN" ]; then
            ln -sf "$DSH_ALT" "$DSH_BIN"
            green "  ✓ dsh linked to $DSH_BIN"
        else
            red "  ✗ dsh binary not found after install"
        fi
    fi
fi

###############################################################################
# 5. Create ~/.dsh/.env (never overwrite)
###############################################################################
echo ""
echo "=== Credentials placeholder ==="

mkdir -p "${HOME}/.dsh"

if [ -f "$DSH_ENV_FILE" ]; then
    yellow "  ~ already exists: $DSH_ENV_FILE (not overwritten)"
    if grep -q '^DEEPSEEK_API_KEY=' "$DSH_ENV_FILE" 2>/dev/null; then
        EXISTING_KEY="$(grep '^DEEPSEEK_API_KEY=' "$DSH_ENV_FILE" | head -1 | cut -d= -f2)"
        if [ -n "$EXISTING_KEY" ]; then
            green "  ✓ DEEPSEEK_API_KEY is already filled in"
        else
            yellow "  ! DEEPSEEK_API_KEY= is empty — fill in the key"
        fi
    fi
else
    echo "DEEPSEEK_API_KEY=" > "$DSH_ENV_FILE"
    chmod 600 "$DSH_ENV_FILE"
    green "  ✓ $DSH_ENV_FILE created (chmod 600)"
fi

###############################################################################
# 6. DSH ACP profile ~/.dsh/profiles/acp/cordis.patch.yml
###############################################################################
echo ""
echo "=== DSH ACP profile ==="

mkdir -p "$DSH_PROFILE_DIR"

cat > "${DSH_PROFILE_DIR}/cordis.patch.yml" <<PATCHEOF
# Generated by install-lab.sh — DeepSeek V4 Flash via DeepInfra (ADR 0008).
- id: llm-pi-ai
  config:
    providers:
      deepinfra:
        baseURL: https://api.deepinfra.com/v1/openai
        api: openai-completions
        apiKeyEnv: DEEPSEEK_API_KEY
        models:
          - id: deepseek-ai/DeepSeek-V4.1-Flash-1017
            name: DeepSeek V4.1 Flash 1017 (DeepInfra)
          # Existing threads keep this id in modelSelection. Without this
          # row pi-ai refuses with UNKNOWN_MODEL as soon as such a thread resumes.
          - id: deepseek-ai/DeepSeek-V4-Flash
            name: DeepSeek V4 Flash (DeepInfra)
          - id: deepseek-ai/DeepSeek-V4-Flash-0731
            name: DeepSeek V4 Flash 0731 (DeepInfra)
          - id: deepseek-ai/DeepSeek-V3.2
            name: DeepSeek V3.2 (DeepInfra)

- id: acp
  config:
    provider: deepinfra
    model: deepseek-ai/DeepSeek-V4.1-Flash-1017

- id: agent-default-model
  config:
    provider: deepinfra
    model: deepseek-ai/DeepSeek-V4.1-Flash-1017

- id: tool-web
  disabled: true

- id: tool-todo
  disabled: true

- id: tool-goal
  disabled: true

# jarvis on the agent path (ADR 0006). Tools are named mcp__jarvis__<name>.
- insert:
    - id: mcp-jarvis
      name: '@deepseek-ai/dsh-mcp-client'
      config:
        serverName: jarvis
        transport: stdio
        # Wrapper instead of a symlink — bwrap cannot follow symlinks.
        command: ${HOME}/.local/bin/jarvis-server-wrapper.sh
        cwd: ${REPO_ROOT}
        env:
          PATH: ${HOME}/.jarvis/bin:${HOME}/.local/bin:/usr/bin:/bin
        failOnStartupError: true

# Workspace-allowlist (ADR 0007 + ADR 0017).
# The cage is the only write right. workspaceRoot is the fallback for a
# session without a cwd. The guard follows the cwd of the open session.
- id: sandbox-policy
  config:
    mode: workspace-write
    workspaceRoot: ${REPO_ROOT}

# Safety net for this lab environment: never an approval dialog.
# Upstream will get policy: auto later (a Zed demand, without a fork). Until then
# never is the lab choice (ADR 0017): deterministic, before the dialog.
- id: approval
  config:
    policy: never

# Read only. dsh-tool-fs leaves write and edit out when false; applyPatch
# is already off upstream and we turn it off explicitly here.
- id: tool-fs
  config:
    read: true
    readImage: true
    write: false
    edit: false
    applyPatch: false

# glob/grep stay on and go through the workspace guard.
- id: tool-fs-search
  disabled: false

# Shell under our bwrap. The network stays open (ADR 0017).
- id: sandbox
  config:
    runnerCommand:
      - ${REPO_ROOT}/packages/lab/cardine-bwrap
    runnerFailureSignatures:
      - 'bwrap: '

# make check at the end of a turn.
- insert:
    - id: slice-check
      name: ${REPO_ROOT}/packages/lab/cardine-slice-check/index.js
    # Read boundary for read/read_image/glob/grep (ADR 0016 + 0017).
    # The guard takes the session's cwd. The Zed server sets no workspace pin.
    - id: secrets-guard
      name: ${REPO_ROOT}/packages/lab/cardine-secrets-guard/index.js
PATCHEOF

green "  ✓ ${DSH_PROFILE_DIR}/cordis.patch.yml generated"

###############################################################################
# 7. Zed configuration ~/.config/zed/settings.json (JSONC-safe)
###############################################################################
echo ""
echo "=== Zed configuration ==="

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
            console.error("Error parsing " + filePath + ": " + e.message);
            console.error("Aborted to protect the existing Zed settings.");
            process.exit(1);
        }
    }
}

if (!settings.agent_servers || typeof settings.agent_servers !== "object") {
    settings.agent_servers = {};
}

const key = "DeepSeek Harness";
const existing = settings.agent_servers[key] || {};
const env = { ...(existing.env || {}) };
delete env.CARDINE_WORKSPACE;
env.PATH = process.env.HOME + "/.jarvis/bin:" + process.env.HOME + "/.local/bin:/usr/bin:/bin";
env.DSH_TELEMETRY_MODE = "OFF";
settings.agent_servers[key] = {
    ...existing,
    type: "custom",
    command: dshPath,
    args: ["--profile", "acp"],
    env: env
};

fs.writeFileSync(filePath, JSON.stringify(settings, null, 2) + "\n", "utf-8");
console.log("  ✓ agent server \"" + key + "\" configured in " + filePath);
'

node -e "$NODE_SCRIPT" "$ZED_SETTINGS"

###############################################################################
# Done
###############################################################################
echo ""
echo "============================================================"
green "  install-lab — done!"
echo "============================================================"
echo ""
echo "One manual step left (if your key is still empty):"
echo ""
echo "  1. Open ~/.dsh/.env and fill in your DeepInfra API key:"
echo ""
echo "       DEEPSEEK_API_KEY=sk-..."
echo ""
echo "  2. In Zed, start a new thread 'DeepSeek Harness' in the Agent panel."
echo ""
echo "  3. Optional: index this repo with:"
echo ""
echo "       cd ${REPO_ROOT}"
echo "       ~/.local/bin/jarvis index \"\$(pwd)\" --no-semantic"
echo ""
echo "     (Without --no-semantic jarvis tries to build a semantic index,"
echo "      which needs a multi-GB model weight downloaded.)"
echo ""
