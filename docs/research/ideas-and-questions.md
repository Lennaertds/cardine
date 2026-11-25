# Ideas and open questions (do not lose them)

> **Role:** your raw questions and hypotheses — recorded before they land in a § or an ADR.
> **Not here:** facts with a URL (§ in `bron/`); hard choices (`docs/decisions/`); implementation plan (`specs/`).

State: 2026-11-07 (A4/B direction: a light non-Electron IDE plus indexing-first; A6–A9 still taking shape). Source of the **order**: [research-programme.md](research-programme.md). Status: `open` / `partial (§…)` / `shape` (decision candidate, no ADR yet) / `later B`.

## A — Research (facts → `bron/` sources)

| # | Your question (paraphrased) | Slice | Status | Note |
|---|------------------------|-------|--------|-----------|
| 1 | What does Cursor have; reuse, improve, or leave alone? | A1 | partial (§9, §13, **§69–§75**) | Working answer ↓; Cloud/Router blogs optional |
| 2 | Other harnesses (DeepSeek Harness, Pi, peers); reuse or improve? | A2 | partial (**§76–§79**, **§105–§112**, §33) | Working answer ↓; enforcement over prompts (§107) |
| 3 | Mistral and open-source models / efficiency? | A3 | partial (**§89–§101**, **§134–§142**) | Working answer ↓; Large 4 LICENSE; Kimi peer |
| 4 | How is an IDE put together: languages, fork, integrations? | A4 | open (names §102–§104) | Direction: non-Electron shortlist — see [ADR 0002](../decisions/0002-the-ide-shell-is-upstream-zed-pulled-as-a-pinned-release-without-fork.md) |
| 5 | Compare IDEs and harnesses down to the bone | A5 | partial (**§80–§86**, **§133**) | Working answer ↓; PKU Harness-Bench Table 2; matrix still |
| 6 | Standard in **docs** vs in **code/harness**? | A6 | **shape** (§113–§117 + §107) | Decision candidate + docs/code table ↓ |
| 7 | Which **quality gates**, when, and what turns them red? | A7 | **shape** (§118–§122 + §117) | Lab ladder + revert sentence ↓ |
| 8 | Which **format** per kind of document? | A8 | **shape** (§123–§127) | Dual rule + format table ↓ |
| 9 | Where does the **session/spine** live when the directory changes? | A9 | **shape** (§128–§132 + §117) | Scope C′ + path/gitignore ↓ |

---

## Working answers A1–A5 (no ADR yet)

A synthesis of existing § — enough to *aim* B, not enough to fork.

### A1 — Cursor

- **Reuse (ideas, not code):** exact/regex-first search (§69) over the embeddings dogma; dynamic context discovery / files as tools (§72); path-scoped rules (§13/§127); keep rate / tool errors as the measurement lens (§74).  
- **Do not chase:** feature parity with Composer/Cloud Agents; a Cursor fork.  
- **Improve over Cursor (the lab angle):** `structure` (enforce policy, A6) + the quality ladder (A7) + a spine that survives a path change (A9) — exactly where Cursor's history fails (§132).

### A2 — Other harnesses

- **Pi (§76/§33):** a minimal TS surface, sessions/tree, packages — the strongest *learning* basis for a "narrow harness".  
- **DSH (§77):** plugin boundaries, session log visible to the model — good for seams, not necessarily a fork.  
- **Cline/OpenCode (§78–§79):** peers for permissions/AGENTS, not the default stack.  
- **Build lessons (§105–§112, §107):** task–harness fit; instructions ≠ enforcement; long-running work needs progress/handoff.  
- **Direction B (hypothesis):** a lean TS harness with Pi's surface, not a full IDE; plugins later.

### A3 — Open models / Mistral

- **Default lab LLM:** the DeepSeek API (cost frontier §80; lineage §89–§94) — your own key.  
- **Kimi/Moonshot peer:** lineage **§134–§142** (K2→K3.1 Pro; MuonClip; KDA; Kimi Code). AA Cyber: K3.1 Pro ~64% vs DS Flash 1017 ~57% (§142); DeepSeek stays cheaper and faster. Measure H×M with both later.  
- **Mistral:** EU/internship motivation plus watching Large 4 (§95–§101); no sole model until the licence and weights are clear.  
- **Local:** optional later (the inference chapter); lab day zero = API.

### A4 — IDE anatomy

