# {{PROJECT}} — agent-instructies

<Eén zin: wat dit project is en voor wie.> Voor mensen: [README.md](README.md).

## Nooit

- Secrets en `.env` niet lezen, tonen of committen. Nieuwe variabelen gaan naar de `.env.example` van de app die ze leest.
- Niets uit `data/raw/` of `data/runtime/` overnemen in code, tests, logs of antwoorden.
- Niet committen of pushen tenzij erom gevraagd is.
- Geen nieuwe map op root of in `docs/` zonder te vragen: elke soort bestand heeft al een vaste plek.
- <Destructief, bv.: `make db-reset` alleen op uitdrukkelijke vraag; het wist de lokale database.>
- Inhoudelijke grenzen: [RULES.md](docs/rules/RULES.md). Security (live): [security.md](docs/architecture/security.md). Overige engineering-docs: via [docs/INDEX.md](docs/INDEX.md) — alleen als de opdracht ze raakt.

## Commando's

| Doel | Commando |
|------|----------|
| Context laden (RULES + BACKLOG + optionele spec) | `make context s=<slug>` (1 call i.p.v. 3-4 losse reads) |
| Alles controleren (moet groen voor je afrondt) | `make check` |
| Controleren + loggen in 1 call | `make finish MSG="wat gedaan"` |
| Ook integratie-, e2e-, deps-audit en native STRICT | `make check-full` |
| Lokaal starten | `make dev` |
| Eén test | `<bv. pnpm --dir apps/api exec jest src/diet/diet-engine.spec.ts>` |
| Dependency toevoegen | `<bv. pnpm --dir apps/web add zod · uv --directory apps/analytics add polars; nooit pip>` |
| Container-safe functies klaarzetten | `make container-setup` (eenmalig per machine) |
| Alle commando's (incl. opt-in) | `make help` |
<!-- als: solo
| Nieuw werkitem (index + plan) | `make spec s=<slug>` |
-->

Opt-in (`security-scan*`, `obs-*`, `perf-*`, `deps-audit`, `polyglot-check`, `radar-*` / `digest-*`): alleen als de opdracht dat vraagt — `make help`, docs via INDEX.

## Werken

- **Start met** `make context s=<slug>`: dat toont RULES.md + BACKLOG + de spec in één uitvoer. Nooit losse reads.
- Geen item? Vraag ernaar: `make context` zonder `s=` toont enkel RULES + werk. Daarna beslis of er een product/architectuur-doc nodig is.
- De **kaart** is [docs/INDEX.md](docs/INDEX.md) — open die alleen als je écht niet weet waar iets hoort. Voor de 5 meest voorkomende gevallen gebruik je:
  - `docs/product/<domein>.md` via PRODUCT.md
  - `docs/architecture/<subsysteem>.md` via ARCHITECTURE.md
  - `docs/how-to/<taak>.md` voor stappenplannen
  - `docs/context/GLOSSARY.md` voor begrippen
  - `docs/rules/RULES.md` voor grenzen (staat al in `make context`)
<!-- als: solo
- Nieuw open werk: `make spec s=<slug>` — BACKLOG = **index** (korte regel + link); plan/slices in `docs/work/specs/<slug>.md`. Nooit een essay in de BACKLOG-tabel.
-->
<!-- als: design
- UI / scherm / craft: eerst [DESIGN.md](docs/design/DESIGN.md); daarna één craft-bestand — nooit alleen screenshots/CSS.
-->
<!-- als: product
- Gedrag / feature: eerst [PRODUCT.md](docs/product/PRODUCT.md); daarna één domeinbestand.
-->
- Architectuur / seams / modules: eerst [ARCHITECTURE.md](docs/architecture/ARCHITECTURE.md); daarna één subsystem. `## Bewust later` (P28): vraag of BACKLOG, niet stil inventeren.
<!-- als: research
- Onderzoek: eerst [RESEARCH.md](docs/research/RESEARCH.md); daarna één onderwerp- of experimentbestand.
-->
<!-- als: cursor
- *subagents* / *delegeer* / *parallel* / te groot: specialisten in `.cursor/agents/`. Parent = synthese (P24).
- *clarify* / *check mijn prompt*: eerst `/clarify` (readonly); nooit auto vóór elke taak.
-->
- **Uitvoeren wint van praten.** *implementeer* / *bouw* / *doe* / *fix* / *voer uit* / *ja* → code in deze beurt. Geen tweede plan.
- Volg bestaande patronen. Voorbeeld: `<pad/naar/voorbeeld>`. Term onbekend: [GLOSSARY.md](docs/context/GLOSSARY.md).
- <Afwijkende conventie die geen linter afdwingt, bv. "Postgres is de enige writer van user-data".>
- **Intent** boven groene tests (RULES/product niet afzwakken). **Geen** nieuwe modulegrenzen / `utils/` zonder vraag (seams in ARCHITECTURE). **Eén slice** per sessie; review eigen diff in frisse context. Rapporteer beknopt; `make check`-output tonen.
- Regels per app: `apps/<app>/AGENTS.md`.

## Afronden


**Zonder te vragen.** Na elke beurt met repo-wijziging (code, docs, specs, config) — of na een afgeronde slice — voer je dit uit. Wacht niet op "log", "rond af" of "ADR". Pure Q&A zonder schrijven: overslaan.

1. **Bundel in 1 call:** `make finish MSG="<kort wat gedaan>"` — draait check + logt in 1 call. Toon de output.
<!-- als: solo
2. Keuze met waarom (voortaan X, niet meer Y, stack/seam/productregel): `make adr t="<besluit als zin>"` + geraakte doc. Geen keuze → geen ADR en niet vragen.
3. Docs die deze wijziging raakt, bijgewerkt (alleen die). Kaart: [docs/INDEX.md](docs/INDEX.md).
4. Item in [BACKLOG.md](docs/work/BACKLOG.md) / spec afvinken als de slice echt klaar is.
-->
<!-- als: team
2. Keuze met waarom: `make adr t="<besluit als zin>"` + geraakte doc. Geen keuze → geen ADR en niet vragen.
3. Korte samenvatting in de PR, volgens de PR-template.
-->
