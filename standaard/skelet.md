# Skelet

> **Rol:** De volledige vaste boom van een project: welke map en welk ingangsbestand waar staat, en waarom.
> **Niet hier:** wat er in elk bestand staat ([bestanden](bestanden.md)), de indeling binnen een app ([stacks](stacks.md)).

## Grondregels

1. **Elke soort heeft één plek, en die plek ligt vast**, ook als de map vandaag nog niet bestaat. Een nieuwe map aanmaken is dan geen keuze meer, alleen uitvoeren.
2. **Kies vanaf dag één de indeling die meegroeit.** Altijd `apps/<app>/`, ook bij één app. Altijd `features/<domein>/` in de web-app, ook bij één feature. Zo vraagt groei nooit een verhuizing.
3. **De boom staat alleen hier.** Een project kopieert hem niet in zijn eigen docs (P5). De mappen die de kit neerzet, tonen de structuur aan mens en agent.
4. **Past iets nergens, dan pas je de standaard aan**, met een rij in [waar hoort dit](waar-hoort-dit.md) en een regel in deze boom. Maak geen losse map in het project.

## De boom

Legende: **●** kern, staat in elk project; [kit/kern](../kit/README.md#lagen) zet het neer · **○** module, de plaats ligt vast; aanmaken bij het eerste bestand of met `--modules` · **S** alleen solo · **T** alleen team.

```
project/
│
│   ── Ingangen ─────────────────────────────────────────────────────────────────────────
├── README.md                      ● MENS: wat, waarom, quickstart, demo-link, link naar docs/INDEX.md
├── AGENTS.md                      ● AGENT: Nooit, commando's, werken, afronden, link naar de kaart
├── .cursorrules                   S jouw laag voor Cursor: voorkeuren, verwijzing naar AGENTS.md; herhaalt er niets uit
├── CLAUDE.md -> AGENTS.md         ○ symlink voor tools die een andere naam lezen
├── Makefile                       ● alle commando's met vaste namen (standaard/makefile.md); `make check` = groen of niet
├── local.mk                       (niet in git) persoonlijke make-targets; de Makefile neemt ze op als het bestand bestaat
│
│   ── Repo-configuratie ────────────────────────────────────────────────────────────────
├── .gitignore                     ● vast blok uit kit/kern; beleid in standaard/git.md
├── .editorconfig                  ● inspringing, regeleinden, charset, voor elke editor
├── .pre-commit-config.yaml        ● guardrails vóór elke commit: secrets, grote bestanden, ruwe data
├── .gitattributes                 ○ Git LFS voor binaire bestanden, regeleinden
├── .tool-versions                 ○ vaste versies van node, pnpm, python, uv (mise of asdf)
├── .env.example                   ○ alleen voor docker-compose en root-scripts; apps hebben hun eigen
├── docker-compose.yml             ○ lokale diensten voor `make dev` (Postgres, Redis, …)
├── package.json                   ○ JS-workspace-root: scripts en devtools, geen app-code
├── pnpm-workspace.yaml            ○ + pnpm-lock.yaml: één lockfile voor alle JS-apps
├── LICENSE                        ○ alleen bij publieke code
│
│   ── Tools en automatisering ──────────────────────────────────────────────────────────
├── .cursor/
│   ├── agents/<rol>.md            ○ Cursor-subagents per rol (ui, product, …); zie standaard/agent-rollen.md
│   ├── rules/<app>.mdc            ○ path-scoped regels (globs: apps/<app>/**)
│   ├── hooks.json                 ○ agent-hooks: lint na een edit, schrijven in migrations/ blokkeren
│   └── hooks/<hook>.sh            ○ scripts die hooks.json aanroept
├── .github/
│   ├── workflows/check.yml        T `make check` op elke PR en op main
│   ├── workflows/native.yml       T bij stacks rust/c: `make check-full` (NATIVE_STRICT)
│   ├── workflows/digest.yml       T bij module research: fetch→propose→draft-PR
│   ├── workflows/deploy.yml       ○ alleen als de host niet zelf deployt
│   ├── pull_request_template.md   T
│   └── ISSUE_TEMPLATE/            T bug.md, feature.md
├── .vscode/                       ○ alleen gedeeld: extensions.json, launch.json; nooit persoonlijke settings
│
│   ── Documentatie (per soort, niet per app) ───────────────────────────────────────────
├── docs/
│   ├── INDEX.md                   ● de kaart: vraag → één bestand
│   │
│   ├── context/                   WAAROM en VOOR WIE
│   │   ├── CONTEXT.md             ● domein, gebruiker of klant, doel, scope, wat succes is
│   │   ├── GLOSSARY.md            ● term → betekenis → naam in de code; ook projectcodes en de domeinlijst
│   │   ├── vision.md              ○ lange termijn: richting, wat het ooit kan worden
│   │   └── assignment.md          ○ school of klant: opdracht, criteria, deadlines, contactpersonen
│   ├── rules/
│   │   └── RULES.md               ● inhoudelijke grenzen: wat nooit mag
│   │
│   ├── product/                   WAT het doet, gezien vanuit de gebruiker
│   │   ├── PRODUCT.md             ○ de domeinen in één tabel + "Bewust niet"
│   │   └── <domein>.md            ○ gedrag, regels, randgevallen van één domein
│   ├── design/                    HOE het eruitziet en aanvoelt (module `design` = huisstandaard-craft)
│   │   ├── DESIGN.md              ○ ingang bij UI-taken: principes, "nooit", tokens, kaart naar één craft-bestand
│   │   ├── shared/                ○ a11y, never, glass — geldt voor alle vlakken
│   │   ├── desktop/               ○ gate, performance, a11y + landingpage/ showcase-craft
│   │   ├── iphone/                ○ touch, motion, materials + application/ product-craft
│   │   └── <project-chrome>.md    ○ lat / session / IA — project-eigen, niet in de kit
│   ├── architecture/              HOE het in elkaar zit
│   │   ├── ARCHITECTURE.md        ● C4 1–2, stack, dataflow, invarianten, poorten, hosting, wat in git
│   │   ├── security.md            ● persoonsgegevens, secrets, auth, dreigingen, Strix
│   │   ├── observability.md       ● signalen, LGTM-stack, correlatie (runtime: module observability)
│   │   ├── performance.md         ● budgets, anti-patronen, bench (`make bench` / `perf-check`)
│   │   ├── dependencies.md        ● CVE-audits, ritueel, snellere/veiligere deps (`make deps-audit`)
│   │   ├── polyglot.md            ● extra/native talen, beslisboom, FFI/sidecar (`make polyglot-check`)
│   │   ├── data-model.md          ○ entiteiten, eigenaarschap, bewaartermijn (het schema zelf: migrations)
│   │   └── <subsysteem>.md        ○ auth, import, pipeline, ml, llm, …
│   ├── research/                  WAT WE WETEN over het domein
│   │   ├── RESEARCH.md            ○ onderzoeksvragen, hoe bronnen beoordeeld worden, kaart van de map
│   │   ├── <onderwerp>.md         ○ literatuur en domeinkennis, en welke productregel erop steunt
│   │   ├── wantlist.md            ○ bronnen die je nog wil verwerven
│   │   ├── radar.md               ○ tech-radar Adopt/Trial/Assess/Hold (`make radar-check`)
│   │   ├── digest/                ○ inbound feeds (`digest-fetch` / `digest-propose`; P5)
│   │   └── experiments/
│   │       └── YYYY-MM-DD-<slug>.md  ○ vraag, opzet, data, resultaat, conclusie (code: apps/<x>/experiments/)
│   ├── business/                  ○ businessplan, prijzen, juridisch, privacybeleid in mensentaal
│   │
│   ├── how-to/
│   │   └── <taak>.md              ● deploy, db resetten, data laden, release: één taak per bestand
│   ├── decisions/
│   │   ├── DECISIONS.md           ○ lijst van geldende besluiten, pas vanaf ±15 ADR's (anders in INDEX.md)
│   │   ├── _template.md           ● ADR-sjabloon; `make adr` kopieert het
│   │   ├── 0000-voorbeeld-native-module-na-budget-breuk.md  ● voorbeeldvorm polyglot (niet geldend)
│   │   └── NNNN-<slug>.md         ● één ADR per besluit; nooit herschrijven, wel vervangen
│   ├── agent/                     ○ agent-werkwijze die NIET bij elke taak geladen moet worden
│   │   ├── write-rules.md         ○ welke paden vrij, welke na toestemming, welke nooit
│   │   ├── doc-conventions.md     ○ hoe je een doc schrijft: notatie, tabellen, toon
│   │   ├── lessons.md             ○ lessen bij meta-taken; wat bij elke taak geldt → AGENTS.md
│   │   └── prompts/<taak>.md      ○ herbruikbare prompts
│   ├── assets/                    ○ afbeeldingen die docs tonen: <onderwerp>-<wat>.png (diagram liefst Mermaid)
│   ├── deliverables/              ○ opgeleverd: verslag, presentatie, poster, pdf; uitvoer, geen waarheid
│   │
│   ├── work/                      STATUS (team: in de issue tracker, niet hier)
│   │   ├── BACKLOG.md             S index open werk: korte regel + link; nieuw via `make spec`
│   │   ├── specs/<slug>.md        S plan per item; na merge weg (sjabloon: specs/_template.md)
│   │   ├── logs/YYYY-MM-DD.md     S wat er die dag gebeurde
│   │   └── meetings/YYYY-MM-DD-<met-wie>.md   ○ verslag van overleg met klant, coach of team
│   └── archive/                   ○ vervangen docs; de kaart sluit deze map uit
│
│   ── Code ─────────────────────────────────────────────────────────────────────────────
├── apps/                          ● elk apart draaibaar of deploybaar stuk, ook als er maar één is
│   └── <app>/                     vaste indeling per stack: [stacks](stacks.md)
├── packages/                      ○ gedeelde code die niet apart deployt: types, ui, config
│   └── <pakket>/
├── infra/                         ○ zodra één compose-bestand niet volstaat: IaC, db-init, k8s
├── scripts/                       ● scripts over de hele repo; check-links.sh (kern), bootstrap, release
├── tests/                         ○ tests over apps heen: end-to-end van het geheel, contracttests
│
│   ── Data (vaste lagen, [data](data.md)) ───────────────────────────────────────────────────────────
├── data/
│   ├── README.md                  ● catalogus: per dataset herkomst, licentie, PII, in git, hoe opnieuw maken
│   ├── raw/                       ● onbewerkte exports en downloads; nooit in git; nooit overschrijven
│   ├── external/                  ● van derden (papers, open data); nooit in git, alleen README.md
│   ├── interim/                   ● tussenstappen van de pipeline; nooit in git; mag altijd weg
│   ├── processed/                 ● uitvoer van de pipeline; in git alleen klein en anoniem (demo/)
│   ├── reference/                 ● met de hand samengesteld: catalogi, mappings, seeds; in git, gereviewd als code
│   ├── runtime/                   ○ wat de app lokaal schrijft (uploads); productie: volume of object storage
│   └── models/                    ○ getrainde modellen en hun metadata; nooit in git (of een registry)
│
└── tmp/                           (niet in git) scratch: screenshots, testrapporten, probeersels; mag altijd weg
```

**Waarom deze indeling:**

- **Docs per soort, niet per app.** Eén feit staat op één plek (P7). Wat alleen voor één app geldt, staat in de geneste `apps/<app>/AGENTS.md` of een `.mdc`-rule (P15), niet in `docs/<app>/`.
- **Vier soorten kennis, vier mappen.** `product/` zegt *wat* het doet, `design/` hoe het eruitziet, `architecture/` hoe het gebouwd is, en `research/` wat je over het domein weet. Een agent die een API-bug oplost, laadt dan geen literatuur, en een agent die een scherm bouwt, laadt geen pipeline-details.
- **Vluchtig en voorbij hebben elk één plek.** Status staat in `work/`, vervangen docs in `archive/`, en wegwerpwerk in `tmp/`. Al de rest is waarheid die je bijhoudt (P8).
- **Uitzondering op `apps/`:** het repo *is* één pakket dat nooit een tweede app krijgt, zoals een library, een CLI of een losse analyse. Zie [stacks §8](stacks.md#8-repo-dat-zelf-één-pakket-is). Bij twijfel kies je `apps/`.

**Klein project?** Het kopieerscript zet alleen de kern neer (●). Modules (○) komen er pas als je ze nodig hebt, maar altijd op hun plaats uit deze boom. Voor een prototype of hackathon volstaat de [minimale versie](../nieuw-project/minimaal.md).

---

## Wat bewust ontbreekt

* **Geen `PROJECT_STRUCTURE.md` met een volledige mappenboom in het project.** De boom staat hier, buiten elk project. Wat niet afleidbaar is (wat in git staat, welke map wat bezit, waar data heen gaat) staat in `ARCHITECTURE.md` en `data/README.md` (P5).
* **Geen `TODO.md` naast `BACKLOG.md`.** Eén plek voor open werk (P7).
* **Geen `CHANGELOG.md` voor interne projecten.** Git en de logs volstaan. Een publieke library is een uitzondering.
* **Geen kopie van tooldocumentatie** (Next.js, NestJS, pandas). Link ernaar, of laat de agent het zelf opzoeken.
* **Geen `docs/<app>/`.** Docs zijn per soort. Wat alleen voor één app geldt, staat in de geneste `AGENTS.md`.
* **Geen `notebooks/` op root.** Een experiment hoort bij de app wiens code het gebruikt, en het verslag hoort in `docs/research/experiments/`.
* **Geen `utils/`, `helpers/` of `misc/`.** Per stack is er één naam: `lib/` in de web-app, `common/` in de API.
* **Geen `src/` op root naast `apps/`.** Kies één van beide ([stacks §8](stacks.md#8-repo-dat-zelf-één-pakket-is)).
* **Geen submappen per categorie in `specs/` of `backlog/`.** Een categorie is een kolom, geen map. Anders verhuist een item als de categorie wijzigt.
