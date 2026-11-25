# New project — step by step

> **Role:** From an empty folder to a project where a human and an agent work well straight away, and how to keep it that way.
> **Not here:** reorganising a running project ([existing-project](../existing-project/INDEX.md)), why it has to be this way ([bron](../bron/principes.md)).

Rule of thumb: **the kit lays the foundation, the content grows on real questions and real mistakes** (P20). A template you do not fill in, you delete; an empty file is a distraction.

## What you copy

Everything comes from [kit](../kit/README.md), with one command. Pick the layers for your situation:

| Situation | Command (after the generators from step 3) |
|-----------|-------------------------------------------|
| Solo, web and API, with database | `kit/new-project.sh <dir> --modules product,design,compose,observability --stacks next,nest --starter` |
| Solo, data or ML | `kit/new-project.sh <dir> --modules research,runtime,models,observability --stacks python --starter` |
| School project in a team, data pipeline | `kit/new-project.sh <dir> --team --modules assignment,deliverables,compose,observability,claude --stacks sql,python --starter` |
| Client project in a team, web | `kit/new-project.sh <dir> --team --modules assignment,product,design,compose,observability --stacks next,nest` |
| Prototype or hackathon | see [minimal](minimal.md) |

In doubt about a module, leave it out. The place is fixed anyway ([skelet](../standard/skelet.md)); you add it later with the same command, which overwrites nothing.

## Steps

| Step | When | Time | Done when |
|------|------|------|-----------|
| [1. Copy the kit](1-copy-the-kit.md) | day 0 | 10 min | `make help` works; `make check` fails with "does not check any app yet" |
| [2. Context and boundaries](2-context-and-boundaries.md) | day 0, before code | 1 hour | CONTEXT, RULES, GLOSSARY filled in; container diagram; first ADRs |
| [3. Apps and feedback loop](3-apps-and-feedback-loop.md) | day 1 | 1–2 hours | every app generated, `make check` green with one real test |
| [4. Agent](4-agent.md) | day 1 | 30 min | `AGENTS.md` and the map are right; a fresh agent passes the test |
| [5. Per feature](5-per-feature.md) | every time | — | spec or issue, slices, `make check` green, docs updated |
| [6. Maintenance](6-maintenance.md) | monthly or per sprint | 30 min | pruned, map right, measured where useful |

In a team you do steps 1 to 4 together in sprint 0: see [team](team.md).

## Ticking off

Copy the list below into your first daily log (`make log`) or into an issue.

```markdown
- [ ] 1 kit copied, `make help` works
- [ ] 2 CONTEXT · RULES · GLOSSARY · ARCHITECTURE (containers + seams) · ADRs stack/db/hosting
- [ ] 3 generators run · kit on top of the apps · `make setup` · `make check` green
- [ ] 4 AGENTS.md filled in (intent, seams, one slice) · docs/INDEX.md without empty references · test with a fresh agent
```
