# docs/INDEX.md (the map)

> **Role:** One entry point for all docs: per file the question it answers, and when not.
> **Not here:** the working method ([agents-root](agents-root.md)), the folder tree ([skelet](../standard/skelet.md)).

**Kit file:** [kit/kern/docs/INDEX.md](../kit/kern/docs/INDEX.md) · layer kern · P2, following the llms.txt example (§15)

## When

Always. The script keeps only the sections of the modules you chose. Every time a doc appears or disappears, the map changes with it.

## Filling in

1. **Per section** a question the reader has ("how does it fit together"), not the folder name.
2. **Per file:** `[name](path) — <which question>. Not: <adjacent question → other file>.` The "not" stops the agent from opening the wrong file.
3. **Folders with many files** (`decisions/`, `logs/`, `experiments/`): no list per file, but how to search (`rg`, the number, the date). Exception: the active ADRs, as long as there are fewer than ±15.
4. **Lines with `<…>`** are replaced or removed. No links to files that do not exist yet.
5. **What is not read up front** (`work/`, `deliverables/`, `archive/`) goes at the bottom, with that warning.

## Example (GymFreak, one section)

```markdown
## Architecture — how it fits together

- [ARCHITECTURE.md](architecture/ARCHITECTURE.md) — Containers, hosting, ports, who writes where. Start here for "where is X".
- [runtime-client.md](architecture/runtime-client.md) — PWA, offline, push, chrome poll. Not: containers → ARCHITECTURE.
- [auth.md](architecture/auth.md) — JWT, demo account, cookies in code. Not: privacy claims → legal.
- [data-import.md](architecture/data-import.md) — How Hevy and Health exports come in. Not: what a field means → GLOSSARY.
- [llm.md](architecture/llm.md) — Which prompts, which model, what never goes to the LLM.
- [security.md](architecture/security.md) — Health data, secrets, auth principles, Strix.
- [observability.md](architecture/observability.md) — Signals and LGTM (opt-in).
- [performance.md](architecture/performance.md) — Budgets and bench (opt-in).
- [dependencies.md](architecture/dependencies.md) — CVE audits (`deps-audit`, opt-in).
- [polyglot.md](architecture/polyglot.md) — Extra languages after measurement (`polyglot-check`, opt-in).
```

## Quick check

- [ ] `make links` is green.
- [ ] Every doc under `docs/` is on the map, or in a folder whose map entry says how to search it.
- [ ] No file is listed twice.
- [ ] A fresh agent asked "where is the import of Hevy?" picks the right file straight away.
