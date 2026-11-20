# Kit

> **Rol:** De bestanden die je naar een project kopieert. Elke laag is een stukje projectroot: wat in `kern/docs/INDEX.md` staat, belandt in `<project>/docs/INDEX.md`.
> **Niet hier:** waarom de structuur zo is ([standaard](../standaard/INDEX.md)), hoe je elk bestand invult ([sjablonen](../sjablonen/INDEX.md)).

## Gebruik

```bash
kit/new-project.sh <map> [--profile app|research|studie|schoolwerk] [--team] [--modules a,b] [--stacks a,b] [--starter] [--name NAAM] [--dry-run] [--no-git]
```

- **Nieuw project:** volg [nieuw-project](../nieuw-project/INDEX.md). Het script maakt de map aan, kopieert de lagen en doet `git init`.
- **Bestaand project:** volg [bestaand-project](../bestaand-project/INDEX.md). Begin met `--dry-run`: dat toont wat ontbreekt. Het script overschrijft nooit een bestaand bestand; wat al bestond, staat in de uitvoer met `=`, zodat je het met de hand kan samenvoegen.
- **Met de hand:** kopieer de inhoud van een laag naar de projectroot (`cp -rn kit/kern/. <project>/`). Vervang dan zelf `{{PROJECT}}` en `{{DATE}}`, en verwijder de blokken `<!-- als: … -->` die niet gelden.

## Lagen

| Laag | Wanneer | Wat het neerzet |
|------|---------|-----------------|
| `kern/` | altijd | `README.md`, `AGENTS.md`, `Makefile`, `.gitignore`, `.editorconfig`, `.pre-commit-config.yaml`, `scripts/check-links.sh`, `docs/` (INDEX, context, rules, architecture, decisions, how-to), `data/` met de vijf vaste lagen, `apps/` |
| `solo/` | alleen jij werkt eraan (standaard) | `.cursorrules` (dunne persoonlijke laag), `docs/work/BACKLOG.md`, `specs/_template.md`, `logs/_template.md` |
| `logging/` | altijd (onderwerp-gecentreerd loggen) | `logs/status-log.md`, `logs/onderwerpen/_template.md` |
| `team/` | met `--team` | `.github/` (CI met `make check`, PR-template, issue-templates); voegt de module `meetings` toe |
| `modules/<naam>/` | met `--modules`, of later | één map of bestand op zijn vaste plek, zie hieronder |
| `stacks/<stack>/apps/<app>/` | met `--stacks`, ná de generator | `app.mk`, `AGENTS.md`, `.env.example`, de vaste mappen van de app |
| `stacks/<stack>/starter/apps/<app>/` | met `--stacks` en `--starter`, alleen bij een nieuwe app | startcode met een test (Python, SQL): `config.py` en `test_config.py` |
| `profiles/<naam>.profile` | met `--profile` | voorgedefinieerde set modules, stacks en extra bestanden voor een projectsoort |

### Profielen

| Profiel | Voor | Modules | Stacks | Extra |
|---------|------|---------|--------|-------|
| `app` | Applicatie (GymFreak, Caddie) | vision, assignment, product, design, research, business, agent, deliverables, meetings, compose, observability | kiest user | — |
| `research` | Onderzoek met software (Agent Engineering) | assignment, research, agent, deliverables, meetings | python | — |
| `studie` | Studieplanning | assignment | — | werk/kalender.md, werk/deadlines.md, werk/studielog.md, Makefile |
| `schoolwerk` | Oefeningen (DL/DB/Python/algo) | assignment, compose | python | containers/, Makefile |

Zie [profiles/](profiles/README.md) voor details.

### Modules

