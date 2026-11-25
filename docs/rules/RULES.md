# Rules

> **Role:** substantive boundaries: what this project never does, and what must always happen.
> **Not here:** code style (the linter), the agent's workflow ([AGENTS.md](../../AGENTS.md)), technical measures ([security.md](../architecture/security.md)).

Every rule is one sentence with its reason. If a rule can be enforced by a test, a hook or a CI check, you do that too, and the rule points at it.

## Never

- Never take data or secrets from other projects into code, tests, docs or prompts: the lab (and later the product) must stay reproducible without someone else's content.
- No production hosting or public release **during the lab phase**: prove it locally first; a deploy or portfolio release only after an explicit productisation choice (which may then be a free OS or a closed product).
- No paid SaaS or mandatory cloud billing as the product model: the direction is the user's own API keys (DeepSeek or others) and very likely entirely free.
- No API keys or `.env` in git, docs or prompts: keys (DeepSeek etc.) stay local with their owner.
- No lessons or standard changes straight into this repo or into the kit: first a § in `bron/bronnen.md` (and the bridge), otherwise the SSOT across the three tracks breaks.
- No duplication of source or kit content: reference, do not copy — one fact in one place.
- No stack or runtime chosen or generated until there is an explicit Pi/TS (or other) runtime choice: this prevents early lock-in and feature bloat.
- No feature bloat beyond the minimal harness (only what `harness` / `structure` / `indexing` need): the lab and its measurements call for a narrow surface; product growth follows only after proven quality.

## Always

- New insights from experiments land first as a source (§) in `bron/`; only then perhaps a bridge to the kit or lab code.
- Domain names in code, product docs and prompts follow [GLOSSARY.md](../context/GLOSSARY.md) (`harness`, `structure`, `indexing`).
- LLM calls use configurable providers via your own keys (DeepSeek as the cheap default direction; other keys allowed) — no hardcoded provider lock without an ADR.
