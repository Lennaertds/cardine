# Write rules for the agent

> **Role:** Which paths an agent may change freely, which after permission, and which never.
> **Not here:** what applies to every task ([AGENTS.md](../../AGENTS.md)); which docs you **read** for a kind of task (that is in `AGENTS.md` § Working and the map).

Open this file only when you want to know whether you may write somewhere. Read routes (UI → DESIGN, feature → PRODUCT) live in `AGENTS.md`, not here — otherwise they are only consulted on write questions.

| Path | Allowed | Why |
|------|---------|-----|
| `apps/*/src/`, `apps/*/tests/` | free | ordinary code |
| `docs/work/` | free | status |
| `docs/` (the rest) | after permission | one fact in one place |
| `apps/*/src/database/migrations/` | after permission | schema changes are irreversible |
| `AGENTS.md`, `.cursor/rules/` | after permission | every rule costs context on every task |
| `data/raw/`, `data/runtime/`, `.env*` | never | raw data, personal data, secrets |
