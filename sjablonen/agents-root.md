# AGENTS.md (root)

> **Role:** What every agent must know on every task: boundaries, commands, working method, finishing, and where the rest lives.
> **Not here:** rules for one app ([agents-app](agents-app.md)), the map of the docs ([docs-index](docs-index.md)).

**Kit file:** [kit/kern/AGENTS.md](../kit/kern/AGENTS.md) · layer kern · P1–P3, P6, P13, P17, P20, P22–P25, P28

## When

Always, day 1, with only what is already true then. It grows on mistakes: every added line is a mistake the agent would otherwise repeat. Every line costs tokens on *every* task (harness tax, P25): prefer a hook/test over a sentence. Target length ~35–70 lines — closer to the Agent Engineering root than to an operations manual.

## Filling in

The order is fixed, with the most important first (P3):

1. **One sentence** on what the project is, and the link to `README.md`.
2. **Never.** The kit already has: secrets, raw data, git, no new folders, RULES + security (live), the rest via INDEX. Add what is **destructive** or **irreversible** in this project, with the why in the same sentence. Obs/perf/deps/polyglot/radar: **no** always-on links and **no** keyword catalogue in this file.
3. **Commands.** Only daily targets in the table (`check`, `check-full`, `dev`, one test, adding a dependency, `make help`; solo: `make spec s=<slug>`). Opt-in = one sentence under the table + INDEX/`make help`, not eight rows and not a table with doc paths.
4. **Working.** Hard read routes only for what always applies to *that kind* of task: INDEX → one file; with modules: UI → `DESIGN.md`, feature → `PRODUCT.md`, research → `RESEARCH.md`; architecture → `ARCHITECTURE.md` always applies. Solo: new open work → `make spec` (BACKLOG = index, plan in the spec). Opt-in engineering: the task names it → INDEX (no catalogue here). Roles and subagents: [agent-rollen](../standard/agent-rollen.md). The kit also has, in **short** form:
   - **intent** above green tests (P22);
   - **no new module boundaries** without asking (P23);
   - **one slice** per session + review in a fresh context (P1, P19, P24);
   - with module `cursor`: *subagents* / *delegate* / *parallel* → `.cursor/agents/` ([cursor-agents](cursor-agents.md));
   - **doing beats talking**;
   - **report briefly** (but do show `make check` output).
5. **Finishing.** Solo: check → docs → **daily log entry** (`make log`, fields: motivation/files/test/failed/item) → an ADR only for a choice with a why → BACKLOG/spec. Team: check → docs → ADR on a choice → PR. Explicit: **without asking** after a repo change; skip pure Q&A. BACKLOG + log = the spine (P27), not the chat.

Optional, only if the team really agrees on it: one line on which model for routine tasks vs. open reasoning work (P26).

## Example (GymFreak, only what the kit does not already have)

```markdown
## Never

- Do not read, log or show in an answer any health data from `data/runtime/user/` or Health exports.
- Do not take code or assets from `Caddie/`: separate projects, separate brands.
- Only change files with "Writing: after permission" in the header after an explicit yes.
- Not sure whether you may write a path: [write-rules.md](docs/agent/write-rules.md).

## Working

- Example of a good domain: `apps/api/src/sleep/` (module, service, `sleep-engine.ts` with tests).
- Postgres is the only writer of user data; the analytics batch only reads.
- Start of a task: RULES → the backlog item → the map.
- Task about UI, screen, layout, PWA, look or craft: `DESIGN.md` first; then only the one craft file that map points to.
- Doing beats talking: *implement* / *build* / *yes* → code this turn, not "shall I start?".
```

A fully filled-in version for a team project is in [DEP2, step D-3](../existing-project/examples/dep2.md#step-d-3-agentsmd-d1-d9).

## Quick check

- [ ] Under 70 lines (`make docs-health`). Longer = harness tax (P25); aim for ~50.
- [ ] Deletion test per line: would the agent make a mistake without this line? If not, cut it (P20).
- [ ] No folder tree, no keyword catalogue of docs, no style rules the linter already enforces, no status.
- [ ] Opt-in engineering (obs/perf/deps/polyglot/radar) only via INDEX/`make help`, **not** as numbered always-on Working steps or as a path table in AGENTS.
- [ ] The command table has no eight rows for rarely used kit targets; those live under `make help`.
- [ ] A rule that can be enforced is also enforced (hook, test, CI) and appears here at most as a reference (P14).
- [ ] The kit's intent and seam rules are there (briefly), not cut out.
- [ ] Reporting: the brief-reporting line is there; no long narrative status updates expected.
- [ ] Fresh agent: does it run `make check` on its own and open the map? On a UI task: `DESIGN.md` first? On "use subagents": does it look in `.cursor/agents/`? ([test](../new-project/4-agent.md#test-with-a-fresh-agent))

### Coverage (Coldtea, source §34)

Eight themes top repos often put in `AGENTS.md`. A tick means the agent finds it in this *system* (not necessarily inline here). Structure/style belongs elsewhere (P5).

| Theme | Covered by | ✓ |
|-------|------------|---|
| Don't-rules | `AGENTS.md` § Never + RULES/security | |
| Commit / PR | Never commit without asking; team: PR in Finishing | |
| Testing / validation | `make check` (+ single test in Commands) | |
| Code style | linter/formatter (not in AGENTS) | |
| Links to docs | the map `docs/INDEX.md` (opt-in via task + INDEX) | |
| CI / pre-commit | `make check` / hooks (a reference is enough) | |
| Build & setup | command table (daily) + `make help` | |
| Project structure | *not* in AGENTS; via INDEX / code (P5) | |
