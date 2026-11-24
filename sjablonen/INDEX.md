# Sjablonen — elk kitbestand invullen

> **Rol:** Per bestand uit de kit: wanneer je het gebruikt, hoe je het invult, een ingevuld voorbeeld en een snelle toets.
> **Niet hier:** de bestanden zelf ([kit](../kit/README.md)), waar ze staan ([skelet](../standaard/skelet.md)).

**Niet kopiëren naar een project.** Je kopieert het kitbestand; deze gids lees je naast het bestand terwijl je het invult.

Elke gids heeft dezelfde vorm: **Wanneer** · **Invullen** · **Voorbeeld** · **Snelle toets**. De voorbeelden komen uit GymFreak (solo) en DEP2 (team) en tonen de vorm. Testnamen, ADR-nummers en bronnen erin zijn illustratief; neem ze niet over als feit.

## Ingangen

| Gids | Bestand in het project | Laag |
|------|------------------------|------|
| [readme](readme.md) | `README.md` | kern |
| [agents-root](agents-root.md) | `AGENTS.md` | kern |
| [agents-app](agents-app.md) | `apps/<app>/AGENTS.md` | stack |
| [cursorrules](cursorrules.md) | `.cursorrules` | solo |
| [cursor-rule](cursor-rule.md) | `.cursor/rules/<app>.mdc` | module `cursor` |
| [cursor-agents](cursor-agents.md) | `.cursor/agents/<rol>.md` | module `cursor` (+ design/product/research) |
| [docs-index](docs-index.md) | `docs/INDEX.md` | kern |

## Docs: stabiele waarheid

| Gids | Bestand in het project | Laag |
|------|------------------------|------|
| [context](context.md) | `docs/context/CONTEXT.md` | kern |
| [glossary](glossary.md) | `docs/context/GLOSSARY.md` | kern |
| [vision](vision.md) | `docs/context/vision.md` | module `vision` |
| [assignment](assignment.md) | `docs/context/assignment.md` | module `assignment` |
| [rules](rules.md) | `docs/rules/RULES.md` | kern |
| [product](product.md) | `docs/product/PRODUCT.md`, `<domein>.md` | module `product` |
| [design](design.md) | `docs/design/DESIGN.md` | module `design` |
| [architecture](architecture.md) | `docs/architecture/ARCHITECTURE.md` | kern |
| [security](security.md) | `docs/architecture/security.md` | kern |
| [observability](observability.md) | `docs/architecture/observability.md` | kern (+ module `observability` voor compose) |
| [performance](performance.md) | `docs/architecture/performance.md` | kern |
| [dependencies](dependencies.md) | `docs/architecture/dependencies.md` | kern |
| [polyglot](polyglot.md) | `docs/architecture/polyglot.md` (+ voorbeeld-ADR `0000-…`) | kern |
| [research](research.md) | `docs/research/RESEARCH.md`, `wantlist.md` | module `research` |
| [radar](radar.md) | `docs/research/radar.md` (+ how-to) | module `research` |
| [digest](digest.md) | `docs/research/digest/` (+ how-to, fetch/propose, `digest.yml`) | module `research` |
| [adr](adr.md) | `docs/decisions/NNNN-<slug>.md` | kern |
| [how-to](how-to.md) | `docs/how-to/<taak>.md` | kern |
| [agent-map](agent-map.md) | `docs/agent/` | module `agent` |

## Docs: werk en verslagen

| Gids | Bestand in het project | Laag |
|------|------------------------|------|
| [backlog](backlog.md) | `docs/work/BACKLOG.md` | solo |
| [spec](spec.md) | `docs/work/specs/<slug>.md` | solo |
| [log](log.md) | `docs/work/logs/YYYY-MM-DD.md` | solo |
| [meeting](meeting.md) | `docs/work/meetings/YYYY-MM-DD-<met-wie>.md` | module `meetings` |
| [experiment](experiment.md) | `docs/research/experiments/YYYY-MM-DD-<slug>.md` | module `research` |

## Data, commando's en repo

| Gids | Bestand in het project | Laag |
|------|------------------------|------|
| [data-readme](data-readme.md) | `data/README.md` | kern |
| [makefile](makefile.md) | `Makefile`, `apps/<app>/app.mk`, `local.mk` | kern, stack |
| [rust-stack](rust-stack.md) | `apps/native` (stack `rust`) | stack |
| [c-stack](c-stack.md) | `apps/native-c` (stack `c`) | stack |
| [compose](compose.md) | `docker-compose.yml`, `.env.example` | module `compose` |
| [loggen](loggen.md) | `logs/status-log.md`, `logs/onderwerpen/T*.md` | log |
| [pre-commit](pre-commit.md) | `.pre-commit-config.yaml`, `.gitignore`, `.editorconfig` | kern |
| [ci](ci.md) | `.github/workflows/check.yml` | team |
| [pr-template](pr-template.md) | `.github/pull_request_template.md`, `ISSUE_TEMPLATE/` | team |

## Profiel-gidsen

| Gids | Bestand in de kit | Profiel |
|------|--------------------|---------|
| [profielen](profielen.md) | `kit/profiles/<naam>.profile` + `kit/profiles/extra/<naam>/` | alle |

## Wat voor elke gids geldt

- `<…>` vervang je; een sectie die niet geldt, schrap je. Een leeg kopje is een afleider.
- Schrijf alleen wat niet uit de code af te leiden is (P5, P6). Twijfel je, doe de [snelle toets](../bron/principes.md#snelle-toets-voor-elke-regel-documentatie).
- Eén feit op één plaats (P7). Staat het al elders, verwijs dan.
- Intent (P22), seams (P23), slice/sessie (P24) en harness tax (P25) zitten in [agents-root](agents-root.md), [architecture](architecture.md), [product](product.md), [spec](spec.md) en [pr-template](pr-template.md).
