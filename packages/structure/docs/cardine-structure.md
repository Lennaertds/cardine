# Package: `cardine-structure`

> **The project standard for every project, regardless of editor or subscription.**
> This is the free product from ADR 0009 — mirrored from `kit/`.

| Field | Value |
|-------|-------|
| **Package** | `cardine-structure` |
| **Audience** | Anyone who wants a project standard (any editor) |
| **Source** | `cardine/packages/structure/` (mirrored from `kit/`) |
| **Install** | `npx @lennaertds/cardine-structure <dir>`, `npm i -g` + `cardine-structure`, or `new-project.sh` |
| **Depends on** | nothing (standalone) |

---

## Contents

The full `kit/`, copied literally into `packages/structure/kit/`.

| Layer | Description | Required? |
|-------|-------------|-----------|
| `kern/` | README, AGENTS.md, Makefile, .gitignore, .editorconfig, docs/ (INDEX, context, rules, architecture, decisions, how-to), data/ (5 fixed layers), apps/ | always |
| `solo/` | .cursorrules, docs/work/BACKLOG.md, specs/_template.md, logs/_template.md | default |
| `logging/` | logs/status-log.md, logs/topics/_template.md | always |
| `team/` | .github/ (CI, PR template, issue templates) | optional (--team) |
| `modules/<name>/` | Per module (agent, research, design, compose, …) | optional (--modules) |
| `stacks/<stack>/` | Per stack (next, nest, python, sql, rust, c) | optional (--stacks) |
| `profiles/<name>.profile` | Predefined combinations | optional (--profile) |
| `new-project.sh` | Generator script | yes |

### Directory structure

```
packages/structure/
├── CHANGELOG.md
├── README.md
├── package.json
├── sync_kit.sh       ← copies the source kit/ here
└── kit/              ← literal copy of the current kit
    ├── README.md
    ├── kern/
    ├── solo/
    ├── logging/
    ├── team/         (optional)
    ├── modules/      (optional)
    ├── stacks/       (optional)
    ├── profiles/     (optional)
    └── new-project.sh
```

## How the kit gets into the package

```
kit/                        (source, in the repo root)
  │
  │  bash packages/structure/sync_kit.sh
  │
  ▼
packages/structure/kit/     (public distribution copy, ships in the package)
  │
  ▼
@lennaertds/cardine-structure on npm
```

There is **no second repo and no pin anymore**. `kit/` used to be pulled from a
separate repo and `kit/COMMIT` held the pinned commit; that pin file is gone.
Since the merge, `kit/` is the only source.

`sync_kit.sh` copies `kit/` literally into `packages/structure/kit/`. Check with
`bash packages/structure/sync_kit.sh --check` whether the two are equal
(`make check` does this too).

## Version coupling

Every `cardine-structure` release contains a copy of `kit/` as it was at release
time.

| cardine-structure | Date | Notes |
|-------------------|------|-------|
| 0.5.0 | 2026-11-24 | `kit/` becomes the source; `pull_kit.sh` and `kit/COMMIT` dropped |
| 0.4.0 | 2026-11-22 | `jarvis-check`/`env-status`/`index` in `kern/Makefile` |
| 0.3.0 | 2026-11-20 | scoped name |
| 0.2.0 | 2026-11-18 | kit tag `kit-v0.2.0` |
| 0.1.0 | 2026-11-17 | first release |

### Publishing a new version

```bash
# 1. Make sure the distribution copy equals the source
bash packages/structure/sync_kit.sh

# 2. Bump the version
#    - packages/structure/package.json: version
#    - packages/structure/CHANGELOG.md: new entry
#    - update this table
#    - git tag structure-v<version>
```

## Adjustments for publication

The kit is copied 1:1 from `kit/`, with two exceptions:

| Change | Why |
|--------|-----|
| `kit/README.md` is **replaced** by a user-facing version | The original contains internal SSOT links to `../standard/`, `../sjablonen/` etc. — those do not exist in the published package |
| `sync_kit.sh` is not in `files` of package.json | Internal tooling, irrelevant to users |

These adjustments are **redone on every copy** (automatically or by hand). The
SSOT stays `kit/`.

## What stays in the repo (private)

| Part | Why private |
|------|-------------|
| `standard/` | Rules, principles, why the structure is the way it is — the logic behind the kit |
| `sjablonen/` | Fill-in guides per file — explanation for the maker |
| `new-project/`, `existing-project/` | Guides — how to use the kit |
| `bron/` | Knowledge, principles, fundamentals — research and background |
| `measurement/` | Measurement protocols, tasks, results |
| `scripts/` | Internal tooling (test-kit, bootstrap, digest-triage, session logs) |

## Install

The package is on the public npm registry as
`@lennaertds/cardine-structure`.

```bash
# Start a new project (recommended)
npx @lennaertds/cardine-structure my-project --profile app --modules research,agent

# Or install globally; the bin is called cardine-structure
npm i -g @lennaertds/cardine-structure
cardine-structure my-project --profile app

# Or straight from the repo (only Git + Bash needed)
bash packages/structure/kit/new-project.sh my-project --profile app
```

## Relations

- Part of the **cardine (meta)** references
- Mirrored from **`kit/`** (repo, SSOT) — see [ADR 0013](../../../docs/decisions/0013-cardine-is-the-public-shop-window-and-pulls-the-structure-from-agent-engineering.md)
- Can be used together with `cardine-lab` for a complete workstation

## Versioning

See [VERSIONING.md](VERSIONING.md) for the general scheme.
CHANGELOG: `packages/structure/CHANGELOG.md` (own version, SemVer).
Git tag: `structure-v<semver>`.
