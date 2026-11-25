# Agent roles and subagents

> **Role:** Which role goes with which kind of task, which docs/code that role opens, and when to start a Cursor subagent instead of just the read route.
> **Not here:** the kit files themselves ([kit](../kit/README.md)), how to fill them in ([sjablonen/cursor-agents](../sjablonen/cursor-agents.md), [agents-root](../sjablonen/agents-root.md)).

Two layers (P2, P24, P25):

| Layer | Where | When |
|-------|-------|------|
| **Read route** | One line in `AGENTS.md` § Works | Always for that kind of task; cheap; works for every tool |
| **Subagent** | `.cursor/agents/<role>.md` | On *subagents* / *delegate* / *parallel*, large multi-track work, or a review of your own diff — its own context window |

No long role essays in `AGENTS.md`. Detail lives in the map (`DESIGN.md`, `PRODUCT.md`, …) and in the agent file. Obs/perf/deps/polyglot/radar have **no** read route of their own and no fixed subagent: only an INDEX plus the task that names them.

## Roles

| Role | Triggers (examples) | Open first | Then code / data | Kit file |
|------|---------------------|------------|------------------|----------|
| **ui** | UI, screen, layout, PWA, look, craft | `docs/design/DESIGN.md` → one craft | `apps/web/src/features/`, `components/ui/`, tokens | module `design` → `.cursor/agents/ui.md` |
| **product** | feature, behaviour, acceptance, domain rule | `docs/product/PRODUCT.md` → one domain | `apps/*/src/.../<domain>/` | module `product` → `.cursor/agents/product.md` |
| **architecture** | seams, containers, modules, dataflow | `docs/architecture/ARCHITECTURE.md` → one subsystem | along existing seams; no new `utils/` | module `cursor` → `.cursor/agents/architecture.md` |
| **research** | research, analysis, literature, experiment | `docs/research/RESEARCH.md` → one topic/experiment | `apps/analytics/` or `pipeline/`, `data/` (do not write `raw/`) | module `research` → `.cursor/agents/research.md` |
| **reviewer** | review, check diff, fresh eyes, after implementation | the task/spec + the diff the parent handed over | readonly; `make check` | module `cursor` → `.cursor/agents/reviewer.md` |
| **clarify** | check my prompt, is this clear, `/clarify` | only the user prompt (+ @-files) | no code; score + rewritten prompt | module `cursor` → `.cursor/agents/clarify.md` |

App pitfalls stay in `apps/<app>/AGENTS.md` (P15), not in the role files.

**Clarify is never always-on.** Running every task through a subagent first costs roundtrips (P25) and clashes with *doing beats talking*. Call it when you are in doubt, or after two failed corrections (§12).

## When the main agent delegates

Delegate (subagent) if at least one applies:

1. The user says *subagents*, *delegate*, *parallel*, or `/<role>`.
2. The work has **several independent tracks** (e.g. UI + API) that can run in parallel.
3. **Review of your own diff** in the same session — reviewer subagent or a new session (P24, source §1).
4. Deep **search/analysis work** that would pollute the main context; the parent wants only the summary.

Stay in the main agent for one narrow slice with one read route.

## Task shapes (orchestrator)

The parent plans and synthesises; specialists execute. Every arrow is a handoff with short, structured output.

```text
UI fix
  main ──read route──▶ DESIGN (+ /ui if needed)
  main ──▶ reviewer   (optional, after the fix)

Feature slice
  main|product ──▶ domain doc + slice
  main ──▶ implementation (or architecture if seams are unsure)
  main ──▶ reviewer     (spec + anti-smell, clean context)

Analysis / research
  main|research ──▶ RESEARCH + sources
  main ──▶ product or experiment doc if it produces a claim

Large change (parallel)
  main ──▶ architecture (boundaries)  ║  research/ui/product (tracks)
  main ──▶ implementation per slice
  main ──▶ reviewer
```

## Examples: prompt → approach

### 1. UI fixes with attachments

```text
UI fixes following the attachments, in order:
1) The bar is too big and does not fit on screen
2) …
Use subagents where it helps.
```

| Step | Who | What |
|------|-----|------|
| 1 | main | Read route UI → `DESIGN.md` → one craft (not just the screenshot) |
| 2 | `/ui` or main | Fixes **in the given order**, one screen/component at a time |
| 3 | optional `/reviewer` | Diff vs. craft + "fits on screen" |

Without a craft doc or screen name: `/clarify` first, or one question ("which screen / which bar?").

### 2. Unclear backlog ToDo

```text
This ToDo @docs/work/BACKLOG.md (line …) is really unclear and badly written, fix it
```

| Step | Who | What |
|------|-----|------|
| 1 | main | Open the backlog item + the linked spec if there is one |
| 2 | main (solo) | Rewrite the **one line** in BACKLOG and/or the spec (`make spec` if missing): goal, scope, done-when |
| — | not | No building a feature; no `/ui` — this is work/docs, not product code |

Unsure whether "fix" means text or implementation: `/clarify` first.

### 3. Explain data → analysis and simplify it

```text
What is the step-by-step path from the raw data to the analysis, and explain it.
I think we can do this more simply.
```

| Step | Who | What |
|------|-----|------|
| 1 | main or `/architecture` | `ARCHITECTURE.md` (dataflow) + `data/README.md` |
| 2 | `/research` if it involves an experiment/literature | Otherwise analytics paths via `apps/analytics/` |
| 3 | main | Explanation in steps; a simplification proposal as **options + impact**, not a silent rewrite of the pipeline |
| 4 | on agreement "simplify" | New slice/ADR; not everything in one session |

### 4. Check the prompt first

```text
/clarify
UI fixes following the attachments: 1) bar too big 2) …
```

| Step | Who | What |
|------|-----|------|
| 1 | `/clarify` | Score, missing info, rewritten prompt |
| 2 | you | Paste the better prompt or answer the questions |
| 3 | main/`/ui` | Only then execute |

### 5. Build a feature (clear)

```text
Implement slice 2 from @docs/work/specs/diet-budget.md. Use subagents.
```

| Step | Who | What |
|------|-----|------|
| 1 | `/product` or main | `PRODUCT.md` → domain doc; respect the slice boundaries |
| 2 | main | Code following existing modules |
| 3 | `/reviewer` | Spec compliance + `make check` |

## Harness tax

- At most one read-route line per role in `AGENTS.md`.
- Keep subagent files short; no copy of `AGENTS.md`.
- Module `cursor` installs the shared agents (`architecture`, `reviewer`, `clarify`) and the rule *subagents → `.cursor/agents/`*; `design` / `product` / `research` install their own role agent.
- No clarify before routine tasks that already have a path, an order and a "done when".

