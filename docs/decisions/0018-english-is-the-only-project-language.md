# 0018 — English is the only project language

- **Status:** accepted
- **Date:** 2026-11-24
- **Touches:** `AGENTS.md`, every doc, every code comment and user-facing string, `Makefile`, directory names

## Summary

In the context of a repo that ships public npm packages, we chose English as the single project language and against the mixed Dutch/English that had grown, so that anyone who installs a package can read what it does, and we accept the cost of a one-time migration of roughly 500 documents.

## Context

The repo started as a personal workspace and was written in Dutch. That was fine while the only reader was its author. Two things changed:

- The packages became **public on npm** (`cardine`, `@lennaertds/cardine-structure`, `@lennaertds/cardine-lab`). The `README.md` that npm renders, the CLI `--help` output and the docs shipped inside the tarball are now the first thing a stranger sees.
- The kit templates land in **other people's projects**. A Dutch `AGENTS.md` in someone else's repo means their agent reads Dutch rules.

The mixed state was worse than either extreme: `AGENTS.md` said "Taal: Nederlands", but the code was English (`function`, `return`, `--allow-scripts`), the npm descriptions were English, and several docs had drifted into English sections. A reader could not tell which language a given file would be in.

`AGENTS.md` carried the rule *"Taal: Nederlands"* as a formatting convention, not as a decision. This ADR turns it into an explicit decision, which is what it always needed to be.

## Decision

We write **everything in English**: docs, code comments, commit-message-like log entries, CLI help, error messages, template files and directory names.

The single exception is `bron/`, which stays Dutch. It is an archive of Dutch source material — videos, articles, snapshots — and translating it would rewrite sentences that are cited elsewhere by `§`-number. It is not read as a rule; it is read as evidence.

Concretely:

- `AGENTS.md` states English as the language, not Dutch.
- Dutch directory names become English: `nieuw-project/` → `new-project/`, `bestaand-project/` → `existing-project/`, `meten/` → `measurement/`, `standaard/` → `standard/`. File names follow the same rule.
- A `make lang-check` target fails the check when Dutch function words appear outside `bron/`.

## Alternatives

| Option | Why not |
|--------|---------|
| Keep Dutch, translate only npm-facing files | Leaves the repo internally inconsistent; every future file needs a judgement call about which layer it belongs to |
| English everywhere, including `bron/` | Rewrites cited source text; the citation number would point at a sentence that no longer exists as written |
| Two repos, one per language | Doubles maintenance for a one-person project and loses the single source of truth the kit depends on |
| Leave it mixed | The current state: no one can predict the language of a file, and `AGENTS.md` says something the code does not follow |

## Consequences

- **Easier:** a stranger can read the package page, the CLI help and the shipped docs. Contributors are not blocked by Dutch. The language rule is one line with one obvious meaning.
- **Harder or risky:** a one-time migration of roughly 500 documents and 80 scripts. The directory renames break every relative link, so `make links` must run after each folder. The `kit/` mirror (`packages/structure/kit/`) must stay byte-identical to `kit/` or the published package drifts from the source.
- **To do:** the phase plan and live status live in [LANGUAGE-MIGRATION.md](../../LANGUAGE-MIGRATION.md). Historical material is not translated: released CHANGELOG sections and old entries in `docs/work/logs/` keep the language they were written in. ADRs are translated, because they are read as current rules rather than as a diary.
