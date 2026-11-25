# Cardine

> **The hinge between human and AI agent in every project.**

AI assistants work best with a fixed project structure. Without one they drift:
they guess directories, miss conventions, and every new session starts over. With
a stable tree — docs, data, decisions, logs — an agent knows immediately where to
find things and where to put them.

Cardine provides that structure, plus the toolchain to work in it right away.
No new editor, no mandatory subscription — just the standard and the tools, with
the agent you already have.

---

## Why Cardine?

*Cardine* is the Latin ablative of *cardo* — the pivot, the hinge a city or a
structure turns on. *"Whereby and from where everything hinges."*

The idea is simple: if every session meets the same tree, an agent does not have
to guess each time where docs, data or decisions live. The project standard is
the hinge that human and agent work around.

Background:
- [docs/decisions/packages-context.md](docs/decisions/packages-context.md) —
  full context: why packages, why these choices, with links to the ADRs

---

## The standard lives *inside* this repo

Nothing to clone side by side: the project standard (**kit**, **sources**,
**templates**, **standard**) lives here, next to the lab and the packages.

| Directory | What | Goes into a project? |
|-----------|------|----------------------|
| [kit/](kit/README.md) | The files themselves, in layers that mirror a project root: `kern`, `solo`, `team`, `modules/<name>`, `stacks/<stack>`. Plus `new-project.sh` | **yes**, via the script |
| [new-project/](new-project/INDEX.md) | Step-by-step from empty directory to working project | no |
| [existing-project/](existing-project/INDEX.md) | Step-by-step to reorder a running project | no |
| [sjablonen/](sjablonen/INDEX.md) | Per kit file: when, how to fill it in, example, quick test | no |
| [standard/](standard/INDEX.md) | The agreements: tree, files, stacks, Makefile, data, git, naming | no |
| [bron/](bron/INDEX.md) | Principles P1–P28, source index + summaries, fundamentals, knowledge map | never |
| [measurement/](measurement/INDEX.md) | Repeatable evaluation with tasks and conditions | only `measurement/kit/` |

The PDFs under `bron/pdfs/` are **outside git** (~166 MB together) and sync via
Syncthing; see [bron/pdfs/README.md](bron/pdfs/README.md).

```bash
make new DIR=~/code/demo ARGS="--profile app"   # new project
make trio s=makefile                           # the three places of one topic
make test-kit                                  # assemble and test the kit
```

The **bridge** from knowledge to standard: what may leave `bron/` and touch
`kit/` is described in [bron/fundament/brug.md](bron/fundament/brug.md). Without
your yes, there is no kit edit.

---

## Packages

Cardine consists of two packages. The meta package (`cardine` in the root) is the
shop window: README, docs, guides. The packages beneath it install separately.

```mermaid
graph TD
    M("cardine (meta)") --> L("@lennaertds/cardine-lab")
    M --> S("@lennaertds/cardine-structure")
    L --> D("DSH + Jarvis + bwrap")
    S --> K("`kit/` / kit")
    style M fill:#4a90d9,color:#fff
    style L fill:#50b86c,color:#fff
    style S fill:#e8a838,color:#fff
```

| Package | What | For whom | Install |
|---------|------|----------|---------|
| **[@lennaertds/cardine-lab]** ⚙️ | Reproducible AI-agent workstation for Arch Linux / Hyprland. Installs DSH, Jarvis, the bwrap sandbox and the Zed config in one idempotent script. | Anyone who wants Zed + DeepSeek Harness on Arch | `npm i -g @lennaertds/cardine-lab` then `cardine-lab install` |
| **[@lennaertds/cardine-structure]** 📁 | Project standard for every project, regardless of editor or subscription. Contains the proven `kern/`-`solo/`-`logging/` tree, modules and stacks, mirrored from `kit/`. | Anyone with a project | `npx @lennaertds/cardine-structure <dir> --profile app` |

### How the packages relate

```
cardine                    ← Meta: repo root with README, docs, guides
├── cardine-lab            ← Toolchain: scripts, sandbox, status checks
│   └── generates          → ~/.dsh/profiles/ (ACP profile for DSH)
│   └── contains           → scripts/, systemd/ (optional tooling)
└── cardine-structure      ← Project standard: mirrored from kit/
    └── kit/               → Literal copy, kept in sync
```

The structure is maintained **in this repo**, in [kit/](kit/README.md).
`packages/structure/kit/` is the public distribution copy that ships with
`@lennaertds/cardine-structure`. It used to be pulled from a separate private
repo on pinned commits (see [ADR 0013](docs/decisions/0013-cardine-is-the-public-shop-window-and-pulls-the-structure-from-agent-engineering.md));
since the merge, `kit/` is the only source and a pin or pull script is no longer
needed.

