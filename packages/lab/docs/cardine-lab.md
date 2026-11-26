# Package: `cardine-lab`

> **A reproducible AI-agent workstation for Arch Linux / Hyprland.**
> Installs the toolchain, sandbox, indexing and editor coupling in one idempotent script.

| Field | Value |
|-------|-------|
| **Package** | `cardine-lab` |
| **Audience** | Anyone who wants an AI-agent workstation on Arch Linux / Hyprland |
| **Source** | `cardine/packages/lab/` |
| **Install** | `npm i -g` + `cardine-lab install` (AUR planned) |
| **Depends on** | nothing (all-in-one installer) |

---

## Contents

Everything in `packages/lab/`:

| File | Role |
|------|------|
| `install-lab.sh` | Main script — idempotent, installs DSH + Jarvis + bwrap + Zed config |
| `cardine-bwrap` | Tighter bwrap cage for the agent shell (ADR 0007) |
| `cardine-status.sh` | Status check for DSH, Jarvis and tools |
| `cardine-slice-check/` | Node module for `make check` after a turn |
| `scripts/` | Tool scripts (digest, security, radar, audit, …) |
| `systemd/` | Timer units for digest-fetch and digest-week |

### Directory structure

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
│   ├── check-language.sh
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

## What is NOT public

| Part | Reason |
|------|--------|
| `systemd/*.service` with a user placeholder | Per-machine config; copy and adjust |
| Personal keys in `~/.dsh/.env` | Always local, never in git |
| Sibling repo connections | Sibling repo, not public |

## Install

The package is on the public npm registry as `@lennaertds/cardine-lab`.

```bash
# Recommended: via npm
npm i -g @lennaertds/cardine-lab
cardine-lab install          # or: cardine-lab install --force

# Status of the environment
cardine-lab status           # --json | --verbose | --fix
```

An AUR package (PKGBUILD) is still on the list, but npm is the only distributed
route.

## Relations

- Requires **`cardine`** for the project structure (install it with `npm i -g cardine`)
- Installs DSH, the Zed config and bwrap — the foundations of the workstation
- `cardine-slice-check` stays in this package until another consumer appears
- Tool scripts are copied into projects via `cardine`

## Versioning

See [VERSIONING.md](VERSIONING.md) for the general scheme.
CHANGELOG: `packages/lab/CHANGELOG.md` (own version, SemVer).
Git tag: `lab-v<semver>`.
