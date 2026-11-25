# Research programme (before stack or fork)

> **Role:** a guideline for agents: what to research, in what order, and where to write it down.
> **Not here:** facts and summaries (those belong in `bron/`); hard stack choices (an ADR only after enough §); the raw idea list ([ideas-and-questions.md](ideas-and-questions.md)).

State: October 2026. The knowledge SSOT is **`bron/`** in this repo (`bronnen.md`, index, fundamentals). Alongside it: the lab, hypotheses and code.

## Rule: A before hard B

1. **A — research** → a new `§` in `bron/bronnen.md` (plus a row in `bronnen-index.md` and the overview).
2. **Do not lose hypotheses or ideas** → here: [ideas-and-questions.md](ideas-and-questions.md), `wantlist.md`, this file.
3. **B — choices** → an ADR in `docs/decisions/` only once A1–A2–A5 have enough axes (A6–A9 feed B without blocking it). No `--starter` and no stack until an explicit yes from the human.
4. **Building** → after that, in `apps/` or harness code.

In parallel a thin wantlist or hypothesis is fine; no "we fork X" ADR on a hunch.

## Order (mandatory)

| # | Slice | Question | Notes |
|---|--------|-------|-------------|
| A1 | Cursor | What does Cursor have; reuse, improve, or *not* touch? | §9, §13, **§69–§75** (Instant Grep, semantic, indexing, dynamic context, Composer, harness, Codex). |
| A2 | Other harnesses | Pi, DeepSeek Harness, peers. Reuse or improve? | **§76–§79** (+ §33). Build/thesis: **§105–§112**. DeepSeek Harness is not the model §. |
| A5 | Comparison | Harnesses and IDEs down to the bone: technical plus benchmarks | Matrix `vergelijking-harness-ide.md` met §-links. Ankers: **§80–§86** + **§133** (PKU Harness-Bench / Fireship Table 2). |
| A4 | IDE anatomy | Languages, fork options, integrations; editor vs harness vs indexing | Shortlist + criteria: [ADR 0002](../decisions/0002-the-ide-shell-is-upstream-zed-pulled-as-a-pinned-release-without-fork.md). Sources: native/TUI architecture, plugin/RPC, LSP — not Electron-first. |
| A3 | Open models / Mistral | Efficiency, local runtime; EU/internship | DeepSeek **§56–§58, §89–§94**; Kimi/Moonshot **§134–§142**; Mistral **§95–§101** (AA watch + Large 4). |
| A6 | Structure: docs vs code | Where does the standard live — in markdown (a prompt) only, or also enforced in the harness or app? | Zie [ideeen § A6](ideas-and-questions.md#a6-clarified-shape); **§113–§117** + §107; kit `make check`. |
| A7 | Feedback and quality loops | Which gates when (in-loop → pre-commit → check → check-full → pre-prod) and what happens on red (revert)? | Zie [ideeen § A7](ideas-and-questions.md#a7-clarified-shape); **§118–§122** + §117; kit P13. |
| A8 | Doc format per audience | Markdown for humans vs machine-first (YAML/JSON/…) for agent-only artefacts | Zie [ideeen § A8](ideas-and-questions.md#a8-clarified-shape); **§123–§127** + §14–§24. |
| A9 | Session scope / spine | Where does agent state live — the IDE chat, the repo root, a subfolder, or explicit spine files? | Zie [ideeen § A9](ideas-and-questions.md#a9-clarified-shape); **§128–§132** + §117; P27. |
| — | Other | New hits | A § in `bron/` first; then wantlist or radar here. |
| B | Choices | Stack, fork/base, what to improve, measurement plan | ADR plus `measurement/` — **not** before A5. |

Session order: **A1 → A2 → A5 → A4 → A3**, then A6–A9 (or a thin wantlist in parallel). B only after a human yes.

## Source types (not everything is YouTube)

| Slice | Typical sources | § shape |
|-------|------------------|--------|
| A1–A2 | Product docs, engineering blogs, repo READMEs, video as a mechanism | A dense § like §69 |
| A3 | Papers, model cards, inference blogs (existing §56 and up) | A § plus fundamentals where needed |
| A4 | Zed/VS Code architecture, extension API, LSP spec, fork comparisons | A § per source or bundle; no marketing TL;DR |
| A5 | SWE-bench / ACI / harness papers plus our own measurement conditions | The matrix here; numbers only with a § |
| A6 | Empirical AGENTS evidence (§20); enforcement (§107–§108, **§113–§117**); kit checks | **Shape** in the ideas file (dual + table); experiment after the stack |
| A7 | The kit check ladder; **§118–§122** (+ §117); Strix §47 | **Shape** (ladder + revert sentence); experiment after the stack |
| A8 | §14–§24 + **§123–§127** | **Shape** (dual rule + format table) |
| A9 | P27; **§128–§132**; §76/§77/§112 | **Shape** (C′ plus the `.agent/` gitignore); pain notes optional |

The prompt for a dense video § stays: `bron/fundament/prompts/youtube-samenvatting.md`. For non-video sources the same requirements apply (type, URL, mechanism, what I take away, no invention).

## Where to write

| What | Where | Not |
|-----|------|------|
| Facts, mechanisms, figures, benchmarks | **`bron/bronnen.md`** (§) plus the index | Do not duplicate them here |
| Depth | `bron/fundament/` when a § is too short | Always-on in AGENTS |
| Raw questions / hypotheses | [ideas-and-questions.md](ideas-and-questions.md) | Presenting them as fact |
| Sources still to read | [wantlist.md](wantlist.md) | |
| Comparison matrix | `vergelijking-harness-ide.md` (still to be written) with § links | Numbers without a § |
| Hard choices | `docs/decisions/*.md` (ADRs) | Before A5 is done |
| Actionable work | `make spec` → BACKLOG + `specs/<slug>.md` | Long essays in BACKLOG |
| Changing the kit or standard | Only through the bridge plus a human yes | Never "just tweak the kit" from this lab |

## Known anchors (do not re-open empty §)

- IDE docs and rules: §9, §13, §14, §20
- Harness / tax / Pi: §5, §25, §30, §33; build/thesis **§105–§112**; A6 **§113–§117**; A7 gates **§118–§122** (enforcement §107)
- DeepSeek **models** and infrastructure: §56–§58, §60, **§89–§94** (not the coding harness §77)
- Kimi/Moonshot (A3 peer): **§134–§142** (lineage, K2→K3.1, MuonClip, KDA, Kimi Code, AA Cyber)
- Mistral (EU/A3): **§95–§101**; AA provider watch §95 + coding §80
- Cursor search and index today: **§69**
- Measuring: `measurement/` plus §19/§20; the A7 ladder ↔ C4 "without check"
- Doc shape: §14–§16, §22–§24; A8 **§123–§127**; A9 session scope **§128–§132** (P27)

Next free § number: see `bron/INDEX.md` (currently after **§142**). Clusters: A5 **§80–§86** + **§133**; DeepSeek **§89–§94**; Kimi **§134–§142**; Mistral **§95–§101**; listicles **§102–§104**; harness building **§105–§112**; A6–A9 **§113–§132**.

## Hypotheses (no ADR yet) — sharpened 2026-10-26

Detail and tables in [ideas-and-questions.md](ideas-and-questions.md). In brief:

- **v1:** own **indexing** (exact-first) + a reused harness (Pi/DSH-like) + **upstream Zed** as the IDE shell ([ADR 0002](../decisions/0002-the-ide-shell-is-upstream-zed-pulled-as-a-pinned-release-without-fork.md)) — no IDE fork, no IDE from scratch, no Electron, no inference serving.  
- **The angle over Cursor:** indexing at the core (§69), plus structure enforcement, the check ladder, a folder spine and dual formats — not feature parity.  
- **Default LLM:** DeepSeek API (cost); Kimi as a peer for quality and cyber (§142); frontier optional.  
- **H×M:** ranking transfer ≈0 (§83); always measure the harness too (§81).  
- **A6 shape:** dual — AGENTS as a table of contents of about 100 lines or fewer; hard rules in checks and hooks.  
- **A7 shape:** `make check` required at the end of a slice; check-full and opt-in are heavier; red → no push, restore.  
- **A8 shape:** audience → format; ADRs stay Markdown.  
- **A9 shape:** spine in `<cwd>/.agent/` (gitignored); the chat may be empty after a path change.

## Purpose of this lab (context)

A solo learning lab (plus a thesis reader later; productisation is conditional). Success = a measurable agent loop that respects the standard. See [CONTEXT.md](../context/CONTEXT.md).
