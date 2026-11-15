# Cardine — agent-instructies

Lab-eerst (spoor 3): minimale AI-harness + standaard; later mogelijk gratis product (portfolio/OS of closed). Voor mensen: [README.md](README.md).

## Nooit

- Secrets en `.env` niet lezen, tonen of committen. Nieuwe variabelen gaan naar de `.env.example` van de app die ze leest.
- Niets uit `data/raw/` of `data/runtime/` overnemen in code, tests, logs of antwoorden.
- Niet committen of pushen tenzij erom gevraagd is.
- Geen nieuwe map op root of in `docs/` zonder te vragen: elke soort bestand heeft al een vaste plek.
- Destructief (`make db-reset` e.d.) alleen op uitdrukkelijke vraag — wist lokale state.
- Inhoudelijke grenzen: [RULES.md](docs/rules/RULES.md). Security (live): [security.md](docs/architecture/security.md). Overige engineering-docs: via [docs/INDEX.md](docs/INDEX.md) — alleen als de opdracht ze raakt.

## Commando's

| Doel | Commando |
|------|----------|
| Alles controleren (moet groen voor je afrondt) | `make check` |
| Ook integratie-, e2e-, deps-audit en native STRICT | `make check-full` |
| Lokaal starten | `make dev` |
| Eén test | (na runtime-keuze: app-testcommando hier) |
| Dependency toevoegen | (na runtime-keuze; nooit `pip` als de stack `uv` gebruikt) |
| Alle commando's (incl. opt-in) | `make help` |
| Nieuw werkitem (index + plan) | `make spec s=<slug>` |

Opt-in (`security-scan*`, `obs-*`, `perf-*`, `deps-audit`, `polyglot-check`, `radar-*` / `digest-*`): alleen als de opdracht dat vraagt — `make help`, docs via INDEX.

## Werken

- Eerst [RULES.md](docs/rules/RULES.md). Daarna het open item: de opdracht noemt het (solo: `docs/work/BACKLOG.md`). Geen item: vraag welk. Geen default.
- Nieuw open werk: `make spec s=<slug>` — BACKLOG = **index** (korte regel + link); plan/slices in `docs/work/specs/<slug>.md`. Nooit een essay in de BACKLOG-tabel.
- De kaart is [docs/INDEX.md](docs/INDEX.md): kies het ene bestand bij je vraag. Geen hele map laden.
- Gedrag / feature: eerst [PRODUCT.md](docs/product/PRODUCT.md); daarna één domeinbestand.
- Architectuur / seams / modules: eerst [ARCHITECTURE.md](docs/architecture/ARCHITECTURE.md); daarna één subsystem. `## Bewust later` (P28): vraag of BACKLOG, niet stil inventeren.
- Onderzoek: eerst [RESEARCH.md](docs/research/RESEARCH.md); daarna één onderwerp- of experimentbestand.
- *subagents* / *delegeer* / *parallel* / te groot: specialisten in `.cursor/agents/`. Parent = synthese (P24).
- *clarify* / *check mijn prompt*: eerst `/clarify` (readonly); nooit auto vóór elke taak.
- **Uitvoeren wint van praten.** *implementeer* / *bouw* / *doe* / *fix* / *voer uit* / *ja* → code in deze beurt. Geen tweede plan.
- Volg bestaande patronen. Domeinen: `harness`, `structure`, `indexing` ([GLOSSARY.md](docs/context/GLOSSARY.md)). Term onbekend: GLOSSARY.
- Geen stack/generators tot expliciete Pi/TS-runtime-keuze. Lessen → eerst § in Agent_Engineering `bron/`, niet hier dupliceren.
- **Intent** boven groene tests (RULES/product niet afzwakken). **Geen** nieuwe modulegrenzen / `utils/` zonder vraag (seams in ARCHITECTURE). **Eén slice** per sessie; review eigen diff in frisse context. Rapporteer beknopt; `make check`-output tonen.
- Regels per app: `apps/<app>/AGENTS.md`.

## Afronden

**Zonder te vragen.** Na elke beurt met repo-wijziging (code, docs, specs, config) — of na een afgeronde slice — voer je dit uit. Wacht niet op “log”, “rond af” of “ADR”. Pure Q&A zonder schrijven: overslaan.

1. `make check` is groen (of leg kort uit waarom niet). Toon de output.
2. Docs die deze wijziging raakt, bijgewerkt (alleen die). Kaart: [docs/INDEX.md](docs/INDEX.md).
3. Dag-log: `make log`, daarna **bovenaan** onder `## Gedaan` een entry: aanleiding · bestanden · test · wat misging/bleef liggen · welk BACKLOG/spec-item. Lege template laten staan = niet afgerond.
4. Keuze met waarom (voortaan X, niet meer Y, stack/seam/productregel): `make adr t="<besluit als zin>"` + geraakte doc. Geen keuze → geen ADR en niet vragen.
5. Item in [BACKLOG.md](docs/work/BACKLOG.md) / spec afvinken als de slice echt klaar is.
