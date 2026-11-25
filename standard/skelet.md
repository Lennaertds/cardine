# Skeleton

> **Role:** The full fixed tree of a project: which folder and which entry file sits where, and why.
> **Not here:** content per doc ([per-doc reference](per-file.md)), the layout inside an app ([stacks](stacks.md)).

## Ground rules

1. **Every kind has one place, and that place is fixed**, even if the folder does not exist yet. Creating a new folder is then no longer a choice, only execution.
2. **Pick the layout that grows with you from day one.** Always `apps/<app>/`, even with one app. Always `features/<domain>/` in the web app, even with one feature. That way growth never asks for a move.
3. **The tree lives only here.** A project does not copy it into its own docs (P5). The folders the kit installs show the structure to human and agent.
4. **If something fits nowhere, change the standard**, with a row in [where does this belong](where-does-this-belong.md) and a line in this tree. Do not create a loose folder in the project.

## The tree

Legend: **●** kern, in every project; [kit/kern](../kit/README.md#layers) installs it · **○** module, the place is fixed; created with the first file or with `--modules` · **S** solo only · **T** team only.

```
project/
│
│   ── Entry points ─────────────────────────────────────────────────────────────────────
├── README.md                      ● HUMAN: what, why, quickstart, demo link, link to docs/INDEX.md
├── AGENTS.md                      ● AGENT: Never, commands, working, finishing, link to the map
├── .cursorrules                   S your layer for Cursor: preferences, reference to AGENTS.md; repeats nothing from it
├── CLAUDE.md -> AGENTS.md         ○ symlink for tools that read another name
├── Makefile                       ● all commands with fixed names (standard/makefile.md); `make check` = green or not
├── local.mk                       (not in git) personal make targets; the Makefile picks them up if the file exists
│
│   ── Repo configuration ───────────────────────────────────────────────────────────────
├── .gitignore                     ● fixed block from kit/kern; policy in standard/git.md
├── .editorconfig                  ● indentation, line endings, charset, for every editor
├── .pre-commit-config.yaml        ● guardrails before every commit: secrets, large files, raw data
├── .gitattributes                 ○ Git LFS for binary files, line endings
├── .tool-versions                 ○ pinned versions of node, pnpm, python, uv (mise or asdf)
├── .env.example                   ○ only for docker-compose and root scripts; apps have their own
├── docker-compose.yml             ○ local services for `make dev` (Postgres, Redis, …)
├── package.json                   ○ JS workspace root: scripts and devtools, no app code
├── pnpm-workspace.yaml            ○ + pnpm-lock.yaml: one lockfile for all JS apps
├── LICENSE                        ○ only for public code
│
│   ── Tools and automation ─────────────────────────────────────────────────────────────
├── .cursor/
│   ├── agents/<role>.md           ○ Cursor subagents per role (ui, product, …); see standard/agent-rollen.md
│   ├── rules/<app>.mdc            ○ path-scoped rules (globs: apps/<app>/**)
│   ├── hooks.json                 ○ agent hooks: lint after an edit, block writes to migrations/
│   └── hooks/<hook>.sh            ○ scripts that hooks.json calls
├── .github/
│   ├── workflows/check.yml        T `make check` on every PR and on main
│   ├── workflows/native.yml       T with stacks rust/c: `make check-full` (NATIVE_STRICT)
│   ├── workflows/digest.yml       T with module research: fetch→propose→draft PR
│   ├── workflows/deploy.yml       ○ only if the host does not deploy itself
│   ├── pull_request_template.md   T
│   └── ISSUE_TEMPLATE/            T bug.md, feature.md
├── .vscode/                       ○ shared only: extensions.json, launch.json; never personal settings
│
│   ── Documentation (by kind, not by app) ──────────────────────────────────────────────
├── docs/
│   ├── INDEX.md                   ● the map: question → one file
│   │
│   ├── context/                   WHY and FOR WHOM
│   │   ├── CONTEXT.md             ● domain, user or client, goal, scope, what success is
│   │   ├── GLOSSARY.md            ● term → meaning → name in the code; also project codes and the domain list
│   │   ├── vision.md              ○ long term: direction, what it might one day become
│   │   └── assignment.md          ○ school or client: assignment, criteria, deadlines, contacts
│   ├── rules/
│   │   └── RULES.md               ● content boundaries: what is never allowed
│   │
│   ├── product/                   WHAT it does, seen from the user
│   │   ├── PRODUCT.md             ○ the domains in one table + "Deliberately not"
│   │   └── <domain>.md            ○ behaviour, rules, edge cases of one domain
│   ├── design/                    HOW it looks and feels (module `design` = house-standard craft)
│   │   ├── DESIGN.md              ○ entry point for UI tasks: principles, "never", tokens, map to one craft file
│   │   ├── shared/                ○ a11y, never, glass — applies to all surfaces
│   │   ├── desktop/               ○ gate, performance, a11y + landing page/showcase craft
│   │   ├── iphone/                ○ touch, motion, materials + application/product craft
│   │   └── <project-chrome>.md    ○ lat / session / IA — project-specific, not in the kit
│   ├── architecture/              HOW it fits together
│   │   ├── ARCHITECTURE.md        ● C4 1–2, stack, dataflow, invariants, gates, hosting, what is in git
│   │   ├── security.md            ● personal data, secrets, auth, threats, Strix
│   │   ├── observability.md       ● signals, LGTM stack, correlation (runtime: module observability)
│   │   ├── performance.md         ● budgets, anti-patterns, bench (`make bench` / `perf-check`)
│   │   ├── dependencies.md        ● CVE audits, ritual, faster/safer deps (`make deps-audit`)
│   │   ├── polyglot.md            ● extra/native languages, decision tree, FFI/sidecar (`make polyglot-check`)
│   │   ├── data-model.md          ○ entities, ownership, retention (the schema itself: migrations)
│   │   └── <subsystem>.md         ○ auth, import, pipeline, ml, llm, …
│   ├── research/                  WHAT WE KNOW about the domain
│   │   ├── RESEARCH.md            ○ research questions, how sources are judged, map of the folder
│   │   ├── <topic>.md             ○ literature and domain knowledge, and which product rule rests on it
│   │   ├── wantlist.md            ○ sources you still want to acquire
│   │   ├── radar.md               ○ tech radar Adopt/Trial/Assess/Hold (`make radar-check`)
│   │   ├── digest/                ○ inbound feeds (`digest-fetch` / `digest-propose`; P5)
│   │   └── experiments/
│   │       └── YYYY-MM-DD-<slug>.md  ○ question, setup, data, result, conclusion (code: apps/<x>/experiments/)
│   ├── business/                  ○ business plan, pricing, legal, privacy policy in plain language
│   │
│   ├── how-to/
│   │   └── <task>.md              ● deploy, reset db, load data, release: one task per file
│   ├── decisions/
│   │   ├── DECISIONS.md           ○ list of active decisions, only from ±15 ADRs (until then in INDEX.md)
│   │   ├── _template.md           ● ADR template; `make adr` copies it
│   │   ├── 0000-example-native-module-after-budget-breach.md  ● example shape for polyglot (not binding)
│   │   └── NNNN-<slug>.md         ● one ADR per decision; never rewrite, only supersede
│   ├── agent/                     ○ agent working method that should NOT be loaded on every task
│   │   ├── write-rules.md         ○ which paths are free, which need permission, which never
│   │   ├── doc-conventions.md     ○ how to write a doc: notation, tables, tone
│   │   ├── lessons.md             ○ lessons on meta tasks; what applies to every task → AGENTS.md
│   │   └── prompts/<task>.md      ○ reusable prompts
│   ├── assets/                    ○ images docs show: <topic>-<what>.png (diagram preferably Mermaid)
│   ├── deliverables/              ○ delivered: report, presentation, poster, pdf; output, not truth
│   │
│   ├── work/                      STATUS (team: in the issue tracker, not here)
│   │   ├── BACKLOG.md             S index of open work: short line + link; new items via `make spec`
│   │   ├── specs/<slug>.md        S plan per item; deleted after merge (template: specs/_template.md)
│   │   ├── logs/YYYY-MM-DD.md     S what happened that day
│   │   └── meetings/YYYY-MM-DD-<with-whom>.md   ○ minutes of consultation with client, coach or team
│   └── archive/                   ○ replaced docs; the map excludes this folder
│
│   ── Code ─────────────────────────────────────────────────────────────────────────────
├── apps/                          ● every separately runnable or deployable piece, even if there is only one
│   └── <app>/                     fixed layout per stack: [stacks](stacks.md)
├── packages/                      ○ shared code that does not deploy separately: types, ui, config
│   └── <package>/
├── infra/                         ○ as soon as one compose file is not enough: IaC, db init, k8s
├── scripts/                       ● repo-wide scripts; check-links.sh (kern), bootstrap, release
├── tests/                         ○ tests across apps: end-to-end of the whole, contract tests
│
│   ── Data (fixed layers, [data](data.md)) ─────────────────────────────────────────────
├── data/
│   ├── README.md                  ● catalogue: per dataset origin, licence, PII, in git, how to recreate
│   ├── raw/                       ● raw exports and downloads; never in git; never overwrite
│   ├── external/                  ● third-party (papers, open data); never in git, only README.md
│   ├── interim/                   ● pipeline intermediate steps; never in git; always safe to delete
│   ├── processed/                 ● pipeline output; in git only small and anonymous (demo/)
│   ├── reference/                 ● hand-assembled: catalogues, mappings, seeds; in git, reviewed as code
│   ├── runtime/                   ○ what the app writes locally (uploads); production: volume or object storage
│   └── models/                    ○ trained models and their metadata; never in git (or a registry)
│
└── tmp/                           (not in git) scratch: screenshots, test reports, experiments; always safe to delete
```

**Why this layout:**

- **Docs by kind, not by app.** One fact has one place (P7). What applies only to one app lives in the nested `apps/<app>/AGENTS.md` or a `.mdc` rule (P15), not in `docs/<app>/`.
- **Four kinds of knowledge, four folders.** `product/` says *what* it does, `design/` how it looks, `architecture/` how it is built, and `research/` what you know about the domain. An agent fixing an API bug then does not load literature, and an agent building a screen does not load pipeline details.
- **Transient and past each have one place.** Status lives in `work/`, replaced docs in `archive/`, and throwaway work in `tmp/`. Everything else is truth you maintain (P8).
- **Exception to `apps/`:** the repo *is* one package that will never get a second app, such as a library, a CLI or a standalone analysis. See [stacks §8](stacks.md#8-repo-that-is-itself-one-package). When in doubt, choose `apps/`.

**Small project?** The copy script installs only the kern (●). Modules (○) arrive only when you need them, but always in their place from this tree. For a prototype or hackathon, the [minimal version](../new-project/minimal.md) is enough.

---

## What is deliberately missing

* **No `PROJECT_STRUCTURE.md` with a full folder tree inside the project.** The tree lives here, outside every project. What is not derivable (what is in git, which folder owns what, where data goes) lives in `ARCHITECTURE.md` and `data/README.md` (P5).
* **No `TODO.md` next to `BACKLOG.md`.** One place for open work (P7).
* **No `CHANGELOG.md` for internal projects.** Git and the logs are enough. A public library is the exception.
* **No copy of tool documentation** (Next.js, NestJS, pandas). Link to it, or let the agent look it up itself.
* **No `docs/<app>/`.** Docs are by kind. What applies only to one app lives in the nested `AGENTS.md`.
* **No `notebooks/` at the root.** An experiment belongs with the app whose code it uses, and the record belongs in `docs/research/experiments/`.
* **No `utils/`, `helpers/` or `misc/`.** Per stack there is one name: `lib/` in the web app, `common/` in the API.
* **No `src/` at the root next to `apps/`.** Choose one of the two ([stacks §8](stacks.md#8-repo-that-is-itself-one-package)).
* **No subfolders per category in `specs/` or `backlog/`.** A category is a column, not a folder. Otherwise an item moves when its category changes.

---
