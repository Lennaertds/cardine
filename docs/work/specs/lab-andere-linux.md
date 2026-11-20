# Spec — lab-andere-linux

> **Rol:** `packages/lab/` werkend krijgen op andere Linux-distributies naast Arch — Debian/Ubuntu, Fedora, openSUSE.

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** open

## Doel

`install-lab.sh` installeert de lab-stack niet alleen op Arch Linux via `pacman`, maar ook op Debian/Ubuntu (`apt`), Fedora (`dnf`) en openSUSE (`zypper`). `cardine-status.sh` herkent die distributies. `cardine-bwrap` werkt ongewijzigd (bwrap is overal hetzelfde).

## Scope

- **In:** `install-lab.sh` (package-manager abstractie, Zed-installatie per distro), `cardine-status.sh` (distro-herkenning), `docs/cardine-lab.md`
- **Buiten scope:** macOS (aparte spec), Windows, embedded Linux, distro's zonder systemd

## Basis — wat blijft gelijk aan Arch

| Onderdeel | Waarom |
|-----------|--------|
| Node.js installatie | Via fnm/nvm/n, niet via distro-pakketbeheer |
| `uv` + jarvis-mcp | Via `uv tool install`, cross-distro |
| DSH (DeepSeek Harness) | `npm install -g`, cross-distro |
| `cardine-bwrap` | bwrap binary heet overal `bubblewrap` of `bwrap` |
| `cardine-slice-check/` | Node-module, OS-onafhankelijk |
| DSH ACP-profiel | YAML-generatie, identiek |
| DSH `.env` aanmaken | Identiek |
| `systemd/` timers | Werkt op elke distro met systemd |

## Wat verandert per distro

| Aspect | Arch | Debian/Ubuntu | Fedora | openSUSE |
|--------|------|---------------|--------|----------|
| **Package manager** | `pacman` | `apt` | `dnf` | `zypper` |
| **sudo commando** | `sudo pacman -S` | `sudo apt install -y` | `sudo dnf install -y` | `sudo zypper install -y` |
| **bubblewrap package** | `bubblewrap` | `bubblewrap` | `bubblewrap` | `bubblewrap` |
| **Zed package** | `zed` / `zeditor` | `.deb` download | `.rpm` download | `.rpm` download |
| **nodejs package** | `nodejs` `npm` | `nodejs` `npm` | `nodejs` `npm` | `nodejs` `npm` |
| **uv package** | `uv` | `uv` (of `pipx`) | `uv` (of `pipx`) | `uv` (of `pipx`) |
| **jq** | `jq` | `jq` | `jq` | `jq` |
| **base-devel/go** | `base-devel` `go` | `build-essential` `golang-go` | `@development-tools` `golang` | `patterns-devel-base-devel` `go` |

## Aanpak per slice

### Slice 1 — Distro-detectie + package-manager abstractie

Huidig: `is_arch()` + `pacman_install()`.
Gewenst: één functie `distro_id()` die `arch`, `debian`, `fedora`, `opensuse` teruggeeft, en één functie `pkg_install()` die de juiste manager kiest.

```bash
distro_id() {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
      arch|archarm)           echo "arch";;
      debian|ubuntu|pop|linuxmint) echo "debian";;
      fedora|rhel|centos)     echo "fedora";;
      opensuse*|suse)         echo "opensuse";;
      *)                      echo "unknown";;
    esac
  elif [ -f /etc/arch-release ]; then
    echo "arch"
  else
    echo "unknown"
  fi
}
```

`pkg_install()` roept op basis van `distro_id` het juiste commando aan:
- **arch:** `sudo pacman -S --needed --noconfirm $@`
- **debian:** `sudo apt install -y $@`
- **fedora:** `sudo dnf install -y $@`
- **opensuse:** `sudo zypper install -y $@`

- [ ] `distro_id()` functie in `install-lab.sh`
- [ ] `pkg_install()` functie die per distro de juiste manager aanroept
- [ ] Bestaande `is_arch()` en `pacman_install()` vervangen
- [ ] `PACMAN_FAILED` hernoemen naar `PKG_FAILED` (general)
- [ ] Label "Arch Linux systeempakketten" → "Systeempakketten"

### Slice 2 — Per-distro package-namen

Niet elk package heet hetzelfde in elke distro. Maak een mapping:

