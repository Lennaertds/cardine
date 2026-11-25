# Research

> **Role:** what we know about the domain, which sources that rests on, and which product rule depends on it.
> **Not here:** the product rules themselves (`product/`), experiment code (`apps/<app>/experiments/`).

## Programme (agents: start here)

How the LLM, this repo and the lab relate (human, once): [tour](../../bron/tour.md).
In full: [research-programme.md](research-programme.md) — A1→A2→A5→A4→A3, then A6–A9, then B. Shape and decision candidates: [ideas-and-questions.md](ideas-and-questions.md).

## State (2026-10-26, shell updated 2026-11-15)

A6–A9 have a **shape** (dual structure, check ladder, dual formats, folder spine) — no ADR yet. A1–A3/A5 partly answered (A3: DeepSeek §89–§94 + Kimi §134–§142 + Mistral §95–§101). The IDE shell is chosen: upstream Zed, no fork ([ADR 0002](../decisions/0002-the-ide-shell-is-upstream-zed-pulled-as-a-pinned-release-without-fork.md)). Indexing-first stays the lab priority. The A5 matrix is open. B waits for a human yes.

## Research questions

1. The minimal harness surface so the agent respects the standard (measurably)? → hypothesis: Pi-like + A6/A7/A9.
2. Structure (A6): **dual** — see [ideas A6](ideas-and-questions.md#a6-clarified-shape).
3. Indexing: exact/regex-first (§69); measure semantic later.
4. (A1–A5) Peers and benches before the stack ADR — [working answers](ideas-and-questions.md#working-answers-a1a5-no-adr-yet).
5. (A7) Ladder + revert — [ideas A7](ideas-and-questions.md#a7-clarified-shape).
6. (A8)/(A9) Format + spine — [A8](ideas-and-questions.md#a8-clarified-shape) / [A9](ideas-and-questions.md#a9-clarified-shape).

## How we assess sources

| Level | What counts | Use |
|-------|-------------|-----|
| A | Meta-analysis or systematic review | May carry a product rule |
| B | Randomised study | May carry a rule, with attribution |
| C | Observational, expert, blog | Only as hypothesis or experiment |

## Map of `research/`

- [research-programme.md](research-programme.md) — order, source types, where to write.
- [ideas-and-questions.md](ideas-and-questions.md) — your questions 1–9 + B; do not lose them.
- [wantlist.md](wantlist.md) — sources we still want to acquire.
- (A5) `vergelijking-harness-ide.md` — still to be written; cells with § links.
- [radar.md](radar.md) — tech radar (Adopt/Trial/Assess/Hold); `make radar-reminder` monthly.
- [digest/](digest/README.md) — inbound feeds; `digest-fetch` / `digest-propose` / `digest-week` → weekly briefs under `bron/weken/` (curate before radar/source entry).
- `experiments/` — one report per experiment: `make experiment s=<slug>`.
