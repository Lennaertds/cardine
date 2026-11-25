# Spec — tokenlogger

> **Role:** Plan for one work item. Temporary: delete after merge; the code and the tests are the truth then.

- **Item:** [BACKLOG.md](../BACKLOG.md) · branch `feat/tokenlogger`
- **Status:** open

## Goal

Track per turn and per session how many tokens (input + output) the LLM calls cost, so the lab gains insight into usage and efficiency and can feed the H×M measurements.

## Scope

- **In:**
  - Token logger as a harness module that logs input/output tokens on every LLM call.
  - Log format: per call with timestamp, model, input_tokens, output_tokens, cost (computed from model pricing).
  - Session-level aggregation (totals per Zed/DSH session).
  - Exportable to JSONL or CSV for analysis.
  - Model pricing per provider configured in `.env` or the harness config.
- **Out of scope:**
  - No UI/dashboard for token usage (pure logging).
  - No real-time warnings on budget overruns.
  - No integration with OTel or the observability stack (unless explicitly decided later).

## Touchpoints

- Modules and files: `packages/lab/` (where the harness runs), `docs/product/harness.md`, `docs/product/llm.md`
- Interface that changes: DSH/tool loop gets a token-tracking hook
- Seams involved: harness → LLM provider (DeepSeek, Claude, …)
- Example to follow: the existing `docs/product/indexing.md` for the research/choice setup

## Slices (each separately testable, one session, through the whole stack)

1. **Minimum viable:** Token counter on LLM response parsing — log input/output tokens to a JSONL file in `data/runtime/`.
2. **Session aggregation:** Gather per DSH session (start/stop), with totals per session in a separate log file.
3. **Pricing config:** Take model pricing from `.env` or a config file, compute cost per call and cumulatively.

## Acceptance

- [ ] After a turn with a real LLM call, a token log sits in `data/runtime/tokens/` with correct input/output counts
- [ ] several sessions give separate logs (no cross-session pollution)
- [ ] `make check` is green
- [ ] Product rules / RULES still hold (no secrets in logs, no data from other projects)