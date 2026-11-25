# Naming and the doc header

> **Role:** How you name files, folders, ADRs, tests and images, and which header every doc starts with.
> **Not here:** where they sit ([skeleton](skelet.md)).

**Docs**

- **Fixed uppercase names** for the entry points: `README.md`, `AGENTS.md`, `INDEX.md`, and per docs folder the entry file named after the folder: `CONTEXT.md`, `GLOSSARY.md`, `RULES.md`, `PRODUCT.md`, `DESIGN.md`, `ARCHITECTURE.md`, `RESEARCH.md`, `DECISIONS.md`, `BACKLOG.md`. Only `docs/INDEX.md` is called `INDEX`.
- **In code and data folders the entry point is called `README.md`**, because GitHub renders it.
- **lowercase kebab-case** for every other doc: `data-import.md`, `how-to/reset-database.md`.
- **ADRs numbered with four digits**: `0007-postgres-single-writer.md`. The number is stable, the title is a decision.
- **Date first** for anything that sits in time: `logs/2026-10-18.md`, `meetings/2026-10-18-coach.md`, `experiments/2026-10-18-sleep-baseline.md`.
- **A template is called `_template.md`** and sits in the folder whose files it creates: `decisions/`, `work/specs/`, `work/logs/`, `work/meetings/`, `research/experiments/`, `product/`. The underscore sorts on top and never collides with a real name. The make targets `adr`, `spec`, `log`, `meeting` and `experiment` copy it ([makefile](makefile.md#docs-and-work)).
- **The filename contains the topic in plain words.** A code may come in front (`H-gym.md`), but never a code on its own (`H.md`). Every code is listed in `GLOSSARY.md`.
- **One language per project for docs.** Code identifiers may be English. The glossary maps the two. For this repo that language is English ([ADR 0018](../docs/decisions/0018-english-is-the-only-project-language.md)).

**Code, data and files**

- TypeScript files in kebab-case (`sleep-engine.ts`, `date-field.tsx`), Python modules and datasets in snake_case (`day_features.py`).
- A test file gets the suffix the test runner expects by default: Jest or Nest `.spec.ts`, Vitest `.test.ts`, Playwright `.spec.ts`, pytest `test_*.py`. The **place** is fixed ([stacks §1](stacks.md#1-every-app)), the suffix follows the tool.
- Images descriptive, lowercase: `iphone-calendar-dark.png`, not `IMG_0086.PNG`.
- **One slug per work item**: spec `docs/work/specs/<slug>.md`, branch `<type>/<slug>` (e.g. `feat/diet-budget`), and the same slug in the PR title.

**Never**

- Versions in filenames (`_v3`, `_final`, `_new`). Versions live in git. If an old variant has to stay around for comparison, put it in `docs/archive/` or `experiments/`.
- `*.sync-conflict-*`, `copy of …`, spaces in names.

---

## Doc header

Every doc under `docs/` starts with a short header. It helps a human and an agent decide whether to read on.

```markdown
# <Title>

> **Role:** <which question this file answers, in one sentence>
> **Not here:** <where the adjacent information lives>
```

Optional for projects where the agent may not write everywhere: `> **Writing:** free | after permission`. Keep the header at two or three lines: every doc pays for it on every read.

---
