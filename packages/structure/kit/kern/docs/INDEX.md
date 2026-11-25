# {{PROJECT}} — docs map

> One entry point for all documentation. Pick the file for your question and open only that one.
> Working method and commands: [AGENTS.md](../AGENTS.md).

## Context — why and for whom

- [CONTEXT.md](context/CONTEXT.md) — Domain, user or client, goal, scope. Not: technical detail.
- [GLOSSARY.md](context/GLOSSARY.md) — What a term means and what it is called in the code. Also the list of domains.
<!-- als: vision
- [vision.md](context/vision.md) — Long-term direction. Not: what is being built now.
-->
<!-- als: assignment
- [assignment.md](context/assignment.md) — The assignment, the assessment criteria and the deadlines.
-->

## Rules — what is never allowed

- [RULES.md](rules/RULES.md) — Content boundaries. Not: code style or working method.
<!-- als: product

## Product — what it does

- [PRODUCT.md](product/PRODUCT.md) — Domains and what we deliberately do not. One file per domain: `product/<domain>.md`.
-->
<!-- als: design

## Design — how it looks

- [DESIGN.md](design/DESIGN.md) — Start here on every UI task: principles, what is never allowed, tokens, map to one craft file.
-->

## Architecture — how it fits together

- [ARCHITECTURE.md](architecture/ARCHITECTURE.md) — Containers, stack, dataflow, invariants, seams, hosting. Start here for "where is X". Not: PWA/auth catalogue → subsystems.
- [security.md](architecture/security.md) — Personal data, secrets, auth principles, Strix. Extensions: `## Deliberately later` (P28).
- [observability.md](architecture/observability.md) — Signals, LGTM, `make obs-*` (opt-in; only if the task names it).
- [performance.md](architecture/performance.md) — Budgets, anti-patterns, `make bench` / `perf-check` (opt-in).
- [dependencies.md](architecture/dependencies.md) — CVE audits, ritual, `make deps-audit` (opt-in).
- [polyglot.md](architecture/polyglot.md) — Extra languages after measurement + ADR; a native folder only with that stack (opt-in).
- [<subsystem>.md](architecture/<subsystem>.md) — <Which question; e.g. runtime-client, auth, data-model>. Not: <adjacent question → other file>.
<!-- als: research

## Research — what we know about the domain

- [RESEARCH.md](research/RESEARCH.md) — Research questions, how sources are judged, map of `research/`. Do not load on code work.
- [wantlist.md](research/wantlist.md) — Sources we still want to acquire.
- [radar.md](research/radar.md) — Tech radar (Adopt/Trial/Assess/Hold); `make radar-reminder` / `radar-check`.
- [digest/](research/digest/README.md) — Inbound digest; `digest-fetch` / `digest-propose` (no auto-radar).
- `research/experiments/` — One report per experiment, with a date. Search with `rg`.
-->
<!-- als: business

## Business

- `business/` — Business plan, pricing, terms, privacy policy in plain language.
-->

## How-to — running a task

- [security-scan.md](how-to/security-scan.md) — Install Strix and run `make security-scan`.
- [perf-bench.md](how-to/perf-bench.md) — `make perf-check` / `make bench` and the app scripts.
- [deps-audit.md](how-to/deps-audit.md) — `make deps-audit` and the audit tools.
- [native-ci.md](how-to/native-ci.md) — Soft vs `NATIVE_STRICT` / `check-full` / `native.yml`.
<!-- als: research
- [radar.md](how-to/radar.md) — Revise the tech radar (`make radar-reminder` / `radar-check`).
- [digest.md](how-to/digest.md) — Digest fetch/propose (`digest-check` / `digest-fetch` / `digest-propose`).
-->
- [<task>.md](how-to/<task>.md) — <When you need this>.

## Decisions — why it is the way it is

- `decisions/` — One ADR per decision. New: `make adr t="<decision as a sentence>"`. Active:
  - [0000 — Example native module](decisions/0000-example-native-module-after-budget-breach.md) — template shape (status *example*); copy it with `make adr`, do not treat it as fact.
  - [<NNNN> — <title>](decisions/<NNNN-slug>.md)
<!-- als: solo

## Work — status (do not read up front)

- [BACKLOG.md](work/BACKLOG.md) — Index of open work (short line + link). New item: `make spec s=<slug>`.
- `work/specs/` — Plan per item; deleted after merge.
- `work/logs/` — Daily logs. Search with `rg`, do not load.
-->
<!-- als: team

## Work — status

- In the issue tracker: <link>. Not in the repo.
-->
<!-- als: meetings
- `work/meetings/` — Minutes of meetings. What was decided lives in an ADR.
-->
<!-- als: agent

## Agent — only when writing or on meta tasks

- [write-rules.md](agent/write-rules.md) — Which paths are free, which need permission.
- [doc-conventions.md](agent/doc-conventions.md) — How to write a doc.
- [lessons.md](agent/lessons.md) — Lessons after failures on meta tasks.
-->

## Data

- [data/README.md](../data/README.md) — Which dataset sits where, origin, licence, what may go into git.
<!-- als: deliverables

## Do not read up front

- `deliverables/` — Delivered pieces, as submitted. Not truth.
-->
<!-- als: archive
- `archive/` — Replaced documents. For history only.
-->