- **editor ≠ harness ≠ indexing.** Lab primary = **indexing / Project-Understanding**; reuse the harness; IDE shell = upstream Zed, pinned release, no fork ([ide-shell](../product/ide-shell.md), [ADR 0002](../decisions/0002-the-ide-shell-is-upstream-zed-pulled-as-a-pinned-release-without-fork.md)).
- Component map: [totaalproduct.md](../product/totaalproduct.md) (9 parts). Shortlist criteria: recorded in [ADR 0002](../decisions/0002-the-ide-shell-is-upstream-zed-pulled-as-a-pinned-release-without-fork.md). Indexing: [indexing.md](../product/indexing.md).  
- Listicles (§102–§104) are a name map with low authority. Depth = native/TUI architecture + plugin/RPC surface (wantlist), not VS Code-first.

### A5 — Comparison

- **Binding Constraint (§81):** scores without harness disclosure mislead — always state H×M.  
- **SWE-Pro / Meta-Harness (§83):** ranking transfer ≈0; the harness often wins more than a model swap.  
- **HarnessTax (§85):** cost-dominant on some benches; Pi is often Pareto-interesting.  
- **PKU Harness-Bench (§133, arXiv:2605.27922):** 106×6×8; NanoBot **76.2** vs OpenClaw **52.4** (−23.8 pp) on the same model pool; NanoBot also used the fewest tokens; Codex* separate (model-bound). Stronger models → less H variance. Confirms "narrow loop" and measuring H×M. Not the same as TheLime1 §84.  
- **Lab measurement plan later:** fixed H, vary M (DeepSeek vs Kimi vs frontier); C4 "without check" as the baseline (A7). The matrix file `vergelijking-harness-ide.md` is still to be written.

---

## A6 — clarified + shape

### What the question is *not* and *is*

- Not: which principles; not "better prose in AGENTS"; not the stack (B).
- Yes: where the standard *executes* in the `structure` domain — docs / code / dual.

### Spectrum

| Option | Example | Cost | Failure mode |
|------|-----------|------|-----------|
| **A — Docs only** | Long AGENTS/RULES | Tokens + drift | Ignored (§20, §107) |
| **B — Code only** | Hooks/checks alone | Maintenance; rigidity (§108) | Intent unreadable for a human |
| **C — Dual** | Short intent MD + runtime | Both, docs thin | Drift when docs ≠ code |

### Decision candidate (no ADR yet)

> **structure = dual (C):** `AGENTS.md` of roughly 100 lines or fewer = table of contents and intent; hard rules in `make check` / path allowlist / hooks; detail in `docs/`, read JIT. Never leave "Never X" in prose alone when it is checkable (§113–§115).

### Lab v1 — what lives where

| Kind of rule | Docs (MD) | Code / check / hook | Both |
|-------------|-----------|---------------------|-------|
| Intent, "why", navigation | ✓ (short) | | |
| Build/test commands | ✓ (pointer) | ✓ (`make …`) | ✓ |
| Lint/style | pointer | ✓ (linter) | |
| No secrets in git / raw data | ✓ (RULES) | ✓ (gitignore, hooks) | ✓ |
| Path allowlist / no writes outside apps | short prohibition | ✓ (PreToolUse / a seam test later) | |
| Architectuur-seams | ARCHITECTURE | later structural test | ✓ |
| "Done" / verify | "run make check" | ✓ stop/check (A7) | ✓ |

### Measuring (after the stack)

Both: tokens (AGENTS size × turns) plus compliance (RULES breach / red check). A light sample.

---

## A7 — clarified + shape

### What it is

Gates **when** plus behaviour on **red** — not a unit-test inventory or a CI vendor.

### Lab v1 ladder

| Gate | Lab v1 | Agent on red |
|------|--------|----------------|
| In-loop (LSP / targeted test) | **Recommended** during a slice | Fix or stop; no "done" |
| `make check` | **Required** at the end of a slice / before finishing | Do not finish; fix or **restore the slice** |
| pre-commit | **Required** as a subset of check (when hooks are on) | Refuse the commit |
| `make check-full` | Pre-merge / pre-release | Do not merge |
| Opt-in (Strix, obs, perf, …) | Pre-prod / on risk | Separate; **never** always-on in `check` (P25) |

### Revert policy (one sentence)

> Red `make check` → no push; no "done"; fix or `git restore`/`checkout` the slice — the harness may later attach a stop hook to `make check` (§118–§121).

### Commit default (proposal)

No push without a green check. Committing on a feature branch is fine when pre-commit is green (WIP allowed locally).

---

## A8 — clarified + shape

### Decision candidate

