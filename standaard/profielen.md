# Profielen — vaste combinaties van modules voor elk soort project

> **Rol:** Per profiel welke modules, stacks, mappen en bestanden een project standaard meekrijgt.
> **Niet hier:** de inhoud van elk bestand ([bestanden](bestanden.md)), hoe je een project start ([nieuw-project](../nieuw-project/INDEX.md), [bestaand-project](../bestaand-project/INDEX.md)).

Een **profiel** is een voorgedefinieerde set modules en config die past bij het soort project. In plaats van elke keer `--modules a,b,c --stacks x,y` te typen, kies je `--profile app` en staat alles klaar.

## Profielen

| Profiel | Voor | Modules (extra boven kern) | Stacks | Starter | `make finish` logt naar |
|---------|------|----------------------------|--------|---------|------------------------|
| `app` | Applicatie bouwen | vision, assignment, product, design, research, business, agent, deliverables, meetings, compose, observability | kiest user | optioneel | `work/sessies/` |
| `research` | Onderzoek met software (geen app) | assignment, research, agent, deliverables, meetings | python | nee | `work/sessies/` |
| `studie` | Studieplanning bijhouden | assignment | — | nee | `work/sessies/` (via `make log`) |
| `schoolwerk` | Oefeningen DL/DB/Python/algo | assignment, compose | python | nee | `work/sessies/` |

## Per profiel in detail

### `app` — Applicatie bouwen

Projecten als GymFreak, Caddie. De volle kit met alle modules die een softwareproject nodig heeft.

- **Modules:** vision, assignment, product, design, research, business, agent, deliverables, meetings, compose, observability
- **Stacks:** user kiest (next, nest, python, sql, rust, c)
- **Starter:** optioneel met `--starter`
- **Waarom deze modules:** een app heeft domeinkennis (product), UI (design), deployment (compose), observability (monitoring), literatuur (research), opdrachtgever (assignment), roadmap (vision), beslissingen (agent), overleg (meetings), oplevering (deliverables), verdienmodel (business)

### `research` — Onderzoek met software

Projecten als Agent Engineering, Cardine. Geen product/UI, wel literatuur, experimenten en software.

- **Modules:** assignment, research, agent, deliverables, meetings
- **Stacks:** python (voor scripts, experimenten)
- **Geen:** product, design, business, compose, observability
- **Extra:** `docs/research/experiments/` krijgt voorrang op `apps/`
- **AGENTS.md:** nadruk op bronnen, experimenten, literatuur — niet op productbouw

### `studie` — Studieplanning

Kalender, deadlines, studielogboek. Geen code, geen product.

- **Modules:** assignment
- **Geen stacks, geen apps/**
- **Extra mappen:** `werk/kalender.md`, `werk/deadlines.md`, `werk/studielog.md`
- **Makefile:** heeft `make log` (korte notitie), `make deadline` (deadline toevoegen), maar **geen** `make check` met test-kit (geen code om te testen)
- **AGENTS.md:** planning en herinneringen, geen codeer-workflow

### `schoolwerk` — Oefeningen

Basis scripts voor Deep Learning, Databases, Python, algoritmes. Podman/Docker voor dependencies.

- **Modules:** assignment, compose
- **Stacks:** python (voor oefenscripts)
- **Extra:** `containers/` map met Dockerfiles en docker-compose.yml per vak
- **Makefile:** heeft `make run` (container starten), `make test` (oefening controleren), `make build` (image bouwen)
- **Nadruk:** reproduceerbare omgeving in containers, geen CI/CD, geen productie

## Hoe een profiel werkt

1. `kit/new-project.sh` krijgt een `--profile <naam>` vlag.
2. Het script leest `kit/profiles/<naam>.profile` — een simpel tekstbestand met variabelen.
3. Die variabelen bepalen welke modules, stacks en extra stappen worden uitgevoerd.
4. Zonder `--profile` valt het script terug op het oude gedrag (alles handmatig via `--modules`, `--stacks`).

Zie [kit/profiles/](../kit/profiles/README.md) voor de bestaande profielen en hoe je een eigen profiel toevoegt.

## Zelf een profiel maken

Een profiel is een bestand `kit/profiles/<naam>.profile` met:

```bash
# kit/profiles/<naam>.profile
PROFILE_NAME="<naam>"
PROFILE_DESCRIPTION="<korte beschrijving>"
MODULES="<module1,module2,…>"
STACKS="<stack1,…>"           # leeg als geen stacks
STARTER=false
EXTRA_DIRS="<map1,map2,…>"    # mappen die niet in kern zitten
```

Voeg een rij toe aan de tabel in dit bestand en aan `kit/README.md`.