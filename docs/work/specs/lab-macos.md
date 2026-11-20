# Spec — lab-macos

> **Rol:** `packages/lab/` werkend krijgen op macOS (Intel en Apple Silicon).

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** open

## Doel

`install-lab.sh` installeert de lab-stack op macOS via Homebrew. `cardine-bwrap` wordt overgeslagen (bwrap bestaat niet op macOS). `cardine-status.sh` herkent macOS en slaat Linux-specifieke checks over. Zed-config gebruikt het macOS-pad.

## Scope

- **In:** `install-lab.sh` (brew-detectie, Zed-installatie via brew, Zed-config pad), `cardine-status.sh` (macOS-herkenning, bwrap-check overslaan), `docs/cardine-lab.md`
- **Buiten scope:** Linux-specifieke dingen (aparte spec), Windows, bwrap/sandbox op macOS

## Basis — wat blijft gelijk aan Linux

| Onderdeel | Waarom |
|-----------|--------|
| Node.js installatie | Via fnm/nvm/n, of via brew |
| `uv` + jarvis-mcp | Via `uv tool install`, cross-platform |
| DSH (DeepSeek Harness) | `npm install -g`, cross-platform |
| `cardine-slice-check/` | Node-module, OS-onafhankelijk |
| DSH ACP-profiel | YAML-generatie, identiek |
| DSH `.env` aanmaken | Identiek |
| Zoekt/SCIP build | Go build werkt op macOS (mits Go geïnstalleerd) |
| `scripts/` tool-scripts | Bash met POSIX-commando's, werken op macOS |

## Wat verandert op macOS

| Aspect | Linux (Arch) | macOS |
|--------|-------------|-------|
| **Package manager** | `pacman` | `brew` (Homebrew) |
| **sudo nodig?** | Ja, voor pacman | Nee, brew werkt zonder sudo |
| **bwrap** | `bubblewrap` via pacman | **Bestaat niet** — sandbox overslaan |
| **Zed** | `pacman -S zed` | `brew install --cask zed` |
| **Zed config pad** | `~/.config/zed/settings.json` | `~/Library/Application Support/Zed/settings.json` |
| **systemd** | Beschikbaar | **Bestaat niet** — geen timers |
| **build-essential** | `base-devel` | Xcode Command Line Tools (`xcode-select --install`) |
| **Go** | `go` via pacman | `brew install go` |
| **Architectuur** | x86_64 | x86_64 (Intel) + arm64 (Apple Silicon) |

## Wat ontbreekt op macOS (en waarom ok)

| Ontbrekend | Gevolg | Oplossing |
|------------|--------|-----------|
| `bwrap` / `cardine-bwrap` | Geen sandbox voor agent-shell | DSH-profiel: `sandbox`-sectie overslaan. Documenteren: "macOS heeft geen equivalente sandbox — agent-shell draait native." |
| `systemd` | Geen digest-timers | Timers zijn optioneel. Op macOS: `launchd`-agents als het nodig is. |
| `pacman` | Geen systeempakketten via dit script | Alles via brew |

## Aanpak per slice

### Slice 1 — macOS-herkenning + brew-installatie

- [ ] `is_macos()` functie: `[ "$(uname)" = "Darwin" ]`
- [ ] Homebrew check: `command -v brew` — als niet aanwezig, faal met installatie-instructies
- [ ] `install_with_brew()` functie: roept `brew install $@` aan
- [ ] Bestaand Arch-blok in `install-lab.sh` uitbreiden met `elif is_macos; then` tak
- [ ] Op macOS: brew installeert Zed, node, uv, jq, go

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

### Slice 2 — macOS-specifieke dependencies

Welke brew-packages heb je nodig:

```bash
MACOS_PKGS=()
if ! command -v zed &>/dev/null && ! command -v zeditor &>/dev/null; then
  MACOS_PKGS+=("--cask zed")
fi
if ! command -v bwrap &>/dev/null; then
  yellow "  ~ bwrap bestaat niet op macOS — sandbox uitgeschakeld"
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
# go (voor Zoekt/SCIP build)
if ! command -v go &>/dev/null; then
  MACOS_PKGS+=("go")
fi
```

- [ ] macOS dependency lijst in `install-lab.sh`
- [ ] Xcode CLI tools check: `xcode-select -p` — als niet gevonden, melding met `xcode-select --install`

### Slice 3 — macOS: geen bwrap, geen sandbox