| Module | Zet neer | Neem hem als |
|--------|----------|--------------|
| `vision` | `docs/context/vision.md` | het project langer loopt dan één semester |
| `assignment` | `docs/context/assignment.md` | er een opdrachtgever is: school of klant |
| `product` | `docs/product/PRODUCT.md`, `_template.md`, `.cursor/agents/product.md` | er meer dan één domein is |
| `design` | `docs/design/DESIGN.md`, huisstandaard-craft (`shared/`, `desktop/`, `iphone/`), `.cursor/agents/ui.md` | er een UI is met eigen huisstijl (premium look / PWA) |
| `research` | `docs/research/` (RESEARCH, wantlist, **radar**, **digest/**, experiments), how-to radar/digest, `data/external/digest/`, `.cursor/agents/research.md` | literatuur/experimenten; tech-radar; digest fetch/propose |
| `business` | `docs/business/` | er een verdienmodel, prijzen of voorwaarden zijn |
| `agent` | `docs/agent/` met write-rules, doc-conventions, lessons, `prompts/` | je veel meta-taken door een agent laat doen |
| `deliverables` | `docs/deliverables/` | je iets indient: verslag, poster, presentatie |
| `meetings` | `docs/work/meetings/_template.md` | je overlegt met klant, coach of team |
| `archive` | `docs/archive/` | je oude docs wil bewaren zonder dat ze meetellen |
| `herordening` | `docs/work/specs/herordening.md` | je een bestaand project herordent |
| `compose` | `docker-compose.yml` (Postgres 17), `.env.example` | een app een database of andere dienst nodig heeft |
| `observability` | `docker-compose.observability.yml`, `infra/observability/` (LGTM) | metrics/logs/traces lokaal; docs staan altijd in kern |
| `packages` | `packages/` | twee apps code delen die niet apart deployt |
| `infra` | `infra/` | één compose-bestand niet meer volstaat |
| `runtime` | `data/runtime/README.md` | de app lokaal bestanden schrijft (uploads) |
| `models` | `data/models/README.md` | je modellen traint |
| `cursor` | `.cursor/rules/_template.mdc`, `.cursor/agents/{architecture,reviewer,clarify}.md` | je Cursor gebruikt (path-rules en/of subagents); zie [agent-rollen](../standaard/agent-rollen.md) |
| `claude` | `CLAUDE.md` → `AGENTS.md` (symlink) | je een tool gebruikt die `CLAUDE.md` leest |

## Stacks

Elke stack heeft een eigen gids met de generator, de scripts die `app.mk` verwacht en de controle achteraf. De generator komt **eerst**, want hij weigert een map die niet leeg is.

| Stack | App | Gids | Belangrijkste targets |
|-------|-----|------|-----------------------|
| `next` | `apps/web` | [stacks/next](stacks/next/README.md) | `dev-web`, `check-web`, `e2e-web`, `clean-web` |
| `nest` | `apps/api` | [stacks/nest](stacks/nest/README.md) | `dev-api`, `check-api`, `integration-api`, `db-reset-api` |
| `python` | `apps/analytics` | [stacks/python](stacks/python/README.md) | `check-analytics`, `data-analytics` |
| `sql` | `apps/pipeline` | [stacks/sql](stacks/sql/README.md) | `migrate-pipeline`, `data-pipeline`, `checks-pipeline` |
| `rust` | `apps/native` | [stacks/rust](stacks/rust/README.md) | `check-native`, `native-check`, `setup-native` (napi **+** PyO3 via `--starter`) |
| `c` | `apps/native-c` | [stacks/c](stacks/c/README.md) | `check-native-c`, `native-c-check`, `setup-native-c` (N-API **+** ctypes via `--starter`) |

Een tweede app van dezelfde stack (bv. `apps/admin` met Next) kopieer je met de hand vanuit `stacks/next/apps/web/`. Daarna hernoem je `WEB_` en `-web` in `app.mk`.

## Afspraken in de kitbestanden

- `{{PROJECT}}` en `{{DATE}}` worden ingevuld; `<…>` vul je zelf in.
- Een blok tussen `<!-- als: <sleutel>` en `-->` blijft alleen staan als die laag, module of stack gekozen is.
- Recepten in `Makefile` en `app.mk` springen in met een tab.
- Een `.gitkeep` houdt een vaste lege map in git. Het script haalt hem weg zodra er iets anders in die map staat.

## Kit veranderen

Pas een kitbestand aan, en daarna de gids in [sjablonen](../sjablonen/INDEX.md) die erbij hoort. Draai daarna `make check` in de root van deze repo: dat stelt een project met alle lagen samen en test het.
