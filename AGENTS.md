# IDE_Agentic — agent-instructies

Lab-eerst (spoor 3): minimale AI-harness + standaard; later mogelijk gratis product (portfolio/OS of closed). Voor mensen: [README.md](README.md).

## Nooit

- Secrets en `.env` niet lezen, tonen of committen. Nieuwe variabelen gaan naar de `.env.example` van de app die ze leest.
- Niets uit `data/raw/` of `data/runtime/` overnemen in code, tests, logs of antwoorden.
- Niet committen of pushen tenzij erom gevraagd is.
- Geen nieuwe map op root of in `docs/` zonder te vragen: elke soort bestand heeft al een vaste plek.
- Destructief (`make db-reset` e.d.) alleen op uitdrukkelijke vraag — wist lokale state.
- Inhoudelijke grenzen: [RULES.md](docs/rules/RULES.md). Security (live): [security.md](docs/architecture/security.md). Overige engineering-docs (obs, perf, deps, polyglot, …): via [docs/INDEX.md](docs/INDEX.md) — alleen als de opdracht ze raakt.
- Geen aanname dat Rust/C (of andere systemstalen) “niet mogen”: hot paths na meting + ADR — [polyglot.md](docs/architecture/polyglot.md). Geen native-map aannemen tot die stack + ADR er is.

## Commando's

| Doel | Commando |
|------|----------|
| Alles controleren (moet groen voor je afrondt) | `make check` |
| Ook integratie-, e2e-, deps-audit en native STRICT | `make check-full` |
| Lokaal starten | `make dev` |
| Eén test | (na runtime-keuze: app-testcommando hier) |
| Dependency toevoegen | (na runtime-keuze; nooit `pip` als de stack `uv` gebruikt) |
| Alle commando's (incl. opt-in) | `make help` |

Niet-dagelijks (`security-scan*`, `obs-*`, `perf-check` / `bench`, `deps-audit`, `polyglot-check`, en met research: `radar-*` / `digest-*`): alleen als de opdracht dat vraagt — targets in `make help`, docs via INDEX.

## Werken

- Eerst [RULES.md](docs/rules/RULES.md). Daarna het open item: de opdracht noemt het (solo: `docs/work/BACKLOG.md`; team: de issue tracker). Geen item: vraag welk. Geen default.
- De kaart is [docs/INDEX.md](docs/INDEX.md): kies het ene bestand bij je vraag en open dat. Een tweede bestand of de code lezen mag altijd. Laad geen hele map in één keer.
- Opdracht over gedrag of feature: eerst [PRODUCT.md](docs/product/PRODUCT.md); open daarna alleen het ene domeinbestand.
- Opdracht over **architectuur**, seams, containers, modules of dataflow: eerst [ARCHITECTURE.md](docs/architecture/ARCHITECTURE.md); open daarna alleen het ene subsystembestand. Architecture-docs met `## Bewust later`: bewuste weglatingen (P28) — vraag of BACKLOG, niet stil inventeren.
- Opdracht over **onderzoek**, analyse, literatuur of experiment: eerst [RESEARCH.md](docs/research/RESEARCH.md); open daarna alleen het ene onderwerp- of experimentbestand.
- **Uitvoeren wint van praten.** Zegt de opdracht *implementeer*, *bouw*, *doe*, *fix*, *voer uit*, of *ja* op een bouwvoorstel: in **deze** beurt code schrijven. Geen tweede plan, geen "zal ik beginnen?", geen antwoord dat alleen bespreekt.
- Alleen een kort plan vóór code als de aanpak onzeker is **én** de gebruiker nog niet om uitvoering vroeg (of om een plan/spec vroeg). Na akkoord of "implementeer": meteen bouwen.

**Alleen als de opdracht het noemt** (geen always-on leesroute):

| Opdracht noemt | Open |
|----------------|------|
| security-scan, pentest, Strix | [security.md](docs/architecture/security.md) + [how-to/security-scan.md](docs/how-to/security-scan.md); alleen eigen targets |
| observability, metrics, traces, logs, Grafana | [observability.md](docs/architecture/observability.md) |
| performance, latency, budgets, bench | [performance.md](docs/architecture/performance.md) + [how-to/perf-bench.md](docs/how-to/perf-bench.md) |
| dependencies, CVE, package-hygiëne | [dependencies.md](docs/architecture/dependencies.md) + [how-to/deps-audit.md](docs/how-to/deps-audit.md) |
| polyglot, Rust/C, FFI, “mag ik native?” | [polyglot.md](docs/architecture/polyglot.md); voorbeeld-ADR `docs/decisions/0000-voorbeeld-…` |
| tech-radar, Adopt/Trial | [radar.md](docs/research/radar.md) + [how-to/radar.md](docs/how-to/radar.md); `make radar-check` / `radar-reminder` |
| digest, feeds, inbound nieuws | [digest/README.md](docs/research/digest/README.md) + [how-to/digest.md](docs/how-to/digest.md); voorstel mag, `radar.md` niet auto (P5) |

- Volg bestaande patronen. Domeinen: `harness`, `structure`, `indexing` ([GLOSSARY.md](docs/context/GLOSSARY.md)).
- Een term die je niet kent: [GLOSSARY.md](docs/context/GLOSSARY.md).
- Geen stack/generators tot expliciete Pi/TS-runtime-keuze. Lessen → eerst § in Agent_Engineering `bron/`, niet hier dupliceren.
- **Intent boven groene tests.** Productregels en [RULES.md](docs/rules/RULES.md) niet afzwakken om tests te laten slagen. Ontbreekt een regel: vastleggen in `product/` of RULES, niet stil omzeilen.
- **Geen nieuwe modulegrenzen** of `utils/`/`helpers/` zonder te vragen. Volg bestaande domeinmodules; seams staan in [ARCHITECTURE.md](docs/architecture/ARCHITECTURE.md).
- **Eén slice per sessie.** Past een taak niet in één beurt: BACKLOG-item + spec met genummerde slices; alleen de gevraagde slice doen; eindig met `Zeg "Ga verder met slice N"`. Queue van die prompts is OK. Voortgang in BACKLOG/spec/log, niet in de chat. Lange keten: na ~3–5 zware slices liever nieuwe chat op slice N. Micro-fix: geen BACKLOG-theater. Review van je eigen diff: nieuwe sessie of sub-agent, niet in dezelfde context.
- **Rapporteer extreem beknopt**; grammatica mag wijken voor kortheid. Bewijs (`make check`-output e.d.) wél tonen.
- Regels die alleen voor één app gelden, staan in `apps/<app>/AGENTS.md`.

## Afronden

1. `make check` is groen. Toon de output.
2. Docs die deze wijziging raakt, zijn bijgewerkt (alleen die). Kaart gewijzigd: [docs/INDEX.md](docs/INDEX.md).
3. Een keuze met een waarom: nieuwe ADR met `make adr t="<besluit als zin>"`.
4. Dag-log bijgewerkt (`make log`) en het item in [BACKLOG.md](docs/work/BACKLOG.md) afgevinkt.
