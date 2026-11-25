# Cardine — docs map

> One entrance to all documentation. Pick the file that matches your question and open only that.
> Workflow and commands: [AGENTS.md](../AGENTS.md).

## Context — why and for whom

- [CONTEXT.md](context/CONTEXT.md) — Domain, user or customer, goal, scope. Not: technical detail.
- [GLOSSARY.md](context/GLOSSARY.md) — What a term means and what it is called in the code. Also the list of domains.

## Rules — what never happens

- [RULES.md](rules/RULES.md) — Substantive boundaries. Not: code style or workflow.

## Product — what it does

- [PRODUCT.md](product/PRODUCT.md) — Overview + what is deliberately not included.
- [totaalproduct.md](product/totaalproduct.md) — How the 9 parts relate.
- Per part (maintained): [ide-shell](product/ide-shell.md) · [fs-events](product/fs-events.md) · [indexing](product/indexing.md) · [tools](product/tools.md) · [harness](product/harness.md) · [llm](product/llm.md) · [structure](product/structure.md) · [agent-ui](product/agent-ui.md) · [session-spine](product/session-spine.md).

## Architecture — how it fits together

- [ARCHITECTURE.md](architecture/ARCHITECTURE.md) — Containers, stack, dataflow, invariants, seams, hosting. Start here for "where is X". Not: PWA/auth catalogue → subsystems.
- [security.md](architecture/security.md) — Personal data, secrets, auth principles, Strix. Extensions: `## Deliberately later`.
- [test_prompt.md](architecture/test_prompt.md) — Prompt to measure the Zed/DeepSeek cage in whichever repo is open.
- [observability.md](architecture/observability.md) — Signals, LGTM, `make obs-*` (opt-in; only when the task mentions it).
- [performance.md](architecture/performance.md) — Budgets, anti-patterns, `make bench` / `perf-check` (opt-in).
- [dependencies.md](architecture/dependencies.md) — CVE audits, the ritual, `make deps-audit` (opt-in).
- [polyglot.md](architecture/polyglot.md) — Extra languages after measuring + ADR; native directory only with that stack (opt-in).
- (Subsystems such as `runtime-client.md` / auth follow after the runtime choice, if needed.)

## Research — what we know about the domain

- [RESEARCH.md](research/RESEARCH.md) — Research questions, how sources are assessed, map of `research/`. Do not load during code work.
- [Tour LLM→lab](../../bron/tour.md) — Continuous narrative (tracks 2+3); not for code work.
- [research-programme.md](research/research-programme.md) — Order A1…B, source types, where § vs ADR.
- [ideas-and-questions.md](research/ideas-and-questions.md) — Raw questions/hypotheses (do not lose them).
- [wantlist.md](research/wantlist.md) — Sources we still want to acquire.
- [radar.md](research/radar.md) — Tech radar (Adopt/Trial/Assess/Hold); `make radar-reminder` / `radar-check`.
- [digest/](research/digest/README.md) — Inbound digest; `digest-fetch` / `digest-propose` (no auto-radar).
- `research/experiments/` — One report per experiment, with a date. Search with `rg`.

## How-to — performing a task

- [security-scan.md](how-to/security-scan.md) — Install Strix and run `make security-scan`.
- [perf-bench.md](how-to/perf-bench.md) — `make perf-check` / `make bench` and app scripts.
- [deps-audit.md](how-to/deps-audit.md) — `make deps-audit` and audit tools.
- [native-ci.md](how-to/native-ci.md) — Soft vs `NATIVE_STRICT` / `check-full` / `native.yml`.
- [radar.md](how-to/radar.md) — Review the tech radar (`make radar-reminder` / `radar-check`).
- [zed-dsh.md](how-to/zed-dsh.md) — Zed + DeepSeek Harness + API key on the lab path.
- [digest.md](how-to/digest.md) — Digest fetch/propose (`digest-check` / `digest-fetch` / `digest-propose`).
- [sandbox-troubleshoot.md](how-to/sandbox-troubleshoot.md) — Solving bwrap/sandbox problems.
- [status-jarvis-dsh.md](how-to/status-jarvis-dsh.md) — Status check for DSH, Jarvis and the whole environment.
## Decisions — why things are the way they are

