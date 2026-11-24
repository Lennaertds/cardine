# Per bestand: lezer, inhoud, grenzen

> **Rol:** Voor elk vast bestand: voor wie het is, wat erin hoort, wat niet, en hoe lang het mag zijn.
> **Niet hier:** hoe je het invult en voorbeelden ([sjablonen](../sjablonen/INDEX.md)).

| Bestand | Lezer | Wat erin staat | Wat er níet in staat | Richtlengte |
|---------|-------|----------------|----------------------|-------------|
| `README.md` | Mens | Wat het project is, waarom, quickstart, link naar `docs/INDEX.md`, demo-link | Status, backlog, mappenboom, agentinstructies | 30–80 regels |
| `AGENTS.md` | Agent | Dagelijks: harde grenzen, korte commandotabel, harde leesroutes (UI → `DESIGN.md`, feature → `PRODUCT.md`, architectuur → `ARCHITECTURE.md`, research → `RESEARCH.md`), één zin opt-in → INDEX/`make help`, wanneer subagents, intent/seams/slice/rapportage in korte vorm, afronden | Overzicht van de repo, keyword-catalogus van zelden-gebruikte docs, acht rijen opt-in Make-targets, genummerde always-on routes voor obs/perf/…, polyglot always-on in Nooit, stijlregels die een linter afdwingt, status, schrijfrechten-tabel (`write-rules`), lange rol-essays | 35–70 regels |
| `.cursor/agents/<rol>.md` | Cursor-subagent | Frontmatter (`name`, `description`, optioneel `model`/`readonly`) + korte werkwijze en welke docs/code die rol opent | Kopie van `AGENTS.md`, status, mappenboom | ≤ 40 regels |
| Geneste `AGENTS.md` | Agent | Wat alleen in deze app afwijkt: commando's, patronen, een voorbeeldbestand | Herhaling van de root | 10–40 regels |
| `.cursorrules` (solo) | Cursor | Verwijzing naar `AGENTS.md`, persoonlijke voorkeuren (taal, toon, browser-check), Cursor-specifieke afspraken | Alles wat in `AGENTS.md` staat: Cursor laadt beide, dus elke herhaling telt dubbel en kan botsen | ≤ 15 regels |
| `.cursor/rules/*.mdc` | Cursor (glob/description) | Alleen wat geneste `AGENTS.md` niet kan: path- of type-scoped regels | Kopie van AGENTS, mensdocs, `alwaysApply: true` voor wat bij elke taak geldt (dat hoort in AGENTS); geen massale docs→mdc | Zo kort als geneste AGENTS; audit in [cursor-rule](../sjablonen/cursor-rule.md) |
| `apps/<app>/README.md` | Mens | Wat de app doet, hoe je ze los draait, link naar de root | Architectuur, herhaling van de root-README | 10–30 regels |
| `docs/INDEX.md` | Beide | Per bestand: welke vraag het beantwoordt, en wanneer níet | Inhoud zelf | 1–2 regels per bestand |
| `context/CONTEXT.md` | Beide | Domein, gebruiker of klant, doel, scope, wat bewust niet | Techniek | 30–100 regels |
| `context/GLOSSARY.md` | Beide | Term → betekenis → naam in de code (tabel, module, type). Ook projectcodes en de lijst van domeinen ([stacks](stacks.md)) | Uitleg van algemene begrippen | Zo lang als nodig |
| `context/vision.md` | Beide | Waarom het op lange termijn bestaat, de richting, wat het ooit kan worden | Wat nu gebouwd wordt (`product/`), planning (`work/`) | 30–150 regels |
| `context/assignment.md` | Beide | Opdracht, beoordelingscriteria, deadlines, contactpersonen, met link naar de originele bron | Hoe je het oplost | Zo kort als de opdracht |
| `rules/RULES.md` | Beide | Inhoudelijke grenzen ("geen medisch advies", "Postgres is de enige writer") | Codestijl (linter), werkwijze (`AGENTS.md`) | Kort; elke regel telt |
| `product/PRODUCT.md` | Beide | De domeinen in één tabel (naam, één zin, link) en een sectie "Bewust niet" | Gedrag van één domein, techniek | 30–80 regels |
| `product/<domein>.md` | Beide | Wat de gebruiker kan, de regels (intentie + waarom + test), randgevallen, acceptatie vanuit de gebruiker | Implementatie, status; een test die de regel afzwakt telt niet als bewaking | Vrij |
| `design/DESIGN.md` | Beide | Ingang bij elke UI-taak: principes, wat nooit mag, tokens, kaart naar één craft-bestand | Kopie van de tokenwaarden (die staan in de code); hele craft-map in één keer | 40–120 regels |
| `design/shared/<x>.md` | Beide | Vloer voor alle vlakken: a11y, never, glass (module `design` levert de huisstandaard) | Product-IA, tokenwaarden | Vrij |
| `design/desktop/**` | Beide | Showcase-gate, performance, landingpage-craft | Product-logger, project-chrome | Vrij |
| `design/iphone/**` | Beide | Touch, motion, materials, application-craft (controls, surfaces, overlays) | lat/session-chrome (project) | Vrij |
| `design/<onderwerp>.md` | Beide | Extra craft buiten de huisstandaard-mappen | Andere onderwerpen | Vrij |
| `architecture/ARCHITECTURE.md` | Beide | Containers, hun verbindingen, stack, dataflow, invarianten, **seams** (naden + wat AI mag zonder akkoord), poorten, hosting, wat in git staat en wat niet | Bestandsopsomming, codedetails, routelijsten, PWA/offline/push-catalogus, auth-flow-dump, featurelijsten (→ `architecture/<subsysteem>.md`) | 60–100 regels (dikker = splitsen) |
| `architecture/security.md` | Beide | Gegevens, secrets, auth, Strix; **`## Bewust later`** (P28) | De "nooit"-regels zelf (`AGENTS.md`) | 40–150 regels |
| `architecture/observability.md` | Beide | Signalen, LGTM, correlatie, Make; **`## Bewust later`** (P28) | Security-dreigingen, containerdiagram, budgets | 40–120 regels |
| `architecture/performance.md` | Beide | Budgets, anti-patronen, bench; **`## Bewust later`** (P28) | Dashboards (`observability.md`) | 40–120 regels |
| `architecture/dependencies.md` | Beide | CVE-audits, ritueel, snellere deps; **`## Bewust later`** (P28) | Strix (`security.md`) | 40–120 regels |
| `architecture/polyglot.md` | Beide | Beslisboom extra/native taal, FFI/sidecar, agentgrenzen; **`## Bewust later`** (P28) | Budgets (`performance.md`); STRICT-CI (`how-to/native-ci.md`) | 40–120 regels |
| `decisions/0000-voorbeeld-native-module-na-budget-breuk.md` | Beide | Voorbeeld-ADR-vorm voor native na budget-breuk (status *voorbeeld*) | Geldende project-ADR’s (`make adr`) | Kort |
| `how-to/security-scan.md` | Beide | Strix installeren en scannen | Dreigingenlijst (`security.md`) | Kort |
| `how-to/perf-bench.md` | Beide | `perf-check` / `bench` en `scripts/bench.sh` per app | Budgets zelf (`performance.md`) | Kort |
| `how-to/deps-audit.md` | Beide | `deps-audit` en audit-tools | Beleid/ritueel (`dependencies.md`) | Kort |
| `how-to/native-ci.md` | Beide | Soft vs `NATIVE_STRICT` / `check-full` / `native.yml` | Beslisboom (`polyglot.md`) | Kort |
| `architecture/data-model.md` | Beide | Entiteiten, relaties, wie wat schrijft, bewaartermijnen | Kolom per kolom, als dat leesbaar in de migraties staat | Vrij |
| `architecture/<x>.md` | Beide | Contracten, schema's, algoritmen, randgevallen van één subsysteem | Andere subsystemen | Vrij |
| `research/RESEARCH.md` | Beide | Onderzoeksvragen, hoe je bronnen beoordeelt, kaart van de map | De inhoud per onderwerp | 20–60 regels |
| `research/<onderwerp>.md` | Beide | Wat de literatuur of het domein zegt, met bronnen, en welke productregel erop steunt | Hoe het geïmplementeerd is | Vrij |
| `research/wantlist.md` | Beide | Bronnen die je nog wil verwerven, met waarom | De bronnen zelf (`data/external/`); stack-keuzes (`radar.md`) | Kort houden |
| `research/radar.md` | Beide | Tech-radar Adopt/Trial/Assess/Hold; ritueel; **`## Bewust later`** (P28) | Always-on AGENTS; live scrapers | 40–120 regels |
| `research/digest/README.md` | Beide | Inbound digest, fetch/propose, P5; **`## Bewust later`** (P28) | Ring-inhoud (`radar.md`); auto-merge | 40–100 regels |
| `how-to/radar.md` | Beide | `radar-check` / `radar-reminder` en maandelijkse pass | Ring-inhoud (`radar.md`) | Kort |
| `how-to/digest.md` | Beide | `digest-check` / fetch / propose | Feed-inhoud zelf | Kort |
| `research/experiments/*.md` | Beide | Vraag, opzet, data (pad en datum), resultaat, conclusie, wat het product ermee doet | Code (in `apps/<x>/experiments/`) | 20–80 regels |
| `business/*.md` | Mens | Businessplan, prijzen, voorwaarden, privacybeleid in mensentaal | Technische uitvoering van privacy (`security.md`) | Vrij |
| `how-to/<taak>.md` | Beide | Genummerde stappen met commando's en de verwachte uitkomst | Achtergrond (dat is uitleg of een ADR) | Kort |
| `decisions/DECISIONS.md` | Beide | Geldende besluiten: nummer, titel, link. Vervangen besluiten onderaan of weg | Inhoud van de besluiten | 1 regel per besluit |
| `decisions/NNNN-*.md` | Beide | Status, context, besluit, alternatieven, gevolgen | Implementatiestappen, status van werk | 15–60 regels |
| `agent/write-rules.md` | Agent, bij schrijven | Welke paden vrij, welke na toestemming, welke nooit | Werkwijze en leesroutes die bij elke taak gelden (`AGENTS.md`) | Eén tabel |
| `agent/doc-conventions.md` | Agent, bij schrijven | Notatie, toon, tabellen, opbouw van een doc | Inhoud | 20–60 regels |
| `agent/lessons.md` | Agent, bij meta-taken | Lessen na mislukkingen die niet bij elke taak gelden | Wat bij elke taak geldt (één regel in `AGENTS.md`) | Kort |
| `agent/prompts/*.md` | Mens | Prompts die je herhaalt | Uitleg over de agent | Per prompt |
| `deliverables/*` | Mens | Wat je opleverde, zoals je het opleverde | Waarheid: een deliverable verwijst naar docs, nooit omgekeerd | — |
| `work/BACKLOG.md` | Beide | **Index** van open werk (Nu / Straks / Geparkeerd): korte regel + link naar spec; nieuw Nu-item alleen via `make spec` | Plan, slices, essay, afgewerkt werk (→ specs / logs / git) | Kort houden |
| `work/specs/*.md` | Agent | Plan per werkitem: doel, scope, buiten scope, raakvlakken (incl. seams), slices (één sessie elk), acceptatie op intent + `make check` | Na merge: niets meer, dus weg; geen vervanging van de BACKLOG-index | Per taak |
| `work/logs/*.md` | Mens | Wat er gebeurde, wat misliep | Waarheid (dat staat in docs) | Vrij; wordt niet vooraf gelezen |
| `work/meetings/*.md` | Mens | Wie er was, wat er beslist werd, acties | Het besluit zelf (dat wordt een ADR) | Kort |
| `archive/*` | Mens | Vervangen docs, met bovenaan wat het vervangt en waarom | — | — |
| `data/README.md` | Beide | Per dataset: pad, herkomst, licentie, persoonsgegevens, in git ja of nee, hoe je hem opnieuw maakt | Schema in detail (`data-model.md`), pipeline (`architecture/`) | Eén tabel |

---