---

## Install paths

### 📁 The project structure only (any editor, any OS)

```bash
npx cardine my-project --profile app
```

Works from any cwd, including an empty directory with no clone. It lays down the
full project tree with `kern/`, `solo/`, `logging/`, plus the chosen modules and
stacks. No toolchain, no sandbox — just the structure. A second run overwrites
nothing. Works in VS Code, Zed, Cursor or a terminal.

```bash
npx cardine my-project --profile app --modules research,agent
npx cardine exercises --profile schoolwerk --dry-run
```

See the [cardine-structure docs](packages/structure/docs/cardine-structure.md)
for every option (profiles, modules, stacks).

### ⚙️ The full AI-agent workstation (Arch Linux / Hyprland)

```bash
# 1. Install the toolchain (DSH, Jarvis, bwrap, Zed config)
npm i -g @lennaertds/cardine-lab
cardine-lab install

# 2. Add the project standard
npx cardine my-project --profile app
```

The lab path uses Zed as IDE, DeepSeek Harness as agent loop, and
`deepseek-flash` as the model with Claude as second provider. See
[docs/decisions/packages-context.md](docs/decisions/packages-context.md) for the
reasoning behind each choice.

See the [cardine-lab docs](packages/lab/docs/cardine-lab.md) for exactly what
gets installed and how to configure the sandbox, indexing and status checks.

---

## How it works — in brief

1. **Start a project**: `cardine-structure` lays down a proven tree.
2. **Learn the structure**: docs/, data/, decisions/ and work/ have fixed places.
   An agent navigates with [docs/INDEX.md](docs/INDEX.md).
3. **Work with an agent**: open your editor, start the agent — the structure
   tells it where docs, rules and work items live.
4. **Check**: `make check` verifies links, lint and tests.
5. **Record**: `make finish` logs what you did.
6. **Update**: a new version of the structure ships as a new package version;
   `sync_kit.sh` keeps the distribution copy equal to `kit/`.

For the full product vision and background:
- [PRODUCT.md](docs/product/PRODUCT.md) — what the product does, per part
- [totaalproduct.md](docs/product/totaalproduct.md) — how the 9 parts relate
- [ARCHITECTURE.md](docs/architecture/ARCHITECTURE.md) — containers, stack, dataflow
- [docs/decisions/packages-context.md](docs/decisions/packages-context.md) — why these
  choices: research questions, sources, ADRs

---

## Docs and navigation

| Where | What |
|-------|------|
| [docs/INDEX.md](docs/INDEX.md) | Full docs map — start here for any question |
| [docs/product/PRODUCT.md](docs/product/PRODUCT.md) | Product overview: what it does, for whom, phases |
| [docs/decisions/](docs/decisions/) | Architecture decisions (ADRs) — why things are the way they are |
| [docs/packages/VERSIONING.md](docs/packages/VERSIONING.md) | Versioning: SemVer, changelogs, git tags |
| [AGENTS.md](AGENTS.md) | Instructions for agents working on this repo |

---

## Versioning

Each package has its **own version**, independent of the others.

| Package | Version | CHANGELOG | Git tag |
|---------|---------|-----------|---------|
| `cardine` (meta) | 0.4.1 | [CHANGELOG.md](CHANGELOG.md) | `v0.4.1` |
| `@lennaertds/cardine-lab` | 0.5.2 | [packages/lab/CHANGELOG.md](packages/lab/CHANGELOG.md) | `lab-v0.5.2` |
| `@lennaertds/cardine-structure` | 0.5.1 | [packages/structure/CHANGELOG.md](packages/structure/CHANGELOG.md) | `structure-v0.5.1` |

SemVer: `major.minor.patch`. A *major* is a breaking change (the installer no
longer works, the kit structure changes incompatibly). A *minor* is new
functionality. A *patch* is a bugfix or documentation.

The meta package gets a new version only when the meta's own structure (docs,
guides) changes — not on every package update. See
[docs/packages/VERSIONING.md](docs/packages/VERSIONING.md) for the full scheme.

---

## Development

This repo contains everything: the project standard ([kit/](kit/README.md)), the
knowledge ([bron/](bron/INDEX.md)), the guides ([sjablonen/](sjablonen/INDEX.md),
[standard/](standard/INDEX.md)) and the lab ([packages/](packages/)).
There is no second repo to synchronise with anymore.

The PDFs in `bron/pdfs/` are deliberately outside git (see
[bron/pdfs/README.md](bron/pdfs/README.md)).

See [AGENTS.md](AGENTS.md) for agent instructions and
[docs/INDEX.md](docs/INDEX.md) for the full documentation map.

[@lennaertds/cardine-lab]: packages/lab/README.md
[@lennaertds/cardine-structure]: packages/structure/README.md
