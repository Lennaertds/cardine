# Templates — filling in every kit file

> **Role:** Per file from the kit: when you use it, how to fill it in, a filled-in example and a quick check.
> **Not here:** the files themselves ([kit](../kit/README.md)), where they sit ([skelet](../standard/skelet.md)).

**Do not copy this into a project.** You copy the kit file; you read this guide next to the file while filling it in.

Every guide has the same shape: **When** · **Filling in** · **Example** · **Quick check**. The examples come from GymFreak (solo) and DEP2 (team) and show the shape. Test names, ADR numbers and sources in them are illustrative; do not take them as fact.

## Entry points

| Guide | File in the project | Layer |
|-------|---------------------|-------|
| [readme](readme.md) | `README.md` | kern |
| [agents-root](agents-root.md) | `AGENTS.md` | kern |
| [agents-app](agents-app.md) | `apps/<app>/AGENTS.md` | stack |
| [cursorrules](cursorrules.md) | `.cursorrules` | solo |
| [cursor-rule](cursor-rule.md) | `.cursor/rules/<app>.mdc` | module `cursor` |
| [cursor-agents](cursor-agents.md) | `.cursor/agents/<role>.md` | module `cursor` (+ design/product/research) |
| [docs-index](docs-index.md) | `docs/INDEX.md` | kern |

## Docs: stable truth

| Guide | File in the project | Layer |
|-------|---------------------|-------|
| [context](context.md) | `docs/context/CONTEXT.md` | kern |
| [glossary](glossary.md) | `docs/context/GLOSSARY.md` | kern |
| [vision](vision.md) | `docs/context/vision.md` | module `vision` |
| [assignment](assignment.md) | `docs/context/assignment.md` | module `assignment` |
| [rules](rules.md) | `docs/rules/RULES.md` | kern |
| [product](product.md) | `docs/product/PRODUCT.md`, `<domain>.md` | module `product` |
| [design](design.md) | `docs/design/DESIGN.md` | module `design` |
| [architecture](architecture.md) | `docs/architecture/ARCHITECTURE.md` | kern |
| [security](security.md) | `docs/architecture/security.md` | kern |
| [observability](observability.md) | `docs/architecture/observability.md` | kern (+ module `observability` for compose) |
| [performance](performance.md) | `docs/architecture/performance.md` | kern |
| [dependencies](dependencies.md) | `docs/architecture/dependencies.md` | kern |
| [polyglot](polyglot.md) | `docs/architecture/polyglot.md` (+ example ADR `0000-…`) | kern |
| [research](research.md) | `docs/research/RESEARCH.md`, `wantlist.md` | module `research` |
| [radar](radar.md) | `docs/research/radar.md` (+ how-to) | module `research` |
| [digest](digest.md) | `docs/research/digest/` (+ how-to, fetch/propose, `digest.yml`) | module `research` |
| [adr](adr.md) | `docs/decisions/NNNN-<slug>.md` | kern |
| [how-to](how-to.md) | `docs/how-to/<task>.md` | kern |
| [agent-map](agent-map.md) | `docs/agent/` | module `agent` |

## Docs: work and reports

| Guide | File in the project | Layer |
|-------|---------------------|-------|
| [backlog](backlog.md) | `docs/work/BACKLOG.md` | solo |
| [spec](spec.md) | `docs/work/specs/<slug>.md` | solo |
| [log](log.md) | `docs/work/logs/YYYY-MM-DD.md` | solo |
| [meeting](meeting.md) | `docs/work/meetings/YYYY-MM-DD-<with-whom>.md` | module `meetings` |
| [experiment](experiment.md) | `docs/research/experiments/YYYY-MM-DD-<slug>.md` | module `research` |

## Data, commands and repo

| Guide | File in the project | Layer |
|-------|---------------------|-------|
| [data-readme](data-readme.md) | `data/README.md` | kern |
| [makefile](makefile.md) | `Makefile`, `apps/<app>/app.mk`, `local.mk` | kern, stack |
| [rust-stack](rust-stack.md) | `apps/native` (stack `rust`) | stack |
| [c-stack](c-stack.md) | `apps/native-c` (stack `c`) | stack |
| [compose](compose.md) | `docker-compose.yml`, `.env.example` | module `compose` |
| [logging](logging.md) | `logs/status-log.md`, `logs/topics/T*.md` | log |
| [pre-commit](pre-commit.md) | `.pre-commit-config.yaml`, `.gitignore`, `.editorconfig` | kern |
| [ci](ci.md) | `.github/workflows/check.yml` | team |
| [pr-template](pr-template.md) | `.github/pull_request_template.md`, `ISSUE_TEMPLATE/` | team |

## Profile guides

| Guide | File in the kit | Profile |
|-------|-----------------|---------|
| [profielen](profielen.md) | `kit/profiles/<name>.profile` + `kit/profiles/extra/<name>/` | all |

## What applies to every guide

- Replace `<…>`; drop a section that does not apply. An empty heading is a distraction.
- Write only what cannot be derived from the code (P5, P6). In doubt, run the quick test for documentation rules in [principes.md](../bron/principes.md#snelle-toets-voor-elke-regel-documentatie).
- One fact in one place (P7). If it already exists elsewhere, link to it.
- Intent (P22), seams (P23), slice/session (P24) and harness tax (P25) live in [agents-root](agents-root.md), [architecture](architecture.md), [product](product.md), [spec](spec.md) and [pr-template](pr-template.md).
