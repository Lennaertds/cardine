# cardine-lab

> Een reproduceerbaar AI-agent-werkstation voor Arch Linux / Hyprland.

Installeert toolchain, sandbox, indexering en editor-koppeling in één idempotent script.

## Installatie

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/ventje/cardine/main/packages/lab/install-lab.sh)
```

## Inhoud

| Bestand | Rol |
|---------|-----|
| `install-lab.sh` | Hoofdscript — idempotent, installeert DSH + Jarvis + bwrap + Zed-config |
| `cardine-bwrap` | Strakkere bwrap-kooi voor de agent-shell |
| `cardine-status.sh` | Status-check voor DSH, Jarvis en tools |
| `cardine-slice-check/` | Node-module voor `make check` na een turn |
| `scripts/` | Extra tool-scripts (security, radar, audit, digest, …) — optioneel |
| `systemd/` | Timer-units voor digest-fetch — optioneel; pas aan voor jouw machine |

Zie [docs/cardine-lab.md](docs/cardine-lab.md) voor volledige documentatie.