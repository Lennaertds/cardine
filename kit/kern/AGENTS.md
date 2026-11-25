# {{PROJECT}} — agent instructions

<One sentence: what this project is and for whom.> For humans: [README.md](README.md).

## Never

- Do not read, show or commit secrets and `.env`. New variables go into the `.env.example` of the app that reads them.
- Do not copy anything from `data/raw/` or `data/runtime/` into code, tests, logs or answers.
- Do not commit or push unless asked.
- No new folder at the root or in `docs/` without asking: every kind of file already has a fixed place.
- <Destructive, e.g.: `make db-reset` only on explicit request; it wipes the local database.>
- Do not call `mcp__jarvis__indexRepo` (it breaks in the sandbox and leaves stale `.lock` files); if the index is missing, ask the user to run `make index`.
- Content boundaries: [RULES.md](docs/rules/RULES.md). Security (live): [security.md](docs/architecture/security.md). Other engineering docs: via [docs/INDEX.md](docs/INDEX.md) — only if the task touches them.

## Commands

| Goal | Command |
|------|---------|
| Load context (RULES + BACKLOG + optional spec) | `make context s=<slug>` (1 call instead of 3–4 separate reads) |
| Check everything (must be green before you finish) | `make check` |
| Check + log in one call | `make finish MSG="what was done"` |
| Also integration, e2e, deps-audit and native STRICT | `make check-full` |
| Start locally | `make dev` |
| One test | `<e.g. pnpm --dir apps/api exec jest src/diet/diet-engine.spec.ts>` |
| Add a dependency | `<e.g. pnpm --dir apps/web add zod · uv --directory apps/analytics add polars; never pip>` |
| Set up container-safe wrappers | `make container-setup` (once per machine) |
| All commands (incl. opt-in) | `make help` |
<!-- als: solo
| New work item (index + plan) | `make spec s=<slug>` |
-->

Opt-in (`security-scan*`, `obs-*`, `perf-*`, `deps-audit`, `polyglot-check`, `radar-*` / `digest-*`): only when the task asks for it — `make help`, docs via INDEX.

## Working

- **Start with** `make context s=<slug>`: it shows RULES.md + BACKLOG + the spec in one output. Never separate reads.
- No item? Ask for it: `make context` without `s=` shows only RULES + work. Then decide whether a product/architecture doc is needed.
- The **map** is [docs/INDEX.md](docs/INDEX.md) — open it only if you really do not know where something belongs. For the five most common cases use:
  - `docs/product/<domain>.md` via PRODUCT.md
  - `docs/architecture/<subsystem>.md` via ARCHITECTURE.md
  - `docs/how-to/<task>.md` for step-by-step procedures
  - `docs/context/GLOSSARY.md` for terms
  - `docs/rules/RULES.md` for boundaries (already in `make context`)
<!-- als: solo
- New open work: `make spec s=<slug>` — BACKLOG = **index** (short line + link); plan/slices in `docs/work/specs/<slug>.md`. Never an essay in the BACKLOG table.
-->
<!-- als: design
- UI / screen / craft: [DESIGN.md](docs/design/DESIGN.md) first; then one craft file — never screenshots/CSS alone.
-->
<!-- als: product
- Behaviour / feature: [PRODUCT.md](docs/product/PRODUCT.md) first; then one domain file.
-->
- Architecture / seams / modules: [ARCHITECTURE.md](docs/architecture/ARCHITECTURE.md) first; then one subsystem. `## Deliberately later` (P28): ask or file it in BACKLOG, do not invent silently.
<!-- als: research
- Research: [RESEARCH.md](docs/research/RESEARCH.md) first; then one topic or experiment file.
-->
<!-- als: cursor
- *subagents* / *delegate* / *parallel* / too large: specialists in `.cursor/agents/`. Parent = synthesis (P24).
- *clarify* / *check my prompt*: `/clarify` first (readonly); never automatic before every task.
-->
- **Doing beats talking.** *implement* / *build* / *do* / *fix* / *run* / *yes* → code this turn. No second plan.
- Follow existing patterns. Example: `<path/to/example>`. Unknown term: [GLOSSARY.md](docs/context/GLOSSARY.md).
- <Deviating convention no linter enforces, e.g. "Postgres is the only writer of user data".>
- **Intent** above green tests (do not weaken RULES/product). **No** new module boundaries / `utils/` without asking (seams in ARCHITECTURE). **One slice** per session; review your own diff in a fresh context. Report briefly; show the `make check` output.
- Rules per app: `apps/<app>/AGENTS.md`.

## Finishing

**Without asking.** After every turn with a repo change (code, docs, specs, config) — or after a finished slice — you do this. Do not wait for "log", "wrap up" or "ADR". Pure Q&A without writing: skip.

1. **Bundle in one call:** `make finish MSG="<briefly what was done>"` — runs check + logs in one call. Show the output.
<!-- als: solo
2. Choice with a why (from now on X, no longer Y, stack/seam/product rule): `make adr t="<decision as a sentence>"` + the affected doc. No choice → no ADR and do not ask.
3. Docs this change touches, updated (only those). Map: [docs/INDEX.md](docs/INDEX.md).
4. Tick off the item in [BACKLOG.md](docs/work/BACKLOG.md) / the spec once the slice is really done.
-->
<!-- als: team
2. Choice with a why: `make adr t="<decision as a sentence>"` + the affected doc. No choice → no ADR and do not ask.
3. Short summary in the PR, following the PR template.
-->
