# How-to — container-safe packages

> **Role:** Run npm, pip and cargo in Podman containers instead of on the host. Prevents supply-chain attacks through install scripts.
> **Not here:** other threats ([security.md](../architecture/security.md)), the Strix pentest ([security-scan](security-scan.md)).

## Why

`npm install`, `pip install` and `cargo build` run **install scripts** that have access to your SSH keys, API keys and files. Isolating them in a container limits the damage if a dependency is compromised.

## Prerequisites

1. **Podman** (or Docker) installed.
   ```bash
   # Arch
   sudo pacman -S podman
   # macOS
   brew install podman
   # Debian/Ubuntu
   sudo apt install podman
   ```
2. **Container images** (pull once):
   ```bash
   podman pull docker.io/library/node:23-slim
   podman pull docker.io/library/python:3.12-slim
   podman pull docker.io/library/rust:latest
   ```

## Setup (once)

```bash
make container-setup
```

This writes shell functions to `~/.config/shell/container-safe.sh`. Then add this to your shell rc:

```bash
source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/container-safe.sh"
```

## Usage

In every agent task or terminal session, replace:

| Instead of | Use |
|------------|-----|
| `npm install` | `npm-safe install` |
| `pnpm install` | `pnpm-safe install` |
| `pip install -r requirements.txt` | `pip-install-safe -r requirements.txt` |
| `cargo build` | `cargo-safe build` |
| `node script.js` | `node-safe script.js` |
| `python script.py` | `python-safe script.py` |

### Offline (no network in the container)

| Instead of | Use |
|------------|-----|
| `npm ci` | `npm-safe-offline ci` |
| `pip install` | `pip-safe-offline install` |
| `cargo build` | `cargo-safe-offline build` |

## Podman not working?

| Problem | Fix |
|---------|-----|
| `podman: command not found` | Install it (see prerequisites) |
| `permission denied` | Podman is rootless — check that `~` is readable |
| `image not found` | `podman pull docker.io/library/node:23-slim` |
| `Z: flag not supported` | Replace `:Z` with `:z` in the functions |
| Slow first run | Image pull — cached afterwards |

## See also

- [security.md](../architecture/security.md) — supply-chain threat
- [scripts/container-safe.sh](../../scripts/container-safe.sh) — the script that writes the functions out
