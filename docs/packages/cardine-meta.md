# Meta package: `cardine`

> **The GitHub repo `Lennaertds/cardine` is both the shop window and the starting point for a new project.**
> The README explains what Cardine is. The root is installable: `cardine <dir>` lays down the
> project structure, so one command in any brand-new directory suffices.

| Field | Value |
|-------|-------|
| **Package** | `cardine` (meta) |
| **Audience** | Anyone starting a new project |
| **Source** | `cardine/` (root) |
| **Registry** | npmjs.org, `access: public` — no token needed |
| **Install** | `npx cardine <dir> [options]` or `npm i -g cardine && cardine <dir>` |
| **Depends on** | contains `packages/structure/kit/`; refers to `cardine-lab` |

Why the root is installable at all: a fresh directory has no clone and does not
need `packages/structure/` from `@lennaertds/cardine-structure`. `bin/cardine`
calls `packages/structure/kit/new-project.sh` with a path that goes through
`readlink -f` first (through an npm symlink `BASH_SOURCE[0]` otherwise points at
`<prefix>/bin`). Nothing is written outside `<dir>`.

---

## What lives in the repo root

```
cardine/
├── README.md           ← Shop window, explanation, links to packages
├── package.json        ← Meta: "cardine" with version, references
├── CHANGELOG.md        ← Overview of all package versions
├── LICENSE             ← MIT
├── docs/
│   ├── INDEX.md        ← Doc map
│   ├── product/        ← Product docs per part
│   ├── decisions/      ← ADRs (public — without private details)
│   ├── packages/
│   │   └── INDEX.md    ← This document
│   ├── how-to/         ← Guides per path
│   └── ...
├── packages/
│   ├── lab/            ← cardine-lab package
│   └── structure/      ← cardine-structure package (mirrored)
├── scripts/            ← Only what the meta needs (status, etc.)
├── AGENTS.md           ← (public, but aimed at developers)
├── Makefile            ← check, context, finish (for development)
└── .gitignore
```

## What stays in the root

| File | Why |
|------|-----|
| `README.md` | Shop window — must be clear at a glance |
| `package.json` | Meta package with `bin.cardine` and `files` |
| `bin/cardine` | Entrypoint: `cardine <dir>` → kit/new-project.sh |
| `CHANGELOG.md` | Overview of all versions |
| `LICENSE` | MIT |
| `docs/` | Product docs, ADRs, guides, packages design |
| `AGENTS.md` | Agent instructions for development |
| `Makefile` | `make check`, `make context` for development |
| `.gitignore` | Standard |
| `.editorconfig` | Code style |
| `.pre-commit-config.yaml` | Pre-commit hooks |
| `.env.example` | Example |

## Packages the meta offers

| # | Package | Doc | Audience |
|---|---------|-----|----------|
| 1 | **`cardine-lab`** | [cardine-lab.md](cardine-lab.md) | Arch/Hyprland AI-agent workstation |
| 2 | **`cardine-structure`** | [cardine-structure.md](cardine-structure.md) | Project standard (any editor) |

## Dependencies and relations

```
                    ┌──────────────────┐
                    │   cardine (meta) │  ← GitHub repo, README, guides
                    │   version x.y.z  │
                    └────────┬─────────┘
                             │ refers to
               ┌─────────────┴──────────────┐
               ▼                            ▼
     ┌─────────────────┐          ┌───────────────────┐
     │  cardine-lab    │          │ cardine-structure │
     │  Arch/Hyprland  │          │ project standard  │
     │  toolchain      │          │ (any editor)      │
     └─────────────────┘          └───────────────────┘
               │                        │
               │                        ├── mirrored from ───► kit/
               │                        │                     (repo, SSOT)
               │
               ├── contains ──► scripts/
               ├── contains ──► systemd/
               └── generates ──► ~/.dsh/profiles/ (ACP profile)
```

### Install orders

| Scenario | Packages | Order |
|----------|----------|-------|
| New project, no toolchain | `cardine` (meta) | `npx cardine <dir>` |
| Full agent workstation | `cardine-lab` + `cardine` | `cardine-lab install` → `npx cardine <dir>` |
| Structure only, without the meta | `@lennaertds/cardine-structure` | `npx @lennaertds/cardine-structure <dir>` |

## Versioning

See [VERSIONING.md](VERSIONING.md) for the general scheme.
The meta package has its own version, which changes only when the meta's own
structure (docs, guides) changes.
Git tag: `v<semver>` (no prefix).

CHANGELOG in the root: `CHANGELOG.md` — an overview of all package versions in
table form.
