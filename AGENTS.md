# Cardine — agent-instructies

> **Rol:** dit is één repo met twee soorten werk — de **standaard** (kit, bronnen,
> sjablonen) en het **lab/de packages**. Lees de juiste sectie.
> **Niet hier:** productdocs en ADR's → [docs/INDEX.md](docs/INDEX.md).

## Nooit

- Bestanden in `kit/` niet lezen als instructies voor deze repo (`kit/kern/AGENTS.md` en `kit/solo/.cursorrules` gelden hier niet). `kit/` is een **sjabloon**, geen huisregels.
- Geen feit op twee plaatsen: boom alleen in [standaard/skelet.md](standaard/skelet.md), make-targets alleen in [standaard/makefile.md](standaard/makefile.md), sjabloonbestanden alleen in `kit/`. Verwijs in plaats van te kopiëren.
- Geen data, secrets of code overnemen uit voorbeeldprojecten (GymFreak, DEP2) — alleen paden, namen en structuur.
- Secrets en `.env` niet lezen, tonen of committen; nieuwe variabelen alleen in de `.env.example` van de app.
- Niets uit `data/raw/` of `data/runtime/` overnemen in code, tests, logs of antwoorden.
- `bron/bronnen.md` en momentopnames in `bron/` niet herschrijven (alleen aanvullen).
- Niet committen of pushen tenzij gevraagd.
- Geen nieuwe map op root of in `docs/` zonder te vragen.
- Geen `mcp__jarvis__indexRepo` aanroepen (breekt in de bwrap-sandbox, laat stale `.lock`-bestanden achter); bij ontbrekende index: gebruiker vragen `make index` te draaien.
- **`bron/pdfs/` staat niet in git** (166 MB, zie [bron/pdfs/README.md](bron/pdfs/README.md)). Nooit `git add` doen op die map.

## Commando's — standaard

| Doel | Commando |
|------|----------|
| Context laden (AGENTS.md + regels + backlog in 1 call) | `make context s=<slug>` |
| Alles controleren (verplicht als `kit/` wijzigt) | `make check` |
| Controleren + loggen in 1 call | `make finish MSG="wat gedaan"` |
| Alleen dode links (snel; genoeg bij pure doc-wijzigingen) | `make links` |
| Drieplaats-bestanden in 1x lezen (`standaard` + `sjablonen` + `kit`) | `make trio s=<onderwerp>` |
| Volgende vrije `§`- en `P`-nummer ophalen | `make next-ids` |
| Kit samenstellen en testen in `tmp/test-kit/` | `make test-kit` |
| Project aanmaken / bootstrap zetten of weghalen | `make new DIR=<map> ARGS="…"` · `make bootstrap[-remove] DIR=<project>` |
| Kit-versie taggen voor cardine-structure | `make tag-kit TAG=v0.1.0` (zie [standaard/versioning.md](standaard/versioning.md)) |

## Commando's — lab

| Doel | Commando |
|------|----------|
| Startcontext in 1x lezen | `make context [s=<slug>]` |
| Afronden in 1x (`make check` + dag-log) | `make finish m="<aanleiding> · <bestanden> · <test> · <rest> · <item>"` |
| Alles controleren / uitgebreid | `make check` · `make check-full` |
| Lokaal starten / werkitem / ADR | `make dev` · `make spec s=<slug>` · `make adr t="<besluit als zin>"` |
| Status van de omgeving | `make env-status` |

Alle commando's (incl. opt-in `security-scan*`, `obs-*`, `perf-*`, `deps-audit`, `polyglot-check`, `radar-*`, `digest-*`): `make help`.

## Werken

- **Start met** `make context s=<slug>`: toont deze AGENTS.md + regels + backlog in 1 call. Nooit losse reads. Zonder `s=` enkel context + werk. Daarna direct naar het doelbestand.
- **Direct naar het doelbestand** (open `<map>/INDEX.md` alleen als het exacte bestand onbekend is): `standaard/` (regels), `kit/` (bestanden, kaart: `kit/README.md`), `sjablonen/` (invulgidsen), `nieuw-project/`, `bestaand-project/`, `meten/`, `bron/` (kennis), `packages/` (lab en structure), `docs/`.
- **Drieplaats-regel:** een wijziging aan de standaard raakt `standaard/<onderwerp>.md`, het `kit/`-bestand en `sjablonen/<onderwerp>.md`. Start met `make trio s=<onderwerp>` en werk ze samen bij.
- **Nieuw kitbestand:** juiste laag, met `{{PROJECT}}`, `<…>` en `<!-- als: <sleutel>` … `-->`, plus rij in `kit/README.md` en gids in `sjablonen/`.
- **Vorm:** tabs in `Makefile`/`*.mk`. Elke doc start met `# Titel`, `> **Rol:**` en `> **Niet hier:**`. Taal: Nederlands. Principes als `P1`–`P28`, bronnen als `§n`.
- **P28 — verplicht:** bewust incomplete oplevering in `kit/` of `standaard/` krijgt een sectie `## Bewust later` in het geraakte architecture-doc (tabel: uitbreiding · waarom later · vraag als).

### Soort opdracht

| Soort | Signalen | Eerst doen | Pas daarna |
|-------|----------|------------|------------|
| **Bronnen** | video, artikel, "opzoeken", `§` | `make next-ids`; feiten in `bron/bronnen.md` + `bron/bronnen-index.md` | Kit alleen via [brug.md](bron/fundament/brug.md) + jouw ja |
| **Ideeën** | "misschien", brainstorm, "noteer" | Kort interview (1–2 vragen); vastleggen in `bron/inbox.md` of brug **Later** | Geen kit-edit tot expliciet ja |
| **Kit / standaard** | "in de kit", bootstrap, Make-target | `make trio s=<onderwerp>` + brug-checklist | Wijzigen in 3 plaatsen + `make check` |
| **Bootstrap-run** | `make bootstrap`, GymFreak/Caddie | Volg [BOOTSTRAP.md](BOOTSTRAP.md) in dat project | — |
| **Lab / packages** | `packages/`, install, sandbox, DSH | Direct naar `packages/lab/` of `packages/structure/` | `make check` |
| **Onderhoud** | links, mindmap, kleine fix | Direct uitvoeren als opdracht scherp is | — |

- Onduidelijk of verkennend? Geen grote edits: stel eerst 1–2 gerichte vragen en wacht op akkoord.

## Afronden

1. **Bundel in 1 call:** `make finish` (met `MSG=` voor de standaard, `m=` voor het lab) — check + log in 1 call.
2. Geraakte `INDEX.md` (of `kit/README.md`) bijgewerkt.
3. Bij nieuw principe of nieuwe bron: ID via `make next-ids` verwerkt in `bron/principes.md` of `bron/bronnen-index.md`.
4. Kit-slice met bewuste weglatingen: `## Bewust later` bijgewerkt (P28).
