# Spec — lab-macos

> **Role:** Get `packages/lab/` working on macOS (Intel and Apple Silicon).

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** open

## Goal

`install-lab.sh` installs the lab stack on macOS via Homebrew. `cardine-bwrap` is skipped (bwrap does not exist on macOS). `cardine-status.sh` recognises macOS and skips Linux-specific checks. The Zed config uses the macOS path.

## Scope

- **In:** `install-lab.sh` (brew detection, Zed install via brew, Zed config path), `cardine-status.sh` (macOS detection, skip the bwrap check), `docs/cardine-lab.md`
- **Out of scope:** Linux-specific things (separate spec), Windows, bwrap/sandbox on macOS

## Base — what stays the same as Linux

| Part | Why |
|-----------|--------|
| Node.js install | Via fnm/nvm/n, or via brew |
| `uv` + jarvis-mcp | Via `uv tool install`, cross-platform |
| DSH (DeepSeek Harness) | `npm install -g`, cross-platform |
| `cardine-slice-check/` | Node module, OS independent |
| DSH ACP profile | YAML generation, identical |
| Creating the DSH `.env` | Identical |
| Zoekt/SCIP build | Go build works on macOS (if Go is installed) |
| `scripts/` tool scripts | Bash with POSIX commands, work on macOS |

## What changes on macOS

| Aspect | Linux (Arch) | macOS |
|--------|-------------|-------|
| **Package manager** | `pacman` | `brew` (Homebrew) |
| **sudo needed?** | Yes, for pacman | No, brew works without sudo |
| **bwrap** | `bubblewrap` via pacman | **Does not exist** — skip the sandbox |
| **Zed** | `pacman -S zed` | `brew install --cask zed` |
| **Zed config pad** | `~/.config/zed/settings.json` | `~/Library/Application Support/Zed/settings.json` |
| **systemd** | Available | **Does not exist** — no timers |
| **build-essential** | `base-devel` | Xcode Command Line Tools (`xcode-select --install`) |
| **Go** | `go` via pacman | `brew install go` |
| **Architecture** | x86_64 | x86_64 (Intel) + arm64 (Apple Silicon) |

## What is missing on macOS (and why that is fine)

| Missing | Consequence | Solution |
|------------|--------|-----------|
| `bwrap` / `cardine-bwrap` | No sandbox for the agent shell | DSH profile: skip the `sandbox` section. Document: "macOS has no equivalent sandbox — the agent shell runs natively." |
| `systemd` | No digest timers | Timers are optional. On macOS: `launchd` agents if needed. |
| `pacman` | No system packages via this script | Everything via brew |

## Approach per slice

### Slice 1 — macOS detection + brew install

- [ ] `is_macos()` functie: `[ "$(uname)" = "Darwin" ]`
- [ ] Homebrew check: `command -v brew` — if not present, fail with install instructions
- [ ] `install_with_brew()` function: calls `brew install $@`
- [ ] Extend the existing Arch block in `install-lab.sh` with an `elif is_macos; then` branch
- [ ] On macOS: brew installs Zed, node, uv, jq, go

```bash
is_macos() {
  [ "$(uname)" = "Darwin" ]
}

install_with_brew() {
  local pkgs=("$@")
  local missing=()
  for pkg in "${pkgs[@]}"; do
    if ! brew list "$pkg" &>/dev/null 2>&1; then
      missing+=("$pkg")
    fi
  done
  if [ ${#missing[@]} -gt 0 ]; then
    echo "  → brew install ${missing[*]}"
    brew install "${missing[@]}"
  fi
}
```

### Slice 2 — macOS-specific dependencies

Which brew packages you need:

```bash
MACOS_PKGS=()
if ! command -v zed &>/dev/null && ! command -v zeditor &>/dev/null; then
  MACOS_PKGS+=("--cask zed")
fi
if ! command -v bwrap &>/dev/null; then
  yellow "  ~ bwrap does not exist on macOS — sandbox disabled"
fi
# node
if ! command -v node &>/dev/null; then
  MACOS_PKGS+=("node")
fi
# uv
if ! command -v uv &>/dev/null; then
  MACOS_PKGS+=("uv")
fi
# jq
if ! command -v jq &>/dev/null; then
  MACOS_PKGS+=("jq")
fi
# go (for the Zoekt/SCIP build)
if ! command -v go &>/dev/null; then
  MACOS_PKGS+=("go")
fi
```

