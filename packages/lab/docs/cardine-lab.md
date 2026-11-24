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

## Wat is NIET voor publiek (blijft in `kit/` privé)

| Onderdeel | Reden |
|-----------|-------|
| `systemd/*.service` met `_jouwgebruiker_` placeholder | Per-machine config; kopieer en pas aan |
| Persoonlijke keys in `~/.dsh/.env` | Altijd lokaal, nooit in git |
| Sibling-repo-verbindingen | Sibling-repo, niet publiek |

## Installatie

Het package staat op de publieke npm-registry als `@lennaertds/cardine-lab`.

```bash
# Aanbevolen: via npm
npm i -g @lennaertds/cardine-lab
cardine-lab install          # of: cardine-lab install --force

# Status van de omgeving
cardine-lab status           # --json | --verbose | --fix
```

Een AUR-package (PKGBUILD) staat nog op de lijst, maar npm is de enige
gedistribueerde route.

## Relaties

- Maakt deel uit van de **cardine (meta)**-verwijzingen
- Installeert DSH, Zed-config en bwrap — de fundamenten van het werkstation
- `cardine-slice-check` blijft in dit package tot er een andere afnemer is
- Tool-scripts worden naar projecten gekopieerd via `cardine-structure`

## Versiebeheer

Zie [VERSIONING.md](VERSIONING.md) voor het algemene schema.
CHANGELOG: `packages/lab/CHANGELOG.md` (eigen versie, SemVer).
Git-tag: `lab-v<semver>`.