- `decisions/` — One ADR per decision. New: `make adr t="<decision as a sentence>"`. In force:
  - [0000 — Example native module](decisions/0000-example-native-module-after-budget-breach.md) — template shape (status *example*); copy via `make adr`, do not treat as fact.
  - [0001 — Runtime stack deliberately deferred until the Pi/TS choice](decisions/0001-runtime-stack-deliberately-deferred-until-an-explicit-pi-or-ts-choice.md)
  - [0002 — The IDE shell is upstream Zed, no fork](decisions/0002-the-ide-shell-is-upstream-zed-pulled-as-a-pinned-release-without-fork.md)
  - [0003 — The agent loop is upstream DeepSeek Harness, no fork](decisions/0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md)
  - [0004 — The standard is dual: a thin AGENTS.md and a hard make check](decisions/0004-the-project-standard-is-dual-a-thin-agents-md-and-a-hard-make-check.md)
  - [0005 — The conversation stays the Zed and DSH session, without a repo spine](decisions/0005-the-conversation-remains-the-zed-and-dsh-session-without-repo-spine.md)
  - [0006 — The agent searches via jarvis; Zed search and LSP stay with the editor](decisions/0006-the-agent-searches-via-jarvis-as-mcp-zed-search-and-lsp-stay-with-the-editor.md)
  - [0007 — Workspace allowlist, shell under bwrap](decisions/0007-tool-approval-is-a-workspace-allowlist-and-the-shell-runs-under-bwrap.md)
  - [0008 — The coding model is deepseek-flash, Claude is the second](decisions/0008-the-coding-model-is-deepseek-flash-and-claude-is-the-second-provider.md) — applies to the API-key path
  - [0009 — The product is the free project structure and a guide to the agent paths](decisions/0009-the-product-is-the-free-project-structure-and-a-guide-to-the-agent-paths.md)
  - [0010 — The meta package points to separate packages and three Zed paths](decisions/0010-the-meta-package-points-to-separate-packages-for-structure-and-three-zed-paths.md)
  - [0011 — The stack follows decision docs and an approval against a catalogue](decisions/0011-the-stack-follows-decision-docs-and-an-approval-against-a-catalogue.md)
  - [0012 — First the personal stack on Arch Linux Hyprland](decisions/0012-the-next-completion-is-the-personal-stack-on-arch-linux-hyprland.md)
  - [0013 — Cardine is the public shop window and mirrors the structure](decisions/0013-cardine-is-the-public-shop-window-and-pulls-the-structure-from-agent-engineering.md)
   
  Context docs (not ADRs, but background to decisions):
   - [packages-context.md](decisions/packages-context.md) — Why meta, lab, structure, and the research questions that preceded them

Distinction research vs decisions: [AGENTS.md](../AGENTS.md) § Research vs decisions.

## Work — status (do not read upfront)

- [BACKLOG.md](work/BACKLOG.md) — Index of open work (short line + link). New item: `make spec s=<slug>`.
- `work/specs/` — Plan per item; removed after merge.
- `work/logs/` — Day logs. Search with `rg`, do not load.

## Packages — design documentation

- [packages/INDEX.md](packages/INDEX.md) — Overview of all packages
- [packages/cardine-lab.md](packages/cardine-lab.md) — cardine-lab package
- [packages/cardine-structure.md](packages/cardine-structure.md) — cardine-structure package
- [packages/cardine-meta.md](packages/cardine-meta.md) — Meta package cardine
- [packages/VERSIONING.md](packages/VERSIONING.md) — Versioning and changelogs
- [packages/IMPLEMENTATION.md](packages/IMPLEMENTATION.md) — Implementation plan (phasing)

## Packages — specs (open work only)

| Spec | Status |
|------|--------|
| [bootstrap-no-stack-until-adr](work/specs/bootstrap-no-stack-until-adr.md) | open (guardrail) |

## Agent — only for writing or meta tasks

- [write-rules.md](agent/write-rules.md) — Which paths are free, which need permission.
- [doc-conventions.md](agent/doc-conventions.md) — How to write a doc.
- [lessons.md](agent/lessons.md) — Lessons after failures in meta tasks.

## Data

- [data/README.md](../data/README.md) — Which dataset lives where, origin, licence, what may go in git.