> **Audience decides the format:** human-facing = Markdown; agent- or tool-only (logs, traces, metrics, ledger) = schema'd JSON/JSONL/YAML plus a check or tool. No secrets in MD; no human intent in JSON alone without a short MD summary (§123–§126).

### Lab v1 — path → format

| Path / glob | Format | Who reads | May the agent write? |
|------------|---------|-----------|----------------------|
| `docs/product\|rules\|architecture\|how-to/**/*.md` | MD | Human (+ JIT) | Yes (slice); links checked |
| `AGENTS.md`, `.cursorrules` | MD (thin) | Agent (+ human skim) | Limited; no oracle edits |
| `docs/decisions/*.md` | MD (+ optional YAML front matter later) | Human | Yes, via `make adr` |
| `docs/work/**` (BACKLOG, specs, logs) | MD | Human | Yes, via make targets |
| `.pre-commit-config.yaml`, `**/tasks.yaml`, compose | YAML | Tools | Rarely; human/CI |
| `data/runtime/**`, agent transcripts | JSON/JSONL / binary | Agent + debug | Yes; **gitignored** |
| Skills / `.mdc` | MD + YAML front matter | Loader + agent | Yes, where the skill path lives |
| Spine (A9): `.agent/` or `.planning/` | JSONL + a short `STATUS.md` | Agent (+ human reads STATUS) | Yes; see the A9 ignore rule |

ADR: MD stays the source of record; optional front matter or index later (§126) — no parallel YAML canon.

---

## A9 — clarified + shape

### Product pain

Cursor's history hangs on the **workspace path** (§132). Going up a level or to a different root gives an empty or wrong chat. P27: the spine lives outside the chat.

### Options → candidate

| Option | Lab v1 verdict |
|------|----------------|
| A — IDE chat only | **Rejected** as the only source (§132) |
| B — One session in the repo root | Too coarse for multiple apps |
| C — Per folder / worktree | **Chosen core** (§129, §131) |
| D — Explicit session id | **Complement** (tool sessions of Pi/Claude under `~/…`, §128/§130) — not instead of a repo spine |

**C′ (proposal):** the active working directory (app/cwd or git worktree) carries the spine files; the IDE chat may be empty after a path change.

### Convention (lab v1, no ADR yet)

| Item | Proposal |
|------|----------|
| Path | `<cwd>/.agent/` (or `.planning/` if a skill enforces that) |
| Content | `status.md` (human, short) + `ledger.jsonl` (machine) + optional `progress.md` |
| Git | **gitignore** `.agent/` / `.planning/` (ephemeral); keep deliberately via `make log` / `docs/work/logs/` |
| Chat | May keep a summary; the source of record for "what was tried and worked" is the spine (§117, §131) |
| Tool sessions | Claude/Pi sessions under home keyed on cwd keep existing; the lab does not trust them across workspace boundaries |

---

## B — Choices on paper (after enough A)

Not to be executed now. Only after A1–A2–A5 (at minimum) plus an explicit yes. A6–A9 **feed** this list:

| B question | Current directional hypothesis (no ADR yet) |
|---------|--------------------------------------|
| Stack | Own **indexing** + a reused harness (Pi/DSH-like) + a light **non-Electron** IDE shell |
| Base | Fork or coupling after the A4 score (Zed/Lapce/Helix/Neovim/Kate); no Electron; no IDE from scratch; Cursor may stay the host temporarily until an ADR |
| Improving over Cursor | **Indexing** exact-first (§69) at the core; plus structure (A6), the check ladder (A7), a folder spine (A9) and dual formats (A8); no Cloud/Composer parity |
| Measurement plan | Fixed H, vary M; C4 without a check vs check+revert; tokens × compliance (A6); measure indexing quality separately |
| Default LLM | DeepSeek API (cost); Kimi peer (§142); frontier optional; **no** own inference serving |

Recorded as ADRs in `docs/decisions/` — see the programme § B.

## Other ideas (parked)

| Idea | Where later |
|------|----------------|
| Own API keys (DeepSeek etc.) | CONTEXT/RULES; harness config after the stack |
| Free product / portfolio / OS vs closed | BACKLOG § Parked, productisation |
| Thesis reader as a second persona | CONTEXT |
| Internship at Mistral (Paris) / EU AI | Motivation A3; §95–§101 — no application plan here |

## How we approach this (brief)

See [research-programme.md](research-programme.md). A6–A9 have decision candidates; A4, the A5 matrix and experiments after the stack stay open. No kit edit and no ADR without a yes.
