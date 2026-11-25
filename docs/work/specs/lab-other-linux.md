# Spec — lab-other-linux

> **Role:** Get `packages/lab/` working on other Linux distributions next to Arch — Debian/Ubuntu, Fedora, openSUSE.

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** open

## Goal

`install-lab.sh` installs the lab stack not only on Arch Linux via `pacman`, but also on Debian/Ubuntu (`apt`), Fedora (`dnf`) and openSUSE (`zypper`). `cardine-status.sh` recognises those distributions. `cardine-bwrap` works unchanged (bwrap is the same everywhere).

## Scope

- **In:** `install-lab.sh` (package-manager abstraction, Zed install per distro), `cardine-status.sh` (distro detection), `docs/cardine-lab.md`
- **Out of scope:** macOS (separate spec), Windows, embedded Linux, distros without systemd

## Base — what stays the same as Arch

| Part | Why |
|-----------|--------|
| Node.js install | Via fnm/nvm/n, not via distro package management |
| `uv` + jarvis-mcp | Via `uv tool install`, cross-distro |
| DSH (DeepSeek Harness) | `npm install -g`, cross-distro |
| `cardine-bwrap` | the bwrap binary is called `bubblewrap` or `bwrap` everywhere |
| `cardine-slice-check/` | Node module, OS independent |
| DSH ACP profile | YAML generation, identical |
| Creating the DSH `.env` | Identical |
| `systemd/` timers | Works on every distro with systemd |

## What changes per distro

| Aspect | Arch | Debian/Ubuntu | Fedora | openSUSE |
|--------|------|---------------|--------|----------|
| **Package manager** | `pacman` | `apt` | `dnf` | `zypper` |
| **sudo command** | `sudo pacman -S` | `sudo apt install -y` | `sudo dnf install -y` | `sudo zypper install -y` |
| **bubblewrap package** | `bubblewrap` | `bubblewrap` | `bubblewrap` | `bubblewrap` |
| **Zed package** | `zed` / `zeditor` | `.deb` download | `.rpm` download | `.rpm` download |
| **nodejs package** | `nodejs` `npm` | `nodejs` `npm` | `nodejs` `npm` | `nodejs` `npm` |
| **uv package** | `uv` | `uv` (of `pipx`) | `uv` (of `pipx`) | `uv` (of `pipx`) |
| **jq** | `jq` | `jq` | `jq` | `jq` |
| **base-devel/go** | `base-devel` `go` | `build-essential` `golang-go` | `@development-tools` `golang` | `patterns-devel-base-devel` `go` |

## Approach per slice

### Slice 1 — Distro detection + package-manager abstraction

Current: `is_arch()` + `pacman_install()`.
Wanted: one `distro_id()` function that returns `arch`, `debian`, `fedora`, `opensuse`, and one `pkg_install()` function that picks the right manager.

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

`pkg_install()` calls the right command based on `distro_id`:
- **arch:** `sudo pacman -S --needed --noconfirm $@`
- **debian:** `sudo apt install -y $@`
- **fedora:** `sudo dnf install -y $@`
- **opensuse:** `sudo zypper install -y $@`

- [ ] `distro_id()` function in `install-lab.sh`
- [ ] `pkg_install()` function that calls the right manager per distro
- [ ] Replace the existing `is_arch()` and `pacman_install()`
- [ ] Rename `PACMAN_FAILED` to `PKG_FAILED` (general)
- [ ] Label "Arch Linux system packages" → "System packages"

### Slice 2 — Per-distro package names

Not every package is called the same in every distro. Make a mapping:

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

| Generic name | Arch | Debian | Fedora | openSUSE |
|----------------|------|--------|--------|----------|
| `bubblewrap` | `bubblewrap` | `bubblewrap` | `bubblewrap` | `bubblewrap` |
| `nodejs` | `nodejs` `npm` | `nodejs` `npm` | `nodejs` `npm` | `nodejs` `npm` |
| `uv` | `uv` | `uv` | `uv` | `uv` |
| `jq` | `jq` | `jq` | `jq` | `jq` |
| `build-essential` | `base-devel` | `build-essential` | `@development-tools` | `patterns-devel-base-devel` |
| `go` | `go` | `golang-go` | `golang` | `go` |

- [ ] `pkg_map()` function in `install-lab.sh`
- [ ] Replace every `ARCH_PKGS+=()` with `pkg_append bubblewrap nodejs uv jq build-essential go`

### Slice 3 — Zed install per distro

Current: only `pacman -S zed`. For other distros Zed has to come from GitHub releases.

```bash
install_zed() {
  case "$DISTRO" in
    arch)
      pkg_install "zed" ;;
    debian)
      # Download the .deb from GitHub
      local url="https://github.com/zed-industries/zed/releases/latest/download/zed-linux-x86_64.deb"
      local tmp="$(mktemp -d)"
      cd "$tmp"
      curl -fsSLO "$url"
      sudo dpkg -i zed-linux-x86_64.deb
      rm -rf "$tmp" ;;
    fedora|opensuse)
      # Download the .rpm
      local url="https://github.com/zed-industries/zed/releases/latest/download/zed-linux-x86_64.rpm"
      local tmp="$(mktemp -d)"
      cd "$tmp"
      curl -fsSLO "$url"
      sudo rpm -i zed-linux-x86_64.rpm
      rm -rf "$tmp" ;;
  esac
}
```

- [ ] `install_zed()` function
- [ ] For Arch `pacman -S zed` stays, for others a GitHub release download
- [ ] Fallback if the GitHub download fails: a message with manual instructions
- [ ] ARM64 support? (x86_64 only for now)

### Slice 4 — Make `cardine-status.sh` distro aware

- [ ] Add `distro_id()` to `cardine-status.sh`
- [ ] The bwrap check works on all Linux distributions (bwrap is `bwrap` everywhere)
- [ ] The Zed path check stays `~/.config/zed/settings.json` (applies to all Linux)
- [ ] Extra check: is the package manager available? (`warn` only)

### Slice 5 — Update the docs

- [ ] `docs/cardine-lab.md`: extend the audience to "Arch, Debian/Ubuntu, Fedora, openSUSE"
- [ ] README.md: install instructions per distro
- [ ] CHANGELOG.md: `0.2.0` entry

## Testing

- [ ] `bash packages/lab/install-lab.sh` — must not crash on non-Arch; shows "recognised distro: ..."
- [ ] `bash packages/lab/cardine-status.sh` — shows the distro in the output
- [ ] `make check` is green
- [ ] (Optional) test in a Docker container per distro

## Touchpoints

- `packages/lab/install-lab.sh` — main script, most changes
- `packages/lab/cardine-status.sh` — distro check
- `packages/lab/docs/cardine-lab.md` — update the docs
- `packages/lab/README.md` — install instructions

## Acceptance

- [ ] `make check` is green
- [ ] `bash packages/lab/install-lab.sh` runs on Arch without regression (the pacman step works)
- [ ] `bash packages/lab/install-lab.sh` recognises Debian/Ubuntu, Fedora, openSUSE and gives the right messages
- [ ] The Zed install on non-Arch downloads from GitHub and installs (tested in Docker)
- [ ] `cardine-status.sh` recognises the distro and shows it
- [ ] The bwrap check works on all Linux