```bash
pkg_map() {
  local name="$1"
  case "$DISTRO" in
    arch)     pkg_arch "$name";;
    debian)   pkg_debian "$name";;
    fedora)   pkg_fedora "$name";;
    opensuse) pkg_opensuse "$name";;
    *)        echo "$name";;
  esac
}
```

| Generieke naam | Arch | Debian | Fedora | openSUSE |
|----------------|------|--------|--------|----------|
| `bubblewrap` | `bubblewrap` | `bubblewrap` | `bubblewrap` | `bubblewrap` |
| `nodejs` | `nodejs` `npm` | `nodejs` `npm` | `nodejs` `npm` | `nodejs` `npm` |
| `uv` | `uv` | `uv` | `uv` | `uv` |
| `jq` | `jq` | `jq` | `jq` | `jq` |
| `build-essential` | `base-devel` | `build-essential` | `@development-tools` | `patterns-devel-base-devel` |
| `go` | `go` | `golang-go` | `golang` | `go` |

- [ ] `pkg_map()` functie in `install-lab.sh`
- [ ] Alle `ARCH_PKGS+=()` vervangen door `pkg_append bubblewrap nodejs uv jq build-essential go`

### Slice 3 — Zed-installatie per distro

Huidig: alleen `pacman -S zed`. Voor andere distro's moet Zed van GitHub releases komen.

```bash
install_zed() {
  case "$DISTRO" in
    arch)
      pkg_install "zed" ;;
    debian)
      # Download .deb van GitHub
      local url="https://github.com/zed-industries/zed/releases/latest/download/zed-linux-x86_64.deb"
      local tmp="$(mktemp -d)"
      cd "$tmp"
      curl -fsSLO "$url"
      sudo dpkg -i zed-linux-x86_64.deb
      rm -rf "$tmp" ;;
    fedora|opensuse)
      # Download .rpm
      local url="https://github.com/zed-industries/zed/releases/latest/download/zed-linux-x86_64.rpm"
      local tmp="$(mktemp -d)"
      cd "$tmp"
      curl -fsSLO "$url"
      sudo rpm -i zed-linux-x86_64.rpm
      rm -rf "$tmp" ;;
  esac
}
```

- [ ] `install_zed()` functie
- [ ] Voor Arch blijft `pacman -S zed`, voor anderen GitHub release download
- [ ] Fallback als GitHub download faalt: melding met handmatige instructies
- [ ] ARM64-ondersteuning? (voorlopig alleen x86_64)

### Slice 4 — `cardine-status.sh` distro-aware maken

- [ ] `distro_id()` toevoegen in `cardine-status.sh`
- [ ] bwrap-check werkt op alle Linux-distributies (bwrap is overal `bwrap`)
- [ ] Zed-pad check blijft `~/.config/zed/settings.json` (geldt voor alle Linux)
- [ ] Extra check: is de package-manager beschikbaar? (alleen `warn`)

### Slice 5 — Docs bijwerken

- [ ] `docs/cardine-lab.md`: doelgroep uitbreiden naar "Arch, Debian/Ubuntu, Fedora, openSUSE"
- [ ] README.md: installatie-instructies per distro
- [ ] CHANGELOG.md: `0.2.0` entry

## Testen

- [ ] `bash packages/lab/install-lab.sh` — mag niet crashen op niet-Arch; geeft melding "herkende distro: ..."
- [ ] `bash packages/lab/cardine-status.sh` — toont distro in output
- [ ] `make check` groen
- [ ] (Optioneel) testen in Docker-container per distro

## Raakvlakken

- `packages/lab/install-lab.sh` — hoofdscript, grootste wijzigingen
- `packages/lab/cardine-status.sh` — distro-check
- `packages/lab/docs/cardine-lab.md` — docs updaten
- `packages/lab/README.md` — installatie-instructies

## Acceptatie

- [ ] `make check` groen
- [ ] `bash packages/lab/install-lab.sh` draait op Arch zonder regressie (pacman-stap werkt)
- [ ] `bash packages/lab/install-lab.sh` herkent Debian/Ubuntu, Fedora, openSUSE en geeft juiste meldingen
- [ ] Zed-installatie op niet-Arch downloadt van GitHub en installeert (getest in Docker)
- [ ] `cardine-status.sh` herkent de distro en toont deze
- [ ] bwrap-check werkt op alle Linux