# Write rules for the agent

> **Role:** which paths an agent may change freely, which need permission, and which never.
> **Not here:** what applies to every task ([AGENTS.md](../../AGENTS.md)); which docs you **read** for a given kind of task (that is in `AGENTS.md` § Working and the map).

Open this file only when you want to know whether you may write somewhere. Read routes (UI → DESIGN, feature → PRODUCT) live in `AGENTS.md`, not here — otherwise they would only be consulted on writing questions.

| Path | Allowed | Why |
|------|---------|-----|
| `apps/*/src/`, `apps/*/tests/` | free | ordinary code |
| `docs/work/` | free | status |
| `docs/` (the rest) | with permission | one fact in one place |
| `apps/*/src/database/migrations/` | with permission | schema changes are irreversible |
| `AGENTS.md`, `.cursor/rules/` | with permission | every rule costs context on every task |
| `data/raw/`, `data/runtime/`, `.env*` | never | raw data, personal data, secrets |
