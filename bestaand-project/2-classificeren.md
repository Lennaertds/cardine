# Stap 2 — Classificeren

> **Rol:** Voor elk bestand bepalen wat het is en waar het hoort, vóór je iets verplaatst.
> **Niet hier:** het verplaatsen zelf ([stap 5](5-verhuizen.md)).

## Beslisregels voor elk bestand, in volgorde

Loop elk bestand of elke map door met deze vragen. Het eerste "ja" bepaalt de plaats.

1. **Is het gegenereerd of herbouwbaar** (build-output, cache, testrapport, screenshot van een testrun)? Dan hoort het niet in git: `tmp/`, `data/interim/` of de map van de tool. Uitzondering: kleine demo-data in `data/processed/demo/`.
2. **Is het geheim of een persoonsgegeven?** Dan hoort het in `.env`, `data/raw/` of `data/runtime/`, en nooit in git.
3. **Is het leeg, dubbel, een sync-conflict of boilerplate van een generator?** Dan mag het weg.
4. **Hoort het bij een ander project?** Dan verhuist het naar dat project, of naar je persoonlijke backlog.
5. **Is het code die draait?** Dan hoort het in `apps/<app>/` volgens [stacks](../standaard/stacks.md), of in `packages/`.
6. **Controleert het iets?** Dan is het een test ([stacks §1](../standaard/stacks.md#1-elke-app)).
7. **Is het data?** Dan hoort het in een laag uit [data](../standaard/data.md).
8. **Is het een afbeelding?** Toont de site ze, dan hoort ze in `public/`. Toont een doc ze, dan hoort ze in `docs/assets/`.
9. **Is het tekst?** Gebruik de tabel hieronder, per sectie.

Een bestand dat twee vragen beantwoordt, splits je (P11). Een bestand waarvoor geen regel past, is een gat in de standaard: voeg een rij toe aan [waar hoort dit](../standaard/waar-hoort-dit.md).

## Soorten tekst

Ga per bestand, en bij grote bestanden per sectie, de [snelle toets](../bron/principes.md#snelle-toets-voor-elke-regel-documentatie) af:

| Soort | Herkenning | Doel |
|-------|------------|------|
| **Afleidbaar** | Mappenboom, lijst van bestanden, configs of tests, beschrijving per bestand | Schrappen. Een beschrijving per module wordt de docstring van die module |
| **Dubbel** | Hetzelfde feit staat op twee plaatsen | Eén plek kiezen, op de andere verwijzen |
| **Status** | "laatste wijzigingen", TODO, sprintstand, "nu bezig met" | `docs/work/` (solo) of de issue tracker (team) |
| **Besluit** | "we kozen X omdat…" | ADR in `docs/decisions/` |
| **Grens** | "nooit", "altijd", "mag niet" | `RULES.md`, of een hook of test als het afdwingbaar is |
| **Valkuil** | "let op", encodingproblemen, rare randgevallen | Bij het subsysteem in `architecture/`, en kort in `AGENTS.md` als het bij elke taak kan opduiken |
| **Hoe** | Stappen, commando's | `how-to/`, of de commandotabel van `AGENTS.md` en een make-target |
| **Architectuur** | Componenten, dataflow, wie schrijft waar | `ARCHITECTURE.md` of `architecture/<subsysteem>.md` |
| **Product** | Wat de gebruiker kan, regels van een domein | `product/<domein>.md` |
| **Domeinkennis** | Literatuur, bronnen, onderzoek | `research/` |
| **Afleider** | Oude versies, parallelle lijnen, `_v3`-bestanden, docs over verwijderde code | Weg, of `docs/archive/` met uitsluiting in de kaart |

## In de verhuistabel

Vul per rij **Wordt** en **Waarom** in. Het waarom is een beslisregel (`regel 3`), een soort (`status`) of een principe (`P5`). Voorbeeld:

| Nu | Wordt | Waarom | Gedaan |
|----|-------|--------|--------|
| `docs/PROJECT_STRUCTURE.md` § boom | weg | afleidbaar (P5) | [ ] |
| `docs/PROJECT_STRUCTURE.md` § hosting en poorten | `docs/architecture/ARCHITECTURE.md` | architectuur | [ ] |
| `last_changes.md` | issues in de tracker, dan weg | status (P8) | [ ] |
| `configs/case1_v3.json`, `_v4` | `configs/archive/` of weg; ADR welke canoniek is | afleider | [ ] |

Volledig uitgewerkt: [GymFreak](voorbeelden/gymfreak.md#plaats-van-elk-bestand), [DEP2](voorbeelden/dep2.md#doelstructuur-docs).
