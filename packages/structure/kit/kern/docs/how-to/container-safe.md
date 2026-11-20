# How-to — container-safe packages

> **Rol:** npm, pip en cargo draaien in Podman-containers in plaats van op de host. Voorkomt supply-chain aanvallen door installatiescripts.
> **Niet hier:** andere dreigingen ([security.md](../architecture/security.md)), Strix-pentest ([security-scan](security-scan.md)).

## Waarom

`npm install`, `pip install` en `cargo build` voeren **installatiescripts** uit die toegang hebben tot je SSH-keys, API-keys en bestanden. Door ze in een container te isoleren, beperk je de schade als een dependency gecompromitteerd is.

## Voorwaarden

1. **Podman** (of Docker) geïnstalleerd.
   ```bash
   # Arch
   sudo pacman -S podman
   # macOS
   brew install podman
   # Debian/Ubuntu
   sudo apt install podman
   ```
2. **Container images** (één keer pullen):
   ```bash
   podman pull docker.io/library/node:23-slim
   podman pull docker.io/library/python:3.12-slim
   podman pull docker.io/library/rust:latest
   ```

## Setup (éénmalig)

```bash
make container-setup
```

Dit schrijft shell-functies naar `~/.config/shell/container-safe.sh`. Voeg daarna toe aan je shell rc:

```bash
source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/container-safe.sh"
```

## Gebruik

Vervang in elke agent-taak of terminal-sessie:

| In plaats van | Gebruik |
|---------------|---------|
| `npm install` | `npm-safe install` |
| `pnpm install` | `pnpm-safe install` |
| `pip install -r requirements.txt` | `pip-install-safe -r requirements.txt` |
| `cargo build` | `cargo-safe build` |
| `node script.js` | `node-safe script.js` |
| `python script.py` | `python-safe script.py` |

### Offline (geen netwerk in container)

| In plaats van | Gebruik |
|---------------|---------|
| `npm ci` | `npm-safe-offline ci` |
| `pip install` | `pip-safe-offline install` |
| `cargo build` | `cargo-safe-offline build` |

## Werkt Podman niet?

| Probleem | Oplossing |
|----------|-----------|
| `podman: command not found` | Installeer het (zie voorwaarden) |
| `permission denied` | Podman is rootless — check of `~` leesbaar is |
| `image not found` | `podman pull docker.io/library/node:23-slim` |
| `Z: flag not supported` | Vervang `:Z` door `:z` in de functies |
| Trage eerste run | Image pull — daarna cached |

## Zie ook

- [security.md](../architecture/security.md) — supply-chain dreiging
- [scripts/container-safe.sh](../../scripts/container-safe.sh) — het script dat de functies uitschrijft