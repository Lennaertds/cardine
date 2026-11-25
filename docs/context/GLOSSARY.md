# Glossary

> **Role:** one term per concept, and what it is called in the code. Use these terms in code, docs and prompts.
> **Not here:** explanation of general concepts (REST, ETL, JWT).

## Domains

The same name in `docs/product/`, and later in app directories once there is a stack (`features/<domain>/`, `src/<domain>/`, …).

| Domain | One sentence | Code or abbreviation |
|--------|--------------|----------------------|
| harness | Agent loop / runtime experiment: how the agent runs and is steered measurably | H |
| structure | Project-structure integration: reading and enforcing the standard (docs, rules, seams) | S |
| indexing | Code/context index so the agent gets targeted context | I |

## Terms

| Term | Meaning | In the code | Not to be confused with |
|------|---------|-------------|-------------------------|
| Track | One of the three layers: environment (kit), knowledge (sources), lab (this repo) | — (docs) | module (kit module agent/research/product) |
| Harness | The minimal runtime that carries the agent loop and measurements | `harness` | Zed itself (external IDE); indexing |
| Structure | Integration with the project standard (reading/enforcing) | `structure` | the standard in `kit/` of this repo |
| Indexing | Building and using a code/context index (Project-Understanding) | `indexing` | digest; IDE shell; harness |
| IDE shell | Lightweight editor host (non-Electron) the rest hangs off | later | Zed/VS Code fork |
| FS/events | Seam: passing file changes to indexing/harness | later | "forking an app" |
| Whole product | Personal stack of 9 parts — [totaalproduct.md](../product/totaalproduct.md) | — (docs) | SaaS productisation |
| Runtime choice | An explicit decision on the stack (e.g. Pi, DSH or an IDE fork) before generators | ADR 0001 (deferral); successor once chosen | kit modules without a stack |
| Productisation | Explicit decision lab → free release (portfolio; OS or closed) | BACKLOG Parked | a silent "make it public" without an ADR |
| DeepSeek | Cheap LLM provider direction via your own API key | env `DEEPSEEK_API_KEY` etc. | DeepSeek Harness (§77); DeepInfra |

## Abbreviations and project codes

| Code | Means |
|------|-------|
| ADR | Architecture Decision Record, a file in `docs/decisions/` |
| H / S / I | Domain codes harness / structure / indexing |
| Pi | Candidate runtime (only after an explicit choice) |
| TS | TypeScript as a candidate direction (only after an explicit choice) |