`cardine-bwrap` slaat nergens op op macOS. Het DSH-profiel moet de sandbox-runner **niet** instellen.

- [ ] In `install-lab.sh`: op macOS de `sandbox`-sectie in `cordis.patch.yml` **niet** genereren
- [ ] jarvis-server wrapper: op macOS is symlink-resolutie geen probleem (geen bwrap), dus wrapper is niet nodig
- [ ] In `cardine-status.sh`: bwrap-check overslaan op macOS — `warn` met "macOS: bwrap niet beschikbaar"

```yaml
# In DSH-profiel op macOS: geen sandbox-runner, geen wrapper.
# shell-commando's draaien native.
```

### Slice 4 — macOS Zed-config pad

Huidig: hardcoded `~/.config/zed/settings.json` (regel 22 in `cardine-status.sh`, regel 18 in `install-lab.sh`).

Op macOS: `~/Library/Application Support/Zed/settings.json`

- [ ] Functie `zed_settings_path()` die per OS het juiste pad teruggeeft:

```bash
zed_settings_path() {
  if is_macos; then
    echo "${HOME}/Library/Application Support/Zed/settings.json"
  else
    echo "${HOME}/.config/zed/settings.json"
  fi
}
```

- [ ] `ZED_SETTINGS` variabele in `install-lab.sh` en `cardine-status.sh` vervangen door aanroep van `zed_settings_path()`

### Slice 5 — Zoekt/SCIP: Go build op macOS

Zoekt en SCIP worden gebouwd met Go. Dat werkt op macOS zolang Go geïnstalleerd is (via brew). De build-stappen in `install-lab.sh` zijn al cross-platform (`go install`, `git clone`, `npm install`). Geen wijziging nodig — alleen Go moet beschikbaar zijn.

- [ ] Test of `setup.sh` (van jarvis-mcp) werkt op macOS
- [ ] Fallback (handmatige Zoekt/SCIP build) werkt ongewijzigd

### Slice 6 — `cardine-status.sh` macOS-aware

- [ ] `is_macos()` functie
- [ ] bwrap-check (§3) overslaan: `if ! is_macos; then ... check bwrap ...`
- [ ] sandbox-detectie (§0) op macOS: `warn` "sandbox: macOS heeft geen bwrap — agent-shell draait native"
- [ ] Zed-pad (§4 check): gebruikt `zed_settings_path()`
- [ ] DSH_HOME check (§10): werkt ongewijzigd op macOS (`~/.dsh`)

### Slice 7 — Docs bijwerken

- [ ] `docs/cardine-lab.md`: doelgroep uitbreiden naar macOS
- [ ] README.md: "brew-based installatie op macOS" sectie
- [ ] `CHANGELOG.md`: `0.2.0` entry

## Architectuurnoten (Apple Silicon vs Intel)

- Zoekt/SCIP Go build: cross-architectuur, Go genereert native binary voor `uname -m`
- jarvis via uv: Python + platform wheels, werkt op arm64
- DSH via npm: Node cross-platform, werkt op arm64
- Zed op macOS: `brew install --cask zed` installeert de juiste arch
- **Geen extra werk** — alles is al multi-arch dankzij Go/Node/brew

## Niet doen (bewust later)

- bwrap-achtige sandbox op macOS (gebruik `sandbox-exec` of Docker) — te zwaar voor lab
- `launchd`-timers als systemd-vervanger — pas als digest-feeds nodig zijn
- Windows — geen bash/npm/uv-pipeline

## Raakvlakken

- `packages/lab/install-lab.sh` — hoofdscript
- `packages/lab/cardine-status.sh` — macOS-checks
- `packages/lab/cardine-bwrap` — ongewijzigd, wordt niet gebruikt op macOS
- `packages/lab/docs/cardine-lab.md` — docs updaten
- `packages/lab/README.md` — installatie-instructies

## Acceptatie

- [ ] `make check` groen
- [ ] `bash packages/lab/install-lab.sh` herkent macOS en gebruikt brew
- [ ] `bash packages/lab/install-lab.sh` configureert Zed op het juiste pad
- [ ] `bash packages/lab/install-lab.sh` slaat bwrap + sandbox over op macOS
- [ ] `bash packages/lab/cardine-status.sh` werkt op macOS zonder fouten (bwrap-check overgeslagen)
- [ ] DSH start op macOS (`dsh --profile acp` init)
- [ ] Zed-config staat op `~/Library/Application Support/Zed/settings.json`