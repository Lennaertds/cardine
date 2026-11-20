# Package: `cardine-lab`

> **Een reproduceerbaar AI-agent-werkstation voor Arch Linux / Hyprland.**
> Installeert toolchain, sandbox, indexering en editor-koppeling in één idempotent script.

| Veld | Waarde |
|------|--------|
| **Package** | `cardine-lab` |
| **Doelgroep** | Wie een AI-agent-werkstation wil op Arch Linux / Hyprland |
| **Bron** | `cardine/packages/lab/` |
| **Installatie** | `curl … \| bash`, npm, later AUR |
| **Afhankelijk van** | niets (alles-in-één installer) |

---

## Inhoud

Alles in `packages/lab/`:

| Bestand | Rol |
|---------|-----|
| `install-lab.sh` | Hoofdscript — idempotent, installeert DSH + Jarvis + bwrap + Zed-config |
| `cardine-bwrap` | Strakkere bwrap-kooi voor de agent-shell (ADR 0007) |
| `cardine-status.sh` | Status-check voor DSH, Jarvis en tools |
| `cardine-slice-check/` | Node-module voor `make check` na een turn |
| `scripts/` | Tool-scripts (digest, security, radar, audit, …) |
| `systemd/` | Timer-units voor digest-fetch en digest-week |

### Mapstructuur

```
packages/lab/
├── CHANGELOG.md
├── README.md
├── install-lab.sh
├── cardine-bwrap
├── cardine-status.sh
├── cardine-slice-check/
│   ├── index.js
│   └── package.json
├── scripts/
│   ├── check-links.sh
│   ├── deps-audit.sh
│   ├── security-scan.sh
│   ├── perf-check.sh
│   ├── polyglot-check.sh
│   ├── radar-check.sh
│   ├── radar-reminder.sh
│   ├── native-ffi.sh
│   ├── digest-check.sh
│   ├── digest-fetch.sh
│   ├── digest-propose.sh
│   ├── digest-reminder.sh
│   ├── digest-rss.py
│   ├── digest-week.sh
│   └── install-digest-timers.sh
└── systemd/
    ├── digest-fetch.service
    ├── digest-fetch.timer
    ├── digest-week.service
    └── digest-week.timer
```

## Wat is NIET voor publiek (blijft in Agent_Engineering privé)

| Onderdeel | Reden |
|-----------|-------|
| Persoonlijke paden in `install-lab.sh` (bv. `REPO_ROOT` naar Agent_Engineering) | Moet generiek gemaakt worden |
| Harde paden naar `/home/ventje/` | Moet `$HOME`-relatief zijn in publieke versie |
| DSH-profiel met DeepInfra-specifieke config | Wordt gegenereerd; template blijft in package |

## Installatie

```bash
# Optie A: direct via curl
bash <(curl -fsSL https://raw.githubusercontent.com/Lennaertds/cardine/main/packages/lab/install-lab.sh)

# Optie B: via GitHub release (zip/tarball)
# Optie C: later als AUR-package (PKGBUILD)
# Optie D: via npm (npm install -g @lennaertds/cardine-lab)
```

## Relaties

- Maakt deel uit van de **cardine (meta)**-verwijzingen
- Installeert DSH, Zed-config en bwrap — de fundamenten van het werkstation
- `cardine-slice-check` blijft in dit package tot er een andere afnemer is
- Tool-scripts worden naar projecten gekopieerd via `cardine-structure`

## Versiebeheer

Zie [VERSIONING.md](VERSIONING.md) voor het algemene schema.
CHANGELOG: `packages/lab/CHANGELOG.md` (eigen versie, SemVer).
Git-tag: `lab-v<semver>`.