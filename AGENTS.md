# Cardine — agent-instructies

Lab-eerst (spoor 3): minimale AI-harness + standaard; later mogelijk gratis product (portfolio/OS of closed). Voor mensen: [README.md](README.md).

## Nooit

- Secrets en `.env` niet lezen, tonen of committen; nieuwe variabelen alleen in de `.env.example` van de app.
- Niets uit `data/raw/` of `data/runtime/` overnemen in code, tests, logs of antwoorden.
- Niet committen of pushen tenzij gevraagd.
- Geen nieuwe map op root of in `docs/` zonder te vragen; geen nieuwe modulegrenzen / `utils/` buiten [ARCHITECTURE.md](docs/architecture/ARCHITECTURE.md).
- Destructief (`make db-reset` e.d.) alleen op uitdrukkelijke vraag.
- Geen stack/generators tot expliciete Pi/TS-runtime-keuze (`ADR 0001`). Lessen → eerst `§` in `Agent_Engineering/bron/`, niet hier dupliceren.

## Commando's

| Doel | Commando |
|------|----------|
| Startcontext in 1x lezen (`RULES` + `BACKLOG` + `spec`) | `make context [s=<slug>]` |
| Afronden in 1x (`make check` + dag-log bovenaan bijwerken) | `make finish m="<aanleiding> · <bestanden> · <test> · <rest> · <item>"` |
| Alles controleren / uitgebreid controleren | `make check` · `make check-full` |
| Lokaal starten / nieuw werkitem / nieuwe ADR | `make dev` · `make spec s=<slug>` · `make adr t="<besluit als zin>"` |

Alle commando's (incl. opt-in `security-scan*`, `obs-*`, `perf-*`, `deps-audit`, `polyglot-check`, `radar-*`, `digest-*`): `make help`.

## Werken

- **Start in 1 call:** draai `make context` (of `make context s=<slug>`) voor `RULES.md` + `BACKLOG.md` + eventuele spec. Geen item genoemd en niet duidelijk uit `BACKLOG.md`? Vraag welk item — geen default.
- **Direct naar het juiste bestand** (open [docs/INDEX.md](docs/INDEX.md) alleen als de plek onbekend is): gedrag → [PRODUCT.md](docs/product/PRODUCT.md) + 1 domeinbestand; architectuur/seams → [ARCHITECTURE.md](docs/architecture/ARCHITECTURE.md) + 1 subsystem; onderzoek → [RESEARCH.md](docs/research/RESEARCH.md) + 1 verslag; termen (`harness`, `structure`, `indexing`) → [GLOSSARY.md](docs/context/GLOSSARY.md); security → [security.md](docs/architecture/security.md).
- **Nieuw open werk:** `make spec s=<slug>` (BACKLOG blijft een korte indexregel; plan in `docs/work/specs/<slug>.md`).
- **Uitvoeren wint van praten:** bij *implementeer* / *bouw* / *doe* / *fix* / *voer uit* / *ja* → direct code/docs wijzigen in deze beurt, geen tweede plan.
- **Kwaliteit & scope:** **intent** boven groene tests; **één slice** per sessie; `## Bewust later` (P28) bij bewust incomplete oplevering. Regels per app: `apps/<app>/AGENTS.md`.
- **Delegatie / review:** *subagents* / *parallel* → `.cursor/agents/` (parent = synthese, P24); *clarify* → `/clarify` (readonly, nooit auto).

## Afronden

**Zonder te vragen** na elke beurt met repo-wijziging (pure Q&A zonder schrijven: overslaan):

1. Draai `make finish m="<aanleiding> · <bestanden> · <test> · <wat bleef liggen> · <item>"` (draait `make check` en schrijft bovenaan `## Gedaan` in de dag-log) en toon de output.
2. Werk alleen de geraakte docs bij (kaart: [docs/INDEX.md](docs/INDEX.md)) en vink een afgerond item af in [BACKLOG.md](docs/work/BACKLOG.md) / spec.
3. Sprak de gebruiker in deze beurt een keuze uit (stack, seam, volgorde, productregel)? Draai `make adr t="<besluit als zin>"` en werk de geraakte doc bij.