- [ ] macOS dependency list in `install-lab.sh`
- [ ] Xcode CLI tools check: `xcode-select -p` — if not found, a message with `xcode-select --install`

### Slice 3 — macOS: no bwrap, no sandbox

`cardine-bwrap` makes no sense on macOS. The DSH profile must **not** set the sandbox runner.

- [ ] In `install-lab.sh`: on macOS do **not** generate the `sandbox` section in `cordis.patch.yml`
- [ ] jarvis-server wrapper: on macOS symlink resolution is no problem (no bwrap), so no wrapper is needed
- [ ] In `cardine-status.sh`: skip the bwrap check on macOS — `warn` with "macOS: bwrap not available"

```yaml
# In the DSH profile on macOS: no sandbox runner, no wrapper.
# Shell commands run natively.
```

### Slice 4 — macOS Zed config path

Current: hardcoded `~/.config/zed/settings.json` (line 22 in `cardine-status.sh`, line 18 in `install-lab.sh`).

Op macOS: `~/Library/Application Support/Zed/settings.json`

- [ ] A `zed_settings_path()` function that returns the right path per OS:

```bash
zed_settings_path() {
  if is_macos; then
    echo "${HOME}/Library/Application Support/Zed/settings.json"
  else
    echo "${HOME}/.config/zed/settings.json"
  fi
}
```

- [ ] Replace the `ZED_SETTINGS` variable in `install-lab.sh` and `cardine-status.sh` with a call to `zed_settings_path()`

### Slice 5 — Zoekt/SCIP: Go build on macOS

Zoekt and SCIP are built with Go. That works on macOS as long as Go is installed (via brew). The build steps in `install-lab.sh` are already cross-platform (`go install`, `git clone`, `npm install`). No change needed — only Go must be available.

- [ ] Test whether `setup.sh` (from jarvis-mcp) works on macOS
- [ ] The fallback (manual Zoekt/SCIP build) works unchanged

### Slice 6 — `cardine-status.sh` macOS aware

- [ ] `is_macos()` functie
- [ ] Skip the bwrap check (§3): `if ! is_macos; then ... check bwrap ...`
- [ ] Sandbox detection (§0) on macOS: `warn` "sandbox: macOS has no bwrap — agent shell runs natively"
- [ ] Zed path (§4 check): uses `zed_settings_path()`
- [ ] DSH_HOME check (§10): works unchanged on macOS (`~/.dsh`)

### Slice 7 — Update the docs

- [ ] `docs/cardine-lab.md`: extend the audience to macOS
- [ ] README.md: a "brew-based install on macOS" section
- [ ] `CHANGELOG.md`: `0.2.0` entry

## Architecture notes (Apple Silicon vs Intel)

- Zoekt/SCIP Go build: cross-architecture, Go generates a native binary for `uname -m`
- jarvis via uv: Python + platform wheels, works on arm64
- DSH via npm: Node cross-platform, works on arm64
- Zed on macOS: `brew install --cask zed` installs the right arch
- **No extra work** — everything is already multi-arch thanks to Go/Node/brew

## Do not do (deliberately later)

- A bwrap-like sandbox on macOS (use `sandbox-exec` or Docker) — too heavy for the lab
- `launchd` timers as a systemd replacement — only once digest feeds are needed
- Windows — no bash/npm/uv pipeline

## Touchpoints

- `packages/lab/install-lab.sh` — main script
- `packages/lab/cardine-status.sh` — macOS checks
- `packages/lab/cardine-bwrap` — unchanged, not used on macOS
- `packages/lab/docs/cardine-lab.md` — update the docs
- `packages/lab/README.md` — install instructions

## Acceptance

- [ ] `make check` is green
- [ ] `bash packages/lab/install-lab.sh` recognises macOS and uses brew
- [ ] `bash packages/lab/install-lab.sh` configures Zed at the right path
- [ ] `bash packages/lab/install-lab.sh` skips bwrap + sandbox on macOS
- [ ] `bash packages/lab/cardine-status.sh` works on macOS without errors (bwrap check skipped)
- [ ] DSH start op macOS (`dsh --profile acp` init)
- [ ] Zed-config staat op `~/Library/Application Support/Zed/settings.json`