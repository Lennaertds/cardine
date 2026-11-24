# Bronnen — video's en geschreven bronnen

> **Rol:** Naslag: samenvattingen van video's en geschreven bronnen. `§n` in andere bestanden verwijst hierheen.
> **Niet hier:** de principes zelf (zie [principes.md](principes.md)) of een snelle inhoudsopgave (zie [bronnen-index.md](bronnen-index.md)).

**Agent Engineering** dekt bijna alle bronnen hier. Indeling is **per thema** (niet per formaat): de **vierlagen-stack** (Prompt → Context → Harness → Loop), daarna praktijk (Graph, Workflow & Specs, Software design, Agent-docs, Ship quality, Product/tooling), daarna fundament-spiegel (Inference, Reasoning, Model internals, Industrie). Elke § begint met **Type** en **URL**. `§n` blijft chronologisch toegekend (vast nummer); binnen een thema staan bronnen oplopend op §-nummer. §1–§9 en §10–§24 houden hun vaste nummers; nieuwere bronnen zijn §25–§192. Diepte: [fundament/](fundament/INDEX.md). Video-prompt: [fundament/prompts/youtube-samenvatting.md](fundament/prompts/youtube-samenvatting.md). Het [totaaloverzicht](#totaaloverzicht) onderaan wordt bijgewerkt wanneer er bronnen bij komen. Een PDF die bij een § hoort, ligt in deze map onder een duidelijke naam (`Auteur-Korte-Titel.pdf`, zoals `DeepSeek-V3_Technical_Report.pdf`); de § linkt erheen.

---

# Prompt Engineering

## §3. Building Great Agent Skills (`The Missing Manual`)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=UNzCG3lw6O0](https://www.youtube.com/watch?v=UNzCG3lw6O0)

In deze video ontleedt Matt Pocock de opbouw van een effectieve AI-skill. Hij waarschuwt voor **"Skill Hell"**: de situatie waarin ontwikkelaars of organisaties tientallen willekeurige prompts en skills verzamelen, maar geen idee hebben waarom sommige wel werken en andere faalbaar of token-slurpends zijn.

```
                                  DE SKILL-CHECKLIST
      ┌────────────────────────────────────────────────────────────────────────┐
      │  1. Trigger   ──>  2. Structure   ──>  3. Steering   ──>  4. Pruning   │
      └────────────────────────────────────────────────────────────────────────┘

```

#### A. The Skill Checklist: Het Raamwerk

##### 1. Trigger Architecture (User-Invoked vs. Model-Invoked)

* **User-Invoked Skills:** Worden handmatig opgeroepen door de ontwikkelaar (bijv. met `/skill-naam`).
* *Voordeel:* **Nul token-overhead** op de achtergrond. De agent hoeft niet continu alle skill-beschrijvingen in zijn geheugen mee te dragen. Maximale voorspelbaarheid.
* *Nadeel:* Hoog cognitieve belasting voor de gebruiker (je moet weten welke skills bestaan en wanneer je ze inzet).


* **Model-Invoked Skills:** De AI leest een korte beschrijving (*context pointer*) in de system prompt en besluit zelfstandig om de skill in te laden wanneer dat nodig is.
* *Voordeel:* Lage belasting voor de gebruiker; de agent kiest zelf zijn gereedschap.
* *Nadeel:* Hoge **Context Load** (elke skill-beschrijving kost permanent tokens) en risico op **onvoorspelbaarheid** (de agent kan besluiten een relevante skill toch niet aan te roepen).


---

##### 2. Intern Structureren: Steps, Reference & Context Pointers

Een goed opgebouwde skill bestaat theoretisch uit twee hoofdelementen:

1. **Steps:** De chronologische, stapsgewijze procedure die de AI moet doorlopen.
2. **Reference:** Ondersteunende informatie (zoals een sjabloon of uitleg van een concept).

```
               [ Main skill.md ] (Minimale omvang)
                      │
                      ├── Pointer: Branch A ──> [ External_Ref_A.md ]
                      └── Pointer: Branch B ──> [ External_Ref_B.md ]

```

* **Het 'Small `skill.md`' Principe:** Het hoofdbestand van de skill (`skill.md`) moet zo klein mogelijk zijn om tokens te besparen en de onderhoudbaarheid te vergroten.
* **External References via Context Pointers:** Als een skill meerdere paden (*branches*) heeft, moet de referentiedocumentatie die alléén voor een specifiek pad geldt, worden weggezet in een los Markdown-bestand. Pas wanneer de AI dat specifieke pad inslaat, volgt hij de *context pointer* naar dat bestand.

---

##### 3. Steering: Sturing via 'Leading Words' en Hiding Future Goals

* **Het Concept van Leading Words (Leitmotif):**
* Eenvoudige instructies als *"schrijf niet laag voor laag"* werken vaak slecht bij AI.
* **Oplossing:** Gebruik een term uit het vakgebied met een hoge informatiedichtheid, zoals **"Vertical Slice"**. Wanneer dit begrip herhaaldelijk in de skill wordt verankerd, zie je het terugkeren in de *reasoning traces* (de interne gedachten) van het model, wat het gedrag van de AI krachtig stuurt.


* **Hiding Future Goals (Legwork Vergroten):**
* **Probleem:** AI is vaak "eager" (te haastig). Als een skill zowel stap 1 (*stel verhelderende vragen*) als stap 2 (*maak een plan*) bevat, zal de AI stap 1 afrafelen om zo snel mogelijk bij het einddoel (stap 2) te komen.
* **Oplossing:** Splits de fase op in twee afzonderlijke skills. Verberg het uiteindelijke doel (stap 2) voor de agent zolang hij in stap 1 bezig is. Zo wordt de AI gedwongen om grondig werk (*legwork*) te verrichten op de huidige stap.


---

##### 4. Pruning: Het Eliminatieproces

Om een skill zo scherp en goedkoop mogelijk te houden, moeten drie vormen van ruis worden weggesneden:

1. **Sedimentation (Bezinksel):** Ongebruikte, verouderde regels die zich in de loop der tijd opstapelen doordat meerdere mensen instructies toevoegen zonder oude regels te durven wissen.
2. **Duplicatie (DRY-principe):** Zorg ervoor dat elk stuk informatie of referentiemateriaal in een skill exact één *Single Source of Truth* heeft.
3. **No-Ops:** Instructies in de prompt die in de praktijk **geen enkel effect** hebben op de output van het model (bijv. een lange alinea die vraagt om nette commit-messages, wat het model van nature al doet). Via een *deletion test* (verwijderen en testen of het resultaat verandert) worden no-ops opgespoord en gewist.

---


---

## §50. Ponytail — “lazy senior” skill voor coding agents

**Type:** Tool + video · **URL:** [https://ponytail.dev/](https://ponytail.dev/)

- **Kern in 2–3 zinnen:** Ponytail is een always-on ruleset/skill die coding agents een *laziness ladder* laat lopen vóór ze code schrijven: YAGNI → hergebruik → stdlib → platform → dependency → one-liner → pas dan minimum. Marketing claimt fors minder LOC/tokens/kosten; de oorspronkelijke single-shot-benchmark (80–94% minder code) is later herzien na kritiek (§51).
- **Status in deze repo:** opnemen als ideeënbron. **Niet** letterlijk installeren als default: kortere code ≠ overzichtelijkere of beter te onderhouden code. Wel bruikbaar als input voor sturing: *simpel houden*, geen over-engineering, performance-bewust — zonder “alles in één file / zo weinig regels mogelijk”.

---

#### A. Wat het is (architectuur van het project)

* Kernlogica: één prompt — `skills/ponytail/SKILL.md` (orde ~100 regels); compacte variant in `AGENTS.md` voor instruction-only hosts.
* Rest van de repo: adapters/plugins/hooks voor Claude Code, Codex, Cursor, Windsurf, Cline, Copilot, OpenCode, Gemini, … + benchmarks + commands.
* Ironie (ook in HN/§51): groot repo rond een dunne skill — “leftpad”-kritiek.

```
  request
    → lees geraakte code + call path   (niet overslaan)
    → ladder (rung 1…7)
    → schrijf minimum + evt. kleine test bij logic
    → eindig met wat je oversloeg / risico's
```

#### B. De ladder (inhoud, niet marketing)

Volgorde die de skill afdwingt (samenvatting uit README/site):

1. Moet dit bestaan? (YAGNI) — anders skip
2. Staat het al in deze codebase? — hergebruik
3. Doet de standard library het? — gebruik die
4. Heeft het platform een native feature? — gebruik die
5. Lost een geïnstalleerde dependency het op? — gebruik die
6. Kan het in één regel? — één regel
7. Pas dan: minimum dat werkt + één kleine test als er branches/loops/parsers/geld/security in zit

*Expliciete “niet knippen”-zone (belangrijk t.o.v. naïeve “schrijf minder”):* trust-boundary validation, data-loss handling, security, accessibility.

Intensiteit: `lite` | `full` (default) | `ultra` | `off`.

#### C. Commands (niet letterlijk overnemen in onze Makefile)

| Command | Rol |
|---------|-----|
| `/ponytail [lite\|full\|ultra\|off]` | Niveau zetten / tonen |
| `/ponytail-review` | Review van de diff: bugs, security, load, missing tests, speed, **en** wat te schrappen (niet alleen delete-list) |
| `/ponytail-audit` | Zelfde checks op hele repo (eerst map: entry points, dataflow, expected load) |
| `/ponytail-debt` | Uitgestelde `ponytail:`-shortcuts → ledger (“later” niet vergeten) |
| `/ponytail-gain` | Scoreboard: minder code / kosten / sneller t.o.v. benchmark |
| `/ponytail-help` | Korte referentie |
| `/ponytail band` | Claude Code UI-band (kosten/tokens/reuse) tonen/verbergen |

Host-limieten: slash-commands vereisen skill-capable host (Claude Code, Codex, …). In Cursor e.d. vaak always-on ruleset **zonder** interactieve slash-commands. Codex: skills via `@`.

#### D. Benchmarks — wat je wél/niet mag geloven

* **Vroege claim (single-shot promptfoo):** mediaan LOC baseline vs caveman vs ponytail; marketing “80–94% less code”. Taken: email validate, debounce, CSV sum, countdown, rate-limit — triviaal t.o.v. echte agent-work.
* **§51** toont: baseline was chatty (meerdere voorbeelden) → LOC opgeblazen; 7 woorden “Follow YAGNI… one-liners” sloeg Ponytail op die suite.
* **Herbouw (agentic, na kritiek):** echte Claude Code-sessies op FastAPI+React-repo; LOC = git diff; arms o.a. bare YAGNI+one-liner. Claim herzien naar ~**54% minder code gemiddeld**, piek tot 94% alleen bij over-build-traps; bare one-liner soms minder veilig (pad-traversal guard weggelaten in één run). Ponytail 5-site: −53% code, −45% output tokens, −26% cost, −41% time (Opus 5.5, 39 tasks) — **vendorcijfers**, kritisch lezen.

#### E. Spanningsveld met *onze* voorkeur

* Gebruiker/standaard: liever **overzichtelijke**, maintainable code met commentaar, modules, geen “alles in zo weinig regels”.
* Ponytail optimaliseert op **minder emit** — dat kan collapsen tot dense one-liners of te weinig structuur als je de ladder zonder tegengewicht draait.
* Bruikbaar midden: stuur op **geen over-engineering** + **stdlib/platform eerst** + **performance waar het meetbaar is**, maar hou **leesbaarheid, seams, tests, docs** als harde constraints (P5, P13, deep modules §2/§32).

#### Wat ik meeneem

* YAGNI-ladder als *checklist vóór genereren* is waardevol; de verpakking als virale skill is dun (§51).
* Commands die lijken op wat we al hebben: `make check` / review-achtige targets — verdiepen i.p.v. `/ponytail-*` kopiëren (bijv. expliciete “over-engineering audit” of “security+perf review” later overwegen).
* Nooit “one-liner” als primary KPI; wel “geen dode abstracties / geen tweede implementatie van stdlib”.
* Safety-tier in herbouwde benchmark: *lazy ≠ negligent* — dat onderscheid overnemen in eigen agent-regels.

#### Open / onduidelijk

* Hoe Ponytail scoort op *maintainability* (niet gemeten in LOC/cost).
* Of always-on skill + prompt-cache (harness tax §30) de moeite waard is vs. korte YAGNI-zin in `AGENTS.md`.
* Exacte overlap met bestaande kit-dont’s en deep-module-regels — brug later, niet nu.

---

## §51. Ponytail? YAGNI! — kritiek op skill-benchmarks (Colin Eberhardt)

**Type:** Artikel · **URL:** [https://blog.scottlogic.com/2026/06/16/ponytail-yagni-and-the-problem-with-prompt-benchmarks.html](https://blog.scottlogic.com/2026/06/16/ponytail-yagni-and-the-problem-with-prompt-benchmarks.html)

- **Kern:** Ponytail is inhoudelijk vooral **YAGNI in ~100 regels Markdown**, verpakt in een groot repo met indrukwekkende (maar aanvankelijk misleidende) LOC-benchmarks. Een 7-woorden-prompt sloeg Ponytail op de *oorspronkelijke* suite. Breder punt: **Skills zonder robuuste eval** rijden op hype; leer models zelf kennen i.p.v. andermans prompt te aanbidden.

---

#### A. Waarom Ponytail aandacht kreeg

* Probleem is echt: agents over-engineeren / te verbose.
* 20k★ in ~1 week + cijfers op de site → uitzonderlijk t.o.v. skills die alleen claims hebben.
* Onder de motorkap: dunne skill; rest adapters. AI-schrijfstijl-tropes in de copy (“The ladder is a reflex…”).

#### B. Wat er mis was met de eerste benchmark

* promptfoo, taken als email/debounce/csv/countdown/rate-limit — te klein voor “Claude Code op mijn repo”.
* LOC telt **alle code in het antwoord**; baseline zonder skill geeft vaak **meerdere voorbeelden + prose** → baseline kunstmatig hoog.
* Debounce-test faalde door DOM-aanname — slechte proxy voor agent+harness met duidelijke context.
* Caveman (terse prose skill) als extra arm — gimmick die wél tokens kan besparen.

#### C. Eberhardt’s ablaties (Haiku, zijn runs)

| Conditie | Gem. LOC (orde) |
|----------|-----------------|
| Baseline | 108 |
| + “one example, no commentary” | 16 |
| + “Follow YAGNI principles” | 10.4 |
| Ponytail | 8.25 |
| + “YAGNI + one-liner solutions” | **6.9** (wint) |

Correctness bleef 100% in zijn runs. Conclusie: op *die* suite is Ponytail ≈ YAGNI(+one-liners), geen magie.

#### D. Wat goed en slecht is aan YAGNI (voor ons)

**Goed**

* Remt spekulatieve abstracties en “voor het geval dat”-frameworks — past bij deep modules / anti-slop (§2, §32).
* Goedkoop te zeggen in `AGENTS.md` zonder 6k-LOC plugin.
* Dwingt “bestaat dit al / stdlib eerst”-denken.

**Slecht / risico**

* YAGNI ≠ “schrijf onleesbare one-liners” of “sla validatie over”.
* Benchmarks die LOC minimaliseren belonen compactheid, niet maintainability (jouw voorkeur: overzicht + commentaar + modules).
* Skills die YAGNI herverpakken zonder agentic eval geven schijnzekerheid.
* Effect hangt van **model + harness** af; skills verouderen zonder regressie-suite (Eberhardt’s meta-punt over Anthropic skills-repo).

#### E. Nasleep (belangrijk voor “hype vs leren”)

* Ponytail-auteur gaf kritiek toe, herbouwde **agentic** benchmark (echte sessies, git-diff LOC, safety-arm). Claims naar ~54% minder code + safety-onderscheid lazy vs careless (§50).
* Eberhardt reageerde positief op die respons — voorbeeld van hoe kritiek de artefacten beter maakt.

#### Wat ik meeneem

* **Meet skills agentic**, niet single-shot chatty completions — parallel aan hoe wij `meten/` willen gebruiken.
* Neem YAGNI-ideeën over als **principes/checklists**, niet als virale plugin-default.
* Wantrouw LOC% in marketing; vraag: *wat telt als regel, wat is de baseline, wat is de harness?*
* Eigen sturing: “simpel + performant + leesbaar” > “minste regels”.

#### Open / onduidelijk

* Hoe vaak “7 woorden YAGNI” faalt op echte multi-file refactors t.o.v. volledige ladder+hooks.
* Of onze Makefile-targets al genoeg “review/audit”-surface hebben zonder nieuwe skill-commands.

---

## Synthese — waar de bronnen het over eens zijn


| Principe | Ondersteund door |
|----------|------------------|
| Context is eindig; meer tokens geeft niet automatisch beter werk | 10, 12, 17, 18, 19 |
| Selectie en presentatie zijn belangrijker dan volume | 10, 17, 18 |
| Afleiders en verouderde of dubbele info schaden meer dan ruis | 18, 20, 23 |
| Klein routerbestand vooraf, details just-in-time | 10, 12, 13, 14, 15 |
| Niet documenteren wat afleidbaar is uit code (mappenboom, per bestand) | 12, 13, 16, 20, 24, 34 |
| Wél documenteren: commando's, tooling, valkuilen, het waarom | 12, 14, 20, 23, 34 |
| Verifieerbare feedback (tests, linters, hooks) is de grootste hefboom | 11, 12, 19 |
| Lokaliteit: regels dicht bij de code waarvoor ze gelden | 13, 14 |
| Het belangrijkste vooraan | 17 |
| Contextbestanden snoeien en testen zoals code | 12, 13, 20, 21, 34 |
| Elke verbetering meten in plaats van aannemen | 11, 20 |

**Spanningsveld om verder te onderzoeken:** de tool-makers (10, 12, 14) raden contextbestanden met een overzicht sterk aan. De enige rigoureuze evaluatie (20) vindt dat overzichten niet helpen en dat de winst hooguit marginaal is. Dat verschil is een concrete onderzoeksopening voor een bachelorproef. Coldtea (§34) laat zien dat top-repos wél structure in `AGENTS.md` zetten — empirisch geen steun (§20), wel een gangbare gewoonte.

---

## §54. Skills vs MCP vs RAG vs Memory: What AI Agents Need to Know (IBM Technology / Martin Keen)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=X4FVEEegCbk](https://www.youtube.com/watch?v=X4FVEEegCbk)

- **Duur:** ~9:10
- **Kern in 2–3 zinnen:** Martin Keen (IBM Technology) zet vier manieren naast elkaar om een agent *extra kennis* te geven buiten trainingsdata: **Skills**, **MCP**, **RAG** en **Memory**. Anti-patroon: alles (runbooks, dashboards, klantgeschiedenis) in één keer in het context window dumpen. Vuistregel: procedure → skill; live lookup/actie → MCP; menselijk geschreven docs → RAG; ervaring van eerdere runs → memory — vaak combineerbaar.

---

#### A. Scenario & anti-patroon: context dump [[00:00](https://www.youtube.com/watch?v=X4FVEEegCbk&t=0)]

* Voorbeeld: webapp met **500 Internal Server Error** op een checkout-pagina; doel van de agent = de fout oplossen.
* Instinct: zoveel mogelijk context verzamelen en in het window gooien — runbooks, dashboards, klantgeschiedenis — en de agent “het laten uitzoeken”. [[00:51](https://www.youtube.com/watch?v=X4FVEEegCbk&t=51)]
* Waarom dat faalt: agent verdwaalt, volgt doodlopende paden, of handelt te algemeen i.p.v. hoe *deze* checkout-pagina werkt. [[01:17](https://www.youtube.com/watch?v=X4FVEEegCbk&t=77)]
* Beter: skills / MCP / RAG / memory (of combinaties) gericht inzetten i.p.v. “context in the fire”. [[01:43](https://www.youtube.com/watch?v=X4FVEEegCbk&t=103)]

```
  Anti-patroon                         Gericht
  ┌─────────────────────┐              ┌──────────────────────────────┐
  │ Runbooks            │              │ Skill  = procedure+oordeel   │
  │ Dashboards          │──dump──► CW  │ MCP    = live tools/data     │
  │ Customer history    │              │ RAG    = docs (mens)         │
  └─────────────────────┘              │ Memory = ervaring (agent)    │
```

#### B. Skills — procedure + oordeel, progressive disclosure [[02:10](https://www.youtube.com/watch?v=X4FVEEegCbk&t=130)]

* **Definitie (video):** set instructies voor één soort taak; soms met bijbehorende code. Bevat stappen *én* judgment (wanneer die stappen volgen / wanneer stoppen).
* **Progressive disclosure:** agent laadt de skill pas in wanneer de taak erom vraagt — niet permanent alles in context. [[02:37](https://www.youtube.com/watch?v=X4FVEEegCbk&t=157)]
* Voorbeeld **triage skill** voor de 500: (1) error rate bekijken → (2) status recente deployments; plus wanneer escaleren naar een mens i.p.v. blijven “pokken”. [[03:04](https://www.youtube.com/watch?v=X4FVEEegCbk&t=184)]
* Zonder skill zou het model dit vaak niet weten: procedure/judgment zit niet in trainingsdata. [[03:29](https://www.youtube.com/watch?v=X4FVEEegCbk&t=209)]
* **Limiet:** skill kan zeggen “check de error rate”, maar geeft geen toegang tot het dashboard — daarvoor tools/connectiviteit nodig. [[03:54](https://www.youtube.com/watch?v=X4FVEEegCbk&t=234)]

#### C. MCP — Model Context Protocol: host ↔ servers [[03:54](https://www.youtube.com/watch?v=X4FVEEegCbk&t=234)]

* **Rol:** agent verbinden met de buitenwereld zodat hij *echt kan handelen/opzoeken* (niet alleen instructies lezen).
* **Architectuur (video):** standaardprotocol tussen agent en systemen.
  * Agent = **MCP host**
  * Elk te bereiken systeem = **MCP server** die weet hoe te verbinden en tools expose’t [[04:19](https://www.youtube.com/watch?v=X4FVEEegCbk&t=259)]
* Voorbeeld: logging-stack / metrics via MCP-calls → logs en error rate *echt* lezen, niet gissen. [[04:44](https://www.youtube.com/watch?v=X4FVEEegCbk&t=284)]
* Framing: “look something up in the world without using proprietary code” → MCP als standaard-interface i.p.v. ad-hoc glue. [[08:42](https://www.youtube.com/watch?v=X4FVEEegCbk&t=522)]
* **Limiet:** MCP lost *bereik* op; niet domeinkennis over wat “normaal” is, dependencies, of eerdere oorzaken. [[05:10](https://www.youtube.com/watch?v=X4FVEEegCbk&t=310)]

#### D. RAG — Retrieval Augmented Generation [[05:36](https://www.youtube.com/watch?v=X4FVEEegCbk&t=336)]

* **Idee:** niet alles vooraf in het window; agent haalt *relevante* stukken op wanneer nodig. [[06:01](https://www.youtube.com/watch?v=X4FVEEegCbk&t=361)]
* Bronnen in het voorbeeld: eigen documenten (manuals, dependency maps).
* Mechanisme (video): vraag → **semantic search** → matching chunks terug in het context window. [[06:28](https://www.youtube.com/watch?v=X4FVEEegCbk&t=388)]
* **Herkomst van kennis:** documenten die een **mens** bewust in een vector database heeft gezet. [[06:54](https://www.youtube.com/watch?v=X4FVEEegCbk&t=414)]

#### E. Memory — ervaring van de agent zelf [[06:54](https://www.youtube.com/watch?v=X4FVEEegCbk&t=414)]

* Oppervlakkig lijkt memory op RAG (relevante stukken later ophalen), maar **bron verschilt**:
  * **RAG** = door mensen geschreven/opgeslagen docs in vector DB
  * **Memory** = wat de agent zelf heeft opgepikt uit eerdere gebeurtenissen en voor later bewaard [[07:20](https://www.youtube.com/watch?v=X4FVEEegCbk&t=440)]
* Voorbeeld: vorige keer was de echte oorzaak van déze 500 *niet* in de runbook; hard uitgezocht → memory kan die les teruggeven. Na fix: schrijf terug wat de fix was voor de volgende keer. [[07:47](https://www.youtube.com/watch?v=X4FVEEegCbk&t=467)]
* Framing: “experience is building up in the agentic memory.” [[08:15](https://www.youtube.com/watch?v=X4FVEEegCbk&t=495)]

#### F. Vuistregel — wanneer wat [[08:15](https://www.youtube.com/watch?v=X4FVEEegCbk&t=495)]

| Soort kennis | Mechanisme |
|--------------|------------|
| Iemand heeft het **opgeschreven** | **RAG** |
| Agent heeft het uit **ervaring** | **Memory** |
| **Herhaalbare procedure** (+ oordeel) | **Skill** |
| Live iets **in de wereld** opzoeken/doen (via standaard protocol) | **MCP** |

```
  Skill ──► wat te doen (stappen + wanneer stoppen)
  MCP   ──► waarmee / waar (tools, logs, metrics)
  RAG   ──► wat mensen documenteerden (just-in-time)
  Memory──► wat eerdere runs leerden (write-back)
```

#### Wat ik meeneem

* Bevestigt P2 / §8–§10: dump-alles-in-context is een anti-patroon; progressive disclosure bij skills past bij curated JIT-context.
* Duidelijke scheiding **RAG (mens-docs)** vs **Memory (agent-ervaring)** — nuttig t.o.v. §52 MemPalace (verbatim store): MemPalace lijkt meer “externe memory-laag”; RAG blijft curated docs.
* Skills zonder tools = blind procedureel advies; MCP zonder skill/RAG = bereik zonder domeinprocedure/kennis — combineer.
* MCP-host/server-taal sluit aan bij harness/tool-registry (§5); hier vooral als *kennis-/actiekanaal*, niet als volledige harness-theorie.
* Geen kit-actie zonder brug: taxonomie is didactisch; onze standaard dekt skills (§3), docs/JIT (§9–§10), tools/hooks al deels.

#### Open / onduidelijk

* Geen implementatiedetails (welke vector DB, memory-schema, skill-bestandformaat) — alleen conceptueel.
* Geen benchmarks of token-kostenvergelijking dump vs. de vier methoden.
* “Without using proprietary code” bij MCP is vaag in transcript; bedoeld als protocol-i.p.v.-custom-integratie? `[niet scherp in bron]`
* Exacte grens memory write-back vs. curated docs / ADR’s in onze kit — later brugtoets, niet nu.

---

## §195. Chain-of-Thought Prompting Elicits Reasoning in Large Language Models (Wei et al., 2022)

**Type:** Paper · **URL:** [https://arxiv.org/abs/2201.11903](https://arxiv.org/abs/2201.11903)

- **Kern:** Het introduceren van **chain-of-thought** (CoT) — tussenstappen in natuurlijke taal laten genereren vóór het antwoord — verbetert het redeneren op rekenkundige, symbolische en gezond-verstand-taken. Een simpele few-shot prompt met "denkstappen" volstaat.

#### A. Relevantie voor tokenverbruik

* CoT **voegt tokens toe** aan de output (tussenstappen), maar kan de *totale* kosten verlagen doordat het model minder foute pogingen doet.
* §75 toont: reasoning traces tussen tool calls weglaten → **−30%** op Cursor Bench (GPT-5-Codex). CoT is dus geen gratis lunch: meet of de extra tokens de accuraatheid voldoende verbeteren.
* Voor agent-workflows: CoT in de *harness* (interne reasoning traces) is effectiever dan CoT in de prompt (visible tokens).

#### B. Wat de paper zegt over token-efficiëntie

| Aspect | Inzicht |
|--------|---------|
| Few-shot efficiëntie | ~8 CoT-voorbeelden volstaan; meer heeft afnemende meerwaarde |
| Output-lengte | CoT genereert typisch 2–5× meer outputtokens |
| Foutreductie | Op math-taken daalt de foutkans met 50–80% |
| Netto-effect | Minder iteraties → meerwaarde per token hoger, maar totale tokens stijgen |

#### Wat ik meeneem

* **Meet-principe voor A5:** hou verhouding reasoning-tokens / actie-tokens bij; als reasoning >50% van output, is de prompt of tool-set te onduidelijk.
* CoT is een **prompt-engineering techniek** die harness-interventie nodig heeft (tussenstappen bewaren, §75).
* **Geen kit-actie:** al gedekt door §75 (reasoning traces) en §3/Pocock skill-ontwerp.

#### Open / onduidelijk

* Of CoT minder effectief is bij frontier-modellen die al interne reasoning hebben (DeepSeek-R1, o-series).




---

# Context Engineering


## §8. Context Engineering for AI Agents

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=BwXremQ-i6I](https://www.youtube.com/watch?v=BwXremQ-i6I)

In deze video bouwt Matt Pocock voort op de "Smart Zone vs. Dumb Zone" theorie en formuleert hij een strak theoretisch raamwerk rondom **Context Rot** en de **vier fundamentele failure modes** van agent-geheugens.

---

### 1. Theoretische Fundamenten: Het 'Attention Budget' & Context Rot

Veel ontwikkelaars nemen aan dat grotere context windows ($1\text{M}+$ tokens) automatisch betekenen dat agents complexere, langdurige taken kunnen uitvoeren. Recente empirische onderzoeken onder 18 frontier-modellen tonen echter het tegendeel aan: **modellen worden minder betrouwbaar naarmate de context groeit**. [[00:38](https://www.youtube.com/watch?v=BwXremQ-i6I&t=38)]

```
                       HET CONTEXT WINDOW "ATTENTION BUDGET"
  ┌───────────────────────────────────────────────────────────────────────────┐
  │                           Eindig Attentie-Budget                          │
  └───────────────────────────────────────────────────────────────────────────┘
        │                                                               │
        ▼                                                               ▼
  [ Klein Context Window ]                                [ Groot Context Window ]
  • Hoge attentiedichtheid per token.                     • Attentie raakt verdund.
  • Hoge betrouwbaarheid & scherpte.                      • Context Rot & hallucinaties.

```

#### A. Context Rot & Het Eindige Attentie-Budget [[00:54](https://www.youtube.com/watch?v=BwXremQ-i6I&t=54)]

* **Context Rot:** Het verschijnsel waarbij de betrouwbaarheid van een LLM degradeert naarmate het aantal tokens in het context window toeneemt. [[00:54](https://www.youtube.com/watch?v=BwXremQ-i6I&t=54)]
* **Het Attentie-Budget (Attention Budget):** Een LLM kijkt niet naar zijn context zoals een SQL-database naar een rij zoekt. Elk token in het window concurreert om een **eindige hoeveelheid attentie**. [[04:18](https://www.youtube.com/watch?v=BwXremQ-i6I&t=258)] Naarmate er meer tokens (tool-outputs, logs, geschiedenis) worden opgestapeld, raakt deze attentie verdund, waardoor het model cruciale instructies negeert of verkeerd interpreteert. [[04:26](https://www.youtube.com/watch?v=BwXremQ-i6I&t=266)]

#### B. De Paradox van Context Engineering [[01:29](https://www.youtube.com/watch?v=BwXremQ-i6I&t=89)]

* **Core Thesis:** *Context Engineering* is de kunst van het bewust bepalen wat er op elk specifiek stapje wél en níét in de context staat. [[01:03](https://www.youtube.com/watch?v=BwXremQ-i6I&t=63)]
* **De Paradox:** Een agent wordt beter in het uitvoeren van lange, complexe taken door **bewust informatie weg te gooien** (*deliberately throwing away information*). [[01:37](https://www.youtube.com/watch?v=BwXremQ-i6I&t=97)]

---

### 2. Anatomie van een Vervuild Context Window

In een realistisch scenario (bijv. een agent die een database-migratie uitvoert) bouwt de context zich als volgt op [[02:00](https://www.youtube.com/watch?v=BwXremQ-i6I&t=120)]:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ 1. System Prompt (Standing Instructions)                                    │
│ 2. Agent Task Prompt (De kernopdracht - vaak slechts een paar regels)       │
│ 3. Project Instructions (`AGENTS.md` / `CLAUDE.md`)                          │
│ 4. Tool Definitions (Lijst van alle beschikbare functies)                    │
│ 5. Message History (Het logboek van alle ondernomen acties)                 │
│ 6. Tool Results (Files, test-outputs, schema-dumps - HET GROOTSTE BLOK)      │
└─────────────────────────────────────────────────────────────────────────────┘

```

**Het Gevaar:** De feitelijke taak/opdracht beslaat slechts een paar regels helemaal aan het begin. Het overgrote deel van de honderdduizenden tokens bestaat uit ruis, dumps en logs die het attentiebudget van de agent uitputten. [[03:29](https://www.youtube.com/watch?v=BwXremQ-i6I&t=209)]

---

### 3. De 4 Failure Modes & De Oplossingen

Pocock identificeert de vier specifieke manieren waarop een context window corrupt raakt, samen met de bijbehorende architecturale oplossingen:

```
  FAILURE MODE                OORZAAK                              OPLOSSING
┌──────────────────┐       ┌───────────────────────────┐        ┌──────────────────┐
│ 1. Poisoning     │ ────> │ Foutieve aanname in geheugen │ ────>  │ Validate         │
├──────────────────┤       ├───────────────────────────┤        ├──────────────────┤
│ 2. Distraction   │ ────> │ Historie stuurt het patroon  │ ────>  │ Compact / Disk   │
├──────────────────┤       ├───────────────────────────┤        ├──────────────────┤
│ 3. Confusion     │ ────> │ Te veel tools beschikbaar   │ ────>  │ Curate           │
├──────────────────┤       ├───────────────────────────┤        ├──────────────────┤
│ 4. Clash         │ ────> │ Tegenstrijdige feiten       │ ────>  │ Prune / Reset    │
└──────────────────┘       └───────────────────────────┘        └──────────────────┘

```

---

#### Failure Mode 1: Context Poisoning $\rightarrow$ Oplossing: Validate [[04:36](https://www.youtube.com/watch?v=BwXremQ-i6I&t=276)]

* **Het Probleem (Poisoning):** De agent trekt een verkeerde conclusie (bijv. leest de API-docs verkeerd en denkt dat retry-code verwijderd kan worden) en schrijft deze foutieve gedachte op in zijn geheugen/notities. [[04:45](https://www.youtube.com/watch?v=BwXremQ-i6I&t=285)] Omdat zijn eigen eerdere output voor het model aanvoelt als *ground truth*, blijft de agent deze foutief aangenomen regel meedogenloos toepassen op alle volgende bestanden. [[05:07](https://www.youtube.com/watch?v=BwXremQ-i6I&t=307)]
* **De Architecturale Oplossing (Validate):** Voordat een conclusie of aanname definitief in het context window of geheugen van de agent wordt opgeslagen, moet deze **extern gevalideerd** worden via een deterministische test (bijv. een snelle verbindingstest of unit-test). [[07:39](https://www.youtube.com/watch?v=BwXremQ-i6I&t=459)]

---

#### Failure Mode 2: Context Distraction $\rightarrow$ Oplossing: Compact & Externalize [[05:18](https://www.youtube.com/watch?v=BwXremQ-i6I&t=318)]

* **Het Probleem (Distraction):** Een LLM is in essentie een *pattern continuation machine*. [[05:35](https://www.youtube.com/watch?v=BwXremQ-i6I&t=335)] Als er een gigantische historie van 100 acties in het context window staat, wordt die historie het sterkste patroon dat het model volgt. De agent vraagt zich niet meer af wat het *einddoel* is, maar gaat puur meer van hetzelfde doen (bijv. in rondjes blijven draaien of doelloos bestanden blijven aanpassen). [[05:50](https://www.youtube.com/watch?v=BwXremQ-i6I&t=350)]
* **De Architecturale Oplossing (Compact & Externalize):**
1. **Compaction:** Gooi het gedetailleerde logboek weg en vervang het door een zeer korte samenvatting van de huidige status. [[08:00](https://www.youtube.com/watch?v=BwXremQ-i6I&t=480)]
2. **Externalization (Disk Storage):** Omdat samenvattingen van samenvattingen vervormen (*photocopy of a photocopy effect*), moeten gedetailleerde feiten worden opgeslagen in **fysieke bestanden op de schijf**. De agent laadt deze bestanden pas in het context window op het moment dat ze specifiek nodig zijn. [[08:20](https://www.youtube.com/watch?v=BwXremQ-i6I&t=500)]


---

#### Failure Mode 3: Context Confusion $\rightarrow$ Oplossing: Curate [[06:00](https://www.youtube.com/watch?v=BwXremQ-i6I&t=360)]

* **Het Probleem (Confusion / Tool Sprawl):** Het inladen van tientallen tool-definities (database, git, ticket-systems, bash) vervuilt het context window. [[06:14](https://www.youtube.com/watch?v=BwXremQ-i6I&t=374)]
* *Benchmark Inzicht:* In een test faalde een model bij een taak toen het **46 tools** aangeboden kreeg, maar slaagde het voor *exact dezelfde taak* wanneer het aantal tools werd teruggebracht naar **19**. [[06:40](https://www.youtube.com/watch?v=BwXremQ-i6I&t=400)]


* **De Architecturale Oplossing (Curate):** Geef de agent enkel de handvol tools mee die strikt noodzakelijk zijn voor de actuele stap. Pas wanneer de agent een specifieke subtaak treft, kan hij dynamisch een extra tool "ophalen" (*Pull-based tool loading*). [[08:46](https://www.youtube.com/watch?v=BwXremQ-i6I&t=526)]

---

#### Failure Mode 4: Context Clash $\rightarrow$ Oplossing: Prune & Reset [[06:56](https://www.youtube.com/watch?v=BwXremQ-i6I&t=416)]

* **Het Probleem (Clash):** Het context window bevat feiten die met elkaar in strijd zijn (bijv. een eerdere foute notitie én een latere correctie). De agent raakt in verwarring doordat twee tegengestelde waarheden om zijn attentie strijden. [[07:17](https://www.youtube.com/watch?v=BwXremQ-i6I&t=437)]
* **De Architecturale Oplossing (Prune or Reset):**
1. **Prune:** Verwijder/wis de verouderde of foutieve informatie direct uit het context window in plaats van de correctie er simpelweg onder te plakken. [[09:10](https://www.youtube.com/watch?v=BwXremQ-i6I&t=550)]
2. **Hard Reset (Momento Pattern):** Sluit het huidige context window volledig af. Start een **gloednieuw window** met enkel de gecorrigeerde, actuele eindstatus van de taak en laat de vergiftigde geschiedenis definitief achterwegen. [[09:20](https://www.youtube.com/watch?v=BwXremQ-i6I&t=560)]


---


---

## §9. Context Engineering in IDE's (zoals Cursor en Claude Code).

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=QgA55EnmUp4](https://www.youtube.com/watch?v=QgA55EnmUp4)

In deze video wordt de verschuiving geanalyseerd van klassieke *Prompt Engineering* naar **Context Engineering** in IDE-agents (zoals Cursor, Claude Code of Windsurf). Waar eerdere ontwikkelaars vertrouwden op 'slimme prompts', focust deze methodiek op het **structureren, scheiden en dynamisch voeden van documentatiebestanden** om hallucinaties te elimineren en grootschalige projecten stapsgewijs te bouwen.

---

### 1. Theoretische Fundamenten: Van Prompt Engineering naar Context Engineering

De term *Context Engineering* (gecocht door Andre Karpathy) markeert het einde van de "Chatbot Wrapper" periode. LLM-applicaties zijn geëvolueerd naar geavanceerde ontwikkelomgevingen die de context van het model actief beheren, orchestreren en verrijken met tools, geheugen en bestanden. [[00:10](https://www.youtube.com/watch?v=QgA55EnmUp4&t=10), [01:16](https://www.youtube.com/watch?v=QgA55EnmUp4&t=76)]

```
                       EVOLUTIE VAN AI INTERACTIE

   PROMPT ENGINEERING                          CONTEXT ENGINEERING
┌───────────────────────────┐               ┌─────────────────────────────────┐
│ • Focus op herformuleren  │               │ • RAG (Retrieval)               │
│   van de enkele vraag.    │  ───────────> │ • Systeemgeheugen (Memory)      │
│ • Doel: Één goed antwoord │               │ • Strikte documentatieregels    │
│   krijgen uit het model.  │               │ • Dynamische tool-toewijzing    │
└───────────────────────────┘               └─────────────────────────────────┘

```

#### A. Wat is Context Engineering? [[00:57](https://www.youtube.com/watch?v=QgA55EnmUp4&t=57), [01:30](https://www.youtube.com/watch?v=QgA55EnmUp4&t=90)]

* **Definitie:** Het voorzien van het model van alle relevante feiten, regels, projectstructuren en documentatie binnen zijn context window op zo'n manier dat **hallucinaties theoretisch onmogelijk worden**. [[00:57](https://www.youtube.com/watch?v=QgA55EnmUp4&t=57)]
* **De Context Window Paradox in IDE's:** [[02:46](https://www.youtube.com/watch?v=QgA55EnmUp4&t=166)]
Het dumps van een complete applicatie in één enkel reusachtig bestand (zoals een gigantische `CLAUDE.md` of `.cursorrules`) veroorzaakt snel *Context Rot*. Naarmate het context window volloopt, neemt de kans op hallucinaties toe en verliest het model het vermogen om instructies nauwkeurig op te volgen. [[02:51](https://www.youtube.com/watch?v=QgA55EnmUp4&t=171)]
* **De Oplossing:** De context moet worden opgesplitst in **modulaire, specifieke bestanden** (*de-coupled documentation architecture*) die enkel worden ingeladen wanneer de actuele taak daar om vraagt. [[03:00](https://www.youtube.com/watch?v=QgA55EnmUp4&t=180)]

---

### 2. De 4 Documentatie-Pijlers van Context Engineering

Om een AI-agent (zoals Cursor) een project foutloos te laten uitvoeren zonder afhankelijk te zijn van zijn 'vluchtige geheugen', genereert de ontwikkelaar een **vierdelige documentatie-structuur** in een aparte `/docs` map [[04:01](https://www.youtube.com/watch?v=QgA55EnmUp4&t=241)]:

```
                                  HET /DOCS ECOSYSTEEM
      ┌────────────────────────────────────────────────────────────────────────┐
      │ 1. PRD.md  ──> [ Generate Rule ] ──> 2. Implementation_Plan.md        │
      │                                      3. Project_Structure.md          │
      │                                      4. UI_UX_Design.md               │
      │                                      5. Bug_Tracking.md               │
      └────────────────────────────────────────────────────────────────────────┘

```

1. **`Implementation_Plan.md` (De Gids / De Reis):** [[04:05](https://www.youtube.com/watch?v=QgA55EnmUp4&t=245), [05:54](https://www.youtube.com/watch?v=QgA55EnmUp4&t=354)]
* Bevat een overzicht van de gehele applicatie opgedeeld in strikte fasen en gedetailleerde checklists.
* Dient als het **persistent geheugen**. Wanneer een nieuwe chat-sessie gestart wordt (waarbij het context window gereset is), leest het model enkel dit bestand om direct te begrijpen waar het gebleven is en wat de volgende stap is. [[06:50](https://www.youtube.com/watch?v=QgA55EnmUp4&t=410)]


2. **`Project_Structure.md` (De Architectuurgrens):** [[04:07](https://www.youtube.com/watch?v=QgA55EnmUp4&t=247), [05:28](https://www.youtube.com/watch?v=QgA55EnmUp4&t=328)]
* Bevat de exacte map- en bestandsstructuur. Voorkomt dat de AI willekeurige nieuwe mappen of bestanden aanmaakt die strijdig zijn met het gewenste framework.


3. **`UI_UX_Design.md` (De Visuele Normen):** [[04:10](https://www.youtube.com/watch?v=QgA55EnmUp4&t=250), [05:23](https://www.youtube.com/watch?v=QgA55EnmUp4&t=323)]
* Bevat de stijlgids, component-regels (bijv. Tailwind-klassen, Shadcn-UI-afspraken) en lay-out-eisen.


4. **`Bug_Tracking.md` (Het Foutenregister):** [[04:11](https://www.youtube.com/watch?v=QgA55EnmUp4&t=251), [05:32](https://www.youtube.com/watch?v=QgA55EnmUp4&t=332)]
* Registreert reeds bekende of opgeloste bugs, zodat de agent bij een foutmelding niet in herhalende lussen vervalt.


---

### 3. Regulering via Regel-Bestanden (`Generate` vs. `Workflow` Rules)

Om te voorkomen dat de IDE-agent alle documentatiebestanden tegelijk in zijn context geladen houdt, gebruikt de workflow twee gescheiden regelbestanden (*Rule Files*) [[04:24](https://www.youtube.com/watch?v=QgA55EnmUp4&t=264)]:

```
                     TWEE-FASIGE REGEL-ARCHITECTUUR

   FASE 1: CONTEXT GENERATIE                  FASE 2: PROJECT EXECUTIE
┌────────────────────────────────┐         ┌────────────────────────────────┐
│ PRD.md                         │         │ Workflow Rule (Slechts ~20 regels)
│   │                            │         │   │                            │
│   ▼                            │         │   ├──> Leest Step 1 Plan       │
│ Generate Rule (Zwaar/Groot)    │         │   ├──> Controleert Structuur   │
│   │                            │         │   └──> Voert uit in IDE        │
│   ▼                            │         └────────────────────────────────┘
│ Genereert alle /docs bestanden │           (Nieuwe schone chat per stap!)
└────────────────────────────────┘

```

#### A. De `Generate Rule` (Eenmalige Zware Context) [[04:26](https://www.youtube.com/watch?v=QgA55EnmUp4&t=266)]

* **Functie:** Leest de initiële wensen (*PRD*) en zet deze om naar de vier gedetailleerde documentatiebestanden (`Implementation_Plan`, `Project_Structure`, etc.).
* **Context Impact:** Deze actie vult het context window van de sessie vrijwel volledig op.
* **Handeling:** Zodra de bestanden gegenereerd zijn, **wordt de chat-sessie afgesloten en gewist**. De gegenereerde Markdown-bestanden staan nu fysiek op de schijf. [[04:36](https://www.youtube.com/watch?v=QgA55EnmUp4&t=276)]

---

#### B. De `Workflow Rule` (Lichte, Permanente Context) [[05:10](https://www.youtube.com/watch?v=QgA55EnmUp4&t=310)]

* **Functie:** Een extreem compact regelbestand dat *permanent* in de system prompt / context van de IDE-agent staat (bijv. `.cursorrules` of `CLAUDE.md`). [[05:43](https://www.youtube.com/watch?v=QgA55EnmUp4&t=343)]
* **Instructies aan de Agent:**
* *"Wanneer je aan code werkt, raadpleeg UITSLUITEND de relevante stap uit `Implementation_Plan.md`."*
* *"Wanneer je een nieuw bestand maakt, controleer `Project_Structure.md`."*
* *"Wanneer er een fout is, check `Bug_Tracking.md`."*


* **Voordeel:** Omdat de `Workflow Rule` zeer klein is ($\approx 20$ regels), blijft er maximale ruimte over in de Smart Zone voor de fysieke code en de specifieke taak. [[05:43](https://www.youtube.com/watch?v=QgA55EnmUp4&t=343)]

---

### 4. Stapsgewijze Executie & Voorkomen van Blind Vertrouwen

1. **Sessie-Isolatie per Taak:** [[09:33](https://www.youtube.com/watch?v=QgA55EnmUp4&t=573)]
* Voor elke nieuwe fase of taak uit de checklist wordt een **gloednieuwe chat-sessie** gestart.
* De agent leest de `Workflow Rule` + de specifieke stap uit `Implementation_Plan.md`. Hij bouwt de fundamenten stapsgewijs op in plaats van de gehele applicatie in één massieve prompt te proberen te genereren. [[09:40](https://www.youtube.com/watch?v=QgA55EnmUp4&t=580), [11:06](https://www.youtube.com/watch?v=QgA55EnmUp4&t=666)]


2. **De 'Gevaar van Blinde Generatie' Waarschuwing:** [[08:15](https://www.youtube.com/watch?v=QgA55EnmUp4&t=495)]
* **Probleem:** AI-modellen volgen instructies in gegenereerde documentatie meedogenloos op. Als er een tegenstrijdigheid of verkeerde aanname in het gegenereerde `Implementation_Plan.md` staat (bijv. een te complexe architectuur i.p.v. een MVP), zal de agent de foutief gegenereerde stappen blindelings uitvoeren. [[08:20](https://www.youtube.com/watch?v=QgA55EnmUp4&t=500)]
* **De Regel:** Menselijke ontwikkelaars moeten het gegenereerde `Implementation_Plan.md` en de gekozen Tech Stack **eerst handmatig reviewen en corrigeren** voordat ze de agent toestemming geven om te beginnen met coderen. [[08:44](https://www.youtube.com/watch?v=QgA55EnmUp4&t=524), [09:00](https://www.youtube.com/watch?v=QgA55EnmUp4&t=540)]


---

## §10. Effective Context Engineering for AI Agents (Anthropic)

**Type:** Artikel · **URL:** [https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)

Het referentieartikel van Anthropic over de overgang van *prompt engineering* naar *context engineering*. Kernstelling: context is een **eindige grondstof met afnemende meeropbrengst**. Goed werk betekent de kleinst mogelijke set tokens met veel signaal vinden die de kans op het gewenste resultaat maximaliseert.

---

### 1. Theoretische Fundamenten

#### A. Prompt engineering vs. context engineering

* **Prompt engineering:** hoe je instructies (vooral de system prompt) formuleert en ordent.
* **Context engineering:** alles wat tijdens de inferentie in het venster belandt beheren: system prompt, tools, MCP, externe data, berichtgeschiedenis. Bij een agent in een lus is dat **iteratief**: bij elke beurt wordt opnieuw gekozen wat mee gaat.

#### B. Waarom context eindig is: het attentiebudget

* Needle-in-a-haystack-onderzoek toont **context rot**: hoe meer tokens, hoe slechter het model iets correct terugvindt. Bij sommige modellen gaat het geleidelijker, maar het fenomeen geldt voor alle modellen.
* Architecturale oorzaak: in een transformer kijkt elk token naar elk ander token, dus \(n^2\) paarrelaties. Bij een lange context wordt de aandacht dunner verspreid.
* Trainingsdata bevat vooral korte sequenties, dus modellen hebben minder ervaring met afhankelijkheden over de hele context.
* Het gevolg is een **geleidelijke helling, geen harde afgrond**: bij lange context blijft een model bruikbaar, maar het wordt minder precies.

```
     KLEINE, RELEVANTE CONTEXT                GROTE, VERDUNDE CONTEXT
  ┌──────────────────────────────┐       ┌──────────────────────────────┐
  │ veel aandacht per token      │       │ aandacht verspreid           │
  │ precieze recall              │  ───> │ minder precieze recall       │
  │ korte afhankelijkheden       │       │ zwakkere redenering op afstand│
  └──────────────────────────────┘       └──────────────────────────────┘
```

---

### 2. Anatomie van Effectieve Context

#### A. System prompts: de juiste "hoogte"

Er zijn twee faalmodi:

1. **Te laag:** broze if-else-logica hardcoderen in de prompt. Dat is fragiel en moeilijk te onderhouden.
2. **Te hoog:** vage richtlijnen die gedeelde context veronderstellen die het model niet heeft.

De goede hoogte ligt ertussen: specifiek genoeg om gedrag te sturen, flexibel genoeg om het model sterke heuristieken te geven.

* Orden prompts in secties (XML-tags of Markdown-koppen). Volgens het artikel wordt de exacte opmaak wel minder belangrijk naarmate modellen beter worden.
* Streef naar de **minimale set informatie die het gewenste gedrag volledig beschrijft**. Minimaal is niet hetzelfde als kort.
* Werkwijze: begin met een minimale prompt op het beste model, kijk waar het misgaat en voeg pas dan instructies en voorbeelden toe.

#### B. Tools

* Tools zijn het contract tussen agent en omgeving. Ze moeten tokenzuinige output geven en efficiënt gedrag aanmoedigen.
* Een veelvoorkomende fout is een opgeblazen toolset met overlappende functies. Als een menselijke engineer niet zeker kan zeggen welke tool past, kan een agent dat ook niet.

#### C. Voorbeelden (few-shot)

* Sterk aanbevolen, maar dan als **een kleine set diverse, canonieke voorbeelden**, niet als een waslijst randgevallen.

---

### 3. Context Ophalen: Just-in-Time & Agentic Search

* **Just-in-time:** de agent houdt lichte verwijzingen bij (bestandspaden, queries, links) en laadt de inhoud pas met tools wanneer hij die nodig heeft, in plaats van alles vooraf in te laden.
* **Metadata als signaal:** mappenhiërarchie, naamgeving en tijdstempels vertellen de agent iets. Een `test_utils.py` in `tests/` betekent iets anders dan hetzelfde bestand in `src/core_logic/`.
* **Progressive disclosure:** de agent bouwt zijn begrip laag per laag op en houdt alleen het nodige in zijn werkgeheugen.
* **Trade-off:** zelf verkennen is trager dan vooraf ophalen. Zonder goede tools en heuristieken verspilt de agent context aan doodlopende sporen.
* **Hybride model** (zoals Claude Code): `CLAUDE.md` gaat vooraf in de context, glob en grep halen de rest op wanneer nodig.
* Het advies blijft *"do the simplest thing that works"*.

---

### 4. Lange Taken: Drie Technieken

```
  TECHNIEK              WAT                                          BEST VOOR
┌───────────────┐   ┌───────────────────────────────────────────┐   ┌────────────────────────┐
│ Compaction    │──>│ Geschiedenis samenvatten, nieuw venster   │──>│ Veel heen-en-weer      │
├───────────────┤   ├───────────────────────────────────────────┤   ├────────────────────────┤
│ Notities      │──>│ Agent schrijft NOTES/TODO buiten de context│──>│ Iteratief bouwen met   │
│ (memory)      │   │ en leest ze later terug                   │   │ duidelijke mijlpalen   │
├───────────────┤   ├───────────────────────────────────────────┤   ├────────────────────────┤
│ Sub-agents    │──>│ Diep zoekwerk in eigen venster; geeft     │──>│ Onderzoek, parallel    │
│               │   │ alleen een samenvatting (1–2k tokens) terug│   │ verkennen              │
└───────────────┘   └───────────────────────────────────────────┘   └────────────────────────┘
```

* **Compaction:** bewaar architectuurbeslissingen, open bugs en implementatiedetails, en gooi overbodige tooloutput weg. Tune de samenvattingsprompt eerst op recall en pas daarna op precisie. De lichtste vorm is oude toolresultaten wissen.
* **Structured note-taking:** een simpel `NOTES.md`- of to-do-patroon geeft persistent geheugen tegen weinig overhead.
* **Sub-agents:** scheiden de details van het zoekwerk van de synthese die de hoofdagent doet.

### Wat ik meeneem

* De documentatie in een repo is **just-in-time context**: maak paden en namen zo duidelijk dat de agent weet wat hij moet openen zonder het eerst te lezen.
* Een routerbestand vooraf en de rest via grep is precies het hybride model dat Anthropic aanbeveelt.
* Een `NOTES.md` of logbestand per taak is een erkende techniek, maar dan als **status**, gescheiden van de stabiele waarheid.

---


---

## §17. Lost in the Middle: How Language Models Use Long Contexts

**Type:** Paper · **URL:** [https://arxiv.org/abs/2307.03172](https://arxiv.org/abs/2307.03172)

---

### 1. Onderzoeksvraag & Opzet

* Hoe goed gebruiken taalmodellen informatie in een **lange** input?
* Twee gecontroleerde taken:
  1. **Multi-document QA:** \(k\) documenten, waarvan er precies één het antwoord bevat. De andere zijn afleiders.
  2. **Key-value retrieval:** synthetische JSON-paren, geef de waarde bij een sleutel.
* Gevarieerd: (i) de **lengte** van de context (aantal documenten) en (ii) de **positie** van het relevante document.
* Modellen: open (MPT-30B-Instruct, LongChat-13B) en gesloten (GPT-3.5-Turbo, Claude-1.3).

---

### 2. Bevindingen

```
  nauwkeurigheid
      ▲
      │█                                   █
      │ █                                 █
      │   █                             █
      │      █  █  █  █  █  █  █  █  █
      └──────────────────────────────────────▶ positie relevante info
       begin            midden            einde
       (primacy)                        (recency)
```

* Een **U-vormige curve**: de prestaties zijn het hoogst als de relevante info aan het **begin** of **einde** staat, en dalen sterk in het **midden**.
* Bij GPT-3.5-Turbo was de score met het relevante document in het midden zelfs **lager dan zonder documenten** (closed-book).
* Modellen met een groter contextvenster gebruiken die context niet noodzakelijk beter.
* *Query-aware contextualization* (de vraag vóór én na de data zetten) maakt de key-value-taak bijna perfect, maar helpt weinig bij multi-document QA.
* Een case study met open-domain QA: de prestaties verzadigen lang voor de recall van de retriever. 50 in plaats van 20 documenten levert maar ongeveer 1 à 1,5% op.

---

### 3. Conclusie

* Een langere context is een **trade-off**: meer informatie kan helpen, maar er moet over meer inhoud geredeneerd worden, en dat kan de nauwkeurigheid verlagen.
* Om te claimen dat een model lange context robuust gebruikt, moet je aantonen dat de **positie** van de info weinig uitmaakt.

### Wat ik meeneem

* **Het belangrijkste vooraan** in een routerbestand of regelbestand (harde regels, commando's). De vraag of taak aan het einde staat al vanzelf dichtbij.
* Meer documenten meegeven levert snel weinig of niets meer op. Selecteren is belangrijker dan volume.

---


---

## §18. Context Rot: How Increasing Input Tokens Impacts LLM Performance (Chroma)

**Type:** Rapport · **URL:** [https://research.trychroma.com/context-rot](https://research.trychroma.com/context-rot)

---

### 1. Probleemstelling

* Modellen hebben contextvensters tot miljoenen tokens en scoren bijna perfect op **Needle in a Haystack (NIAH)**. Daardoor lijkt lange context "opgelost".
* Maar NIAH test vooral **lexicale matching** (de vraag en het antwoord delen woorden). Echte taken vragen semantisch begrip en hebben dubbelzinnigheid en afleiders.
* Moeilijkheid bij het meten: langere input maakt een taak vaak ook complexer. Chroma houdt de **moeilijkheid constant en varieert alleen de lengte**.

---

### 2. Opzet

* **18 modellen**, waaronder GPT-4.1, Claude 4, Gemini 2.5 en Qwen3.
* Experimenten:
  1. **Similariteit tussen vraag en antwoord** (cosine similarity, gemiddeld over vijf embeddingmodellen).
  2. **Afleiders:** inhoud die over hetzelfde onderwerp gaat maar de vraag niet beantwoordt, tegenover **irrelevante** inhoud.
  3. **Inhoud en structuur van de haystack** (onderwerp, logische volgorde of door elkaar).
  4. **LongMemEval:** conversationele QA met een gerichte, korte versie tegenover een volledige, lange versie.
  5. **Repeated words:** een reeks herhaalde woorden met één afwijkend woord exact kopiëren.

---

### 3. Bevindingen

* Modellen gebruiken hun context **niet uniform**. Ook bij eenvoudige taken worden ze **onbetrouwbaarder naarmate de input langer wordt**, vaak op een onregelmatige en verrassende manier.
* Hoe **minder** de vraag op het antwoord lijkt, hoe sneller de prestaties dalen bij langere input.
* **Afleiders** schaden meer dan irrelevante tekst, en hun impact wordt groter met de lengte. Niet elke afleider schaadt even sterk.
* De **structuur van de haystack** heeft invloed: in deze tests deden modellen het opvallend genoeg vaak beter met door elkaar geschudde tekst dan met een logisch doorlopende tekst.
* Bij **LongMemEval** scoren modellen duidelijk beter met de gerichte, korte versie dan met de volledige geschiedenis.
* Bij **repeated words** dalen de prestaties met de lengte. Modellen weigeren, genereren te veel of te weinig, of verzinnen woorden die niet in de input staan.
* Modelfamilies verschillen: sommige onthouden zich eerder van een antwoord bij twijfel, andere hallucineren met vertrouwen.

---

### 4. Conclusie

* Echte toepassingen zijn complexer dan deze tests, dus de verwachting is dat de degradatie in de praktijk **nog sterker** is.
* **Niet alleen óf de relevante informatie in de context staat telt, maar vooral hoe ze gepresenteerd wordt.** Dat is de kern van context engineering.

### Wat ik meeneem

* **Afleiders zijn erger dan ruis.** Verouderde of bijna-correcte documentatie (oude configs, "v3/v4/v5"-varianten, dubbele beschrijvingen) is precies het soort afleider dat het meest schaadt.
* Een gerichte, korte context werkt beter dan "alles meegeven".
* Gebruik in documentatie dezelfde termen als in de code: lexicale overlap maakt terugvinden makkelijker.

---


## §194. LeanVec: Token Optimization for LLMs (Hugging Face / Pinecone)

**Type:** Paper / blog · **URL:** [https://arxiv.org/abs/2404.01099](https://arxiv.org/abs/2404.01099) · [blog](https://huggingface.co/blog/leanvec)

- **Kern:** **LeanVec** reduceert token-count door gelijkaardige of redundante context te detecteren en comprimeren vóór inferentie. Niet het model aanpassen, maar de input slimmer maken: token-deduplicatie, context-compressie en dynamische lengte-aanpassing.

#### A. Technieken

| Techniek | Wat | Token-besparing (claim) |
|----------|-----|------------------------|
| **Token-deduplicatie** | Dubbele of bijna-dubbele fragmenten detecteren en vervangen door pointers | Tot ~30% |
| **Context-compressie** | Informatie-arme regio's (lijsten, boilerplate) samenvatten tot korte representatie | Tot ~50% op sommige inputs |
| **Dynamische lengte** | Automatisch bepalen wat de optimale context-lengte is per taak | Gemengd |

#### B. Relevantie voor Agent Engineering

* Past bij §8/§10 (context rot → minder tokens = minder verdunning) en §18 (afleiders schaden).
* **Harness-patroon:** een deterministische pre-processing-stap (compressie) vóór de LLM-call — precies wat §5 (harness laag) en §74 (static→dynamic) beschrijven.
* Complementair aan prompt-caching (§30/§143): LeanVec reduceert *input* tokens, caching reduceert *compute* op herhaalde prefixen.

#### Wat ik meeneem

* **Experiment-idee:** LeanVec-preprocessing als harness-hook vóór DeepSeek-API-calls → meet of token-reductie de accuraatheid beïnvloedt (A5).
* **Geen kit-default:** vendor-claims; eigen meting nodig op agent-taken.

#### Open / onduidelijk

* Of LeanVec werkt voor code (hoge informatiedichtheid) vs. natuurlijke taal (meer redundantie).

---

---

## §196. How Language Models Use Long Contexts: An Empirical Study (Liu et al., 2024)

**Type:** Paper · **URL:** [https://arxiv.org/abs/2404.06675](https://arxiv.org/abs/2404.06675)

- **Kern:** Empirische studie naar hoe LLMs informatie in lange context *werkelijk* gebruiken. Bevindingen: (1) modellen vertrouwen sterk op **recency** (recente info), (2) prefill-order beïnvloedt accuracy met >20%, (3) prompt-caching (KV-cache) wijzigt het attentiepatroon, (4) herhaling van instructies aan het einde van de context verbetert recall.

#### A. Relevantie voor token-optimalisatie

| Bevinding | Impact op tokenstrategie |
|-----------|------------------------|
| Recency bias > primacy bias | Plaats instructies/doelen **aan het einde**, niet aan het begin van de context |
| Prefill-order >20% effect | Experimenteer met volgorde van docs in de context |
| KV-cache wijzigt attentie | Prompt caching (DeepInfra/Anthropic) is niet alleen een snelheidsoptimalisatie, maar beïnvloedt ook de kwaliteit |
| Instructie-herhaling helpt | Herhaal kerninstructie aan het einde van tool-outputs (niet alleen in system prompt) |

#### B. Relatie tot andere bronnen

* Bouwt voort op §17 (Lost in the Middle) — toont dat recency bias sterker is dan primacy bias voor moderne modellen.
* Verklaart waarom §9 en §72 (dynamic context, JIT-context) werken: korte, recente context wint van lange, gemengde context.
* Past bij §30 (§75): prompt caching verandert attentiedynamiek — meet mét en zonder cache.

#### Wat ik meeneem

* **Praktische tip voor system prompt:** zet de belangrijkste instructie in de **laatste** alinea van de system prompt, niet de eerste.
* **Experiment-idee:** voeg een `[INSTRUCTIE]`-marker toe aan het einde van elke tool-output met de kernopdracht herhaald → meet of accuraatheid stijgt.
* **Geen kit:** empirische inzichten, geen voorschriften.

#### Open / onduidelijk

* Of recency bias even sterk geldt voor code-taken (hoge specificiteit) vs. QA-taken (in de paper).
* Effectgrootte van instructie-herhaling op agent-loops met >10 turns.



## §52. MemPalace — lokale, verbatim agent-memory

**Type:** Repo / tool · **URL:** [https://github.com/MemPalace/mempalace](https://github.com/MemPalace/mempalace)

- **Kern:** Long-term memory buiten het context window: gesprekken en projecttekst **verbatim** opslaan (geen samenvatten/parafraseren), gestructureerd ophalen met hybride search, lokaal (ChromaDB + SQLite KG), MCP/hooks voor Claude Code / Cursor / Codex.
- **Relatie tot deze standaard:** wij doen “geheugen” al via **docs + JIT + git + ADR’s** (P2, P5, §9–§10, §23). MemPalace is een *extra* retrieval-laag over sessies/chat — interessant om van te leren, niet automatisch beter dan curated docs.

---

#### A. Palace-metafoor (structuur)

```
  Wing (persoon / project / domein)
    └── Room (dag / sessie / thread)
          └── Closet (topic-bundel)
                └── Drawer (verbatim chunk — exacte woorden)
```

* Index-laag kan **AAAK** gebruiken: dichte symbolische pointers zodat een model snel scant; inhoud blijft full-fidelity in de drawer.
* Scoping: zoeken binnen wing/room i.p.v. één platte corpus → minder context rot (§8/§18).

#### B. Retrieval

* Default: vector (Chroma) + **Okapi BM25** her-ranking (typisch ~0.6 vector / ~0.4 BM25 in searcher; cosine + keyword — zoals in Better Stack-demo: `mempalace search "Why PostgreSQL"` met scores).
* Claim LongMemEval: raw R@5 **96.6%** zonder LLM; hybrid hoger; rerank met LLM nog hoger — vendor/repro in hun `benchmarks/`.
* Protocol: *search before answering* over verleden beslissingen/personen; greenfield-taken niet reflexief zoeken. Antwoord **citeren** uit drawer, niet herformuleren.

#### C. Integratie

* CLI: `mine` (bestanden / Claude JSONL), `search`, `wake-up`, `audit`, hooks pre-compaction / session-end.
* MCP: tientallen tools (`mempalace_search`, KG query/timeline, diary, …).
* Cursor/Claude hooks: auto-save vóór contextcompressie — raakt precies het “agent vergeet na compact”-probleem.

#### D. Wat wij al beter / anders doen

| MemPalace | Agent Engineering-kit |
|-----------|------------------------|
| Verbatim chat als bron van waarheid | **Curated** docs; chat is ruis (P5, §20) |
| Automatisch indexeren van alles | Selectief documenteren van *waarom* (ADR §23) |
| Semantic recall over sessies | Repo-map + INDEX + just-in-time openen (§9, §16) |
| Extra daemon/MCP-oppervlak | Minder moving parts (P25 harness tax) |

#### Wat ik meeneem

* **Hybride BM25+vector** en **scoped indices** (wing/room) zijn sterke retrieval-lessen voor eventuele eigen “beslissingen-zoek”-tooling.
* **Verbatim** > lossy summary voor audittrail — past bij ADR’s en “niet herschrijven”.
* Hooks vóór compaction = goed patroon; inhoud hoort bij *beslissingen/docs*, niet bij ruwe transcripts als SSOT.
* Bootstrap: **geen** MemPalace als default; wel noteren als opt-in experiment naast bestaande context-engineering.

#### Open / onduidelijk

* Privacy/footprint van volledige chat-index op laptop.
* Of AAAK-index drift veroorzaakt t.o.v. drawer-inhoud.
* Overlap met Cursor memories / project rules — meten vóór adoptie.

---

## §69. Cursor Instant Grep — lokale regex-index voor agent-tools (Cursor)

**Type:** Engineering-blog + docs · **URL:** [https://cursor.com/blog/fast-regex-search](https://cursor.com/blog/fast-regex-search) · docs: [https://cursor.com/docs/agent/tools/search](https://cursor.com/docs/agent/tools/search)

- **Datum blog:** 2026-03-23 · auteur Vicent Martí · ~21 min lezen  
- **Kern in 2–3 zinnen:** Cursor’s agent zoekt code vooral met **exacte / regex-zoeken**, niet (meer) via een door de user te sturen “semantic codebase index”. **Instant Grep** is een *lokale* inverted-index (sparse n-grams) die kandidaten selecteert; de echte match blijft een scan op die bestanden. Privacy-claim docs: geen upload van paden/code om een search-index te bouwen, geen embeddings van de codebase voor search.  
- **Aanvulling (staff, forum):** semantische index/embeddings voor search zijn afgebouwd; agents leunen op Instant Grep + file reads — [forum-draad](https://forum.cursor.com/t/what-do-you-think-about-cursor-removing-the-codebase-indexing-settings/165899). Oudere blog over Merkle/embeddings ([secure codebase indexing](https://cursor.com/blog/secure-codebase-indexing)) beschrijft de **vorige** pipeline — historisch, niet de huidige search-path.  
- **Complementair:** §9 (docs-structuur in IDE’s), §13 (Rules — wél user-stuurbaar), §16 (Aider repo-map).

---

#### A. Probleem: agents houden van grep, monorepo’s niet

* Geschiedenis in blog: `grep` (1973) → ctags/IDE-syntaxis → LSP → agentic coding, en agents gebruiken weer massaal **grep**.  
* Semantische index helpt bij veel taken (eerdere Cursor-werk), maar sommige queries **vereisen** regex/exacte match.  
* Default in de meeste harnesses (incl. Cursor vroeger): **`ripgrep`**. Snel per file, maar moet (conceptueel) over **alle** files. In grote enterprise-monorepo’s: routinematig **>15 s** per `rg` → agent-workflow stokt.  
* Analogie: IDE bouwt lokale syntactische index voor Go-to-Definition; Cursor bouwt een index voor de **kernoperatie** van agents: tekstlookup.

#### B. Klassieke regex-index (achtergrond)

* Paper 1993 (Zobel/Moffat/Sacks-Davis): n-grams + inverted index + regex→n-gram-heuristiek. Populair via Russ Cox (2012, Google Code Search).  
* **Inverted index:** token → posting list (document-id’s); AND = intersectie, OR = unie.  
* **Trigrams** (overlappende 3-tekens): sweet spot vs bigrams (te brede postings) / quadgrams (te veel keys). Index: alle trigrams in docs; query: regex parsen → trigrams → kandidaten → **deterministische** re-match op die files.  
* Referenties in veld: `google/codesearch`, Sourcegraph **Zoekt**. Trade-off: simpele heuristiek → te veel kandidaten; zware heuristiek → te veel trigram-lookups.  
* Detour **suffix arrays** (`livegrep`): krachtig op één corpus (bv. Linux kernel), duur om dynamisch te updaten / te schalen over veel repo’s.  
* GitHub Blackbird-achtig: trigrams + **probabilistische masks** (bloom-achtig “4e teken” / posities) — opslag zuinig, maar bloom **saturatie** bij updates.  
* **Sparse n-grams** (o.a. ClickHouse regex, nieuwere GitHub Code Search): deterministische gewichten op character-pairs; index extracteert veel n-grams, query gebruikt *covering* (minimaal aantal). Frequentietabel op OSS-code als hash → zeldzame pairs hoog gewicht → minder lookups. **Startpunt voor Cursor’s client-index.**

#### C. Instant Grep — lokaal, niet server-side

```
  Agent tool "search"
       │
       ▼
  Instant Grep (lokaal)
       │  sparse-n-gram lookup (mmap table → postings file)
       ▼
  kandidaten-bestanden
       │
       ▼
  echte regex-match op file-inhoud
       │
       ▼
  hits → Agent opent files → inhoud kan in modelrequest
```

* **Waarom lokaal (blog):** (1) na index nog file-scan nodig — server zou sync of roundtrips eisen; (2) privacy/security rond opslag; (3) latency — Composer is snel; search is hot path, vaak **parallel**; (4) **versheid** — agent moet eigen writes vinden; stale exact-search → “wild goose chase” + tokenverspilling. Semantische embeddings veranderen na edit meestal weinig in nearest-neighbor-richting; exacte search faalt hard bij stale index.  
* **Sync-model:** index verankerd aan een **git commit**; user/agent-edits als **laag erop** → snelle incremental updates, snel laden bij start.  
* **Opslag (blog):** twee bestanden — (1) postings achter elkaar op disk; (2) gesorteerde lookup-tabel (n-gram-**hashes** → offset). Alleen de tabel wordt **`mmap`** in de editor; postings random-read. Hash-collisie maakt postings alleen breder, nooit fout-positief op eindmatch.  
* **Docs Instant Grep:** custom engine, sneller dan ripgrep op grote codebases; full regex + word-boundary; agent gebruikt automatisch bij symbol-referenties; geen config.  
* **Privacy (docs):** index build/query on-device; **geen** upload van paths/code voor search-index; **geen** embeddings van codebase voor search. Wél: geopende match-inhoud kan in modelrequest (zie Cursor Data Use).  
* **Forum (staff):** index binaries onder **`.git/cursor/`** (per-repo, niet in git tracking); ~**halve** grootte van geïndexeerde source (ballpark); `.gitignore` by construction; `.cursorignore` op access path; geen index → fallback **plain ripgrep**; “Cursor Indexing & Retrieval” in Output = stale naam, geen bewijs van semantic build.

#### D. Agent-loop / context — wat de user wél en niet stuurt

| Laag | Wat Cursor doet | User stuurt? |
|------|-----------------|--------------|
| Instant Grep + file read | Tool-keuze van agent; lokale index | Indirect: `.gitignore` / `.cursorignore`; geen “tune embeddings”-UI meer |
| Explore **subagent** (docs) | Eigen contextvenster, sneller model, parallelle searches; samenvatting terug i.p.v. raw dump | Prompt (“use a subagent…”) of automatisch bij brede search |
| Rules / AGENTS.md (§13) | Persistente instructies vooraan in context | **Ja** — project/user/team rules |
| Docs-structuur (§9) | Welke markdown JIT geladen wordt | **Ja** — jouw `/docs` + workflow rules |
| Semantic codebase embeddings | Afgebouwd voor search (staff) | Was beperkt stuurbaar; nu vooral irrelevant voor search-path |

* Multi-root (docs): elke workspace-folder-context beschikbaar; features die één git-root nodig hebben (worktrees) disabled; Cloud Agents geen multi-root.

#### E. Historische pipeline (niet verwarren)

* [Securely indexing large codebases](https://cursor.com/blog/secure-codebase-indexing): Merkle-tree sync, chunk-embeddings, server-side semantic search, simhash copy binnen team — nuttig om te begrijpen wat “codebase indexing” *was*.  
* Lab-les: oude UI-teksten / `embeddable_files.txt` / “Delete index” kunnen nog spoken; bron van waarheid voor **huidige** search = Instant Grep-docs + fast-regex-blog + staff-forum.

#### Wat ik meeneem

* **Spoor 3 / lab:** Cursor’s black box voor *search* is niet “jouw embeddings tunen”, maar **tool-kwaliteit + ignore-files + rules/docs**. Verbeterhoek lab = **structure** (standaard in context) en eventueel **eigen** indexstrategie — niet feature-pariteit met Cursor’s Instant Grep.  
* **Hergebruik:** idee lokaal, commit-verankerd, incremental, exact-first bij sterke models; Explore-subagent-patroon = parallel search buiten main context (§8 context rot).  
* **Niet sturen / niet kopiëren:** sparse-n-gram engine + Composer-integratie is product-IP; lab v1 mag `rg`/simpele index + structure-JIT.  
* **Hypothese (geen ADR):** embeddings-index is *niet* verplicht voor een goede coding-agent-loop in 2026; meten later (A5) of semantic retrieval elders (docs/ADR’s) wél zin heeft.  
* **Geen kit-actie** vanuit dit lab.

#### Open / onduidelijk

* Exacte sparse-n-gram/hash-details van Instant Grep vs blog’s algemene algoritmen (blog is pedagogisch + “starting point”).  
* Wanneer Explore-subagent automatisch triggert (drempels niet in docs).  
* Of Cloud Agents dezelfde lokale Instant Grep-path hebben `[niet in bron]`.  
* Benchmarkcijfers in blog-UI (workflow timings) niet als harde getallen overgenomen zonder screenshot/transcript.
* Cross: semantic tijdperk **§70–§71**; dynamische context **§72**; Composer **§73**; harness-evolutie **§74**; per-model harness **§75**.

---

## §70. Improving agent with semantic search (Cursor)

**Type:** Engineering-blog · **URL:** [https://cursor.com/blog/semsearch](https://cursor.com/blog/semsearch)

- **Datum:** 2025-11-06 · Stefan Heule, Emily Jia, Naman Jain · ~4 min  
- **Kern:** Semantic search (NL-query → code-chunks) naast grep verbetert agent-uitkomsten; Cursor traint een **eigen embedding-model** op agent-traces. Claim (offline): gemiddeld **+12.5%** accuracy (range **6.5–23.5%** per model). Later productpad: Instant Grep dominant (**§69**); deze § = waarom semantic ooit “necessary” heette.  
- **Cross:** index-pipeline **§71**; Instant Grep **§69**.

#### A. Wat semantic search is

* Tool naast regex/grep: queries als “where do we handle authentication?” → relevante code-segmenten.  
* Stack: eigen embedding-model + indexing pipelines voor snelle retrieval.

#### B. Offline: Cursor Context Bench

* Dataset met bekende juiste antwoorden over codebases.  
* Vergelijking: tools **met** vs **zonder** semantic search; alle geteste (incl. Composer) beter mét semantic.

#### C. Online A/B (zelfde model)

| Metric | Claim |
|--------|--------|
| Code retention (algemeen) | **+0.3%** met semantic |
| Code retention (≥1000 files) | **+2.6%** |
| Dissatisfied follow-ups zonder semantic | **+2.2%** meer ontevreden follow-ups |

* Effect kleiner online omdat niet elke query search nodig heeft.

#### D. Custom retrieval training

```
  agent session traces (searches + file opens)
           │
           ▼
  LLM rankt “wat had eerder opgehaald moeten worden”
           │
           ▼
  train embedding similarity ↔ die rankings
```

* Feedbackloop op echte agent-gedrag i.p.v. generieke code-similarity.

#### E. Conclusie blog (toen)

* “Semantic search is currently necessary… especially large codebases”; zwaar gebruik van **grep + semantic** samen.  
* **Historische spanning met §69:** staff later: models goed genoeg met Instant Grep → semantic search-path afgebouwd voor search. Claims hier blijven nuttig voor A5 (wanneer semantic wél/niet loont).

#### Wat ik meeneem

* **Spoor 3:** embedding-index is een *optie met gemeten lift*, geen dogma; lab mag eerst exact/structure; semantic later meten op docs/ADR’s.  
* Train-op-agent-traces = patroon voor retrieval die bij de loop past.  
* Offline Context Bench + online keep-rate/dissatisfaction = assen voor A5/meten.  
* Geen kit.

#### Open / onduidelijk

* Exacte Context Bench-publicatie/repro `[niet in bron]`.  
* Of semantic elders in product (niet-search) nog leeft na Instant Grep.

---

## §71. Securely indexing large codebases (Cursor)

**Type:** Engineering-blog · **URL:** [https://cursor.com/blog/secure-codebase-indexing](https://cursor.com/blog/secure-codebase-indexing)

- **Datum:** 2026-01-27 · Jeremy Stribling · ~6 min  
- **Kern:** Semantic-index voor grote repo’s: Merkle-tree sync, syntactische chunks → embeddings (async), team **index-reuse** via simhash + content proofs zodat je geen code ziet die je lokaal niet hebt.  
- **Status t.o.v. §69:** beschrijft de **server-side semantic** pipeline; Instant Grep is lokaal/regex. Beide lezen voor A1; niet mengen als “huidige search”.

#### A. Probleem

* Naive index op tienduizenden files: uren; semantic pas bruikbaar vanaf ~**80%** klaar.  
* Team-clones gemiddeld ~**92%** similariteit → hergebruik i.p.v. elke machine from scratch.

#### B. Eerste index: Merkle + chunks

```
  file hashes → folder hashes → root (Merkle)
  edit → alleen pad naar root wijzigt → sync divergente takken
  file → syntactic chunks → embeddings (duur, async)
  embedding cache op chunk-inhoud
```

* Workspace **50k** files: alleen namen + SHA-256 ≈ **3.2 MB**; tree beperkt transfer.  
* Sync wijzigt **nooit** client-files.

#### C. Index hergebruiken (team/user)

* Client: Merkle → **simhash** (samenvatting content-hashes) → server zoekt nabije simhashes in vector-DB (zelfde team/user).  
* Boven drempel → kopieer index op achtergrond; client mag ondertussen al zoeken op bron-index.  
* Eisen: resultaten reflecteren lokale tree; **nooit** hits op files die client niet heeft.

#### D. Content proofs

* Client upload volle Merkle + simhash; server koppelt hash ↔ encrypted path.  
* Search filtert: geen proof → drop result.  
* Na gelijke roots: proofs weg; queries op gesynchroniseerde index.

#### E. Time-to-first-query (claim)

| Percentiel | Zonder reuse | Met reuse |
|------------|--------------|-----------|
| mediaan | 7.87 s | 525 ms |
| p90 | 2.82 min | 1.87 s |
| p99 | 4.03 uur | 21 s |

#### Wat ik meeneem

* Merkle + incremental sync = les voor elke grote index (ook lab).  
* **Access proofs** = security-patroon bij gedeelde indexes.  
* Solo-lab: team-reuse minder relevant; embedding-cost/async wel.  
* Geen kit; niet als huidige Instant Grep-architectuur presenteren.

#### Open / onduidelijk

* Exacte simhash/threshold-algoritme `[niet in bron]`.  
* Of pipeline nog actief na semantic-search afbouw (§69 forum).

---

## §72. Dynamic context discovery (Cursor)

**Type:** Engineering-blog · **URL:** [https://cursor.com/blog/dynamic-context-discovery](https://cursor.com/blog/dynamic-context-discovery)

- **Datum:** 2026-01-06 · Jediah Katz · ~6 min  
- **Kern:** Minder **static** context vooraf; agent haalt zelf op (**dynamic context discovery**). Primatief: **files**. Raakt A8/A9 (history als file, MCP als folder).

#### A. Static vs dynamic

* Harness per frontier-model getuned; context-engineering over lange trajectory geldt voor alle models.  
* Dynamic = token-efficiënter + minder tegenstrijdige context.

#### B. Vijf toepassingen

1. **Lange tool-outputs → file** (shell/MCP): i.p.v. truncaten → schrijf file; agent `tail`/leest meer. Minder onnodige summarization.  
2. **Chat history als file** bij summarization: lossy summary + pointer naar history; agent kan details terugzoeken.  
3. **Agent Skills** (open standard): naam/description static; body/scripts dynamisch via grep/semantic.  
4. **MCP tools**: descriptions naar **folder per server** (niet platte tool-search); static alleen namen → look-up on demand. A/B: runs mét MCP-call → **−46.9%** total agent tokens (hoog variantie). Status (re-auth) communiceerbaar.  
5. **Integrated terminal → files**: agent grept logs; geen copy-paste.

#### C. Waarom folders i.p.v. tool-search (voetnoot)

* Flat index verspreidt tools; folder = cohesieve server; `rg`/`jq` op descriptions.

#### D. Abstratie

* “Files may not be final interface” — voorlopig simpel + krachtig.

#### Wat ik meeneem

* **Spoor 3 / A8–A9:** history/terminal/MCP als files = direct antwoord op “session over workspace” en “logs in ander formaat”.  
* Skills = static tip + dynamic body (past bij dunne AGENTS + JIT docs).  
* MCP token-bloat oplossen in **harness**, niet elke server.  
* Geen kit-default; wel hypothese voor lab-spine.

#### Open / onduidelijk

* Exact pad/naamgeving van sync-folders op disk `[niet in bron]`.  
* Of −46.9% reproduceerbaar buiten Cursor A/B.

---

## §146. Your agents can get smarter over time with Hindsight (Better Stack)

**Type:** Video (short) · **URL:** [https://www.youtube.com/watch?v=K_awCw_NL1A](https://www.youtube.com/watch?v=K_awCw_NL1A) · repo: [vectorize-io/hindsight](https://github.com/vectorize-io/hindsight)

- **Duur:** ~1:57 · upload ~2026-09-27
- **Kern in 2–3 zinnen:** Better Stack-promo van **Hindsight** als agent-memory: custom server (Docker of **embedded**/geen server) op **Postgres + pgvector** (embedded via **PGZero**); LLM herschrijft input naar korte feiten (what/when/where/who/why) met links (entities, betekenis, tijd, oorzaak); background consolidation → observations + mental models; claim: beter dan Zep/Supermemory + deelbaar team-geheugen.
- **Cross:** MemPalace §52 (verbatim/local); skills/RAG taxonomie §54; inbox #29 → deze §.

---

#### A. Probleem + claim [[00:00](https://www.youtube.com/watch?v=K_awCw_NL1A&t=0)]

* Built-in memories (bv. Claude) → dezelfde fouten blijven terugkomen. Hindsight claimt “most accurate … ever tested” vs Zep/Supermemory; shared org memory.

#### B. Architectuur (video) [[00:30](https://www.youtube.com/watch?v=K_awCw_NL1A&t=30)]

```
  input → LLM fact-rewrite (5W)
        → graph-achtige links (entity / meaning / time / cause)
        → Postgres + vector + FTS
        → background consolidation (observations, mental models)
  deploy: central Docker  |  embedded (PGZero)
```

* Meer dan “alleen vector DB”: structured facts + consolidatie + shared server.

#### Wat ik meeneem

* Zelfde spanning als §52: externe memory-bank vs **curated docs/ADR** als SSOT (P2/P5). Interessant voor lab-opt-in; **geen** kit-default zonder meting.
* Shared team-memory = governance/secret-risico (wat mag agent “leren” van collega’s?).
* Inbox #29 LongMemEval **94.6%**-claim: niet in deze short uitgewerkt — verifiëren op repo/paper.

#### Open / onduidelijk

* Exacte benches/LongMemEval-cijfers in deze clip `[niet in bron]`; licentie/hosting-kosten.

---


## §73. Composer — fast frontier model with RL (Cursor)

**Type:** Engineering-blog · **URL:** [https://cursor.com/blog/composer](https://cursor.com/blog/composer)

- **Datum:** 2025-10-29 · research  
- **Kern:** **Composer** = MoE coding-agent-model; RL in productie-achtige tool-omgevingen; claim frontier coding + ~**4×** sneller dan vergelijkbare models (interne bench). Voorlab: model×harness-co-design, niet alleen “welke API”.

#### A. Motivatie

* Tab → prototype **Cheetah** → Composer: slim genoeg + interactief snel.  
* RL-taak: probleem → edit/plan/antwoord met tools: read/edit, terminal, **semantic search**, grep.

#### B. Cursor Bench

* Echte agent-requests van Cursor-engineers + hand-curated optimale oplossingen.  
* Meet correctheid **én** naleven van bestaande abstracties/praktijken.

#### C. RL-incentives

* Efficiënte tool-keuzes + parallelisme.  
* Minder onnodige/ongegronde claims.  
* Emergent: complexe searches, linter-fixes, unit tests schrijven/runnen.

#### D. Infra (hoog niveau)

* PyTorch + Ray async RL; MXFP8 MoE kernels + expert parallelism + hybrid sharded DP → duizenden GPU’s.  
* MXFP8 → snellere inference zonder post-training quant.  
* Honderdduizenden concurrent sandboxes; scheduler uit Background Agents hergebruikt → RL ≈ productie-omgeving.

#### E. Benchmark-noot (voetnoot blog)

* Interne harness-bench; klassen Fast Frontier / Best Open / Frontier 7/2025 / Best Frontier (GPT-5, Sonnet 4.5 **beter** dan Composer op score). TPS genormaliseerd op Anthropic-tokenizer.

#### Wat ik meeneem

* Lab v1: **geen** eigen frontier-model; wél: train/eval in *echte* tool-loop (A5/meten).  
* Snelheid + parallel tool use = productkeuze (Composer↔Instant Grep §69).  
* Geen kit.

#### Open / onduidelijk

* Publieke Cursor Bench-set? `[niet in bron]`  
* Relatie Composer vs Composer 2 in latere posts.

---

## §74. Continually improving our agent harness (Cursor)

**Type:** Engineering-blog · **URL:** [https://cursor.com/blog/continually-improving-agent-harness](https://cursor.com/blog/continually-improving-agent-harness)

- **Datum:** 2026-04-30 · Stefan Heule & Jediah Katz · ~11 min  
- **Kern:** Harness verbeteren als product: hypothese → offline CursorBench + online A/B (keep-rate, LLM-satisfaction) → tool-error taxonomy + alerts → **per-model** tool-formats/prompts. Toekomst: multi-agent orchestratie in de harness.

#### A. Context window evolutie

* Late 2024: veel guardrails (lint na elke edit, herschrijf te korte reads, max tools/turn) + zware static context (folder layout, semantic snippets, compressed attachments).  
* Nu: meeste daarvan weg; static rest: OS, git status, current/recent files; rest **dynamic** (§72).

#### B. Meten

* Offline: CursorBench (+ publieke benches).  
* Online A/B: latency, tokens, tool calls, cache hit; plus **Keep Rate** (code blijft in repo na interval); LLM leest user-reacties (tevreden vs stacktrace).  
* Voorbeeld: duurder model voor summarization → verwaarloosbare kwaliteit, niet waard.

#### C. Tool-errors & context rot

* Fouten blijven in context → rot; soms sessie vast.  
* Unknown error = altijd harness-bug (alert).  
* Expected: o.a. `InvalidArguments`, `UnexpectedEnvironment`, `ProviderError`, `UserAborted`, `Timeout`.  
* Anomaly alerts per tool×model. Weekly automation + Cloud Agents → tickets/fixes. Sprint: unexpected tool errors **orde-grootte** omlaag.

#### D. Per-model customisatie

* OpenAI: patch-edits; Anthropic: string replace — verkeerd formaat = extra tokens + fouten.  
* Diepe prompt-tweak per provider/versie; “context anxiety” via prompt verminderen.  
* Mid-chat model switch: wissel harness; OOD history; instructies “je neemt over”; cache miss; soms summarize; advies: één model per chat of **subagent** met gekozen model.

#### E. Toekomst

* Multi-agent: plan / snelle edits / debug — orchestratie = harness-probleem.

#### Wat ik meeneem

* **A7:** keep-rate + tool-error taxonomy + anomaly baselines = concrete meetideeën naast `make check`.  
* **Lab:** start model-agnostic tools; per-model fine-tuning is Cursor-schaal.  
* Static→dynamic bevestigt dunne AGENTS + JIT (§9/§13/§72).  
* Geen kit.

#### Open / onduidelijk

* Publieke Keep Rate-definities/intervallen.  
* Exacte CursorBench-openheid.

---

## §75. Improving Cursor’s agent for OpenAI Codex models (Cursor)

**Type:** Product/engineering-blog · **URL:** [https://cursor.com/blog/codex-model-harness](https://cursor.com/blog/codex-model-harness)

- **Datum:** 2025-12-04  
- **Kern:** Case study: harness **per model** tunen (Codex / GPT-5.1-Codex-Max) — shell-bias, preambles, literal lint-instructies, reasoning traces, “take action”, message-ordering valkuilen.

#### A. Principe

* Labs trainen op eigen tools/prompts; Cursor mengt vertrouwde + Cursor-tools; meet op Cursor Bench + adoption.

#### B. Aanpassingen (Codex)

| Thema | Wat |
|-------|-----|
| Shell-forward training | Codex leert veel via shell; Cursor hernoemt/aligns tools naar `rg`-achtig; “prefer tool over `cat`”; sandbox als vangnet |
| Preambles | Reasoning summaries 1–2 zinnen; geen mid-turn “praat met user”-prompttaal |
| `read_lints` | Tool-definitie alleen onvoldoende → **letterlijke** “after substantive edits, call read_lints…” |
| Reasoning traces | Tussen tool calls bewaren; drop → **−30%** Cursor Bench (GPT-5-Codex); OpenAI claimde ~**−3%** op SWE-bench voor GPT-5 zonder traces |
| Bias to act | Default: implementeer tenzij user plan vraagt; Cloud Agents nog sterker |
| Message ordering | System > user; “don’t waste tokens” in system → model weigerde ambitieuze taken |

#### Wat ik meeneem

* Harness≠één prompt: **model-specifieke** tool-shapes en letterlijke triggers.  
* Reasoning-state tussen tools kritiek voor sommige families (meten!).  
* Anti-patroon: system-prompt die user-intent frustreert (token-spaarzaamheid).  
* Lab: DeepSeek/andere keys → verwacht harness-tweak, niet alleen API-swap.  
* Geen kit.

#### Open / onduidelijk

* Exacte tool-namen mapping shell↔Cursor `[deels in bron]`.  
* Geldt −30% nog voor nieuwere Codex-versies.

---

# Harness Engineering


## §5. Harnesses in AI: A Deep Dive (Tejas Kumar, IBM)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=C_GG5g38vLU](https://www.youtube.com/watch?v=C_GG5g38vLU)

Tejas Kumar behandelt de fundamentele definitie en architectuur van een **AI Harness** binnen de AI-engineering context. Waar een LLM een onvoorspelbare *black box* is, is de *harness* de deterministische, gecontroleerde schil eromheen die zorgt voor **betrouwbaarheid en verankering** (*grounding*).

```
                       ┌─────────────────────────────────────────┐
                       │               AI HARNESS                │
                       │ ┌─────────────────────────────────────┐ │
                       │ │ Guardrails (Max Steps / Truncation) │ │
                       │ ├─────────────────────────────────────┤ │
                       │ │ Deterministic Tool Registry         │ │
                       │ ├─────────────────────────────────────┤ │
                       │ │   ┌─────────────────────────────┐   │ │
                       │ │   │     Agent Loop / Runtime    │   │ │
                       │ │   │ ┌─────────────────────────┐ │   │ │
                       │ │   │ │   LLM Model (Blackbox)  │ │   │ │
                       │ │   │ └─────────────────────────┐ │   │ │
                       │ │   └─────────────────────────────┘   │ │
                       │ ├─────────────────────────────────────┤ │
                       │ │ Verification Step & Auto-Handlers   │ │
                       │ └─────────────────────────────────────┘ │
                       └─────────────────────────────────────────┘

```

#### A. Theoretische Noodzaak van een Harness

1. **Het Model als Onbetrouwbare Huurling:**
* Ontwikkelaars "huren" inferentie bij frontier-modellen (OpenAI, Anthropic, Google). Deze modellen zijn onvoorspelbaar, niet-deterministisch en kunnen op elk moment wijzigen.
* Een *Agent Harness* is de software-infrastructuur rondom de agent die de uitvoeringsomgeving verankert aan een **stabiele, gecontroleerde werkelijkheid**.


2. **Harness Engineering vs. Prompting:**
* **De Fout:** Wanneer een agent faalt (bijv. liegt dat een actie is geslaagd of niet kan inloggen), proberen ontwikkelaars het model "harder te prompten" via de system prompt.
* **De Oplossing:** Pas de prompt *niet* aan. Bouw deterministische logica in de harness die de staat van de wereld controleert, de fout opvangt en de agent stuurt of corrigeert.


---

#### B. De Zes Bouwstenen van een Agent Harness

1. **Tool Registry:** Een gestructureerde verzameling van functies (met strikte parameter-schema's) die de agent toegang geven tot de buitenwereld (bestandssysteem, browser, bash).
2. **Context Manager / Compressor:** Logica die de berichtengeschiedenis activeert, bijsnijdt of samenvat wanneer grenzen dreigen te overschrijden (bijv. het behouden van de system prompt + de meest recente $N$ berichten).
3. **Guardrails:** Harde limieten ingesteld buiten de controle van de LLM, zoals `max_iterations` (bijv. breek af na 6 stappen) of token-budgetten.
4. **Agent Loop:** De cyclische verwerkingslus waarin de agent observaties ontvangt, beslissingen neemt en tools aanroept.
5. **Deterministic Verification Step:** Een afzonderlijke, programmatische controle die achteraf verifieert of de actie daadwerkelijk geslaagd is (bijv. via test-execution, statuscode-checks of DOM-reflectie) in plaats van te vertrouwen op de bewering van de LLM.
6. **Automated Sub-Handlers (Sidecar Logica):** Deterministische functies die ingrijpen zodra de agent een specifieke toestand bereikt (bijv. een inlogscherm) door automatisch en veilig inloggegevens in te spuiten via de harness, zonder dat de LLM toegang tot gevoelige sleutels nodig heeft.

---


---

## §11. Building Effective Agents (Anthropic)

**Type:** Artikel · **URL:** [https://www.anthropic.com/engineering/building-effective-agents](https://www.anthropic.com/engineering/building-effective-agents)

Gebaseerd op het werk met tientallen teams. De boodschap: de succesvolste implementaties gebruiken **eenvoudige, combineerbare patronen**, geen complexe frameworks. Voeg pas complexiteit toe wanneer die het resultaat aantoonbaar verbetert.

---

### 1. Workflows vs. Agents

* **Workflow:** LLM's en tools volgen vooraf gedefinieerde codepaden. Dat is voorspelbaar en consistent.
* **Agent:** het LLM stuurt zelf zijn proces en toolgebruik. Dat is flexibel, maar duurder en fouten kunnen zich opstapelen.
* Begin met de eenvoudigste oplossing. Vaak volstaat één goed geoptimaliseerde LLM-call met retrieval en voorbeelden.
* Frameworks verbergen prompts en responses en maken debuggen moeilijker. Begin met de API zelf, en als je een framework gebruikt, begrijp dan wat eronder zit.

---

### 2. Bouwstenen en Patronen

```
  AUGMENTED LLM  (LLM + retrieval + tools + geheugen)  ← basisbouwsteen
        │
        ├── Prompt chaining      vaste stappen, met "gates" (checks) tussenin
        ├── Routing              input classificeren → gespecialiseerde vervolgstap
        ├── Parallelization      sectioning (deeltaken) of voting (meerdere pogingen)
        ├── Orchestrator-workers centrale LLM verdeelt dynamisch werk en voegt samen
        ├── Evaluator-optimizer  één LLM genereert, een andere beoordeelt, in een lus
        └── Autonomous agent     LLM + tools + feedback uit de omgeving, in een lus
```

* **Orchestrator-workers** past bij code: hoeveel bestanden je moet aanpassen, hangt af van de taak.
* **Evaluator-optimizer** werkt als er duidelijke evaluatiecriteria zijn.
* **Agents** hebben bij elke stap **"ground truth" uit de omgeving** nodig (toolresultaten, uitgevoerde code), plus stopcondities en checkpoints voor de mens.

---

### 3. Drie Kernprincipes

1. Hou het ontwerp van de agent **eenvoudig**.
2. Maak de **planning van de agent zichtbaar** (transparantie).
3. Ontwerp de **agent-computer interface (ACI)** zorgvuldig, met grondige tooldocumentatie en tests.

---

### 4. Bijlagen: Coding Agents & Tools

* Code leent zich goed voor agents omdat oplossingen **verifieerbaar zijn met automatische tests**, de agent op testresultaten kan itereren, en kwaliteit objectief meetbaar is. Menselijke review blijft wel nodig voor de bredere systeemvereisten.
* **Prompt engineering voor tools:** steek evenveel moeite in de ACI als in een mens-computerinterface. Schrijf tooldocumentatie zoals een goede docstring voor een junior collega. Test veel inputs. Ontwerp tools fouttolerant (*poka-yoke*).
* Praktijkvoorbeeld: bij hun SWE-bench-agent ging meer tijd naar de tools dan naar de prompt. Relatieve paden liepen mis zodra de agent van map wisselde. Toen ze **absolute paden** verplichtten, verdween die fout volledig.

### Wat ik meeneem

* **Tests en checks zijn de "ground truth"** voor een coding-agent, en dus de belangrijkste projectstructuur.
* Interfaces fouttolerant maken (absolute paden, één commando voor alle checks) levert meer op dan extra uitleg.
* "Voeg complexiteit pas toe als het aantoonbaar helpt" geldt ook voor documentatielagen.

---


---

## §12. Best Practices for Claude Code (Anthropic)

**Type:** Documentatie · **URL:** [https://www.anthropic.com/engineering/claude-code-best-practices](https://www.anthropic.com/engineering/claude-code-best-practices)

Praktijkgids die vertrekt van één beperking: **het contextvenster loopt snel vol en de prestaties dalen naarmate het voller wordt**. Bijna elke tip volgt daaruit.

---

### 1. Geef de Agent een Manier om Zijn Werk te Verifiëren

* Een agent stopt wanneer het werk "af lijkt". Zonder een check die hij zelf kan draaien, ben jij de verificatielus.
* Een check is alles wat een leesbaar pass/fail-signaal geeft: een testsuite, de exitcode van een build, een linter, een diff tegen een fixture, een screenshot naast een design.
* Hoe hard de check de taak afsluit, kan op vier niveaus: (1) vragen in de prompt, (2) een doel voor de hele sessie, (3) een deterministische stop-hook die blokkeert tot de check slaagt, (4) een tweede opinie via een reviewer-subagent.
* Laat de agent **bewijs tonen** (testoutput, uitgevoerd commando, screenshot) in plaats van succes te beweren.

---

### 2. Eerst Verkennen, dan Plannen, dan Coderen

```
  Explore (plan mode, alleen lezen) → Plan (bewerkbaar plan) → Implement (+ tests) → Commit/PR
```

* Plannen loont bij een onzekere aanpak, wijzigingen in meerdere bestanden of onbekende code.
* **Als je de diff in één zin kan beschrijven, sla het plan over.**

---

### 3. Specifieke Context in de Prompt

* Beperk de scope (welk bestand, welk scenario), wijs naar bronnen (git-geschiedenis), verwijs naar **bestaande patronen** in de code, en beschrijf het symptoom samen met wat "opgelost" betekent.
* Verwijs met `@` naar bestanden in plaats van te beschrijven waar code staat.

---

### 4. Een Effectieve CLAUDE.md

* Wordt bij elke sessie ingeladen, dus zet er **alleen in wat breed geldt**. Kennis die maar soms nodig is, hoort in **skills** die op aanvraag laden.
* Toetsvraag per regel: *"Zou het weghalen hiervan fouten veroorzaken?"* Zo niet, schrappen. Een opgeblazen bestand zorgt ervoor dat de echte instructies genegeerd worden.

| ✅ Opnemen | ❌ Weglaten |
|-----------|------------|
| Bash-commando's die het model niet kan raden | Wat het model uit de code kan afleiden |
| Afwijkende stijlregels | Standaardconventies van de taal |
| Testinstructies en test runner | Gedetailleerde API-docs (link ernaar) |
| Repo-etiquette (branches, PR's) | Informatie die vaak verandert |
| Projectspecifieke architectuurkeuzes | Lange uitleg of tutorials |
| Eigenaardigheden van de omgeving (env vars) | Beschrijving per bestand van de codebase |
| Niet-evidente valkuilen | Vanzelfsprekendheden ("schrijf clean code") |

* Wordt een regel genegeerd, dan is het bestand waarschijnlijk te lang. Stelt de agent vragen die al beantwoord zijn, dan is de formulering dubbelzinnig.
* Behandel `CLAUDE.md` **als code**: reviewen, snoeien en testen of het gedrag echt verandert.
* Benadruk ("IMPORTANT") hooguit een paar regels. Als alles benadrukt is, valt niets meer op.

---

### 5. Uitbreidingen: Hooks, Skills, Subagents

* **Hooks** zijn deterministisch: gebruik ze voor wat **zonder uitzondering** moet gebeuren (linten na elke edit, schrijven naar `migrations/` blokkeren). Instructies in `CLAUDE.md` zijn maar adviezen.
* **Skills** (`SKILL.md`) bevatten domeinkennis en herhaalbare workflows en laden alleen wanneer relevant.
* **Subagents** werken in een eigen venster met eigen tools en houden zoekwerk uit de hoofdcontext.

---

### 6. Sessiebeheer & Faalpatronen

* Gebruik `/clear` tussen ongerelateerde taken. **Heb je twee keer tevergeefs gecorrigeerd, begin dan opnieuw** met een betere prompt.
* Een frisse context is beter voor review: de reviewer is niet bevooroordeeld door code die hij net zelf schreef (Writer/Reviewer-patroon).
* Een reviewer die gevraagd wordt om gaten te vinden, vindt er bijna altijd. Laat alleen gaten melden die correctheid of vereisten raken, anders krijg je over-engineering.

| Faalpatroon | Oplossing |
|-------------|-----------|
| Kitchen-sink-sessie (taken door elkaar) | `/clear` tussen taken |
| Steeds opnieuw corrigeren | Na twee keer: opnieuw beginnen met een betere prompt |
| Overgespecificeerde CLAUDE.md | Hard snoeien of omzetten naar een hook |
| Plausibel maar ongetest | Altijd verificatie voorzien |
| Eindeloos verkennen | Scope afbakenen of een subagent inzetten |

### Wat ik meeneem

* De in/uit-tabel van CLAUDE.md is een directe checklist voor elk routerbestand. "Per-bestand-beschrijving van de codebase" staat er expliciet bij als iets om weg te laten.
* Wat altijd moet gebeuren: **hook of test, geen regel in Markdown**.
* Een kleine router met skills of docs op aanvraag is het aanbevolen patroon.

---


---

## §19. SWE-agent: Agent-Computer Interfaces Enable Automated Software Engineering

**Type:** Paper · **URL:** [https://arxiv.org/abs/2405.15793](https://arxiv.org/abs/2405.15793)

---

### 1. Kernidee: de Agent-Computer Interface (ACI)

* Mensen werken beter met goede tools (IDE's). LM-agents zijn een **nieuwe categorie eindgebruiker** met eigen sterktes en beperkingen, en hebben dus ook een eigen interface nodig.
* De **ACI** is de abstractielaag tussen agent en computer: welke commando's er zijn, hoe feedback terugkomt en hoe de geschiedenis beheerd wordt.
* Ze passen het model niet aan, alleen de interface.

---

### 2. Vier Ontwerpprincipes

1. **Simpele, begrijpelijke acties**: weinig opties en korte documentatie, in plaats van bash-commando's met tientallen flags.
2. **Compacte, efficiënte acties**: belangrijke operaties (navigeren, bewerken) gebundeld in zo weinig mogelijk stappen.
3. **Informatieve maar beknopte feedback**: toon de nieuwe staat na een edit, zonder overbodige details.
4. **Guardrails** tegen foutpropagatie, zoals een syntaxcheck die een edit met fouten meteen weigert.

---

### 3. Concrete Componenten

```
  Zoeken     find_file / search_file / search_dir   → max. 50 resultaten, anders "verfijn je query"
  Bekijken   file viewer: 100 regels per venster, regelnummers, pad, totaal aantal regels
  Bewerken   edit met regelbereik + automatische linter; foute edit wordt geweigerd
  Context    oudere observaties ingekort tot één regel
```

---

### 4. Resultaten

* Met GPT-4 Turbo loste SWE-agent **12,5%** van SWE-bench op, tegenover 3,8% voor het vorige beste niet-interactieve systeem.
* In de ablatie op SWE-bench Lite: **+10,7 procentpunt** tegenover een agent met alleen een gewone Linux-shell.
* De ACI werkt ook met een ander model (Claude 3 Opus: 10,5%).
* Mensen kunnen onnodige informatie negeren, een LM niet: alle inhoud kost geheugen en rekenwerk, en afleidende context schaadt.

### Wat ik meeneem

* De **omgeving** (zoekresultaten met een limiet, korte feedback, linters als guardrail) beïnvloedt de prestaties aantoonbaar, los van de prompt.
* Voor een project betekent dat: **één snel check-commando**, duidelijke foutmeldingen, en bestanden die niet gigantisch zijn.
* Methodologisch voorbeeld voor een bachelorproef: **ablatie**, één onderdeel tegelijk weglaten en meten wat het effect is.

---


---

## §25. Is the Agent Harness Dead?

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=7Y4sbZgBdnc](https://www.youtube.com/watch?v=7Y4sbZgBdnc)

### 1. Is the Agent Harness Dead? (Jediah Katz, SpaceXAI / ex-Cursor)

Jediah Katz (voormalig lead engineer van het agent-harness team bij Cursor, overgenomen door SpaceX) analyseert de evolutie van de agent-infrastructuur en adresseert de actuele vraag: **"Is de agent harness dood nu modellen steeds slimmer worden?"**

```
                     DE EVOLUTIE VAN HET ONTWERPDOMEIN

 2023: Prompt Engineering ──> 2025: Context Engineering ──> 2026: Harness / Loop Engineering
 (Tekstuele instructies)      (Programmatische Context)      (Systeem-Runtimes & Flywheels)

```

#### A. De Twee Lagen van een Agent Harness

Katz deelt een geavanceerde agent-harness op in twee lagen:

1. **De Runtime Layer (De Fundering):**
* Regelt de fysieke uitvoering van de agent-loop, zandbakken (sandboxes) en de **persistente staat**. Zorgt ervoor dat langdurige taken onderbroken en hervat kunnen worden. Dit is traditionele, robuuste software-engineering.


2. **De Context & Orchestration Layer (De "Wild West"):**
* Bepaalt *welke* modellen wanneer worden aangeroepen en *welke* context ze zien (prompts, tools, memory compaction, guardrails).


---

#### B. De "Harness Flywheel" Theory (Waarom de klassieke Harness zichzelf opheft)

Veel onderzoeken (zoals van UC Berkeley en Apple/EPFL) tonen aan dat bij de nieuwste frontier-modellen het type harness nauwelijks nog invloed heeft op benchmarks zoals SWE-bench Light. De reden hiervoor is het **Data Flywheel Effect**:

```
                              DE HARNESS FLYWHEEL
┌─────────────────────────────────────────────────────────────────────────────┐
│ 1. Een geavanceerde Harness maakt complexe taken mogelijk voor huidige LLM's.│
│ 2. Meer ontwikkelaars voeren deze complexe taken succesvol uit met agents.   │
│ 3. Deze trainingsdata (traces) stroomt terug naar de AI-labs.               │
│ 4. Het volgende Frontier Model leert deze vaardigheden NATIVELY (spontaan). │
│ 5. De Harness-ontwikkelaars kunnen hun oude hacks/guardrails WISSEN (prune).│
└─────────────────────────────────────────────────────────────────────────────┘

```

* **Conclusie:** De harness heft zijn eigen 'context-hacks' op doordat het model de vaardigheden (zoals zelfstandig codebases verkennen of tests draaien) **absorbeert in de weights**.

---

#### C. Waarom de Harness NIET Dood Is: Het Nieuwe Agent-Frontier

Hoewel *coding intelligence* gecodificeerd raakt in het model, verschuift de Harness naar **nieuwe frontiers**:

1. **Boven-Coderende Taken (bijv. Grockbot / Autonomous Colleagues):**
* Multi-agent coördinatie, autonome communicatie, risico-inschatting (*acting vs. asking*) en langdurig geheugen vereisen wél weer zware harness-sturing.


2. **Infrastructure & Cloud Execution:**
* Dagenlang draaiende agents kunnen niet op een lokale laptop draaien. Ze vereisen cloud-gebaseerde runtimes.


3. **Trust, Security & Scoped Permissions:**
* Beveiliging, API-budgetten en scopings-guardrails om rampzalige acties te voorkomen kunnen *nooit* aan het model alleen worden overgelaten.


4. **Kosten- & Token-Efficiëntie:**
* Uit onderzoeken blijkt dat hoewel verschillende harnesses dezelfde score halen, de **kosten per taak gigantisch verschillen**. Een efficiënte harness bespaart duizenden dollars aan token-cost.


---


---

## §30. Why Harness is SO Expensive (Caleb Writes Code)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=8ji5vURIllM](https://www.youtube.com/watch?v=8ji5vURIllM)

Caleb analyseert de financiële en economische frictie van moderne AI-agent workflows. Hoewel de kosten van 'ruwe intelligentie' (de API-tokenprijs van losse modellen) fors dalen, worden agentic workflows via IDE's (zoals Claude Code, Cursor, OpenCode, Cline) **tot wel 30 tot 150 keer zo duur**.

```
                     COST EXPLOSION: CHAT VS. HARNESS

  DIRECT CHAT PROMPT                         HARNESS PROMPT (Claude Code/Cline)
┌─────────────────────────────────┐        ┌───────────────────────────────────┐
│ • Prompt: 25 tokens.            │        │ • Directe Prompt: 25 tokens.      │
│ • Systeem-overhead: ~0 tokens.  │        │ • System Prompt Overhead:         │
│ • Kosten per actie: $0.00001    │        │   8.000 - 30.000 tokens!          │
│                                 │        │ • Meerdere lussen (Loops/Pings).  │
│                                 │        │ • Kosten per actie: $0.37 (30x!)  │
└─────────────────────────────────┘        └───────────────────────────────────┘

```

#### A. De Oorzaak: Systeem-Prompts & De "Harness Tax"

* **System Prompt Overhead:** Om te zorgen dat een agent bestanden kan bewerken, terminal-commando's kan draaien, MCP-tools snapt en regels volgt, voegt elke harness een gigantische **verborgen System Prompt** toe (tussen de 8.000 en 30.000 tokens per verzoek).
* **De "Tollgate":** Elke enkele klik of actie die je naar het model stuurt, moet deze 'tol' van tientallen duizenden tokens betalen.
* **Kostenvergelijking van een simpele vraag ("Maak een alfabet-bestand")**:
* **Directe API / Chat:** $\approx \$0.01$
* **PI Harness:** $\approx \$0.025$
* **Cline Harness:** $\approx \$0.07$
* **OpenCode Harness:** $\approx \$0.11$
* **Claude Code Harness:** $\approx \$0.37$ (bijna **$30\times$ duurder** vanwege de reusachtige lijst ingebouwde functies).


---

#### B. Het Oscillatie-Effect (Roundtrip Multiplication)

In een agentic workflow stuurt een mens niet één vraag waarop één antwoord volgt. Er ontstaat een **oscilatie/lus** tussen het model en de harness:

1. Mens stuurt opdracht.
2. Model leest map-inhoud $\rightarrow$ stuurt verzoek naar Harness.
3. Harness voert uit op de pc $\rightarrow$ stuurt resultaat terug (inclusief de volle System Prompt + historie).
4. Model vraagt bestand aan te maken $\rightarrow$ stuurt verzoek naar Harness.
5. Harness maakt bestand $\rightarrow$ stuurt bevestiging terug.

* **Conclusie:** Voor een taak van 15 minuten vinden er tientallen *roundtrips* plaats. Elke stap stuurt de volledige geschiedenis én de zware System Prompt opnieuw mee, wat de token-teller explosief laat stijgen.

---

#### C. De Economie van Prompt Caching (Hoe API-vendors verdienen)

* **Prompt Caching als Enabler:** Zonder *Prompt Caching* (het tijdelijk opslaan van de berekende KV-cache van de System Prompt op de server) zouden coding-agents onbetaalbaar zijn.
* **De Business Case van Anthropic op H100 GPU's:**
* Een NVIDIA H100 kost in verhuur $\approx \$3$ per uur.
* Als Anthropic via slimme quantisatie 12 plekken van een $1\text{M}$ context window voor 5 minuten cached op één H100 card, genereert die enkele GPU $\approx \$70$ per uur aan Prompt Caching-opbrengsten.


* **1-Hour Cache Writes:** Om langlopende taken ($>10$ minuten) te ondersteunen zonder de extreem dure GPU-VRAM bezet te houden, verplaatst de provider de ongebruikte KV-caches waarschijnlijk tijdelijk van het snelle VRAM naar een nabijgelegen snelle NVMe-SSD.

---


---

## §33. Pi Agent Framework / Negative Space (Caleb Writes Code)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=FJxgz5pN4wU](https://www.youtube.com/watch?v=FJxgz5pN4wU)

Uitgebreide analyse van de **Pi Agent / Pi Framework** (bekend als het brein achter *OpenClaw*). Caleb behandelt het Pi Agent Framework, de filosofie van *"Negative Space"* in agentic software-engineering, en waarom **extensibiliteit in code** superieur kan zijn aan gezwollen (*bloated*) all-in-one harnesses zoals Claude Code of Cursor.

---

### 1. Theoretisch Kernconcept: "Negative Space" & De 'Un-Bloated' Agent

Waar populaire coding-agents (zoals Claude Code, Cursor, Codex CLI) proberen op te vallen door steeds méér ingebouwde features toe te voegen (MCP, sub-agents, to-do-lists, background bash), valt **Pi** juist op door **zoveel mogelijk WEG te laten**. [[00:54](https://www.youtube.com/watch?v=FJxgz5pN4wU&t=54), [01:12](https://www.youtube.com/watch?v=FJxgz5pN4wU&t=72)]

```
                       COMPARE: BLOATED VS. MINIMAL HARNESS

    CLAUDE CODE / CURSOR (Bloated Harness)                PI AGENT (Minimal Harness)
┌──────────────────────────────────────────┐    ┌──────────────────────────────────────────┐
│ • Sub-agents out-of-the-box.             │    │ • NUL ingebouwde sub-agents.             │
│ • MCP-protocols ingebouwd.               │    │ • NUL ingebouwde MCP.                    │
│ • Achtergrond-bash processen.            │    │ • NUL ingebouwde To-Do lijsten.          │
│ • Statische instellingen in `settings.json`│  │ • Zelf-uitbreidbaar in TypeScript-code.  │
│ • Grote System Prompt Overhead ($$).     │    │ • Lichte, razendsnelle execution loop.   │
└──────────────────────────────────────────┘    └──────────────────────────────────────────┘

```

* **Negative Space Filosofie:** Net als in de kunst (waar de lege ruimte rond een object het onderwerp definieert), definieert Pi zich door wat het *niet* is. Het levert een extreem strakke, minimale schil waarop ontwikkelaars hun eigen maatwerk-agent bouwen. [[00:58](https://www.youtube.com/watch?v=FJxgz5pN4wU&t=58)]
* **Build-to-Delete Principle:** Omdat de onderliggende LLM's elke paar maanden drastisch verbeteren en vaardigheden absorberen, raken zware harnesses snel verouderd (bekend van *LangChain* dat 4 keer en *Manus* dat 5 keer volledig herschreven moest worden). Pi vermijdt *over-engineering* in de harness-laag om maximale duurzaamheid op lange termijn te garanderen. [[06:12](https://www.youtube.com/watch?v=FJxgz5pN4wU&t=372), [06:34](https://www.youtube.com/watch?v=FJxgz5pN4wU&t=394)]

---

### 2. De Extensibiliteits-Paradigma: JSON-configs vs. Native Code Hooks

In traditionele agents is de harness een "black box". Wil je het gedrag aanpassen (bijv. een audit-log schrijven als een bestand wordt gewist via een *pre-tool hook*), dan moet je dit configureren via een statisch `settings.json` bestand dat de harness moet interpreteren. [[01:30](https://www.youtube.com/watch?v=FJxgz5pN4wU&t=90), [02:01](https://www.youtube.com/watch?v=FJxgz5pN4wU&t=121)]

```
                         HOOK IMPLEMENTATIE-PARADIGMA

  TRADITIONEEL (Claude Code/Cursor)                   PI AGENT FRAMEWORK
┌────────────────────────────────────┐       ┌────────────────────────────────────┐
│ `settings.json`                    │       │ `extension.ts` (Native TypeScript) │
│ {                                  │       │ export function preToolUse(tool) { │
│   "hooks": { "preTool": "script" } │  ───> │   writeAuditTrail(tool.args);     │
│ }                                  │       │ }                                  │
└────────────────────────────────────┘       └────────────────────────────────────┘
  (Statisch, beperkt door de schil)            (Zelf-bewuste agent herschrijft
                                                zijn eigen runtime-harness!)

```

#### De Unieke Eigenschap van Pi

* **Harness Extension via TypeScript:** In Pi schrijf je hooks en uitbreidingen direct in **TypeScript-code**. [[02:15](https://www.youtube.com/watch?v=FJxgz5pN4wU&t=135)]
* **Self-Aware Self-Extension:** De Pi-agent kan **zijn eigen harness herschrijven** in runtime. Zodra de gebruiker of agent `/reload` uitvoert in de terminal, gebruikt Pi de zojuist door de agent geschreven TypeScript-code als z'n nieuwe ingebouwde hook of tool. [[02:22](https://www.youtube.com/watch?v=FJxgz5pN4wU&t=142), [02:29](https://www.youtube.com/watch?v=FJxgz5pN4wU&t=149)]

---

### 3. De 4-Delige Systeemarchitectuur van Pi

Pi past strakke software-principes toe, waaronder **Separation of Concerns** en het **Open-Closed Principle** (Open voor uitbreiding, gesloten voor modificatie): [[04:20](https://www.youtube.com/watch?v=FJxgz5pN4wU&t=260), [04:36](https://www.youtube.com/watch?v=FJxgz5pN4wU&t=276)]

```
                             PI AGENT ARCHITECTUUR
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│ 1. `pi-ai/`  ──> Beheert API-provider verbindingen (OpenAI, Anthropic, SpaceX, Gemini).  │
│                  Regelt streaming, tool-calling, token-tracking & mid-chat switches.   │
├─────────────────────────────────────────────────────────────────────────────────────────┤
│ 2. `agent/`  ──> De autonome agentic loop (validation, event-streaming, tool execution).│
├─────────────────────────────────────────────────────────────────────────────────────────┤
│ 3. `tui/`    ──> De Terminal UI (rendering, sessies, thema's, interactie).               │
├─────────────────────────────────────────────────────────────────────────────────────────┤
│ 4. `scaffold/`─> De uitbreidingen (hooks, maatwerk-tools, custom workflows).            │
└─────────────────────────────────────────────────────────────────────────────────────────┘

```

1. **`pi-ai` (Provider Abstraction Layer):** Afgescheiden module die alle communicatie met verschillende LLM-providers regelt. Het maakt het mogelijk om *midden in een gesprek* naadloos te wisselen van provider (bijv. van OpenAI naar Anthropic of Gemini). [[04:44](https://www.youtube.com/watch?v=FJxgz5pN4wU&t=284), [05:06](https://www.youtube.com/watch?v=FJxgz5pN4wU&t=306)]
2. **`agent` (The Core Loop):** Afgescheiden agentic-loop die de uitvoering van tools, validatie van invoer en event-streaming verwerkt. [[05:10](https://www.youtube.com/watch?v=FJxgz5pN4wU&t=310)]
3. **`tui` (Terminal User Interface):** De lichtgewicht CLI-schil voor sessiebeheer en rendering. [[05:14](https://www.youtube.com/watch?v=FJxgz5pN4wU&t=314)]
4. **Scaffolding / Extensions:** Waar applicaties zoals **OpenClaw** op gebouwd zijn. Door Pi als framework te importeren, bouwen ontwikkelaars hun eigen gespecialiseerde agents (zoals een lichte code-review agent) zonder te betalen voor de $30\text{k}$-token overhead van een zware commerciële agent. [[02:35](https://www.youtube.com/watch?v=FJxgz5pN4wU&t=155), [05:26](https://www.youtube.com/watch?v=FJxgz5pN4wU&t=326)]

* **Actuele productfeiten (2026):** zie **§76** (pi.dev / monorepo) — deze § blijft de video/filosofie.

---

## §76. Pi Coding Agent — minimale extensible harness (pi.dev / earendil-works)

**Type:** Productdocs + repo · **URL:** [https://pi.dev/](https://pi.dev/) · repo: [https://github.com/earendil-works/pi](https://github.com/earendil-works/pi)

- **Kern:** Open-source **minimale** agent harness (MIT): TypeScript monorepo; defaults zonder baked-in sub-agents/plan mode; uitbreiden via extensions/skills/packages. Vier modes: interactive TUI, print/JSON, RPC, SDK. Complementair aan video **§33** (negative space).  
- **Install:** `curl … pi.dev/install.sh` of `npm i -g --ignore-scripts @earendil-works/pi-coding-agent`; Node **≥ 22.19**.

#### A. Packages (monorepo)

| Package | Rol |
|---------|-----|
| `@earendil-works/pi-ai` | Multi-provider LLM API |
| `@earendil-works/pi-agent-core` | Agent runtime, tools, state |
| `@earendil-works/pi-coding-agent` | Coding CLI + SDK (`createAgentSession`) |
| `@earendil-works/pi-tui` | Terminal UI |
| `@earendil-works/chord` | Hot-reload plugins, contracts, RPC |
| `@earendil-works/pi-durable` | Durable conversations/tasks (Pi 1.0) |
| `@earendil-works/pi-telemetry` | Vendor-neutral telemetry contracts |

#### B. Context engineering (productclaims)

* Dunne system prompt; **AGENTS.md** uit `~/.pi/agent/`, parents, cwd.  
* **SYSTEM.md** per project (replace/append).  
* Compaction (customizable via extensions).  
* Skills on-demand (progressive disclosure, cache-vriendelijk).  
* Prompt templates (`/name`); extensions kunnen pre-turn inject / history filter / RAG.

#### C. Modes & extensibility

* Interactive / `pi -p` / `--mode json` / RPC stdin-stdout / in-process SDK.  
* Extensions = TypeScript met tools, commands, shortcuts, events, TUI; features elders baked-in → hier packages (sub-agents, plan, permissions, SSH, sandbox, MCP).  
* `pi install npm:…` / `git:…`; `/reload` na self-edit.  
* Providers: Anthropic, OpenAI, Google, Mistral, Ollama, OpenRouter, …; mid-session `/model`.  
* Session history als **tree** (`/tree`, branches in één file; `/export`, `/share`).

#### Wat ik meeneem

* **Spoor 3 / B-kandidaat:** Pi ≈ TypeScript-basis + structure via AGENTS/extensions i.p.v. Cursor-pariteit — past lab-hypothese “minimale harness”.  
* SDK + RPC = embed in eigen app zonder full IDE-fork.  
* Tree-sessions raken A9 (history niet alleen “één chat-folder”).  
* ≠ DeepSeek Harness (**§77**): Pi = negative space; DSH = everything-is-plugin product UI.  
* Geen kit; geen “we forken Pi”-ADR hier.

#### Open / onduidelijk

* Exacte default tool-set vs extension-defaults in 1.0 release notes.  
* OpenClaw als referentie-integratie — apart § indien diep nodig.

---

## §77. DeepSeek Harness (`dsh`) — everything is a plugin

**Type:** Repo + product · **URL:** [https://github.com/deepseek-ai/deepseek-harness](https://github.com/deepseek-ai/deepseek-harness) · site: [https://www.deepseek.com/en/harness/](https://www.deepseek.com/en/harness/)

- **Kern:** Open-source agent harness van DeepSeek AI (**MIT**), CLI `dsh`, Web UI (`npx @deepseek-ai/dsh web` → `127.0.0.1:3080`). Architectuur: **everything-is-a-plugin** op **Cordis** ([arxiv 2608.25512](https://arxiv.org/abs/2608.25512) spatiotemporal composability). **≠** DeepSeek-model/infra-§ (§56–§62).  
- **Status:** developer/public preview; **breaking changes** verwacht. SAFETY.md verplicht vóór run.

#### A. Run & surfaces

* npm: `npx @deepseek-ai/dsh web`; source: pnpm build + `pnpm dsh web`.  
* Desktop + web; coding, everyday tasks, research, background jobs, plugins.  
* Python/TS SDK (JSON-RPC); Python vereist expliciete `DSH_HOME` (ontdekt `~/.dsh` bewust niet).  
* Docs: architecture.md, AGENTS.md in repo; plugin-topic `dsh-plugin`.

#### B. Architectuur (docs/architecture.md)

* **Cordis:** alles is plugin (model adapter, tool registry, session log, agent loop); registraties = reverseerbare effects; unload rewindt. Geen privileged core om te patchen.  
* **Profile** = geordende bundles + out-of-tree plugins + `cordis.patch.yml` in Harness home. Templates: `web`, `headless`, `sdk`, `sdk-minimal`, `acp`.  
* **Bundle** = Cordis-config + code; `dsh-base` = gedeelde laag (adapters, tools, persistence, sandbox/approval, credentials, telemetry); web/headless/sdk/acp-apps stapelen daarop; `sdk-minimal` = uitzondering zonder base.  
* Core packages o.a.: `session` (append-only SessionEvent-log), `system-prompt`, `tools`, `agent` / `agent-loop`, `llm`.  
* **Turn/step:** turn = ≥0 steps; step = één modelrequest + toolcalls; waterfalls (`agent/pre-step`, `tools/pre-execute`…); **model-visible = logged** (reconstructeerbaar uit session log).  
* Capability **seams** (fs/shell/sandbox/subagent): service def + provider + consumer — swap sandbox verplaatst bash/PTY/LSP mee.

#### C. Plugin-ecosysteem (releases, o.a. 0.2.1-rc)

* Custom plugin indexes; Agent kan plugins maken (“create mode”).  
* Enable/disable/uninstall + hot-reload waar mogelijk.  
* Experimenteel: Claude Code Mods-compat-laag, Git Worktrees, session state API, DevTools.  
* AGENTS.md (`DSH_AGENTS_HOME`); working_directory tool; SSH helper; secret redaction.

#### D. Positie t.o.v. peers

| | DeepSeek Harness | Pi (§76) | Cursor (§69–§75) |
|--|------------------|----------|------------------|
| Extensie | Plugins (Cordis) | TS extensions/packages | Closed + hooks/MCP |
| UI | Web/desktop first | TUI/SDK first | IDE first |
| Model | DeepSeek + custom APIs | Many providers | Many + Composer |

#### Wat ik meeneem

* **Hergebruik:** plugin-grenzen + AGENTS.md + worktrees + secret redaction.  
* **Verbeterhoek lab:** structure/indexing t.o.v. standaard — DSH is breed product; niet alles overnemen (harness tax).  
* Preview-volatiliteit = risico voor “fork nu”; beter observeren + A5.  
* Geen kit; keys nooit in git.

#### Open / onduidelijk

* Cordis-paper (arxiv 2608.25512) diepte → fundament als A4/A5 dat vraagt.  
* Exacte default tool-set per profile.

---

## §78. Cline — open agent runtime (IDE / CLI / desktop / SDK)

**Type:** Repo + product · **URL:** [https://github.com/cline/cline](https://github.com/cline/cline) · [https://cline.bot/](https://cline.bot/)

- **Kern:** Open-source coding agent (**Apache 2.0**) als **gedeelde runtime** achter VS Code-extension, CLI, desktop (Tauri), JetBrains-client, SDK. Human-in-the-loop diffs/commands; Plan/Act; MCP + plugins. Peer voor **editor-extension-route** (A4).  
- **Arch (overview):** WebviewProvider → Controller (state/tasks) → Task (API + tools); HostProvider abstrahert VS Code/CLI/desktop; webview↔core via typed messages / gRPC-achtige Protobus.

#### A. Productvlakken

| Surface | Rol |
|---------|-----|
| VS Code / JetBrains | Sidebar agent, diffs, approvals |
| CLI | Interactive + headless/CI (`cline --json`) |
| Desktop | Sessions per folder, schedules |
| SDK `@cline/sdk` | Eigen agents, tools, teams |

#### B. Agent-gedrag (claims README)

* Projectbrede edits; monitort linter/compiler; checkpoints/undo.  
* Bash + long-running processes (reageert op output).  
* **Plan** (verkennen/vragen) vs **Act** (uitvoeren); auto-approve optioneel.  
* Rules: `.clinerules`; skills voor on-demand rules.  
* Multi-provider (Anthropic, OpenAI, Gemini, OpenRouter, Bedrock, Ollama, …).  
* MCP + programmatic plugins (tools + lifecycle hooks).  
* Multi-agent teams; cron schedules; chat-connectors (Slack/Telegram/…).

#### C. Lab-relevant

* Extension-in-bestaande-IDE = alternatief voor full fork / terminal-only.  
* Checkpoints + Plan/Act = A7-achtige veiligheidspatronen.  
* `.clinerules` ≈ Rules/AGENTS — vergelijk met kit-AGENTS (P10).

#### Wat ik meeneem

* **A2/A4:** Cline = referentie “host abstraction + shared core”.  
* Niet default-stack; wel assen voor A5-matrix (approval, plan/act, SDK).  
* Geen kit.

#### Open / onduidelijk

* Hoe strikt HostProvider parity CLI vs VS Code is in praktijk.  
* Benchmarks vs Cursor/Pi — A5.

---

## §79. OpenCode — terminal-first open coding agent (anomalyco)

**Type:** Docs + repo · **URL:** [https://opencode.ai/docs/](https://opencode.ai/docs/) · repo: [https://github.com/anomalyco/opencode](https://github.com/anomalyco/opencode) (was sst/opencode)

- **Kern:** Open-source coding agent (MIT), primair **TUI**; ook desktop/IDE-integratie. Provider-keuze (75+ claim via community-samenvatting); `AGENTS.md` (+ fallback `CLAUDE.md`); permissions; build/plan agents; subagents.  
- **Let op:** OpenCode 1 vs 2 — install-paden kunnen conflicteren (`opencode` binary).

#### A. Harness-bouwstenen (docs + community-analyse)

1. Agent loop — interactive / `opencode run` / `opencode serve` (OpenAPI).  
2. Tools — files, search, bash, webfetch; MCP in `opencode.json` (local/remote).  
3. Context — `AGENTS.md`; extra instructions/globs in config.  
4. State — `--continue` / `--session` / `--fork`; server mode.  
5. Permissions — per actie allow/ask/deny (laatste match wint).  
6. Verification — `/undo` `/redo`; plan-agent beperkt edits.  
7. Orchestratie — primary **build** vs **plan** (Tab); subagents general/explore/(scout); custom agents als markdown under `.opencode/agents/`.

#### B. Workflow-claims (docs)

* `/init` → analyseert project, schrijft `AGENTS.md` (commit aanbevolen).  
* Plan mode: geen edits tot akkoord; dan Build.  
* `@` file fuzzy search in prompts.

#### Wat ik meeneem

* Duidelijke **permission + plan/build**-scheiding = overneembaar patroon voor lab (veiligheid zonder Cursor).  
* AGENTS.md-first = alignment met kit.  
* Terminal-first peer naast Pi; Cline = IDE-first.  
* Geen kit; V1/V2-installchaos = les voor eigen CLI-naming.

#### Open / onduidelijk

* Officiële “7 building blocks”-pagina vs community-herformulering — cijfers/providers verifiëren op opencode.ai bij A5.  
* Scout-subagent overal aanwezig?

---

## §80. Artificial Analysis Coding Agent Index (benchmarks + cost)

**Type:** Leaderboard / methodologie · **URL:** [https://artificialanalysis.ai/agents/coding-agents](https://artificialanalysis.ai/agents/coding-agents) · methodologie: [https://artificialanalysis.ai/methodology/coding-agents-benchmarking](https://artificialanalysis.ai/methodology/coding-agents-benchmarking)

- **Kern:** Publieke **coding-agent** benches die **model + harness + settings** samen meten (niet “het model alleen”), plus **cost / tokens / wall-time**. Voor spoor 3: A5-anker en steun voor “DeepSeek via API = sterke kost/prestatie” — zonder meteen frontier-stack te kiezen.  
- **Index v2.0:** gelijk gewicht over 3 componenten; per taak **3 attempts**, dan taak-genormaliseerd gemiddelde.

#### A. Drie componenten (~290 taken)

| Eval | Focus | Taken | Scoring (samenvatting AA) |
|------|-------|-------|---------------------------|
| **FrontierCode v1.1** (Cognition) | SE op echte OSS-repo’s; “zou maintainer mergen?” | 100 (private set) | Blocking fail → 0; anders 70–100%; reward-hacking-scan → 0 |
| **Terminal-Bench 4.0** (Laude) | Agentic terminal/workflows | 66 | Pass/fail, pass@1 |
| **SWE-Atlas-QnA-AA** (Scale + AA-grading) | Repo Q&A / uitleg | 124 | Binary pass/fail (Task Resolve Rate-achtig); AA paste rubric/judge |

* Verschillende vaardigheden: Q&A ≠ patch-execution ≠ terminal — index alleen + per-bench lezen.

#### B. Wat ze ook rapporteren (naast score)

* **Cost/task** — pay-per-token API (input, cache, cache-write, output); **niet** Cursor-abonnement of infra.  
* **Tokens/task** — input / cached / output; cache-hit beïnvloedt kost sterk.  
* **Wall time/task** — actieve agent-runtime (niet env-startup/verifier).  
* Safety refusals; reward hacking (FrontierCode).  
* **Harness Comparison**-tab: “Coming soon” (stand fetch) — later relevant voor A5.

#### C. Cost-frontier (AA aankondiging Index v2.0 — claims)

Uit Artificial Analysis’ eigen samenvatting bij v2.0-release (LinkedIn/changelog-achtig; cijfers **snapshot**, herverifiëren op de live charts):

| Config (claim) | Index | ~$/task |
|----------------|-------|---------|
| Codex + **DeepSeek V4.1 Flash** (max) | **47.3** | **$0.39** |
| Codex + GPT-6.1 Sol (max) | 54.1 | $1.50 |
| Codex + GPT-6 Astra (max) | 54.7 | $7.04 |
| Claude Code + Claude Opus 5.5 (max) | **61.7** (toen lead) | $11.42 |

* Opus leidt kwaliteit; DeepSeek-Flash op Codex zit op de **goedkope** Pareto-kant: lagere score, ordes-lager in $/task.  
* In de agent-filter van de site komen o.a. `codex-deepseek-v4-1-flash-…` en `deepseek-harness-deepseek-v4-1-flash-…` voor — harness×model-varianten, niet “DeepSeek alleen”.

#### D. Leesregels (AA zelf)

* Variant = agent + model + settings; zelfde productnaam ≠ zelfde rij.  
* Hoger index ≠ best voor jouw workflow (IDE, latency, lokale keys).  
* Vergelijk binnen gepubliceerde suite/versie; methodologie evolueert (v1.5→v2.0: DeepSWE → FrontierCode).

#### Wat ik meeneem

* **Spoor 3:** bevestigt lab-richting **eigen DeepSeek API-key** (CONTEXT/RULES): niet omdat frontier wint, maar omdat **$/kwaliteit** op publieke agent-benches aantrekkelijk is.  
* A5-matrix: assen = Index + $/task + tokens + wall-time + harness-variant (§77 DSH vs Codex+DeepSeek vs Pi+…).  
* Geen ADR “we kiezen DeepSeek als enige model”; wel hypothese: default-provider = goedkoop/sterk genoeg, frontier optioneel later.  
* Geen kit.

#### Open / onduidelijk

* Exacte live-cijfers op jouw URL-filter wijzigen; altijd charts herladen vóór citatie in matrix.  
* Of DeepSeek **Harness** (§77) vs Codex+DeepSeek-model systematisch verschilt op AA (Harness Comparison nog “soon”).  
* Subscription vs API-kost voor Cursor/Claude Code niet in deze $/task.
* Cross: scaffold/harness-disclosure papers **§81–§82**; Meta-Harness + SWE-Pro matrix **§83**; Harness-Bench **§84**; Arena HarnessTax **§85**.

---

## §81. Stop Comparing LLM Agents Without Disclosing the Harness (Zhang et al.)

**PDF:** [`pdfs/Yunbei-Zhang_Stop-Comparing-LLM-Agents-Without-Disclosing-Harness.pdf`](pdfs/Yunbei-Zhang_Stop-Comparing-LLM-Agents-Without-Disclosing-Harness.pdf)

**Type:** Position paper (arXiv) · **URL:** [https://arxiv.org/abs/2605.23950](https://arxiv.org/abs/2605.23950) · HTML: [https://arxiv.org/html/2605.23950v1](https://arxiv.org/html/2605.23950v1)

- **Kern (Binding Constraint Thesis):** Op long-horizon agent-taken met vergelijkbare frontier-modellen is de **execution harness** (context, tools, orchestration, verification) vaak een **sterkere determinant** van performance dan het model. Scores zonder harness-disclosure misattributeren gains aan “het model”.  
- **Framing:** closed-loop — harness = controller \(\mathcal{C}_H\); LLM = open-loop policy \(\pi_\theta\) die alleen \(c(s_t)\) ziet.

#### A. Bewijs uit publicaties (paper)

* Terminal-Bench 2: zelfde model, andere harness → pass@1 **69.7% → 77.0%** (cite in paper).  
* Derde-partij monitoring: tot **~15 pp** scaffold-only op SWE-bench Verified.  
* SWE-bench Pro: Claude Opus 4.5 **45.9%** (SEAL scaffold) vs **55.4%** (Claude Code); WarpGrep-subagent kan ranking MiniMax↔Opus omdraaien.  
* HAL: tot bijna **48 pp** swing voor één model over scaffolds.  
* Typische “model advances” in papers: vaak slechts **2–4 pp** — dwarrelen naast harness-gaten.

#### B. Binding Constraint / variantie

\[
\mathrm{Var}(B)=\mathrm{MV}+\mathrm{HV}+\mathrm{interaction}
\]

* Thesis: HV (+ interactie) vaak ≥ MV.  
* Valid vergelijking: **locked harness** (één H voor alle M) of **factorial** (M×H grid + HV/MV/reversals rapporteren).

#### C. Controller-kwantiteiten (niet model)

* **Stability** — progress non-decreasing onder update-rule.  
* **Context drift** — hoe snel task-info het venster verlaat.  
* **Control lag** — stappen tussen anomalie en correctie.

#### D. Voorstel framework

* Disclosure-standaard (ETCSOVG-kaart in appendix).  
* Variance-decomposition protocol + perturbation stress-tests.

#### Wat ik meeneem

* **A5/lab:** nooit “Pi vs Cursor” zonder H×M-cel; matrix = pairs.  
* Verbetert spoor-3-hypothese: **structure/indexing in harness** kan meer waard zijn dan model-upgrade.  
* Cross §80 (AA al H×M), §82–§85. Geen kit.

#### Open / onduidelijk

* Empirische HV>MV hangt van regime (frontier vs mid); Arena HarnessTax (§85) vindt op sommige benches vooral **cost**-effect.

---

## §82. The Scaffold Effect in Coding Agents (Vats & Golev)

**PDF:** [`pdfs/Naman-Vats_The-Scaffold-Effect-In-Coding-Agents.pdf`](pdfs/Naman-Vats_The-Scaffold-Effect-In-Coding-Agents.pdf)

**Type:** Paper (arXiv) · **URL:** [https://arxiv.org/abs/2607.22585](https://arxiv.org/abs/2607.22585)

- **Kern:** Op Terminal-Bench Pro (50 taken, 2 models × 3 OSS-harnesses): harness → tot **40×** tokens per *solved* task; pass@1-verschillen binnen model klein (**0–8 pp**, CI’s vaak 0). Failure **fingerprints** herhalen over models → scaffold-property.  
- Unit van vergelijking: **harness–model pair**; no-action turns = wait/oversight-tax.

#### A. Setup

* Models: Qwen 3.6 Plus, MiniMax M2.5 (OpenRouter).  
* Harnesses: **Goose**, **OpenCode**, **OpenHands-SDK** (Harbor).  
* 300 trials; 8 archetypes (BUG/BUILD/DATA/…).

#### B. Resultaten (abstract/intro)

* Token/solved gap tot **40×**.  
* Pass-rate paired gaps klein.  
* Fingerprints: Goose≈REASON; OpenHands≈VERIFY/MAX_TURNS; OpenCode≈idle-loop/TIME.  
* Cite TB2.0: Opus 4.5 **52.1% vs 57.8%** harness A/B met **256.9M vs 3.9M** input tokens (~**65×**) voor +5.7 pp.

#### C. Aanbeveling

* Kies pairs onder token/latency-budget; rapporteer tokens, latency, **volle harness-spec**.

#### Wat ik meeneem

* Efficiëntie ≠ accuracy: lab moet **tokens/$** meten (make bench / meten/).  
* OpenCode failure-mode (idle) = waarschuwing bij §79.  
* Geen kit.

#### Open / onduidelijk

* Anoniem supplementary repo; exacte tabellen in PDF.

---

## §83. Meta-Harness + “How much is the harness worth?” (SWE-bench Pro)

**PDF (Meta-Harness):** [`pdfs/Yoonho-Lee_Meta-Harness.pdf`](pdfs/Yoonho-Lee_Meta-Harness.pdf)

**Type:** Paper + repo + experiment · **URL paper:** [https://arxiv.org/abs/2603.28052](https://arxiv.org/abs/2603.28052) · **URL repo:** [https://github.com/JoelNiklaus/harness-optimization](https://github.com/JoelNiklaus/harness-optimization) · Space: [https://huggingface.co/spaces/joelniklaus/harness-optimization](https://huggingface.co/spaces/joelniklaus/harness-optimization) · sectie: [How Much Is The Harness Worth?](https://github.com/JoelNiklaus/harness-optimization#how-much-is-the-harness-worth-swe-bench-pro)

- **Meta-Harness (Lee et al.):** outer-loop die **harness-code** zoekt (agentic proposer + filesystem van prior candidates/traces). Claims: text-class +7.7 pts @ 4× minder context-tokens; RAG-math +4.7 pts over 5 held-out models; agentic coding > hand baselines op TerminalBench-2.  
- **Coding/SWE-bench Pro-arm (JoelNiklaus fork):** 10 harnesses × 2 models × 250 held-out taken — “geen beste harness, alleen beste **pairing**”.

#### A. SWE-Pro grid (claims README / X-thread)

Models: **GLM-5.2** 744B-A40B (FP8) vs **Gemma 4** 26B-A4B (BF16). Harnesses o.a. mini_swe_agent, codex, claude_code, qwen_code, hermes, openclaw, crush, opencode, **pi**, goose.

| harness | GLM pass@1 | GLM out/task | Gemma pass@1 | Gemma out/task |
|---------|------------|--------------|--------------|----------------|
| mini_swe_agent | 52.4% (46.2–58.5) | 93k | 28.4% | 56k |
| codex | 49.6% | **621k** | 20.8% | 117k |
| claude_code | 47.6% | 32k* | 24.4% | 101k |
| qwen_code | 41.6% | 80k | 26.8% | 39k |
| hermes | 39.6% | 102k | 27.6% | 146k |
| openclaw | 38.4% | **16k** | 21.6% | 60k |
| crush | 32.0% | 41k | **36.0%** | 39k |
| opencode | 28.0% | 44k | 33.2% | 48k |
| **pi** | 25.6% | 41k | 28.0% | 32k |
| goose | 23.2% | 33k | 15.2% | 35k |

\*Thread/figuur noemt soms andere out/task voor claude_code — bij twijfel HF-dataset `joelniklaus/CodingBenchmarkResults` raadplegen.

* Range GLM: **23.2→52.4%**; Gemma: **15.2→36.0%** door alleen harness te wisselen.  
* Spearman rank-correlatie harness-ranking over models ≈ **−0.05** (geen transfer).  
* Vendor-harnesses (codex/claude_code) sterk op groot model, vallen op klein; **crush** Pareto op Gemma (~36% @ ~$0.30); Gemma+crush > GLM in diens slechtste harnesses bij ~**$0.30 vs $3.61**/task (thread-claim).  
* ~**39×** spreiding output tokens (16k–621k). **97%** input ≈ conversation prefixes → prompt caching kritiek.  
* Thinking-off op Gemma: crush/opencode/pi verliezen ~⅔ score; claude_code beweegt weinig (lead, geen full result).

#### B. Meta-Harness framework

* Zoekt harness-code, niet weights.  
* Proposer ziet prior source/scores/traces via filesystem.  
* Reference: text_classification, terminal_bench_2; legal_agent_bench blog *Don't Train the Model, Evolve the Harness*.

#### Wat ik meeneem

* **Kern voor lab:** investeer in **H×M-fit** (DeepSeek + dunne Pi-achtige harness) i.p.v. alleen frontier.  
* Pi/OpenCode in matrix = peers (§76/§79); rankings **niet** overdraagbaar.  
* Caching/prefix = ontwerpconstraint (zie Cursor §72).  
* Geen kit; Meta-Harness outer-loop = later experiment, niet dag-0.

#### Open / onduidelijk

* Exacte $-labels op figuur vs tabel out/task.  
* Of DeepSeek-modellen in deze 10×2 grid zitten (hier GLM/Gemma).

---

## §84. Harness-Bench (TheLime1)

**Type:** Repo / leaderboard · **URL:** [https://github.com/TheLime1/harness-bench](https://github.com/TheLime1/harness-bench) · site: [https://thelime1.github.io/harness-bench/](https://thelime1.github.io/harness-bench/)

- **Kern:** Leaderboard die vraagt *welke harness haalt het meeste uit een model*, niet alleen welk model. Genormaliseerde YAML-runs + GitHub Pages. Status: early v1 / community submissions.

#### A. Wat een run vastlegt

* harness id/version/config; model + intelligence level; benchmark + split; score/uncertainty/tasks; cost, wall-time, tokens; execution command; artifacts; **trust tier** (self_reported / artifact_complete / maintainer_verified).

#### B. Seed suites

* Terminal-Bench 2.1, SWE-bench Verified, Aider Polyglot — uitbreidbaar via registry YAML.

#### Wat ik meeneem

* Datamodel voor onze A5-matrix / eventueel `meten/`.  
* Trust tiers = goede discipline. Geen kit.

#### Open / onduidelijk

* Dekte van seed-data t.o.v. AA (§80) / Joel grid (§83).  
* Naam-botsing: PKU-paper **Harness-Bench** = **§133** (andere benchmark).

---

## §85. HarnessTax (Arena) — cost vs correctness

**Type:** Research blog · **URL:** [https://arena.ai/blog/coding-agents-harness-tax](https://arena.ai/blog/coding-agents-harness-tax) · cite: [https://harnesstax.github.io/](https://harnesstax.github.io/)

- **Kern:** 21 model–harness pairs (7 models × **Claude Code / Codex CLI / Pi**) op SWE-bench Lite + Terminal-Bench 2.0 (30 taken × 3 attempts). Op deze benches: harness beïnvloedt **kosten** sterk, **success** weinig; **Pi** (4 tools: read/write/edit/bash) op Pareto; models vaak beter *buiten* vendor-harness.

#### A. Bevindingen

1. Zelfde model ≈ zelfde success, tot **~5×** kost; Fable 5: Claude Code **$1.33** vs Pi **$0.67** (~2×) bij ~97% success.  
2. Geo-mean: Claude Code ~**2.0×** Pi / **1.6×** Codex (SWE Lite); ~**1.5×** Pi (TB2.0). Success-effect harness ±2% / ±5%.  
3. Claude Code **initieel context >10×** Pi → harness tax vanaf call 1.  
4. 9/12 Anthropic/OpenAI-vergelijkingen: **andere** harness wint success. Voorbeeld: GPT-5.6 Sol TB2.0 Pi **83.3% @$0.42** vs Codex **78.9% @$0.76**.

#### B. Nuance t.o.v. §81/§83

* Hier: cost-dominant, success-flat (Lite/TB2.0 sample).  
* Joel SWE-Pro (§83): success **wél** sterk harness-afhankelijk + ranking flip. → **workload-afhankelijk**.

#### Wat ik meeneem

* Lab-default **minimale harness (Pi-achtig) + goedkoop model (DeepSeek)** is empirisch verdedigbaar.  
* “Harness tax” = P25-taal. Geen kit.

#### Open / onduidelijk

* 30-task sample; contamination-risico op open benches (auteurs erkennen).

---

## §86. Community: harness als bottleneck + BenchGen (Reddit)

**Type:** Forumcommentaar · **URL context:** discussie bij harness/SWE-Pro-posts; product genoemd: [https://benchgen.com/](https://benchgen.com/)

- **Kern (parafrase comment):** Community hypergefocust op foundation models; harness (context limits, semantic caching, tool routing) is vaak de echte bottleneck. Topmodel in brittle harness faalt waar kleiner model in robuste setup slaagt (long-horizon). Evaluatie vraagt consistente scoring + task-simulatie — standaard model-leaderboards dekken dat niet. BenchGen claimt end-to-end agent-configs (o.a. OpenClaw, Hermes) te tracken: trajectory adherence, token efficiency, task success; aanbod matrix-testing.

#### Wat ik meeneem

* Richting bevestigt §81–§85; BenchGen = kandidaat-tool voor A5 (**Assess**, niet Adopt) — verifiëren onafhankelijk.  
* Geen kit; geen vendor-lock zonder meting.

#### Open / onduidelijk

* Reddit-thread-URL niet als permanente cite; methodologie BenchGen open?

---

## §87. Technical writing in the agentic era (Joel Niklaus)

**Type:** Blog · **URL:** [https://huggingface.co/blog/joelniklaus/technical-writing-in-the-agentic-era](https://huggingface.co/blog/joelniklaus/technical-writing-in-the-agentic-era)

- **Kern:** Met coding agents is tekst goedkoop; schaars = **editorial**. Lead with strongest result; write around visuals; inspect agent-prose zoals agent-code; workflow: resultaat→visual→prose→citation pass.

#### Wat ik meeneem

* Voor AE `bron/` + lab docs (A8): dichte § met cijfers/figuren eerst — past youtube-prompt.  
* A8 formaat×publiek: **§123–§127**.  
* Geen kit.

---

## §88. Switzerland Does Top AI Research, but Too Little of It Stays (Joel Niklaus)

**Type:** Blog / data essay · **URL:** [https://huggingface.co/blog/joelniklaus/swiss-ai-research](https://huggingface.co/blog/joelniklaus/swiss-ai-research) · data: HF `joelniklaus/swiss-ai-research`

- **Kern:** CH sterk in papers/capita (2023–25); weinig private AI-investment/capita vs IL/US; veel exits naar buitenland; daling CH PhD’s exact sciences. Beleidsaanbevelingen (funding, VC, first customer, industry PhD).

#### Wat ik meeneem

* **Niet** core A1–A5; wel context ecosystem/industrie. Lab: focus blijft harness×model, niet geo-policy.  
* Geen kit.

#### Open / onduidelijk

* Affiliation-noise (OpenAlex) — auteur noemt limitations.

---

# Loop Engineering


## §26. What Is Loop Engineering? (IBM Technology)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=DQBqh6gcx7U](https://www.youtube.com/watch?v=DQBqh6gcx7U)

In deze video wordt **Loop Engineering** ontleed als het overkoepelende systeem dat gebouwd is rondom de repetitieve agentic loop. Waar *Prompt Engineering* vraagt om menselijke invoer bij elke stap, automatiseert Loop Engineering de evaluatie en hervatting van de cyclus.

```
                             DE AGENTIC LOOP ANATOMIE
   [ Trigger (Hook/Cron) ]
             │
             ▼
      ┌────────────┐        Action         ┌────────────┐
      │   Goal     │ ────────────────────> │   Action   │ (Tools / MCP)
      └────────────┘                       └────────────┘
            ▲                                    │
            │                                    ▼
      ┌────────────┐        Observe        ┌────────────┐
      │   Adjust   │ <──────────────────── │  Observe   │ (Sub-agent Checker)
      └────────────┘                       └────────────┘

```

#### A. De 4 Basisfasen van de Loop

1. **Goal:** De specifieke, verifieerbare eindconditie (bijv. *"Stop wanneer alle unit-tests van de checkout slagen"* - vermijd vage doelen zoals *"Maak de code beter"*).
2. **Action:** De fysieke actie (bestand bewerken, API/MCP-aanroep).
3. **Observe:** Het opvangen van de output (test-resultaten, logs).
4. **Adjust:** Bijstellen of afsluiten op basis van de observatie.

---

#### B. De 6 Bouwstenen van Loop Engineering Infrastructure

1. **Triggers (Schedules & Hooks):** Tijdgebaseerd (Cron) of event-driven (GitHub PR, Webhooks) starten van de lus.
2. **Context Management:** Het bijsnijden, comprimeren of via skills stapsgewijs vrijgeven (*progressive disclosure*) van de opgestapelde data.
3. **The Spine (Persistent State):** Een centrale status (vaak Markdown-bestanden) waar de agent vastlegt wat hij heeft geprobeerd en wat wel/niet werkte.
4. **Tools & Connectors (MCP):** Standaardinterfaces waarmee de agent acties in de echte wereld uitvoert.
5. **Sub-Agent Verification:** Het inzetten van een *gescheiden* agent (vaak een ander model) om de gecontroleerde actie objectief te valideren.
6. **Human-in-the-Loop Safeguards:** De menselijke interventie die noodzakelijk blijft om gevaarlijke valkuilen te voorkomen.

---

#### C. De 3 Risico's van Volledige Automatisering (De 'Schulden')

1. **Comprehension Debt (Begripsschuld):**
* De kloof tussen de hoeveelheid code in een systeem en de mate waarin menselijke ontwikkelaars deze nog begrijpen. Bij calamiteiten in productie kan niemand het systeem meer herstellen.


2. **Intent Debt (Intentieschuld):**
* De agent maakt code die technisch werkt (tests slagen), maar die ingaat tegen de zakelijke intentie (bijv. een test laten slagen door kortingscodes niet meer te valideren). Mensen moeten de *intentie* (in bijv. `AGENTS.md`) blijven voeden.


3. **Cognitive Surrender (Cognitieve Overgave):**
* Het fenomeen waarbij ontwikkelaars blindelings accepteren wat de loop genereert, wat de *Comprehension Debt* tot kritieke hoogten drijft.


---


---

## §27. Loop Engineering Explained in 8 min (Caleb Writes Code)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=4biXYSNkn9Y](https://www.youtube.com/watch?v=4biXYSNkn9Y)

Caleb biedt een helder overzicht van de **hiërarchische stapeling** van engineering-disciplines en legt uit waarom *Loop Engineering* de logische opvolger is van Harness Engineering.

```
                       DE INGENIEURSHIËRARCHIE

 ┌──────────────────────────────────────────────────────────────────┐
 │ 4. LOOP ENGINEERING: Self-prompting, triggers & continue loops   │
 ├──────────────────────────────────────────────────────────────────┤
 │ 3. HARNESS ENGINEERING: Runtime, buiten-context sturing          │
 ├──────────────────────────────────────────────────────────────────┤
 │ 2. CONTEXT ENGINEERING: Tool-calls & RAG in het context window   │
 ├──────────────────────────────────────────────────────────────────┤
 │ 1. PROMPT ENGINEERING: Tekstuele instructies aan het model       │
 └──────────────────────────────────────────────────────────────────┘

```

#### A. De Evolutie van de Engineering-Lagen

1. **Prompt Engineering:** Statische tekstuele instructies in de prompt (*"Je bent een klantenservice medewerker"*).
2. **Context Engineering:** De agent de autonomie geven om via tools/RAG zijn eigen context window te vullen met bestanden en DB-data.
3. **Harness Engineering:** Externe runtimes/systemen buiten het context window die taken opbreken, de context-samenvoeging beheren en sessies stabiliseren bij taken van $>10$ minuten.
4. **Loop Engineering:** Een overkoepelende laag boven de Harness die **de menselijke prompt-initiatie volledig vervangt**.

---

#### B. De Essentie van Loop Engineering: Self-Prompting & Continuïteit

* **De Vernieuwing:** Bij alle eerdere lagen moet een *mens* de opdracht geven (*"Clone deze site"*, *"Los deze bug op"*).
* **Loop Engineering:** Het bouwen van een steiger (*scaffolding*) waarin het systeem **zichzelf prompt** en continu onderhoudt op basis van gebeurtenissen in de echte wereld (bijv. elk uur automatisch World Cup-scores ophalen, bugs uit logs vissen, via worktrees/git-branches verwerken en PR's openen).

---


---

# Graph Engineering


## §28. Graph Engineering Explained in 8 min (Caleb Writes Code)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=mBePcvqLX88](https://www.youtube.com/watch?v=mBePcvqLX88)

Caleb legt uit hoe de overgang van een enkele agent naar een **dynamische graaf van meer dan 100 gespecialiseerde agents** (zoals in de *Deep Research* feature van Claude Code) de nieuwste doorbraak is in agentic workflows.

```
                     EVOLUTIE VAN HET AGENT-PARADIGMA

  SINGLE AGENT (Cursor/Roo)        ──>        GRAPH ENGINEERING (Claude Code)
┌────────────────────────────┐              ┌────────────────────────────────────┐
│ • Één reusachtig Context   │              │ • 100+ Lichte, gespecialiseerde    │
│   Window.                  │              │   Agents (Nodes).                  │
│ • Geheugen raakt snel      │              │ • Vaste/Dynamische stroom van      │
│   vervuild (Context Rot).  │              │   data en taken (Edges/DAG).       │
└────────────────────────────┘              └────────────────────────────────────┘

```

#### A. Wat is Graph Engineering?

* **Wiskundige Oorsprong:** Gebaseerd op Euler's Graaftheorie (1736, Zeven brggen van Koningsbergen). Een graaf bestaat uit **Nodes** (punten) en **Edges** (verbindingen).
* **Graph Engineering:** Het opbreken van een hele complexe taak in een netwerk van gespecialiseerde LLM-nodes die via edges data en opdrachten uitwisselen.
* **DAG (Directed Acyclic Graph):** De meest voorkomende vorm bij research- en code-agents. De gegevensstromen lopen enkel vooruit van fase naar fase zonder terugkerende lussen (acyclisch).

---

#### B. De 5 Fasen van een Deep Research Graph (100+ Agents in Claude Code)

Claude Code genereert on-the-fly een JavaScript-runtime script (bijv. 420+ regels) om dynamisch een graaf op te bouwen:

```
 ┌──────────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────┐
 │ Fase 1:      │     │ Fase 2:      │     │ Fase 3:      │     │ Fase 4:      │     │ Fase 5:      │
 │ Scoping Agent│ ──> │ 5 Web-Search │ ──> │ 25 Data-Fetch│ ──> │ 75 Fact-Check│ ──> │ 1 Synthesis  │
 │ (1 Node)     │     │ Agents       │     │ Agents       │     │ & Vote Agents│     │ Report Agent │
 └──────────────┘     └──────────────┘     └──────────────┘     └──────────────┘     └──────────────┘

```

1. **Fase 1 (Scoping):** 1 agent analyseert de vraag en splitst deze op in subthema's.
2. **Fase 2 (Discovery):** 5 agents zoeken tegelijkertijd naar betrouwbare bronnen op het web.
3. **Fase 3 (Extraction):** 25 agents halen in parallel de inhoud van alle sites op.
4. **Fase 4 (Verification & Voting):** 75 agents controleren de feiten, verifiëren de claims cross-bronnig en stemmen over de betrouwbaarheid.
5. **Fase 5 (Synthesis):** 1 finale agent voegt alle geverifieerde data samen in één gestructureerd eindrapport.

---

#### C. Waarom Graph Engineering Werkt (en wat het kost)

* **Voordeel 1: Extreme Snelheid via Parallellisatie:** Tientallen agents voeren hun werk tegelijk uit in plaats van sequentieel.
* **Voordeel 2: Separation of Concerns & Context Isolatie:** Elke sub-agent heeft zijn eigen, kleine context window ($\approx 20\text{k}$ tokens). Dit voorkomt *Context Rot* en vervuiling van het geheugen.
* **Het Kostenprobleem:** Eén agent gebruikt $4\times$ meer tokens dan een chat, een multi-agent graaf $15\times$ meer. 108 agents met elk $20\text{k}$ tokens startcontext zou zonder cachen $\approx \$10$ kosten per prompt op Opus.
* **De Enabler:** **Prompt Caching** verlaagt de kosten van de reusachtige opgeslagen system-prompts naar $\approx \$1$, waardoor dit grafen-model commercieel haalbaar wordt.

---


---


# Workflow & Specs

## §1. Complete AI Coding Workflow (`mattpocock/skills`)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=M6mYodf0dJM](https://www.youtube.com/watch?v=M6mYodf0dJM)

Deze video fixeert zich op het oplossen van de **context-degradatie** en **entropie** die optreden wanneer ontwikkelaars LLM's willekeurig code laten genereren. Matt Pocock bouwt een theoretisch onderbouwd proces waarin een ontwikkelaar van een vage gedachte naar geverifieerde productiecode beweegt.

#### A. Theoretische Fundamenten & Kernprincipes

1. **De 'Smart Zone' van Context Windows (Token Economy)**
* **Probleem:** Grote taalmodellen (LLM's) hebben weliswaar context windows van honderden duizenden tokens, maar vertonen na verloop van tijd *attention degradation* of *lost in the middle*-verschijnselen. Rond 140.000 tokens neemt het vermogen tot scherp redeneren en hallucinatievrij coderen drastisch af.
* **Theorie:** Een AI-coderingssessie moet beschouwd worden als een schaars budget. Eén unbroken context window moet exact één logische eenheid aan werk bevatten. Zodra het doel bereikt is of de limiet van de *smart zone* nadert, moet de context geleegd worden.


2. **Demping van Context Load (User-Invoked vs. Model-Invoked)**
* Veel AI-skill-frameworks laden tientallen skill-beschrijvingen permanent in de *system prompt* of *agent context*, wat kostbare tokens verbruikt en ruis veroorzaakt. Pocock kiest er bewust voor om skills **User-Invoked** te maken (aangeroepen door de gebruiker via bijv. `/grill-with-docs`), zodat de agent enkel met de actuele taakbelasting in zijn geheugen draait.


3. **Stateful Knowledge Capture (ADR's & Domain Docs)**
* Doordat context windows tijdelijk zijn, moet opgedane kennis persistent worden opgeslagen in de repository zelf. Dit gebeurt via Architectural Decision Records (ADR's) en een centrale `context.md`. Zo blijft het project geheugen behouden over meerdere, gescheiden AI-sessies heen.


---

#### B. De Vier Fasen van de Pipeline

```
[ Idee ] ──> 1. Grill with Docs ──> 2. To Spec ──> 3. To Tickets ──> 4. Implement & Sub-agent Review ──> [ PR / Commit ]

```

##### Fase 1: `grill-with-docs` (De Dialectische Verkenning)

* **Doel:** Het overbruggen van de kloof tussen een vaag idee en een uitvoerbaar ontwerp.
* **Werking:** De AI werkt niet als een passieve uitvoerder, maar als een kritische interviewer. Hij analyseert de codebase en stelt vragen over randgevallen, architectuurkeuzes en *test seams* (de raakvlakken waar getest kan worden) totdat er een gedeeld begrip is bereikt.

##### Fase 2: `to-spec` (De Context-Compressie)

* **Doel:** Het omzetten van een lange interview-discussie naar een duurzame specificatie.
* **Werking:** De AI vat het volledige transcript samen in een gestructureerd document met een probleemstelling, gekozen oplossingsrichting, *user stories* en randvoorwaarden. Dit document dient later als de *Single Source of Truth* om het eindresultaat tegen te toetsen.

##### Fase 3: `to-tickets` (Slicing in Smart Zones)

* **Doel:** De specificatie opbreken in werkpakketten die exact binnen één *smart zone* (één schone context window) passen.
* **Werking:** Een te grote taak veroorzaakt hallucinaties tijdens de implementatie. Door de specificatie op te splitsen in kleinschalige, afgebakende tickets wordt gegarandeerd dat elke AI-sessie gefocust en effectief blijft.

##### Fase 4: `implement` & De Sub-Agent Review Pattern

* **Doel:** Veilige code-generatie en objectieve kwaliteitsbewaking.
* **Theorie van Sub-Agents:** Een AI die net 500 regels code heeft geschreven, is blind voor zijn eigen fouten doordat de gegenererde tokens zijn redenering beïnvloeden.
* **Werking:** De `implement`-skill voert de code uit, maar lanceert vervolgens **geïsoleerde sub-agents** met een schone context window. Deze sub-agents voeren twee onafhankelijke controles uit:
1. *Spec Compliance Check:* Komt de code exact overeen met de acceptatiecriteria in de specificatie?
2. *Code Quality & Anti-Smell Check:* Voldoet de code aan de lokale en algemene architectuurnormen (bijv. Martin Fowler's code smells)?


---


---

## §4. `/wayfinder`: Nothing is too big to plan anymore (Matt Pocock)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=F3lL98Pj90o](https://www.youtube.com/watch?v=F3lL98Pj90o)

In deze video presenteert Matt Pocock de **`wayfinder`**-skill, een theoretisch en praktisch kader om grootschalige, complexe softwareprojecten te plannen en uit te voeren zonder dat de agent verdwaalt in een te grote context of dat er sprake is van *Upfront Waterfall Planning*.

```
                                  DE WAYFINDER MAP
      [ Startidee ] ──> (Grilling) ───► [ Decision Frontier ]
                                               │
               ┌───────────────────────────────┼───────────────────────────────┐
               ▼                               ▼                               ▼
      [ Research Ticket ]             [ Prototype Ticket ]            [ Discussion Ticket ]
               │                               │                               │
               └───────────────────────────────┼───────────────────────────────┘
                                               ▼
                                  (Fog of War Klart Op)
                                               │
                                               ▼
                                   [ Build-Ready Spec / Tasks ]

```

#### A. Theoretische Fundamenten: Omgaan met de 'Fog of War'

1. **Context Window vs. Smart Zone bij Grote Projecten:**
* **Probleem:** Bepaalde projecten zijn te omvangrijk om in één enkele agent-sessie of *smart zone* (de optimale redeneerzone van $\approx 140\text{k}$ tokens) te bevatten. Als je probeert alles in één keer uit te stippelen, loopt het geheugen vol met aannames, waardoor de AI hallucineert of verdwaalt.
* **Theorie:** Het plannen van complexe software is een **dynamisch zoekproces** door een onzekere ruimte (*Fog of War*). Je kunt niet vanaf dag één het volledige pad naar het einddoel zien, omdat beslissing $B$ pas genomen kan worden nadat beslissing $A$ is onderzocht of getest.


2. **Graph-Based Decision Management (De Decision Frontier):**
* Wayfinder structureert een project als een gerichte grafiek van beslissingstickets (*Decision Graph*).
* **Frontier:** De set van beslissingen die *nu* genomen kunnen worden op basis van de huidige kennis.
* **Fog:** Alle afhankelijke beslissingen die geblokkeerd blijven totdat de *Frontier*-tickets zijn opgelost.


---

#### B. De Vier Beslissingstypen (*Decision Ticket Types*)

Om de *Fog of War* op te klaren, zet Wayfinder vier specifieke typen tickets in die elk in een **afzonderlijke, schone context-sessie** worden uitgevoerd:

1. **Research Tickets:** De agent gaat autonomie-gericht informatie verzamelen (bijv. een API verkennen of een codebase-analyse uitvoeren) en rapporteert de bevindingen terug naar de *Map*.
2. **Prototype Tickets:** Om te voorkomen dat het proces vervalt in *Waterfall Planning* (enkel speculeren op papier), bouwt de agent een *high-fidelity*, wegwerpbare prototype-codebase om aannames direct in de praktijk te valideren.
3. **Grilling / Discussion Tickets:** Een gerichte, dialectische interview-sessie met de ontwikkelaar om keuzes rondom architectuur of UI te verfijnen.
4. **Task / Real-World Tickets:** Externe taken die door een mens of via een externe integratie moeten worden uitgevoerd.

---

#### C. Primaire Bronnen & De Levenscyclus van een Spec

1. **Primary Source Integrity:**
* Bij traditionele planning dient een samenvattende specificatie als *Single Source of Truth*, maar verliest men de achterliggende argumentatie.
* In Wayfinder blijven alle individuele beslissingstickets bewaard in de issue-tracker (bijv. GitHub Issues, Linear, Jira). Wanneer een agent later bij de implementatie twijfelt, kan hij via referenties terugkeren naar de **primaire bron** (het oorspronkelijke discussieticket).


2. **Echte Specs zijn Niet-Persistent (*Non-Persistent Specs*):**
* In tegenstelling tot *Spec-Driven Development* (waarbij documenten voor altijd onderhouden moeten worden), dient een specificatie binnen Wayfinder puur als een **tijdelijk navigatiemiddel** om multi-sessie implementatie aan te sturen. Zodra de code geïmplementeerd, getest en gecode-reviewed is, wordt de spec gesloten en opgeruimd. De code zelf (met de tests) is de uiteindelijke waarheid.


---


---

## §6. Why Software Factories Fail (Dexter Munnelly, Human Layer)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=Ib5GBkD555M](https://www.youtube.com/watch?v=Ib5GBkD555M)

Dexter Munnelly bekritiseert de utopie van de **"Lights-Off Software Factory"** — het idee dat we code-reviews volledig kunnen afschaffen, het lezen van code kunnen schrappen en de ontwikkeling 100% autonoom door AI-agent-loops kunnen laten afhandelen.

```
                 TRADITIONELE LUS VS. LIGHTS-OFF MYTHE

  2022 Factory:     Plan/Align  ──>  Build (Mens)   ──>  Code Review (Mens) ──> Prod
  2026 Agentic:     Prompt      ──>  Build (Agent)  ──>  Code Review (Agent)──> Prod
  Lights-Off Mythe: Prompt      ──>  Build (Agent)  ──>  [ GEEN REVIEW ]    ──> Prod
                                                                │
                                                                ▼
                                                        Codebase Collapse!

```

#### A. De Oorzaak van het Mislukken: Waarom Modulen Vervallen

1. **Reinforcement Learning (RL) Mislukking op Onderhoudbaarheid:**
* **Hoe Coding-modellen Worden Getraind (bijv. SWE-bench):** Modellen worden beloond met een binaire score (1 of 0) als de gegenereerde patch ervoor zorgt dat de geautomatiseerde tests slagen.
* **Het Effect:** Modellen leren de weg van de minste weerstand. Ze schrijven lelijke `try-catch`-blokken, negeren architectuurnormen en passen *shotgun surgery* toe (willekeurige plekken aanpassen) puur om de test te laten slagen.
* **De Kostenfunctie-Kloof:** De kosten van slechte architectuur en verslechterde onderhoudbaarheid (*maintainability*) worden pas na **maanden of jaren** zichtbaar. Omdat de beloningsprikkel van RL direct plaatsvindt, kan een model niet getraind worden op het behoud van lange-termijn codekwaliteit.


2. **Het Instorten van de Codebase (Codebase Collapse):**
* Organisaties die "Lights-Off" gaan, zien op korte termijn een piek in het aantal geopende Pull Requests, maar op middellange termijn stijgt het aantal bugs per ontwikkelaar explosief, duren incidenten langer en worden codebases onbeheersbaar.


---

#### B. Het Redmiddel: Menselijke Sturing via Pre-Planning & Alignment

Omdat harness-engineering alleen een model niet kan aanleren wat "goede architectuur" is op lange termijn, moeten ontwikkelaars de "lampen weer aandoen" en focussen op de juiste **sturingsfases**:

```
  [ 1. Product Review ] ──> [ 2. System Architecture ] ──> [ 3. Program Design ] ──> [ 4. Vertical Slices ]

```

1. **Product Review:** Het definiëren van het gewenste gedrag en randvoorwaarden op functioneel niveau.
2. **System Architecture:** Component-contracten, datamodellen en systeemgrenzen opstellen.
3. **Program Design:** Het vooraf ontwerpen van interfaces, method-signatures, type-definities en *call graphs*.
4. **Vertical Slices:** Werk opdelen in afhankelijke, controleerbare stappen over de gehele stack heen, in plaats van de agent een massieve horizontale laag in één keer te laten genereren.

**Conclusie van Dexter:** 30 minuten vooraf investeren in afstemming en programma-ontwerp met behulp van AI bespaart uren aan slop-code reviewen achteraf. Menselijke ontwikkelaars moeten de eindverantwoordelijkheid over het code-ontwerp blijven dragen.

---

## §7. Full Walkthrough: Workflow for AI Coding

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=-QFHIoCo-Ko](https://www.youtube.com/watch?v=-QFHIoCo-Ko)

Met een duur van ruim anderhalf uur is dit zijn meest complete demonstratie van een end-to-end ontwikkelworkflow. Pocock combineert inzichten uit klassieke software-architectuur met de limieten van LLM-context management.

---

### 1. Theoretische Fundamenten: De LLM Token Economy

Pocock introduceert twee kerntheorieën die bepalen hoe ontwikkelaars interactie moeten zoeken met AI-agents:

```
                      DE CONTEXT WINDOW DYNAMIEK
  0 Tokens                                100k Tokens               1M Tokens
  ┌──────────────────────────────────────────┬──────────────────────────┐
  │               SMART ZONE                 │        DUMB ZONE         │
  │  • Scherpe redeneringen                  │  • Attention Degradation │
  │  • Hoge attentie / Kwalitatieve output   │  • Hallucinaties / Slop  │
  └──────────────────────────────────────────┴──────────────────────────┘

```

#### A. De 'Smart Zone' vs. de 'Dumb Zone' [[03:28](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=208)]

* **Quadratic Attention Cost:** LLM-attentie schaalt kwadratisch naarmate de context groeit. Elk toegevoegd token beïnvloedt de relatie met alle voorgaande tokens.
* **De 100k Limiet:** Ongeacht of een model een context window heeft van 200.000 of 1.000.000 tokens, de **"Smart Zone"** vervalt vrijwel altijd rond de $\approx 100.000$ tokens. [[04:04](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=244)]
* **Het Effect:** Boven deze grens treedt *attention degradation* op. Het model wordt minder scherp, negeert instructies, herhaalt fouten en genereert *"slop"* (slechte, niet-geteste code).
* **De Oplossing:** Taken moeten strikt zo gedimensioneerd worden dat ze binnen één enkele Smart Zone afgerond kunnen worden. [[04:37](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=277)]

#### B. Het 'Momento' Geheugenmodel vs. Compacting [[07:31](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=451)]

* **Compacting Is Schadelijk:** Het comprimeren van een lange conversatie (*compacting*) behoudt ruis (*sedimentation*) in het geheugen, waardoor je alsnog dicht bij de Dumb Zone blijft. [[10:36](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=636)]
* **Het 'Momento' Model:** Pocock behandelt de agent als het hoofdpersonage uit de film *Memento*: de agent vergeten alles zodra de sessie sluit.
* **Theorie:** Start elke fase met een **volledig schone context** (terug naar enkel de minimale system prompt). Geef de agent enkel de nodige, duurzaam opgeslagen bestanden mee (zoals de PRD of specifieke tickets). [[10:50](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=650)]

---

### 2. De Volledige Workflow: Van Dialectiek tot Parallelle Implementatie

Deze workflow transformeert vage wensen naar geteste productiecode via een strakke scheiding tussen **Human-in-the-Loop** (dagshift) en **AFK / Autonomous Loops** (nachtshift). [[53:23](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=3203)]

```
  HUMAN-IN-THE-LOOP (Dagshift)                     AFK AGENT (Nachtshift)
┌───────────────────────────────┐               ┌─────────────────────────────┐
│ 1. Dialectiek (`grill me`)    │               │ 4. Execution Loops          │
│ 2. Destination (`write a PRD`)│ ────────────> │    • TDD (Red-Green-Ref.)   │
│ 3. Journey (Canban / Slicing) │  (Backlog)    │    • Feedback Loops (CI)    │
└───────────────────────────────┘               └──────────────┬──────────────┘
                                                               │
                                                               ▼
                                                [ Sub-agent Code Review ]

```

---

#### Fase 1: Dialectische Verkenning (`grill me`) [[13:53](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=833)]

* **Doel:** Het opbouwen van een *Design Concept* (het onzichtbare, gedeelde idee tussen de mens en de AI). [[17:18](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=1038)]
* **Anti-Pattern:** *Specs-to-Code* of direct *Plan Mode* activeren. De AI is in plan mode te gehaast om een plan te genereren zonder de randvoorwaarden echt te begrijpen. [[16:43](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=1003)]
* **Proces:** De ontwikkelaar roept `/grill-me` aan met een vage opdracht. De AI interviewt de mens meedogenloos over randgevallen, datamodellen en opzet. [[16:15](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=975)]

---

#### Fase 2: De Bestemming vastleggen (`write a PRD`) [[30:45](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=1845)]

* **Doel:** Het vastleggen van de resultaten uit de grilling-sessie in een *Product Requirements Document* (PRD). [[31:45](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=1905)]
* **Samenstelling van een Goede PRD:**
1. *Problem Statement & Solution:* Wat bouwen we en waarom? [[32:00](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=1920)]
2. *User Stories:* Cucumber-achtige acceptatiecriteria. [[32:06](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=1926)]
3. *Module Changes:* Welke **Deep Modules** worden aangepast? [[32:54](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=1974)]
4. *Out of Scope:* Wat maken we uitdrukkelijk *niet* (voorkomt scope creep). [[58:37](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=3517)]


* **De Review-Paradox:** Pocock leest de gegenererde PRD zelf **niet** door. [[35:25](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=2125)] Omdat de mens en de AI via de grilling-sessie al op dezelfde golflengte zitten, is de PRD slechts een samenvatting voor de AI. De mens hoeft niet de samenvattingscapaciteit van de LLM te reviewen, maar bewaart de menselijke energie voor de fysieke code review. [[35:47](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=2147)]

---

#### Fase 3: De Reis Plannen (Vertical Slices & Canban Boards) [[39:39](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=2379)]

```
  HORIZONTAL SLICING (Fout):           VERTICAL SLICING / TRACER BULLETS (Goed):
  Phase 1: DB Schema ──┐               Slice 1: UI ──> API ──> DB (Mini Feature)
  Phase 2: API Route ──┼─> Geen Test!  Slice 2: Uitbreiding Logica
  Phase 3: Front-End ──┘               Slice 3: Edge Cases

```

* **Vertical Slicing (Tracer Bullets):** [[42:08](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=2528)]
* AI neigt van nature tot *horizontaal coderen* (eerst alle DB-tabellen, dan alle API's, dan de UI). Dit voorkomt dat de AI tussentijds feedback krijgt over het werkende systeem. [[43:03](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=2583)]
* **Tracer Bullet Rule:** Elke taak/ticket moet een **dunne verticale doorsnede** van de stack zijn (DB + API + UI), zodat de AI direct na stap 1 een geïntegreerd systeem kan testen. [[43:48](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=2628)]


* **Canban Graph (DAG):** In plaats van een lineair fasenplan activeert Pocock een afhankelijkheidsgrafiek van losse markdown-tickets. Dit maakt parallelle uitvoering door meerdere agenten mogelijk. [[49:51](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=2991)]

---

#### Fase 4: Autonome Uitvoering (AFK Loops & TDD) [[53:59](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=3239)]

* **Test-Driven Development (TDD) verplicht stellen:** [[01:06:46](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=4006)]
* Zonder TDD schrijft de AI de code en pas achteraf de tests. Dit leidt tot nep-tests die altijd slagen. [[01:08:01](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=4081)]
* De agent wordt verplicht om de **Red-Green-Refactor** cyclus uit te voeren: [[01:07:00](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=4020)]

$$\text{1. Schrijf Falende Test (Red)} \longrightarrow \text{2. Voer Uit \& Bevestig Fout} \longrightarrow \text{3. Maak Passend (Green)}$$


* **Feedback Loops als het Kwaliteitsplafond:** De AI is zo goed als de feedbackloops in de codebase (Type-checks, Linter, Vitest/Jest). Slagen de tests niet, dan kan de AI zijn eigen fouten niet gecorrigeerd krijgen. [[01:09:57](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=4197)]

---

### 3. Advanced Codebase Design voor AI-Driven Development

Om een codebase schaalbaar te houden met AI-agents, gebruikt Pocock twee geavanceerde technieken:

#### A. Deep Modules & De 'Gray Box' Aanpak [[01:14:26](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=4466)]

* **Het Probleem:** Ontwikkelaars verliezen hun grip op de codebase als AI honderden losse, kleine bestandjes (*shallow modules*) aanmaakt. [[01:15:11](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=4511)]
* **De Oplossing (John Ousterhout):** Zorg voor **Deep Modules** — grote logische blokken met een extreem eenvoudige interface, maar rijke interne functionaliteit. [[01:17:07](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=4627)]
* **Het 'Gray Box' Principe:** Ontwikkelaars ontwerpen de **interface** van de module strikt handmatig, maar behandelen de interne implementatie als een *Gray Box*. Je delegeert de interne logica aan de AI en controleert enkel de werking aan de buitenranden via de interface. [[01:20:25](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=4825)]

```
                       DE 'GRAY BOX' MODULE BENADERING
                       ┌──────────────────────────────┐
                       │  Eenvoudige Public Interface │  <── Menselijk Ontwerp
                       ├──────────────────────────────┤
                       │  Interne Logica & Functies   │  <── Gedelegeerd aan AI
                       │  (Verborgen Complexiteit)    │      (Geïsoleerd getest)
                       └──────────────────────────────┘

```

---

#### B. Parallelle Orchestratie: Push vs. Pull Steering [[01:28:04](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=5284)]

Wanneer je agents parallel laat draaien (bijv. via een orchestrator zoals *Sand Castle* [[01:30:03](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=5403)]), stuurt Pocock de agenten aan via twee mechanismen:

1. **Pull Steering (Implementer Agent):** [[01:28:38](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=5318)]
* De implementatie-agent draait met minimale context en krijgt de vrijheid om zelf informatie (*skills*, documentatie) op te halen wanneer hij vastloopt. Dit houdt de token-kosten laag.


2. **Push Steering (Reviewer Agent):** [[01:29:17](https://www.youtube.com/watch?v=-QFHIoCo-Ko&t=5357)]
* De Reviewer-agent krijgt de regels **actief ingespuit** (*pushed*). Hij leest de diff van de implementer, krijgt de strikte coding standards geforceerd in zijn prompt en beoordeelt de code met een schone context in de Smart Zone.


---


---

## §37. Stop Prompting Claude. Use Karpathy's Method Instead. (Austin Marchese)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=7zZy1QTvokM](https://www.youtube.com/watch?v=7zZy1QTvokM)

Austin Marchese vat in ~13 minuten ([YouTube](https://www.youtube.com/watch?v=7zZy1QTvokM), ~798s) een werkwijze samen die hij aan Andrej Karpathy toeschrijft: stop met “betere one-shot prompts” als primaire hefboom, en bouw in plaats daarvan drie lagen rond het model — **Spec**, **Verifier** en **Environment**. De video is methodisch (geen benchmark); nuttig als brug tussen vibe coding en agentic engineering. [[00:00](https://www.youtube.com/watch?v=7zZy1QTvokM&t=0)]

```
              KARPATHY-METHODE (DRIE LAGEN)

   ┌─────────────┐     ┌─────────────┐     ┌──────────────────┐
   │  1. SPEC    │────>│ 2. VERIFIER │────>│ 3. ENVIRONMENT   │
   │  doel+keuzes│     │ criteria +  │     │ CLAUDE.md / KB / │
   │  (interview)│     │ critic/eval │     │ skills/guardrails│
   └─────────────┘     └─────────────┘     └──────────────────┘
         ↑                    ↑                      ↑
    wat wil je écht?     wanneer is “klaar”     waar werkt de agent
    (niet alleen taak)   meetbaar bewezen?      (context + schil)
```

---

#### A. Laag 1 — Spec: doel blootleggen, niet alleen de taak [[00:28](https://www.youtube.com/watch?v=7zZy1QTvokM&t=28)]

* **Car wash op 50 meter:** vraag hoe je sneller bij een carwash komt die 50 m verderop ligt. Zonder de context dat je een *auto* nodig hebt voor een carwash, antwoordt het model vaak “loop”. Technisch “redelijk”, productief nutteloos — klassiek **missing goal context**.
* **Goal ≠ task statement:** de eerste zin (“bouw X”) is zelden de echte succesdefinitie. De spec moet constraints, non-goals, trade-offs en “klaar”-criteria blootleggen.
* **Agile kleine specs, geen waterfall:** liever korte, scherpe specificaties die je iteratief aanscherpt dan één groot vooraf-plan dat het model blind afwerkt. Waterfall-specs verouderen terwijl de agent nog typt.
* **Precisie:** vage wensen (“maak het netjes / schaalbaar”) nodigen uit tot copy-paste bloat; concrete acceptance en voorbeelden sturen beter.
* **Laat het model jou interviewen:** in plaats van aannames te vullen, stelt de agent verhelderende vragen over keuzes die jij moet maken (auth-model, data-grenzen, UX-prioriteit).
* **Key decisions expliciet verifiëren:** architectuurkeuzes die ertoe doen moeten in de spec of in een checklist terugkomen, niet stilzwijgend in gegenereerde code verdwijnen.
* **Plan mode lukewarm:** Karpathy (via Marchese) is lauw over alleen “plan mode”. Hij wil **gedetailleerde spec-samenwerking** met de agent — het plan als gezamenlijk artefact, niet als dunne tussenstap vóór ongecontroleerde implementatie.

```
   SLECHTE SPEC                         BETERE SPEC-LOOP
┌─────────────────────────┐           ┌────────────────────────────┐
│ “Bouw een carwash-app”  │           │ Doel, constraints, non-goals│
│ → model vult gaps in    │   ─────>  │ Agent interviewt mens       │
│ → car wash walk-fout    │           │ Key decisions afgevinkt     │
└─────────────────────────┘           │ Kleine slice → verify → next│
                                      └────────────────────────────┘
```

---

#### B. Laag 2 — Verifier: meetbaar maken vóór je bouwt [[03:34](https://www.youtube.com/watch?v=7zZy1QTvokM&t=214)]

* LLM’s zijn sterk waar succes **meetbaar** is (tests groen, schema valide, metric boven drempel) en zwak waar succes “smaak” of onuitgesproken intent is.
* **Animals vs ghosts:** geen intrinsieke motivatie of moreel “begrip” zoals bij dieren — wel statistische en RL-circuits. Schreeuwen (“doe het goed!”) helpt niet; verifieerbare signalen wel. (Zelfde metafoor keert terug in §41.)
* **Eval-criteria vóór build:** definieer acceptance *vóór* implementatie. Achteraf “lijkt goed in de chat” is de builder die zichzelf beoordeelt.
* **Tweede model als critic:** o.a. een Codex-plugin genoemd als critic/reviewer naast de builder — review in een andere rol (en idealiter frisse context).
* **Externe signalen:** linters, typechecks, tests, CI, runtime-logs, diffs. Alles wat buiten de genererende chat om “waar” of “onwaar” kan zijn.

```
   ZONDER VERIFIER                      MET VERIFIER
┌──────────────────────────┐         ┌──────────────────────────────┐
│ “Lijkt af” in dezelfde   │         │ Criteria vooraf vastgelegd   │
│   chat als de builder    │  ────>  │ Critic / 2e model            │
│ Geen stopconditie        │         │ Externe signals (make check) │
└──────────────────────────┘         └──────────────────────────────┘
```

---

#### C. Laag 3 — Environment: harness rond het model [[08:48](https://www.youtube.com/watch?v=7zZy1QTvokM&t=528)]

* **`CLAUDE.md` (of `AGENTS.md` / equivalent):** standing instructions die de agent always-on meeneemt — dun houden, anders attention budget en harness tax.
* **Knowledge-base mappen:** feiten, ADRs, API-referenties buiten de chat; de agent laadt just-in-time i.p.v. alles in één prompt te dumpen.
* **Skills voor herhaalde taken:** vaste procedures (`SKILL.md`-achtig) voor terugkerend werk, zodat je niet elke sessie opnieuw “prompt-engineert”.
* **Guardrails always / ask / never:**
  * *always* — mag zonder vragen (lint, read-only inspectie);
  * *ask* — destructief of duur, mens bevestigt;
  * *never* — secrets pushen, `main` forceren, productie wissen.
  Idealiter deels **deterministisch** (hooks/CI), niet alleen Markdown-advies.

---

#### D. Focus: thinking outsourcen, understanding niet [[12:36](https://www.youtube.com/watch?v=7zZy1QTvokM&t=756)]

Afsluiter van de video: je mag *denken* in de zin van uitwerking, boilerplate, zoeken en herschrijven aan het model overlaten. **Begrijpen van doelen en het richten van de AI** blijft menswerk. De productiviteitswinst zit in dieper doelbegrip + betere environment/verifier, niet in creatiever formuleren van dezelfde vage vraag.

#### Wat ik meeneem

* Drie lagen mappen op Agent Engineering: **Spec** ≈ intent/docs/slices (P18, P22); **Verifier** ≈ P13 + critic in frisse context (P19); **Environment** ≈ harness/`AGENTS.md`/skills + deterministische guardrails (P14, P17).
* Car-wash = goal/context-engineering; zelfde voorbeeld in §41.
* Plan-mode alleen is te dun; gedetailleerde **spec-samenwerking** past bij tijdelijke specs (P8) en vertical slices.
* Knowledge bases + dunne router amplificeren begrip zonder alles always-on (P2); harness tax blijft meetellen (P25).
* Diepte: [fundament/agents/](fundament/agents/INDEX.md) — geen kit-default “Karpathy-plugin”.

#### Open / onduidelijk

* Exacte grens “plan mode vs. spec collaboration” verschilt per tool (Claude Code / Cursor / Codex); de video is methodisch, geen A/B-test.


---


---

## §41. Andrej Karpathy: From Vibe Coding to Agentic Engineering w/ Stephanie Zhan (Sequoia Capital)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=96jN2OCOfLs](https://www.youtube.com/watch?v=96jN2OCOfLs)

Andrej Karpathy spreekt met Stephanie Zhan op **AI Ascent 2026** (~30 min, [YouTube](https://www.youtube.com/watch?v=96jN2OCOfLs)) over de verschuiving van **vibe coding** naar **agentic engineering**. Kern: wanneer agent-chunks “gewoon goed uitkomen”, wat **verifiability** betekent voor LLM’s, en waarom de menselijke bottleneck **directing + understanding** is — niet typen. Past inhoudelijk bij §37 (zelfde Karpathy-methode-taal).

---

#### A. Inflectie (dec 2025) en Software 1.0 / 2.0 / 3.0

* **Dec 2025-inflectie:** agentic code-chunks kwamen opeens vaak “gewoon goed genoeg uit de doos”; vibe coding werd een konijnenpijp — lage drempel, snelle prototypes, ook snelle technical debt.
* **Software-lagen (Karpathy):**
  * **1.0** — klassieke code die je schrijft en runt.
  * **2.0** — datasets + weights: het programma is geleerd.
  * **3.0** — **prompting + context** als hefboom over een LLM-als-interpreter (jij programmeert de runtime met taal en bestanden).

```
   1.0 code               2.0 weights/data            3.0 prompts+context
   jij schrijft logic →   jij curated/traint    →     jij stuurt de interpreter
                                                      (files, tools, specs)
```

* **OpenClaw-install als voorbeeld:** niet fragiele bash voor mensen-klikpaden, maar tekst die je aan een **agent** plakt. Documentatie wordt **agent-native**.
* **MenuGen vs. Gemini + Nano Banana:** een “app” die vooral image-overlay/glue deed werd **spurious** toen model+tooling hetzelfde goedkoper/directer deed — producten die alleen thin wrapper zijn, verdampen.

---

#### B. Verifiability: wat je kunt specificeren vs. wat je kunt verifiëren

* Traditionele computers: automatiseren wat je **precies specificeert**.
* LLMs: automatiseren wat je kunt **verifiëren** (tests, checkers, game win, compile). Waar verificatie ontbreekt, blijft de output jagged.
* **Jagged peaks:** wiskunde/code sterk door RL en verifieerbare rewards; andere domeinen grillig.
* **Car wash walk:** zelfde voorbeeld als §37 — zonder auto-context kiest het model “loop”.
* **Chess GPT-3.5 → 4:** sprong meer door **data/circuits** dan “pure scale only” — ontdek in welke circuits je zit.
* Praktijkregel: zit je **buiten** het sterke circuit → **fine-tune / data**, niet harder schreeuwen in de prompt.
* **Founders:** in verifieerbare domeinen blijven eigen RL/finetune-hefbomen strategisch relevant (je bouwt de verifier mee).
* Implicatie voor productkeuze: features zonder checkable success (pure “smaak”, ongedefinieerde UX) blijven mens-zwaar; features met oracle (compile, test, schema, eval set) schalen met agents.

```
   SPECIFICEERBAAR (klassiek)          VERIFIEERBAAR (LLM-sweet spot)
   exacte instructie → exacte actie    ruwe intent → output + check
                                       (unit test, diff, rubric, game)
```

---

#### C. Vibe coding vs. agentic engineering

| | Vibe coding | Agentic engineering |
|---|-------------|---------------------|
| Effect | Verhoogt de **vloer** | Verhoogt het **plafond** |
| Stijl | Snel, exploratief, chat-first | Spec, harness, review, meetbare done |
| Risico | Slop, copy-paste bloat, spurious apps | Over-process; wel onderhoudbaarder |
| Artefact | “Het werkt nu” | Spec + tests + herhaalbare omgeving |

* **Spec oversight:** schrijf/verscherp een **gedetailleerde spec met de agent**; plan mode alleen is te zwak (zelfde lijn als §37).
* **Taste / design / unique IDs:** onderscheidend werk vs. “API-recall intern” (model dat stack-conventies napraat zonder productoordeel).
* Codekwaliteit: agents neigen naar **opgeblazen / copy-paste** modules. Pogingen à la microGPT-simplify falen wanneer je **buiten** de RL/verifieerbare sweet spot optimaliseert.

---

#### D. Animals vs. ghosts; agent-native wereld; bottleneck

* Modellen zijn **geen dieren** met drift/motivatie; wel **ghosts**: statistische + RL-circuits. Schreeuwen helpt niet; signals, constraints en verifiers wel.
* **Agent-native docs:** copy-pasteable instructies voor agents, geen menselijke UI-paden (“klik links op Settings…”).
* **Agent-to-agent:** systemen die onderling taken en artefacts uitwisselen, niet alleen mens↔één chatvenster.
* **Outsource thinking, not understanding:** uitwerking mag weg; doelbegrip en sturing niet.
* Knowledge bases **amplificeren understanding**; de schaarse resource is menselijke **directing**-capaciteit.

```
   MENS (bottleneck)                    AGENT / LLM
   begrip · smaak · doelen · verify →   zoeken · boilerplate · edits
   directing / acceptance          ←──  diffs · tests · critiques
```

---

#### E. Praktische checklist uit het gesprek (gecondenseerd)

1. Schrijf de **spec met** de agent; behandel plan mode als hulpmiddel, niet als eindproduct.
2. Zet **verifiers** klaar vóór volume-codegen (tests, linters, acceptance).
3. Houd docs **agent-plakbaar**; vermijd click-path prose.
4. Bouw **KB’s** die begrip schalen; houd always-on routers klein.
5. Accepteer jaggedness: kies domeinen/circuits waar verify bestaat; fine-tune als je erbuiten zit.
6. Gebruik vibe coding voor floor/exploration; schakel naar agentic engineering voor quality ceiling.

#### Wat ik meeneem

* Software 3.0 ≈ context+prompt als hefboom; agentic engineering ≈ **harness + loop + specs** (P13, P14, P18, P22, P25).
* Vibe coding verhoogt de vloer; discipline nodig voor ceiling (P19, P23, §32 de-slop).
* Spec-samenwerking > plan-mode-only; tijdelijke specs (P8); router klein, KB JIT (P2).
* Animals/ghosts → guardrails deterministisch (P14), niet alleen “wees voorzichtig” in Markdown.
* Agent-native docs sluiten aan op kit-`AGENTS.md` / bootstrap: instructies die een agent kan uitvoeren.
* MenuGen-les: thin wrappers op modelvaardigheden zijn fragiel — bouw seams en unieke waarde (P16/P23), niet alleen glue.
* Brug: §37 (methode), [fundament/agents/](fundament/agents/INDEX.md).

#### Open / onduidelijk

* Dec-2025 “inflectie” is periodisering/anekdote gekoppeld aan modelreleases — nuttig frame, geen gecontroleerd experiment.
* Hoe ver “agent-to-agent” in 2026 al productief is vs. aspirational blijft buiten deze talk.
* Timestamps per hoofdstuk ontbreken in de aangeleverde excerpt-set; claims hier zijn inhoudelijk aan de transcript-excerpts gekoppeld, niet aan seconden-markers.


---


# Software design (AI-tijdperk)

## §2. Software Fundamentals in het AI-Tijdperk

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=v4F1gFy-hqg](https://www.youtube.com/watch?v=v4F1gFy-hqg)

In deze lezing bekritiseert Pocock de opkomende hype rondom **"Specs-to-Code"** — het idee dat ontwikkelaars in de toekomst enkel nog specificaties hoeven te schrijven en de onderliggende code volledig aan AI kunnen overlaten zonder deze ooit te bekijken.

```
                                  SPECS-TO-CODE MYTHE
                      ┌────────────────────────────────────────┐
                      │ Specificatie ──> AI Compiler ──> Code  │
                      └───────────────────┬────────────────────┘
                                          │
                                          ▼ (In de praktijk)
                                   Software-Entropie!

```

#### A. Waarom "Specs-to-Code" Faalt: Software-Entropie & Complexiteit

1. **Software-Entropie (Pragmatic Programmer):**
* Entropie is de natuurkundige neiging van systemen om te vervallen tot wanorde. In software betekent dit dat elke losse verandering aan een codebase de algehele structuur verslechtert, tenzij er actief wordt geïvesteerd in het ontwerp.
* Bij *Specs-to-Code* genereert de AI steeds nieuwe code bovenop een verslechterende structuur. Het herhaaldelijk hercompileren van specs leidt onherroepelijk tot **"garbage code"** en onbeheersbare bugs.


2. **Complexiteit als de Echte Kostenpost (John Ousterhout):**
* *A Philosophy of Software Design* definieert complexiteit als alles aan de structuur van een systeem dat het moeilijk maakt om het te begrijpen of aan te passen.
* **De Mythe:** "Code is cheap."
* **De Realiteit:** Slechte code is duurder dan ooit. Als een codebase complex en verstrengeld is, kan de AI de context niet meer begrijpen en hallucineert hij. AI presteert pas optimaal binnen een overzichtelijke, goed gestructureerde codebase.


---

#### B. De Vijf Fundamentele Pijlers voor AI-Driven Development

##### 1. Het Gedeelde Ontwerpconcept via Dialectiek (`grill me`)

* **Theorie (Frederick P. Brooks - *The Design of Design*):** Wanneer twee entiteiten samenwerken, bestaat het ontwerp primair als een abstract, onzichtbaar idee tussen hen in: het *Design Concept*.
* **Toepassing:** In plaats van direct een actieplan te genereren (zoals de standaard *Plan Mode* in veel tools eitig doet), dwingt de `grill-me`-skill de AI om de gebruiker uit te horen. Door tientallen gerichte vragen te stellen, verkennen ze samen de takken van de beslissingsboom totdat het *Design Concept* 100% helder is.

##### 2. Ubiquitous Language (Domain-Driven Design)

* **Probleem:** AI heeft de neiging om extreem langdradig te worden (*verbose*) of concepten verkeerd te interpreteren wanneer er geen vaste definities zijn.
* **Theorie (Eric Evans - DDD):** Ontwikkelaars, domeinexperts en de code moeten exact dezelfde taal spreken.
* **Toepassing:** Een `ubiquitous-language`-skill scant de codebase en genereert een bestand (`domain-terms.md`) met strikte definities van alle kernbegrippen. Dit bestand wordt meegegeven in de context van de AI. Het resultaat is dat de AI minder tokens verspilt, gerichter nadenkt en code oplevert die direct aansluit bij de domeinlogica.

##### 3. Begrenzing via Feedback Loops (TDD & Outrunning Headlights)

* **Probleem:** AI neigt tot "outrunning its headlights" — het genereert grote hoeveelheden code in één keer zonder tussentijds te controleren of het werkt.
* **Theorie (Pragmatic Programmer):** De snelheid van je feedbackloop is je maximumsnelheid.
* **Toepassing:** Test-Driven Development (TDD) dwingt de AI om kleine, beheerste stappen te nemen:

$$\text{Schrijf Falende Test} \longrightarrow \text{Maak Minimal Werkend} \longrightarrow \text{Refactor Design}$$


Dit voorkomt dat de AI afdwaalt in een ontestbaar web van code.

##### 4. Diepe Modulen vs. Ondiepe Modulen (John Ousterhout)

| Eigenschap | Ondiepe Modulen (*Shallow Modules*) | Diepe Modulen (*Deep Modules*) |
| --- | --- | --- |
| **Interface** | Complex, veel geëxponeerde functies en instellingen. | Zeer eenvoudig en klein. |
| **Functionaliteit** | Weinig interne logica per module; sterk afhankelijk van andere modules. | Veel verborgen functionaliteit en interne complexiteit. |
| **Impact op AI** | Slecht. AI moet tientallen kleine bestandjes doorzoeken, raakt de draad kwijt en snapt de afhankelijkheden niet. | Uitstekend. De AI hoeft enkel de eenvoudige interface van de module te begrijpen. |

```
Shallow Modules (Slecht voor AI):       Deep Modules (Optimaal voor AI):
┌───┐ ┌───┐ ┌───┐ ┌───┐                 ┌───────────────────────────────┐
│ A │─│ B │─│ C │─│ D │                 │         Simple Interface      │
└───┘ └───┘ └───┘ └───┘                 ├───────────────────────────────┤
  │     │     │     │                   │  Deep Internal Logic (A,B,C)  │
  └─────┴─────┴─────┘                   └───────────────────────────────┘

```

##### 5. Strategisch vs. Tactisch Programmeren

* **Tactisch Programmeren:** Snel code opleveren om een feature af te vinken, zonder oog voor de algehele architectuur (dit is waar een AI van nature op aanstuurt).
* **Strategisch Programmeren:** De menselijke ontwikkelaar werkt als een "generaal" op strategisch niveau. Je ontwerpt de interfaces en modulegrenzen (de diepe modulen) en delegeert de tactische implementatie van de interne logica aan de AI.

---


---

## §32. How To De-Slop A Codebase Ruined By AI (Matt Pocock)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=3MP8D-mdheA](https://www.youtube.com/watch?v=3MP8D-mdheA)

Matt Pocock adresseert het toenemende fenomeen van **AI Slop**: de snelle verrotting van codebases doordat AI-agents (zoals Cursor of Claude Code) bliksemsnel code toevoegen zonder rekening te houden met het totale systeem, wat leidt tot een gigantische **software-entropie** en een ononderhoudbare *"big ball of mud"*.

```
                             DE REFRACTORING MATRX

         Tactische Programmer (De AI-Agent)       Strategische Programmer (De Mens)
      ┌──────────────────────────────────────┐  ┌──────────────────────────────────────┐
      │ • Schrijft snel code en functies.    │  │ • Bepaalt de architectuur & grenzen. │
      │ • Werkt lokaal op 'ground level'.    │  │ • Ziet het 'big picture' en de seams.│
      │ • Ziet de lange-termijn entropie    │  │ • Beslist welke modules verdiept     │
      │   en samenhang niet.                 │  │   moeten worden (Deep Modules).      │
      └──────────────────────────────────────┘  └──────────────────────────────────────┘

```

#### A. Kerntheorieën uit 'A Philosophy of Software Design' (John Ousterhout)

Pocock introduceert een essentieel begrippenkader om codebases gezond te houden:

1. **Deep Modules vs. Shallow Modules:**
* **Deep Module (Goed):** Verbergt een enorme hoeveelheid complexe implementatie achter een zeer eenvoudige, kleine interface. Biedt hoge *leverage* (kracht per geleerde interface).
* **Shallow Module (Slecht / AI Slop):** Heeft een ingewikkelde interface met maar een klein beetje implementatie erachter. AI-agents neigen ertoe om tientallen van dit soort ondiepe, versnipperde functies aan te maken.


2. **Locality (Lokaliteit):**
* Veranderingen, bugs en logica rondom één concept horen bij elkaar geclusterd op één plek te staan. AI-agents verstoren dit vaak door logica te verspreiden over meerdere bestanden.


3. **Seams & Adapters (Naden en Adapters):**
* **Seam:** De grens waar twee modules/interfaces op elkaar aansluiten. Dit is de exacte plek waar unit- of integratietests geplaatst moeten worden.
* **Adapter:** Een concrete klasse/functie die aan de interface voldoet (bijv. een echteklok vs. een nepklok in tests).


---

#### B. Het `improve-codebase-architecture` Skill & De 'Grilling Session'

Pocock presenteert zijn open-source skill om door AI verruïneerde codebases te redden (*de-slopping*):

1. **Exploratie op Zoek naar Shallow Modules:** De skill scant de codebase op zoek naar versnipperde concepten of ondiepe interfaces die samengevoegd moeten worden tot *Deep Modules*.
2. **De Grilling Session (Menselijk-in-de-Loop Overleg):**
* De agent stelt de menselijke ontwikkelaar kritische vragen over voorgestelde interfaces en datastromen.
* **Cruciaal Inzicht:** Dit is *geen* AFK-proces (Away From Keyboard). De mens moet fungeren als de **Strategische Programmer** (de Generaal) die de beslissingen neemt, terwijl de AI-agent optreedt als de **Tactische Programmer** (de Sergeant) die de code fysiek herstructureert.


---

#### C. Redden van Legacy Codebases

* Om AI veilig in te zetten op een bestaande of vervuilde codebase, moet je eerst een **harness rondom de code bouwen** via goede integratietests op de *Seams*.
* Pas wanneer er sterke *Deep Modules* met strakke interfaces zijn gedefinieerd, worden de AI-agents betrouwbaar en schalen hun gegenereerde oplossingen zonder het systeem verder af te breken.

---


---


## §144. Open source is not enough (Premature Abstraction)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=7zmuMKR7q8w](https://www.youtube.com/watch?v=7zmuMKR7q8w)

- **Duur:** ~15:21 · upload ~2026-10-27 · slotaflevering compiler-serie
- **Kern in 2–3 zinnen:** Open source + zelf compileren is **niet** genoeg voor trust: compilers (en alles wat programma’s hanteert) kunnen Ken Thompson’s *Trusting Trust*-backdoor meedragen die in schone source onzichtbaar blijft. Parallel: **Rice’s theorem** → interessante “wat doet dit programma?”-vragen zijn onbeslisbaar; type systemen / checks zijn bewust te strenge (of te losse) *proxies* op de tekst. Mitigaties: reproducible builds, Wheeler’s diverse double-compiling, CompCert/proof assistants, bootstrappable builds vanaf handgeschreven **hex0**.
- **Cross:** deep modules / seams §2/§32; agent-output review = bottleneck (sponsor-aside CodeRabbit); ship-trust / supply chain.

---

#### A. Framing: binary → source → compiler → nog steeds niet veilig [[00:00](https://www.youtube.com/watch?v=7zmuMKR7q8w&t=0)]

* Closed binary: onbekende backdoors/bugs. OSS + zelf compileren helpt — tot de **compiler** iets injiceert. Ook compiler-source lezen/compileren lost Thompson (1983 Turing Award) niet op: backdoor plant zich in elke *nieuwe* compiler die uit “schone” source komt.

#### B. Analyse-stadia = geheugenmacht [[01:00](https://www.youtube.com/watch?v=7zmuMKR7q8w&t=60)]

| Stadium | Geheugenmodel | Gevolg |
|---------|---------------|--------|
| Lexer | Eindige toestanden (FA) | Geen echte nest-telling → regex ≠ nested `()` |
| Parser | Stack (PDA) | In theorie genoeg; praktijk: C peekt symbol table; C++ templates erger; **Perl**-parse zonder runnen onbeslisbaar (formeel ~2008) |
| Semantic analysis | Turing machine | Symbol table/type rules willekeurig → Rice |

#### C. Rice’s theorem + “full employment” voor compiler-schrijvers [[02:42](https://www.youtube.com/watch?v=7zmuMKR7q8w&t=162)]

* Elke interessante vraag over *wat* (of *hoe*) een programma computeert is **onbeslisbaar** (geen methode die voor *alle* programma’s werkt). Voorbeelden: ooit printen? deling door nul? pure functie? zelfde functie?
* Daarom: optimalisaties nooit “volledig” — compiler kan nutteloze assignment / pure call niet altijd bewijzen. Textbooks: *full employment theorem for compiler writers*.

#### D. Types als beslisbare proxy [[04:02](https://www.youtube.com/watch?v=7zmuMKR7q8w&t=242)]

* Beslisbaar = vragen over **tekst** (elke branch eindigt op `return` → tree walk). Type systemen vertalen onbeslisbare runtime-vragen naar zulke proxies → **false rejects** (geldig programma geweigerd) of **false accepts** (C-stijl).
* `restrict` / GCC `pure`: programmeur claimt; liegen → stille verkeerde code. Rust borrow checker: checkt → weigert soms geldige programma’s.
* C++ templates: type-taal ≈ programmeertaal → Rice opnieuw; praktijk: abort na ~1000 nest-niveaus.
* Static vs dynamic: betaal compile-time rejects **of** runtime crashes — welke kant van het theorema.

#### E. Types as proofs / proof assistants [[06:32](https://www.youtube.com/watch?v=7zmuMKR7q8w&t=392)]

* Type = statement; body = bewijs; checker = proof check (Curry–Howard). Alledaagse talen: zwakke statements + non-terminatie → “bewijs” door nooit returnen. Expressieve terminating types → proof assistants (**Lean**, ASR “Rock” ≈ Coq/Rocq).

*(Sponsor CodeRabbit ~[07:22](https://www.youtube.com/watch?v=7zmuMKR7q8w&t=442)–[08:37](https://www.youtube.com/watch?v=7zmuMKR7q8w&t=517): agent-code ≈ gratis → **review** bottleneck; overgeslagen behalve les.)*

#### F. Trusting Trust mechanisme [[08:37](https://www.youtube.com/watch?v=7zmuMKR7q8w&t=517)]

1. **Escape-bootstrapping:** `\v` = 11 eenmalig hardcoderen → binary “weet” het → source mag weer `\v` zeggen; kennis leeft **alleen** in de binary-keten.
2. **Twee patches:** (a) bij compile van OpenSSH: inject secret password; (b) bij self-compile: inject *beide* patches (quine/self-string). Compile één keer met patches → wis source → elke latere rebuild draagt backdoor. Geldt ook voor assembler/loader/**microcode**.
3. **Induc** (2009, Delphi): infecteerde precompiled stdlib (niet compiler-binary); clean reinstall doodde het — zwakker dan Thompson (die zich bij elke rebuild herplant).

#### G. Mitigaties + bootstrapping [[12:13](https://www.youtube.com/watch?v=7zmuMKR7q8w&t=733)]

* **Reproducible builds** (Debian ~2013+): zelfde source → bit-identieke bytes; één gecompromitteerde buildmachine faalt als iemand herbouwt/vergelijkt.
* **David A. Wheeler (2005) diverse double-compiling:** compile A met A én onafhankelijke B; hercompile A met beide resultaten → bytes moeten gelijk. Fork van A telt niet als B.
* **Csmith** (2011): >**300** bugs in GCC/LLVM/commercieel; stil verkeerde code; **CompCert** (proven parts) clean in die run — compiler *in* proof checker; moet zelf nog gecompileerd worden.
* **Bootstrappable builds:** **hex0** = **357** bytes handgeschreven machinecode → assembler → tiny C → oude GCC → moderne GCC → distro. Keten “klaar” **2023**; buiten kernel + build-helper komt alles uit source behalve die 357 bytes.

#### Wat ik meeneem

* “OSS genoeg” is te zwak voor agent/toolchain-supply-chain; meet **reproducibility** + diverse compilers waar het telt.
* Agent-coding: review blijft knelpunt (zelfde als series-outro: wat AI niet “gratis” maakt).
* Types/checks = proxies (P13-achtig: intent vs enforce) — parallel should/must (§107/hooks).
* Geen kit-actie; wel kenniskaart trust/bootstrap naast software design.

#### Open / onduidelijk

* Exacte Rocq/Lean-naam ASR; of CompCert-claim Csmith-scope volledig dekt.
* Hoe ver hex0-keten reproduceerbaar is op eigen hardware zonder helper-trust.

---


# Agent-docs & docs-architectuur

## §13. Rules (Cursor-documentatie)

**Type:** Documentatie · **URL:** [https://cursor.com/docs/context/rules](https://cursor.com/docs/context/rules)

De officiële uitleg over hoe Cursor persistente instructies in de context van de agent brengt.

---

### 1. Vier Soorten Rules

| Soort | Waar | Geldt voor |
|-------|------|-----------|
| **Project Rules** | `.cursor/rules/*.mdc` (in git) | Deze codebase, per pad of relevantie |
| **User Rules** | Instellingen | Al je projecten (alleen Agent/Chat) |
| **Team Rules** | Dashboard | Hele organisatie, eventueel verplicht |
| **AGENTS.md** | Root of submappen | Eenvoudig alternatief zonder metadata |

* Volgorde bij conflicten: **Team → Project → User**.
* Een rule wordt **vooraan in de modelcontext** geplaatst.

---

### 2. Hoe een Project Rule Wordt Toegepast

```
  alwaysApply: true                    → altijd geladen
  globs: src/**/*.tsx                  → automatisch als een passend bestand in context is
  description: "..." (geen globs)      → agent leest de beschrijving en beslist zelf
  niets                                → alleen bij @-vermelding
```

* Alleen `.mdc`-bestanden met frontmatter worden herkend. Een gewoon `.md`-bestand in `.cursor/rules/` wordt genegeerd.
* **Een `@bestand` in een rule wordt niet ingevoegd**: het is een verwijzing die de agent zelf opent wanneer nodig. Wat altijd in de context moet zitten, zet je in de rule zelf.
* Geneste `AGENTS.md` in submappen worden samengevoegd met die van de bovenliggende mappen. De meest specifieke wint.

---

### 3. Best Practices volgens Cursor

* Hou rules gefocust, uitvoerbaar en afgebakend, en **onder de 500 regels**.
* Splits grote rules in combineerbare delen.
* **Verwijs naar bestanden in plaats van ze te kopiëren**: zo blijven rules kort en verouderen ze niet.
* Vermijd: hele stijlgidsen (gebruik een linter), elk commando documenteren (de agent kent npm, git, pytest), zeldzame randgevallen, en wat al in de codebase staat.
* **"Begin eenvoudig. Voeg een rule pas toe als de agent herhaaldelijk dezelfde fout maakt."**

### Wat ik meeneem

* Path-scoped rules (globs) zijn het Cursor-mechanisme voor lokaliteit: regels voor `apps/web` laden alleen bij werk in `apps/web`.
* "Rule toevoegen bij een herhaalde fout" is een goede **groeiregel** voor documentatie: niet vooraf alles uitschrijven.
* In een teamproject waar niet iedereen Cursor gebruikt, is `AGENTS.md` het gemeenschappelijke formaat.

---


---

## §14. AGENTS.md — Een Open Formaat voor Coding Agents

**Type:** Standaard · **URL:** [https://agents.md](https://agents.md)

---

### 1. Idee

* **"A README for agents"**: een voorspelbare plek met de context die een coding-agent nodig heeft.
* `README.md` blijft voor mensen (quickstart, beschrijving, contributing). `AGENTS.md` bevat wat een README rommelig zou maken: build-stappen, tests en conventies.
* Eén bestand dat veel tools lezen (onder meer Codex, Cursor, Jules, Gemini CLI, Aider, Zed, Warp, Windsurf, RooCode), in plaats van een eigen formaat per tool.

---

### 2. Inhoud & Structuur

* **Geen verplichte velden**: gewone Markdown.
* Populaire secties: projectoverzicht, build- en testcommando's, codestijl, testinstructies, security, commit/PR-afspraken, deployment, valkuilen ("alles wat je een nieuwe collega zou vertellen").
* **Monorepo:** zet een geneste `AGENTS.md` per package. Het dichtstbijzijnde bestand heeft voorrang. De OpenAI-repo had er op het moment van schrijven 88.
* Bij conflicten wint het bestand dat het dichtst bij het bewerkte bestand staat. **Expliciete chatinstructies gaan boven alles.**
* Agents voeren testcommando's die erin staan ook echt uit en proberen failures op te lossen.
* Migreren: hernoemen naar `AGENTS.md` en een symlink leggen voor oude namen (`CLAUDE.md`, `AGENT.md`).

```
  repo/
  ├── AGENTS.md              ← globale instructies
  ├── apps/web/AGENTS.md     ← frontend-specifiek, wint binnen apps/web
  └── apps/api/AGENTS.md     ← backend-specifiek
```

### Wat ik meeneem

* Voor **DEP2 (5 personen, verschillende tools)** is `AGENTS.md` in de root de juiste basis.
* Een geneste `AGENTS.md` per app is het tool-onafhankelijke equivalent van path-scoped Cursor-rules.
* Let op: hoofdstuk 20 laat zien dat *wat* erin staat bepaalt of het helpt.

---


---

## §15. llms.txt — LLM-vriendelijke Ingang voor Websites (Jeremy Howard)

**Type:** Voorstel / standaard · **URL:** [https://llmstxt.org](https://llmstxt.org)

---

### 1. Probleem

* Webpagina's zijn voor mensen gemaakt: navigatie, ads en JavaScript rond de eigenlijke informatie. Ze terug omzetten naar schone tekst is onnauwkeurig, en elk verspild token kost tijd en geld.
* Agents hebben het meest aan **beknopte informatie op expertniveau op één toegankelijke plek**.

---

### 2. Voorstel

* Een `/llms.txt`-bestand in Markdown op de root (of op een subpad, dan geldt het voor alles daaronder).
* Pagina's bieden een **schone Markdown-versie** op dezelfde URL met `.md` erachter.
* Het bestand blijft klein genoeg voor de context. **Het detail staat achter de links en wordt alleen opgehaald wanneer nodig.**

```
# Projectnaam                         ← enige verplichte sectie (H1)

> Korte samenvatting met de kerninformatie

Optionele toelichting (geen koppen)

## Docs                               ← H2 = lijst van bestanden
- [Titel](url): waarom/wanneer lezen

## Optional                           ← mag overgeslagen worden bij korte context
- [Titel](url)
```

* Verschil met `sitemap.xml`: een sitemap somt alles op, `llms.txt` is een **gecureerde selectie**.
* Richtlijnen: helder taalgebruik, korte beschrijving per link, **geen onverklaard jargon**, en het bestand testen door een agent vragen te stellen met alleen `llms.txt` als startpunt.

### Wat ik meeneem

* Het formaat is in feite een **INDEX_DOCS-patroon**: H1, een samenvatting van één alinea, en lijsten met link plus "wanneer lezen".
* Een sectie "Optional" voor secundaire bronnen is een goed idee voor docs-indexen.
* Testmethode: geef een agent alleen de index en kijk of hij het juiste bestand vindt.

---

## §16. Repository Map (Aider)

**Type:** Documentatie · **URL:** [https://aider.chat/docs/repomap.html](https://aider.chat/docs/repomap.html)

---

### 1. Wat een Repo Map Is

* Bij elke vraag stuurt Aider een **beknopte kaart van de hele repo** mee: bestanden met hun belangrijkste klassen en functies, inclusief signaturen.
* Voordeel 1: het model ziet de API's van de hele repo en kan vaak al genoeg afleiden om de taak op te lossen.
* Voordeel 2: als het meer code nodig heeft, weet het **welke bestanden** het moet vragen.

---

### 2. Optimalisatie binnen een Tokenbudget

* Bij grote repo's is zelfs de kaart te groot. Aider bouwt daarom een **graaf** met bestanden als knopen en afhankelijkheden als verbindingen, en rangschikt die (graph ranking).
* Alleen de **meest gerefereerde identifiers** komen in de kaart, binnen een budget (standaard ongeveer 1k tokens), dynamisch afgestemd op de chat.

```
  bestanden + afhankelijkheden → graaf → ranking → top-symbolen binnen tokenbudget → repo map
```

### Wat ik meeneem

* De kaart wordt **automatisch afgeleid uit de code**, niet met de hand onderhouden. Dat ondersteunt het principe "documenteer niet wat afleidbaar is".
* Goede, consistente namen voor modules en functies zijn de eigenlijke "kaart": ze maken grep en ranking effectief.

---


---

## §20. Evaluating AGENTS.md: Are Repository-Level Context Files Helpful for Coding Agents?

**Type:** Paper · **URL:** [https://arxiv.org/abs/2602.11988](https://arxiv.org/abs/2602.11988)

De eerste rigoureuze test van wat bijna elke vendor aanraadt. **Zeer relevant voor een bachelorproef**: het is zowel de dichtstbijzijnde verwante studie als een methodologisch sjabloon.

---

### 1. Opzet

* Twee settings:
  1. **SWE-bench Lite** (populaire repo's) met **door een LLM gegenereerde** contextbestanden volgens de aanbevelingen van de tool-makers.
  2. **AGENTbench** (in latere versies CTXbench): nieuwe benchmark met **138 taken** (bugfixes en features) uit **12 minder bekende Python-repo's** die zelf een **door ontwikkelaars geschreven** contextbestand bevatten.
* Drie condities per taak: **geen** contextbestand, **door een LLM gegenereerd**, **door ontwikkelaars geschreven**.
* Meerdere agents en modellen. Gemeten: of de taak opgelost is (tests), kosten en gedrag in de traces.

---

### 2. Resultaten

| Conditie | Effect op slaagkans | Kosten |
|----------|--------------------|--------|
| Door LLM gegenereerd | gemiddeld **−3%** (daling in 5 van 8 settings) | **+20%** of meer |
| Door ontwikkelaars geschreven | gemiddeld **+4%** (marginaal) | hoger |

* Agents **volgen de instructies wel**. Een tool zoals `uv` wordt ongeveer 1,6 keer per taak gebruikt als hij vermeld wordt, en bijna nooit als hij niet vermeld wordt. Het gebrek aan winst komt dus niet doordat instructies genegeerd worden.
* Contextbestanden leiden tot **meer verkennen en testen**: meer grep, meer gelezen bestanden, meer tests. Dat verklaart de hogere kosten.
* **Repository-overzichten helpen niet**: agents vinden de relevante bestanden niet sneller (gemeten als het aantal stappen tot het eerste aangeraakte bestand uit de echte patch). Sommige modellen zochten en lazen het contextbestand zelfs meerdere keren, terwijl het al in de context zat.
* **Contextbestanden zijn grotendeels dubbele documentatie**: als de onderzoekers alle andere documentatie verwijderden, verbeterden de door een LLM gegenereerde bestanden de prestaties wel (gemiddeld +2,7%). Ze helpen dus vooral in slecht gedocumenteerde repo's.

---

### 3. Conclusie van de Auteurs

* Laat door een LLM gegenereerde contextbestanden voorlopig weg, tegen het advies van de tool-makers in.
* Schrijf alleen **minimale vereisten** op: specifieke tooling en niet-standaard praktijken, niets wat al in de codebase of de docs staat.
* *"Unnecessary requirements make tasks harder"*: elke extra eis maakt de taak voor de agent zwaarder.
* Elke poging om de prestaties te verbeteren moet **eerst rigoureus geëvalueerd worden**.

### Wat ik meeneem

* **Een mappenboom of overzicht in het routerbestand levert niets op**, terwijl precies dat het populairste onderdeel is. Dat ondersteunt "niet documenteren wat afleidbaar is".
* Wat wél werkt: **niet-afleidbare, specifieke instructies** (welke tool, welk commando, welke valkuil).
* Elke regel in een contextbestand wordt een **eis** die de agent probeert na te leven. Een overbodige regel is dus geen neutrale ruis, maar extra werk.
* Methodologie die ik kan overnemen: drie condities, taken uit echte PR's, slaagkans via tests, en kosten en gedrag uit de traces.

---


---

## §21. Agentic Coding Manifests & Agent READMEs (Chatlatanagulchai et al.)

**Type:** Paper · **URL:** [https://arxiv.org/abs/2509.14744](https://arxiv.org/abs/2509.14744)

* [On the Use of Agentic Coding Manifests: An Empirical Study of Claude Code](https://arxiv.org/abs/2509.14744) · Kasetsart University, NAIST · 2025
* [Agent READMEs: An Empirical Study of Context Files for Agentic Coding](https://arxiv.org/abs/2511.12884) · Kasetsart University, Queen's University, NAIST · 2025, ACM TOSEM

Twee beschrijvende studies: ze meten niet of contextbestanden helpen (zie hoofdstuk 20), maar **wat ontwikkelaars er in de praktijk in zetten**.

---

### 1. Studie 1: Claude.md-manifests

* **253 `CLAUDE.md`-bestanden uit 242 repo's** (alleen repo's met minstens 20 commits nadat het bestand toegevoegd werd).
* Structuur: **ondiepe hiërarchie**, meestal één hoofdkop met enkele subsecties.
* Inhoud gedomineerd door **operationele commando's**, **technische implementatienotities** en **architectuur op hoog niveau**.

---

### 2. Studie 2: Agent READMEs (grootschalig)

* **2.303 contextbestanden uit 1.925 repo's**, voor Claude Code, OpenAI Codex en GitHub Copilot.
* De bestanden zijn **geen statische documentatie**: ze evolueren als **configuratiecode**, met frequente, kleine toevoegingen. Daardoor worden ze vaak complex en moeilijk leesbaar.
* Inhoudsanalyse van 16 soorten instructies: ontwikkelaars geven vooral **functionele context**: testprocedures (ongeveer 76%), implementatiedetails (ongeveer 71%), architectuur (ongeveer 68%), build- en run-commando's.
* **Een duidelijk gat:** niet-functionele eisen zoals **security (ongeveer 15%)** en **performance (ongeveer 15%)** staan er zelden in.

```
  wat er WEL in staat            wat er ZELDEN in staat
  ─────────────────────          ──────────────────────
  testen, build/run              security
  implementatiedetails           performance
  architectuur                   (guardrails in het algemeen)
```

### Wat ik meeneem

* Contextbestanden groeien vanzelf aan ("nog één regel"). Plan **periodiek snoeien** in, net zoals refactoren.
* Een gemiste kans in de meeste projecten: **guardrails voor security en performance**. Bij GymFreak (gezondheidsdata) en DEP2 (database-credentials) is dat net relevant.
* Bruikbaar als **literatuurbasis** voor een bachelorproef: wat er in de praktijk gebeurt, tegenover wat werkt (hoofdstuk 20).

---


---

## §22. Diátaxis — Een Systematisch Kader voor Technische Documentatie

**Type:** Documentatiekader · **URL:** [https://diataxis.fr](https://diataxis.fr)

---

### 1. Kernidee

* Documentatie moet georganiseerd worden rond **de behoeften van de gebruiker**, niet rond de structuur van het product.
* Er zijn **vier verschillende behoeften** en dus vier vormen van documentatie. Die mengen is de belangrijkste oorzaak van slechte documentatie.
* De naam komt uit het Grieks: *dia* (over, doorheen) en *taxis* (ordening).
* Diátaxis gaat over **inhoud** (wat schrijf je), **stijl** (hoe) en **architectuur** (hoe orden je het).

---

### 2. De Vier Vormen (het "kompas")

```
                         PRAKTISCH (doen)
                               │
         TUTORIAL              │              HOW-TO GUIDE
    leren door te doen         │         een concreet doel bereiken
    "neem me bij de hand"      │         "hoe los ik X op?"
                               │
  VERWERVEN ───────────────────┼─────────────────── TOEPASSEN
  (studie)                     │                   (werk)
                               │
         UITLEG                │              REFERENTIE
    begrip, achtergrond,       │         droge, volledige feiten
    het "waarom"               │         "wat is de exacte waarde?"
                               │
                        THEORETISCH (weten)
```

| Vorm | Doel | Toon |
|------|------|------|
| **Tutorial** | Een beginner een eerste succes laten beleven | Begeleidend, stap voor stap |
| **How-to** | Iemand die al competent is een taak laten afwerken | Doelgericht, met de veronderstelling dat de lezer het domein kent |
| **Referentie** | Exacte beschrijving van het systeem | Neutraal, volledig, structuur volgt de code |
| **Uitleg** | Begrip, context en afwegingen | Beschouwend, mag meningen en alternatieven bevatten |

* **Het kompas** als beslisinstrument: stel twee vragen. Gaat het om **doen of weten**? Gaat het om **leren of werken**? Het antwoord vertelt in welk kwadrant een stuk tekst hoort.
* **Werkwijze:** niet eerst alles herstructureren, maar **stap voor stap** verbeteren: kies een stuk, bepaal waar het hoort en verbeter het.

### Wat ik meeneem

* De vier vormen zijn ook voor agents bruikbaar: een agent die een taak uitvoert heeft **how-to + referentie** nodig, en zelden tutorials.
* **Uitleg (het waarom)** hoort apart, bijvoorbeeld als ADR (hoofdstuk 23). Zo blijft referentie kort en vindbaar.
* Een documentatiebestand dat twee vormen mengt (een mappenboom met uitleg over het waarom erdoor) is moeilijker te lezen, voor mensen en voor agents.

---


---

## §23. Architectural Decision Records (ADR)

**Type:** Praktijk / standaard · **URL:** [https://adr.github.io](https://adr.github.io)

---

### 1. Definities

* **Architectural Decision (AD):** een gerechtvaardigde ontwerpkeuze voor een architecturaal belangrijke vereiste.
* **Architecturally Significant Requirement (ASR):** een vereiste met meetbaar effect op de architectuur of de kwaliteit van het systeem.
* **ADR:** een record van **één** beslissing met de redenering, trade-offs en gevolgen.
* **Decision log:** de verzameling ADR's van een project.
* Breder toepasbaar dan architectuur: *any decision record*.

---

### 2. Het Klassieke Sjabloon (Nygard)

```
  # ADR-007: <korte titel als beslissing>
  Status:       Proposed | Accepted | Deprecated | Superseded by ADR-012
  Context:      welke krachten/beperkingen spelen er?
  Decision:     wat we beslissen ("We gebruiken ...")
  Consequences: wat er makkelijker en moeilijker wordt, inclusief nadelen
```

* Een ADR wordt **niet herschreven** wanneer een beslissing verandert. Er komt een nieuwe ADR die de oude **vervangt** (*superseded*). Zo blijft de geschiedenis van het waarom bewaard.
* **Y-statement** (Zdun et al.) als compacte vorm: *"In de context van X, geconfronteerd met Y, kozen we voor Z en tegen W, om A te bereiken, en we aanvaarden B."*
* Gebruikt en aanbevolen door onder meer het Azure Well-Architected Framework en AWS Prescriptive Guidance.

### Wat ik meeneem

* Het **waarom** van een keuze kan een agent nooit uit de code afleiden. Precies daarom hoort het in documentatie.
* Eén beslissing per bestand, met een vaste structuur en een status, is goed vindbaar met grep en voorkomt tegenstrijdige feiten (*context clash*): een vervangen beslissing is expliciet gemarkeerd.
* GymFreak heeft al `docs/decisions/DECISIONS.md` als één groot bestand. Losse ADR's met een status zijn beter vindbaar en tonen duidelijker wat nog geldt.

---


---

## §24. Het C4-model voor Software-architectuur (Simon Brown)

**Type:** Architectuurkader · **URL:** [https://c4model.com](https://c4model.com)

---

### 1. Kernidee

* Een **ontwikkelaarsvriendelijke** manier om architectuur te tekenen: **hiërarchische abstracties** en bijhorende diagrammen, onafhankelijk van notatie en tools.
* Te vergelijken met in- en uitzoomen op een landkaart: elk niveau vertelt een ander verhaal aan een ander publiek.

---

### 2. De Vier Niveaus

```
  1. SYSTEM CONTEXT   het systeem als één doos + gebruikers + externe systemen
         │ zoom in
  2. CONTAINERS       apps, databases, services die apart draaien (web, api, db, ...)
         │ zoom in
  3. COMPONENTS       logische blokken binnen één container
         │ zoom in
  4. CODE             klassen/functies (meestal niet met de hand; afleiden uit code)
```

* Aanvullende diagrammen: **system landscape**, **dynamisch** (een flow in de tijd) en **deployment** (waar draait wat).
* In de praktijk volstaan niveau 1 en 2 meestal. Niveau 4 laat je best automatisch genereren.

### Wat ik meeneem

* Het **containerdiagram** (niveau 2) is het nuttigste architectuuroverzicht voor een agent: welke apps er zijn, hoe ze praten en waar de data staat. Dat is niet afleidbaar uit één bestand.
* Niveau 4 (code) niet met de hand documenteren: dat sluit aan bij hoofdstuk 12, 16 en 20.
* Diagrammen als **Mermaid in Markdown** blijven tekst, dus doorzoekbaar en leesbaar voor een agent.

---


---

## §34. What the 100 biggest GitHub repos put in their AGENTS.md (Coldtea)

**Type:** Blog / field study · **URL:** [https://www.coldtea.ai/blog/agents-md-field-study](https://www.coldtea.ai/blog/agents-md-field-study)

Field study: de `AGENTS.md` van de 100 meest-gesterde GitHub-repos die er één hebben. Geen experiment of slaagkansmeting (zie §20), wel wat grote projecten in de praktijk opschrijven — inclusief een "Score your own AGENTS.md"-checklist.

---

### 1. Steekproef

* Van de top-1000 repos heeft 27% een root-`AGENTS.md`; de 100 meest-gesterde daarvan vormen de steekproef (samen 11,4M sterren).
* Mediaan ongeveer 1.200 woorden; 784 expliciete don't-regels; 90% schrijft in *must* / *always* / *never*.
* Bestanden zijn vooral **operating manuals** (oriëntatie + verificatie), niet alleen rulebooks. Dedicated boundaries nemen relatief meer ruimte bij de giants.

---

### 2. Acht thema's die de meerderheid dekt

Gemeten als aanwezigheid (niet als woordenaandeel). De "Score your own"-checklist volgt deze majority-topics:

1. Expliciete don't-rules
2. Commit- en PR-richtlijnen
3. Testing / validatie
4. Code style & linting
5. Links naar andere docs
6. CI / pre-commit
7. Build & setup-commando's
8. Project structure

Coldtea distilleert daaruit ook een "perfect AGENTS.md"-template (overview → structure → setup → testing → style → git → boundaries). Dat is een corpus-spiegel, geen bewijs dat die vorm agents beter maakt.

---

### Wat ik meeneem

* De **acht vinkjes** zijn bruikbaar als dekkingsaudit bij onderhoud van een agent-router: mist een thema, dan is er een gat — of het feit staat bewust elders.
* Hun template dump **project structure** en **code style** in `AGENTS.md`. Dat botst met "niet documenteren wat afleidbaar is" (§20, P5): structure hoort via de kaart/`ls`, style via linter.
* Don't-rules, commando's, test/validatie-loop en links naar docs: dat sluit aan bij wat hier wél in de kit-`AGENTS.md` staat.
* Score = "kan de agent dit vinden in het systeem?", niet "staat alles inline in één bestand".
* Populaire 2-min-samenvatting van deze studie: **§55** (Better Stack).

---

## §55. Most GitHub Repos Are Doing AGENTS.md WRONG (Better Stack)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=kJ4uDzFAL8k](https://www.youtube.com/watch?v=kJ4uDzFAL8k)

- **Duur:** ~2:06
- **Artikel (in beschrijving):** [Coldtea — agents-md field study](https://www.coldtea.ai/blog/agents-md-field-study) → dichte naslag: **§34**
- **Kern in 2–3 zinnen:** Korte Better Stack-clip die Coldtea’s field study populariseert: de meeste top-repos missen een `AGENTS.md`/instructiebestand; de bestanden die er wél zijn, lijken meer op **operations manuals** dan op pure rulebooks; grotere repos besteden meer ruimte aan *don't*-regels. Eindigt met de acht-punten-checklist uit de studie (percentages) en het advies: zeg hoe te builden/testen én wat nooit mag.

---

#### A. Adoptie & anti-patroon [[00:00](https://www.youtube.com/watch?v=kJ4uDzFAL8k&t=0)]

* Steekproefclaim (video = Coldtea): top-**1.000** GitHub-repos; slechts **27%** heeft zo’n instructiebestand. [[00:00](https://www.youtube.com/watch?v=kJ4uDzFAL8k&t=0)]
* Rest: geen AI, of elke contributor volgt eigen rulesets. [[00:15](https://www.youtube.com/watch?v=kJ4uDzFAL8k&t=15)]

#### B. Operations manual vs. rulebook [[00:15](https://www.youtube.com/watch?v=kJ4uDzFAL8k&t=15)]

* Grootste patroon: bestanden zijn vooral **operation manuals** — architectuurbeschrijving, exacte commands om te runnen/testen — niet alleen abstracte regels. [[00:15](https://www.youtube.com/watch?v=kJ4uDzFAL8k&t=15)]

#### C. Groter repo → strenger (don't-zwaarte) [[00:31](https://www.youtube.com/watch?v=kJ4uDzFAL8k&t=31)]

* Top-100 `agent.md`-bestanden wijden **bijna dubbel** zoveel ruimte aan “wat de agent *niet* mag” t.o.v. kleinere projecten. [[00:31](https://www.youtube.com/watch?v=kJ4uDzFAL8k&t=31)]
* Cijfers (zelfde als §34): **784** zinnen die *don't* impliceren; **90%** van de files met *must* / *always* / *never*. [[00:47](https://www.youtube.com/watch?v=kJ4uDzFAL8k&t=47)]

#### D. Concrete voorbeelden uit grote repos [[00:47](https://www.youtube.com/watch?v=kJ4uDzFAL8k&t=47)]

* **Vercel Next.js:** verbiedt agents om “Generated with Claude Code”-achtige footers in commits te zetten. [[00:47](https://www.youtube.com/watch?v=kJ4uDzFAL8k&t=47)]
* **Bun:** ALL-CAPS-regel — *never run `bun test` directly* omdat dat wijzigingen niet oppikt. [[01:02](https://www.youtube.com/watch?v=kJ4uDzFAL8k&t=62)]

#### E. Lengte-spreiding [[01:02](https://www.youtube.com/watch?v=kJ4uDzFAL8k&t=62)]

* Mediaan ~**1.200** woorden.
* **OpenHands:** &gt; **14.000** woorden.
* **VS Code:** hele file **33** woorden — grotendeels redirect elders. [[01:18](https://www.youtube.com/watch?v=kJ4uDzFAL8k&t=78)]
* Kortste genoemd: **Neovim**, **35** woorden — kern: als AI je commit heeft aangeraakt, zeg dat. [[01:18](https://www.youtube.com/watch?v=kJ4uDzFAL8k&t=78)]

#### F. Acht-dingen-checklist (Coldtea, met % in video) [[01:34](https://www.youtube.com/watch?v=kJ4uDzFAL8k&t=94)]

Video noemt ranking + percentages (aanvulling op de thema-lijst in §34):

| Claim in clip | % (video) |
|---------------|-----------|
| Minstens één expliciete don't-rule | **86%** |
| Commits/PR’s hoe ze eruit moeten zien | ~**79%** |
| Tests + lint uitleggen | ~**¾** |

Afsluiter-advies: bij een nieuw project — zeg hoe te **builden**, hoe te **testen**, en wat de agent **nooit** mag aanraken. [[01:50](https://www.youtube.com/watch?v=kJ4uDzFAL8k&t=110)]

#### Wat ik meeneem

* Geen nieuwe empirie t.o.v. §34 — wel snelle checklist + memorabele repo-voorbeelden (Next.js footer-ban, Bun test-regel, VS Code/Neovim shorties).
* Bevestigt spanning §34 ↔ §20/P5: “operations manual” met architecture dump is gangbaar, niet per se optimaal.
* Don't / must / never + build/test-loop blijft de bruikbare kern voor kit-`AGENTS.md`.
* Geen kit-actie zonder brug: popularisatie van bestaande §34.  
* A8 formaat×publiek: **§123–§127**.

#### Open / onduidelijk

* Video zegt “agent.md” / “instruction files”; Coldtea-studie dekt `AGENTS.md`-achtige bestanden — exacte bestandsnaam-filter niet in deze clip.
* Volledige acht thema’s + template alleen in §34 / artikel, niet uitgeschreven in de 2 min.
* Of “almost double the space” voor don'ts exact gemeten is als woorden/regels — video-claim; details in studie.

---

## §123. Structuring context — AGENTS.md + `.agents/` JSON (ModernizeSpec)

**Type:** Best-practice / vendor-docs · **URL:** [https://modernizespec.dev/best-practices/agent-context/](https://modernizespec.dev/best-practices/agent-context/)

- **Kern (A8):** **Dual by audience** expliciet: `AGENTS.md` = human-readable (agents lezen prose); `.agents/*.json` + `manifest.json` = machine-readable / progressive load. Geen “alles JSON” of “alles MD”.

#### A. Discovery-hiërarchie (claim)

1. Tool-config (`.claude/` / `.cursor/` …)  
2. Root `AGENTS.md`  
3. `.agents/` JSON via manifest  
4. Standaardbestanden (package.json, README)  
5. Grep → 6. full explore (duur)

* Manifest ~200 tokens → alleen relevante JSON laden.  
* AGENTS: tip onder ~400 regels; commands bovenaan; forbidden patterns; géén volledige API/history (→ OpenAPI / ADR).

#### Wat ik meeneem

* Sterkste steun A8-hypothese dual. Lab: MD voor PRODUCT/RULES/ADR; machine-first voor logs/metrics; optioneel later `.agents/manifest` — **geen** massale migratie.  
* Cross §14, §113 (TOC). Vendor-patroon, niet standaard.

#### Open / onduidelijk

* Token-cijfers (50–100×) = auteur-claim, niet gemeten hier.

---

## §124. Agent Skills — YAML frontmatter + Markdown body (Anthropic)

**Type:** Engineering · **URL:** [https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills) · docs: [Agent Skills overview](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview) · open standard (update 2025-12)

- **Kern (A8):** Eén artefact, **twee lagen formaat**: YAML FM (`name`, `description`) altijd in system prompt (~100 tok/skill); MD-body pas bij trigger; scripts/resources als **code** (niet in context) wanneer determinisme nodig.

#### A. Progressive disclosure = formaatkeuze

| Level | Formaat | Wanneer |
|-------|---------|---------|
| 1 Metadata | YAML FM | Always |
| 2 Instructions | Markdown body | On trigger |
| 3+ Resources | MD / code files | On demand / exec |

* Code in skill = tool, niet prose-dump.  
* `description` moet *wat* + *wanneer* (trigger).

#### Wat ik meeneem

* Template voor A8 “dual al normaal” (skills FM).  
* Mens leest MD-body; loader/agent matcht op YAML. Cross §3/§54/§114. Geen kit.

---

## §125. llms.txt v2 — Markdown dat ook parsers aankan

**Type:** Spec / voorstel · **URL:** [https://llmstxt.org/](https://llmstxt.org/) · changes: [https://llmstxt.org/changes.html](https://llmstxt.org/changes.html) · v2 ~2026-08-10 · basis: **§15**

- **Kern (A8):** Bewust **Markdown i.p.v. XML** omdat agents/LLM’s het lezen; toch **vaste skelet** zodat klassieke parsers/regex werken. Mens + agent + tool.

#### A. v2 t.o.v. §15

* Discoverability: `rel="alternate" type="text/markdown"` + `rel="describedby"` → llms.txt.  
* Subpath-llms.txt dekt die path; meest specifieke wint.  
* `.md` append **of** extension-replace ok.  
* Optional-sectie = conventie (hint), geen mechanische tool-semantiek meer (v1 `llms_txt2ctx` weg).

#### Wat ik meeneem

* “MD voor agents” ≠ slordige prose: **constrained MD**.  
* Past A8: curated index in MD; detail achter links. Geen kit-verplichting.

---

## §126. Structured MADR — Markdown + YAML frontmatter (ADR)

**Type:** Spec · **URL:** [https://github.com/zircote/structured-madr/blob/main/SPECIFICATION.md](https://github.com/zircote/structured-madr/blob/main/SPECIFICATION.md) · v1.0.0 · 2026-01-15 · CI: [smadr.dev](https://smadr.dev/guides/ci-validation/)

- **Kern (A8):** ADR blijft **Markdown-body** (mens); **YAML FM** (title, status, tags, dates, …) voor index/CI/LLM-inject. Superset van MADR 4 — geen vervanging van prose door pure YAML.

#### A. Dual zonder tweede canon

* Required FM: title, description, type=`adr`, category, tags, status, created, updated, author, project.  
* Optioneel: `audience`, `related`, technologies.  
* Validatie via JSON Schema; index **genereren** uit FM (anti-drift) — praktijk elders (cloister/adr:index).  
* Security: géén secrets in frontmatter.

#### Wat ik meeneem

* Antwoord op A8 open keuze: **MD canoniek** + optionele FM/index — geen `decisions/*.yaml` als SoR.  
* Cross §23. Lab: pas FM toe als index/check loont; geen verplichte Structured-MADR-adopt.

#### Open / onduidelijk

* Community-spec, niet Nygard/MADR-core; zware audit-sectie mag overkill voor solo-lab.

---

## §127. Cursor Rules — `.mdc` frontmatter vs plain `AGENTS.md`

**Type:** Productdocs · **URL:** [https://cursor.com/docs/rules](https://cursor.com/docs/rules) · verdieping op **§13**

- **Kern (A8):** Zelfde instructietekst, **verschillend formaat voor laadcontrole**. `.mdc` = MD + YAML FM (`alwaysApply`, `globs`, `description`); plain `.md` in `.cursor/rules/` wordt **genegeerd**. `AGENTS.md` = plain MD, geen metadata — eenvoud/portabiliteit.

#### A. Wanneer welk formaat

| Behoefte | Formaat |
|----------|---------|
| Altijd / pad / intelligent / @-only | `.mdc` + FM |
| Simpele projectinstructies, multi-tool | `AGENTS.md` |
| Mens skimmen + agent | Beide MD-body; FM alleen voor *routing* |

* Nested AGENTS.md: path-scope zonder FM.  
* Forum-waarschuwing: symlink AGENTS↔mdc → **dubbele** context — één bron houden.

#### Wat ik meeneem

* Frontmatter = machine-metadata voor **wanneer laden**, niet vervanging van mens-prose.  
* Kit: dun `.cursorrules` → AGENTS; path-rules als `.mdc` alleen als nodig. Geen kit-edit hier.

---


# Ship quality

## §47. Strix — AI-gestuurde pentest-agents (Better Stack + docs)

**Type:** Video + docs · **URL:** [https://www.youtube.com/watch?v=vRTliPb8fjg](https://www.youtube.com/watch?v=vRTliPb8fjg)

- **Kern:** Open-source (en managed) tool waarbij AI-agents als pentesters samenwerken: recon, OWASP Top 10 / API-aanvallen, **werkende PoC’s** (niet alleen “mogelijk kwetsbaar”), remediatie/PR, SARIF/CI. Docker-sandbox verplicht voor self-hosted.
- **Intentie hier:** kandidaat voor **bootstrap/opt-in security-validatie** naast `make check` — niet als vervanging van security.md / P17, wel als uitvoerbare feedbacklus (P13/P14).

---

#### A. Wat de video claimt / demo’t

* Probleem: unit-tests groen ≠ veilig; handmatige pentest duur; klassieke scanners → lawine false positives.
* Strix: multi-agent crew (recon, exploit, …), sandboxed, findings met exploit-bewijs + fix-richting; “quick” scan demo ~10 min (token-/tijd-trade-off vs diepere modes).
* Install: curl-installer of pipx; `strix --target …`; LLM-key (OpenRouter/Anthropic/…); eerste run pulled Docker image.
* Alleen op targets waar je **toestemming** voor hebt (eigen staging / side project).
* Benchmark-claim video: XBOW-achtige exploit-suite ~96% solve, ~19 min/challenge — **vendor/video-cijfer**, verifiëren.
* CI: GitHub Actions / headless `-n`, fail-on severity; coding-agent skills via `npx skills add usestrix/strix`.

#### B. Capaciteiten (docs)

* Targets: lokale map, GitHub-URL, live URL, OpenAPI/Postman, multi-target white-box (code + live).
* Toolkit: HTTP-proxy, browser-exploits, shell in sandbox, Python PoC-runtime, SAST+DAST-achtig.
* Outputs: `vulnerabilities.json/csv`, `findings.sarif`, exit codes (o.a. 2 = vulns found) → agent/CI-vriendelijk.
* Skills-pakket: penetration-testing, fix-vulnerabilities, CI-scanning, OWASP Top 10, API security, …

#### C. Wat performance hier wél/niet is

* Strix is **security**-validatie, geen load/perf-harness. Performance monitoring hoort bij observability (**§48**).
* Wel: “valideer applicatie vóór ship” als breed bootstrap-thema — security + later perf/SLO’s naast elkaar zetten.

#### Wat ik meeneem

* **Uitvoerbare security-feedback** sluit aan op P13/P14/P17 en het gat in veel AGENTS.md’s (§21/~15% security).
* Bootstrap-kandidaat: documenteer `strix` (of gelijkwaardig) als **opt-in** target (`make security-scan` later?), met Docker + API-key + “alleen eigen targets”; niet always-on in `make check` (te traag/duur/niet-deterministisch).
* Skills voor coding agents: interessant, maar supply-chain van third-party skills kritisch bekijken ([skills-veiligheid](fundament/agents/skills-veiligheid.md)).

#### Open / onduidelijk

* Kosten per scan (LLM tokens) op realistische apps.
* False-negative-profiel vs klassieke SAST.
* Licentie/managed vs self-hosted voor school/solo-projecten.

---

## §48. Observability — signalen, correlatie, SLO’s, cardinality (breed overzicht)

**Type:** Overzicht · **URL:** [https://cheatsheets.davidveksler.com/observability-logs-metrics-traces-slos.html](https://cheatsheets.davidveksler.com/observability-logs-metrics-traces-slos.html)

- **Kern:** Elke applicatie die live gaat, moet **observeerbaar** zijn: niet alleen “draait het?”, maar *waarom is het traag/fout/onveilig*. De “7 levels”-video is een didactische ladder; wij nemen die **niet letterlijk** over als standaard, wel alle deelgebieden + uitbreiding naar performance, security-signalen en operationele kwaliteit.
- **Intentie hier:** basis voor latere bootstrap/docs (`docs/architecture/` of ops-runbook) — eerst kennis, dan kit.

---

#### A. De “7 levels”-ladder (als oriëntatie, niet als dogma)

| Level (video) | Signaal | Typische tools in de clip |
|---------------|---------|---------------------------|
| 1 Logs | Wat gebeurde er precies? | Grafana |
| 2 Metrics | Hoe verandert het over tijd? | Prometheus, Grafana |
| 3 Traces | Waar zat de latency in de keten? | OpenTelemetry, Jaeger |
| 4 Correlation | Signalen aan elkaar knopen | OTel, Grafana |
| 5 Alerts | Wanneer wekken we iemand? | Prometheus, PagerDuty |
| 6 SLOs | Wat beloven we de gebruiker? | Datadog, Grafana |
| BOSS Cardinality | Explosie van time series / kosten | Prometheus, Grafana |

Les van de ladder: volwassenheid = niet méér dashboards, maar **verbonden** signalen + alerts die op **symptomen/SLO-burn** staan i.p.v. ruwe CPU-spikes.

#### B. Vollediger signaalmodel (wat we wél willen “overlopen”)

| Signaal | Vraag | Let op |
|---------|-------|--------|
| **Logs** | Exact event / stack / audit | Structured JSON; `trace_id` meenemen |
| **Metrics** | Rate, errors, duration, saturation (RED/USE) | Labels **bounded**; geen `user_id` op metrics |
| **Traces** | Causale pad over services | Context propagation; sampling-beleid |
| **Events** | Deploys, flag flips, failovers | Timestamps + service.version |
| **Profiles** | CPU/mem hot paths | Perf-optimalisatie, niet business-proof |
| **Synthetics** | Scripted user journey van buitenaf | Alleen wat het script ziet |
| **RUM** | Echte browser/UX-latency | Koppelen aan backend IDs |
| **Security telemetry** | Auth-failures, WAF, anomaly, audit | Raakt Strix (§47) + runtime detection |
| **SLOs / error budgets** | Wanneer shippen vs. pagineren | Alert op burn rate, niet op elke spike |

**Correlation-velden (minimum):** `service.name`, `version`, `environment`, `trace_id` / `span_id`, `request_id`.

**Cardinality (de “boss”):** elke unieke labelcombinatie = time series. Hoog-kardinaliteit-IDs horen in logs/traces, niet in Prometheus-labels — anders storage/query-kosten en alert-ruis.

#### C. Performance & veiligheid in hetzelfde frame

* Performance: latency histograms (p95/p99), saturatie, DB/pool metrics, profiles bij hotspots; SLO’s op user-facing latency/availability.
* Veiligheid: security logs + authz-failures als first-class signalen; periodieke **actieve** validatie via Strix-achtige tools (§47); observability ≠ pentest, wel detectie/forensics.
* Agent Engineering-hoek: agents die “fix prod” doen zonder metrics/traces vergroten comprehension debt (§26); harness moet observatie-hooks kunnen hebben zonder always-on essay in AGENTS.md.

#### Wat ik meeneem

* Bootstrap-kandidaat: dunne `docs/architecture/observability.md` (of sectie in architecture) met **welke signalen dit project verplicht** + hoe lokaal/CI ze raakt — inhoud later, structuur nu al denkbaar.
* `make check` blijft snel/deterministisch; zwaardere obs-stacks horen in `check-full` / runtime, niet in unit-check.
* Cardinality + SLO-burn zijn de twee “senior”-lessen die de 7-levels-video impliciet eindigt mee.

#### Open / onduidelijk

* Welke minimale stack voor solo/Next/Nest-kit (OTel + Grafana Cloud vs self-host).
* Of Better Stack (kanaal) als vendor de default mag kleuren — liever open standaarden (OTel) in de standaard noemen.

---


# Product / tooling-rand

## §31. Jev Explained in 7 min (Caleb Writes Code)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=vj7hysh0mOI](https://www.youtube.com/watch?v=vj7hysh0mOI)

Caleb analyseert de opkomst van **Jev** (geproduceerd door TypeSafe AI), een nieuw type gespecialiseerd AI-model dat breekt met het klassieke "Chat & Coding Agent" paradigma en zich richt op **razendsnelle, gestructureerde en probabilistische workflow-automatisering**.

```
                        DE TWEESPRONG IN MODEL-DEVELOPMENT

      Klassieke Autoregressieve LLM's                  Jev (TypeSafe AI)
┌─────────────────────────────────────────┐       ┌─────────────────────────────────────────┐
│ • Geoptimaliseerd voor menselijke pref. │       │ • Geoptimaliseerd voor determinisme &   │
│   en verifieerbare beloningen (RLHF/RL).│       │   probabilistische keuzes.              │
│ • Genereert vrije tekst token per token.│       │ • Geen vrije tekst; stuurt en ontvangt │
│ • Latency: 2 tot 10+ seconden.          │       │   strikte JSON/datastructuren.          │
│ • Rijk aan creativiteit en redenering.  │       │ • Latency: 70 tot 500 milliseconden!   │
└─────────────────────────────────────────┘       └─────────────────────────────────────────┘

```

#### A. De 'Schism in the Orthodox Line' (Waarom LLM's falen in automatisering)

* **Het Probleem:** Generatieve modellen (zoals Claude, GPT, Gemini) zijn geoptimaliseerd om menselijke assistenten of IDE-coding-agents te zijn. Wanneer ze echter worden ingezet voor simpele, repetitieve automatisering (bijv. e-mail routering, RAG-filtering, model-routing, games), schieten ze te kort vanwege hun **hoge latency en trage token-per-token generatie**.
* **Jev’s Assertie:** Het geforceerd duwen van zware, op menselijke interactie geoptimaliseerde LLM's in snelle workflows is fundamenteel fout.

---

#### B. Hoe Jev Werkt: Vrijwel Geen Tekst, Wel Parallel Sampling

1. **Parallel Sampling & Datastructuren:** In plaats van token voor token tekst uit te spugen, verwerkt Jev gestructureerde input en geeft het direct een **waarschijnlijkheidsverdeling (probability distribution)** terug over categorieën of keuzes.
2. **Extreme Snelheid ($40\times$ tot $200\times$ sneller):** Jev haalt end-to-end responstijden van **$70\text{ms}$ tot $500\text{ms}$**.
3. **De Drie Primitieve Typen:**
* `Choice`: Categorieke keuzes selecteren.
* `Score`: Gewogen ordening/prioriteit toekennen.
* `Null` (of Probabilistische Bool): Kans op ja/nee.


* **Analogie:** Werken met Jev voelt volgens Caleb als een terugkeer naar *logische poorten en registers* in software, waarop ontwikkelaars weer snelle, deterministische software-abstracties bouwen.

---

#### C. Context in het Pareto-Frontier

* Jev is niet bedoeld als vervanger voor complexe redeneermodellen, maar bezet een cruciale hoek in het **Pareto-frontier** van AI-modellen: de smalle, extreem snelle laag onder Flash/Nano-modellen.
* Het toont aan dat de AI-markt horizontaal verbreedt: we gaan van *één generiek model voor alles* naar gespecialiseerde micro-modellen voor specifieke taken.

---


---

## §44. This Open-Source Tool Generates UI Like Magic (Better Stack / Warren)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=AhVHtwh5k3E](https://www.youtube.com/watch?v=AhVHtwh5k3E)

Warren (Better Stack, ~7 min, [YouTube](https://www.youtube.com/watch?v=AhVHtwh5k3E), okt 2026) demo’t **generatieve UI** met open-source **Open UI**: apps/iconen on-demand genereren (weer, calculator, coffee shop finder, flight tracker) zonder vooraf geschreven UI-code voor elk geval. Model in demo: **Gemini 3.8 Flash**. Doel: uitleggen wat Open UI is, hoe de compacte taal werkt, en wanneer je het wilt.

---

#### A. Demo: “lege” launcher, UI streamt binnen

* Dashboard met lege apps; typ titel → model genereert UI + icoon; stream zichtbaar; resultaat is interactief (calculator 20+5, maps + coffee shops, YouTube-subscribe-knop als easter egg).
* ChatGPT’s “intelligent UI” = marketingnaam voor vergelijkbare generative-UI-idee; Open UI is de open-spec/tooling-richting.

---

#### B. Wat Open UI wél / niet is

* **Wel:** een **spec** om UI consistent te renderen met *jouw* componentbibliotheek (React, Vue, Svelte; shadcn/Tailwind, Material, …). Optionele eigen component-library — niet verplicht.
* **Niet:** “nóg een UI kit die je moet adopten i.p.v. je design system”.
* Use cases: kleine UI on-demand (data/charts, forms, chat-widgets); niet per se hele product-SPA’s genereren als productie-architectuur.

```
   gebruiker / agent-intent
        │
        ▼
   model antwoordt in OpenUI-lang (regel-voor-regel)
        │
        ▼
   parser → jouw components (React/…) → interactieve UI
```

---

#### C. Waarom geen “gewoon JSON”?

* Klassiek: model → geneste JSON schema van de componentboom → wachten tot **hele** object klaar is → traag, slecht streamen.
* **OpenUI-lang:** compacte, **per-regel** parsebare taal → live streaming + **tokenzuiniger** dan JSON.
* Concurrenten (video-claims):
  * **Vercel JSON Render:** wel line-streamable, maar **&gt;2× tokens** en **&gt;2× latency** vs Open UI (volgens video).
  * **Google A2UI:** vergelijkbaar idee (+ Flutter); weer A2UI-JSON → **&gt;2× tokens** vs OpenUI-lang.
* Les: JSON is fundamenteel verbose voor UI-trees; een dedicated DSL wint op tokens/latency.

Packages genoemd: `open-ui.dev/react` (system prompt met supported components + lang), `open-ui.dev/react/lang` (lang → React). Alles self-hosted open-source in de demo.

---

#### D. Productie-realiteit van de demo

* Lokaal, **niet production-ready**.
* Poging **Cerebras** (~1800 tok/s op Qwen-achtig): te veel broken apps + rate limits → overgestapt op Gemini Flash.
* Toekomstbeeld video: 10k tok/s + secure backend + **user-scoped sandbox**; alleen frontend on-demand, API’s vast — dan wordt “app uit het niets” interessanter.

#### Wat ik meeneem

* Generative UI = **context + component-contract** aan het model geven (P2): supported components in de system prompt = harness rond UI-output.
* Token-efficiënte outputformaten raken P25 (harness/serving tax) — DSL vs JSON meetbaar.
* Voor Agent Engineering-kit: **geen** Open UI als default; wel relevant als je agent-chat UI’s bouwt (module/design of product-UI).
* Ecosysteem: [fundament/ecosysteem](fundament/ecosysteem/INDEX.md) kan Open UI later als stub; nu volstaat §44.
* Risico: on-demand UI zonder sandbox = supply-chain/XSS-achtige surface — productie = verify + isolatie (P14/P17).

#### Open / onduidelijk

* Exacte package-namen/URLs en benchmarkmethodiek “2× tokens” — video-claim; check open-ui.dev docs bij adoptie.
* Modelnaam “Gemini 3.8 Flash” / “Qwen 3.8” — transcript; verifieer tegen actuele model cards.


---

## §64. Why Rust Is The New GOAT For AI (Better Stack)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=R-tLX37Xgx8](https://www.youtube.com/watch?v=R-tLX37Xgx8)

- **Duur:** ~6:24 · upload ~2026-10-24
- **Kern in 2–3 zinnen:** Better Stack over waarom AI-tooling (Copilot runtime, Codex CLI, Bun/Claude Code, xAI) naar **Rust** verschuift: ownership i.p.v. handmatige C/C++-memory of GC-pauses; Copilot session+reply **5.25 s → 292 ms** via native embed i.p.v. Node-subprocess; agents profiteren van compile-errors; Python blijft DX terwijl hot paths (tokenizers, tiktoken, Pydantic v2, **uv**) al Rust zijn; NVIDIA kondigt Rust-GPU-kernels aan (nog niet productie). Geen kit-rewrite — les voor **harness/CLI** rond het model.
- **Cross:** deepseek-recipe Rust **§62**; kit native/Rust-scaffolds = aparte stack, niet deze industrieclip.

---

#### A. Framing: “AGI in Python” → Rust in de tools [[00:00](https://www.youtube.com/watch?v=R-tLX37Xgx8&t=0)]

* 2023-tweet “AGI will be built in Python”; Musk: “Rust”; ~3 j later: xAI-code mostly Rust. [[00:00](https://www.youtube.com/watch?v=R-tLX37Xgx8&t=0)]
* GitHub: Copilot-runtime → Rust; start session + één reply: **&gt;5 s → &lt;300 ms**. [[00:13](https://www.youtube.com/watch?v=R-tLX37Xgx8&t=13)]
* Bun (JS-runtime achter Claude Code, ASR “9 cloud code”): Zig → Rust “this summer”. OpenAI **Codex** CLI: ~**97%** Rust. Teams GitHub→Anthropic herschrijven tools; veel Python-libs draaien al Rust underneath. [[00:19](https://www.youtube.com/watch?v=R-tLX37Xgx8&t=19)]

#### B. Waarom Rust: memory + geen GC [[00:45](https://www.youtube.com/watch?v=R-tLX37Xgx8&t=45)]

* Oorsprong: Graydon Hoare (Mozilla, Vancouver 2006) — lift-software crashes; C/C++ memory. Rust 1.0 mei 2015; Stack Overflow “most admired”; 2025: **72%** van Rust-users wil blijven. [[00:45](https://www.youtube.com/watch?v=R-tLX37Xgx8&t=45)]
* C/C++: use-after-free, double-free, leaks. Microsoft 2019: ~**70%** CVE’s memory-safety; Chrome ~**70%** high-severity memory. Android: new code in Rust; memory-bugs **76%** (2019) → **&lt;20%** “last year”; Google: ~**1000×** fewer memory bugs/line vs Android C/C++. [[01:24](https://www.youtube.com/watch?v=R-tLX37Xgx8&t=84)]
* GC (Python/Node/Go/Java): pauses onbekend. Discord Go-service: latency/CPU spikes ~elke **2 min**; Rust-rewrite: geen spikes. [[02:11](https://www.youtube.com/watch?v=R-tLX37Xgx8&t=131)]
* Rust: **één owner**; free bij einde owner; compile-time checks; snel deels door geen GC. [[02:34](https://www.youtube.com/watch?v=R-tLX37Xgx8&t=154)]

#### C. Copilot / Codex: subprocess → native [[02:57](https://www.youtube.com/watch?v=R-tLX37Xgx8&t=177)]

* Oud: TypeScript + per app eigen **Node**-process via GitHub SDK; ≥~**100 MB** vóór werk. Rust: één native binary/lib; in-process call “als plugin” → **5.25 s → 292 ms**. [[03:01](https://www.youtube.com/watch?v=R-tLX37Xgx8&t=181)]
* Codex CLI: Node eruit (o.a. Node 22+-blocker + perf). [[03:40](https://www.youtube.com/watch?v=R-tLX37Xgx8&t=220)]

#### D. DX, Cargo, agents als co-porters [[03:49](https://www.youtube.com/watch?v=R-tLX37Xgx8&t=229)]

* Compiler: exacte regel + suggestie; **Cargo** build/test/deps — 2025 SO: meest admired tool in categorie. [[03:49](https://www.youtube.com/watch?v=R-tLX37Xgx8&t=229)]
* Android: Rust-changes ~**4×** minder vaak rolled back; ~**25%** minder review-tijd. [[04:13](https://www.youtube.com/watch?v=R-tLX37Xgx8&t=253)]
* Agents: broken Rust → compiler feedback → retry. GitHub-port: ~**430k** TS → **832k** Rust + ~**470k** tests in ~**14.5** weken; Copilot-agents schreven majority. Memory-rule errors slechts ~**1.7%** van agent-compiler-errors. [[04:24](https://www.youtube.com/watch?v=R-tLX37Xgx8&t=264)]

#### E. Python-op-Rust + GPU-kernels [[04:58](https://www.youtube.com/watch?v=R-tLX37Xgx8&t=298)]

* Python blijft makkelijkste AI/data-DX; crunch underneath → Rust: HF **tokenizers** (~**19.6 MB** compiled Rust), OpenAI **tiktoken**, **Pydantic** v2+, **uv** (pip-replacement). [[05:01](https://www.youtube.com/watch?v=R-tLX37Xgx8&t=301)]
* GPU-kernels nog mostly CUDA C++; “last month” NVIDIA: schrijf kernels in Rust — post: **niet** production-ready, wel richting. [[05:34](https://www.youtube.com/watch?v=R-tLX37Xgx8&t=334)]

#### F. Conclusie voor builders [[05:53](https://www.youtube.com/watch?v=R-tLX37Xgx8&t=353)]

* Python-AI schrijven: niet per se switchen — `pip install` is al vaak Rust. **CLI / agent harness** rond een model: GitHub, OpenAI, xAI, Anthropic bewegen naar Rust. [[05:53](https://www.youtube.com/watch?v=R-tLX37Xgx8&t=353)]

#### Wat ik meeneem

* Agent Engineering: latency van **harness/runtime** (Node-subprocess, cold start) kan dominant zijn t.o.v. model-tok/s — meet end-to-end (P25-achtig).
* Compile-errors als agent-feedback-loop = sterke harness-eigenschap; niet “vervang alle Python”.
* Stack-splitsing: notebook/Python DX + Rust hot path is de industrie-default; deepseek-recipe (§62) past in dat patroon.
* Geen kit-actie (geen verplichte Rust-harness); bestaande kit native/Rust blijft opt-in scaffold.

#### Open / onduidelijk

* Primaire bronnen achter Copilot 292 ms / 14.5‑week port-cijfers (blog vs marketing).
* Bun Zig→Rust scope; Anthropic-claim “moving to” vs concrete ship.
* NVIDIA Rust-kernel productnaam/status buiten “last month”-post.

---


---


# Inference

## §29. Inference Engines Explained in 10 min (Caleb Writes Code)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=_xM8scs4_x4](https://www.youtube.com/watch?v=_xM8scs4_x4)

Deze video deconstrueert de onderste lagen van de AI-stack en legt uit hoe gespecialiseerde **Inference Engines** (zoals `llama.cpp`, `vLLM`, `SGLang` en `TensorRT-LLM`) de verwerkingssnelheid en geheugenefficiëntie van autoregressieve LLM's maximaliseren.

```
                               DE AI-INFRASTRUCTUUR STACK
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│ Application / Agent Layer  (Cursor, Claude Code, Windsurf)                               │
├──────────────────────────────────────────────────────────────────────────────────────────┤
│ Harness & Loop Layer       (State Management, Triggers, Worktrees)                       │
├──────────────────────────────────────────────────────────────────────────────────────────┤
│ Inference Engine Layer     (vLLM, llama.cpp, SGLang, TensorRT-LLM)                       │
├──────────────────────────────────────────────────────────────────────────────────────────┤
│ Model Kernel / OS Layer    (PagedAttention, RadixAttention, CUDA, Memory Mapping)        │
├──────────────────────────────────────────────────────────────────────────────────────────┤
│ Hardware Layer             (NVIDIA GPUs, CPU, Apple Silicon, RAM, NVMe SSD)             │
└──────────────────────────────────────────────────────────────────────────────────────────┘

```

##### A. De Evolutie & Het Breukpunt in 2023

Vóór 2023 gebruikte men generieke frameworks zoals PyTorch voor inferentie. Met de opkomst van autoregressieve LLM's (zoals LLaMA) bleek PyTorch ongeschikt: LLM's vereisen specifieke optimalisaties rondom **KV-Cache management, batching en quantisatie**.

---

##### B. De 4 Grote Inference Engines & Hun Doorbraken

###### 1. `llama.cpp` (Hardware Agnostic & Memory Hierarchy)

* **Doel:** Draaien op consumentenhardware (CPU/RAM/Apple Silicon) met een minimale memory-footprint en nul afhankelijkheden (geen PyTorch/CUDA verplicht).
* **Mechanisme (Memory Mapping - `mmap`):** Laadt het model niet geforceerd/eager in de GPU VRAM, maar mapt het bestand direct in het virtuele geheugen van het besturingssysteem. Het OS haalt pas pagina's op naar het RAM-geheugen zodra die nodig zijn.

###### 2. `vLLM` (PagedAttention & Continuous Batching)

* **Doel:** Maximale throughput en verwerkingscapaciteit (concurrency) behalen op enterprise GPU-servers voor duizenden gelijktijdige gebruikers.
* **Het Probleem:** KV-Cache eist enorm veel geheugen op. Oude systemen reserveerden vooraf aaneengesloten blokken geheugen, wat leidde tot $60\% - 80\%$ geheugenfragmentatie.
* **De Oplossing (PagedAttention):** Overgenomen uit virtueel-geheugenbeheer van besturingssystemen. De KV-Cache wordt opgedeeld in kleine, vaste blokken (pages) die overal in de VRAM verspreid mogen liggen.
* **Continuous / In-Flight Batching:** Zodra één verzoek in de batch klaar is met genereren, schuift een nieuw verzoek direct in de actieve batch in plaats van te wachten tot de hele batch afgerond is.

###### 3. `SGLang` (RadixAttention & Prefix Sharing)

* **Doel:** Extreme versnelling van prompts die dezelfde instructies of context delen (bijv. veel gebruikers die starten met *"Je bent een nuttige assistent..."* of agent-harnesses met dezelfde system prompt).
* **De Oplossing (RadixAttention):** Een boomstructuur (*radix tree*) waarin de KV-caches van gedeelde prompt-prefixes bewaard blijven in het geheugen. Bij een nieuwe query hergebruikt de engine de bestaande KV-cache van de prefix in plaats van deze opnieuw te berekenen. Dit levert tot **$6,4\times$ hogere throughput** op.

###### 4. `TensorRT-LLM` (NVIDIA Stack Vertical Integration)

* **Doel:** NVIDIA’s eigen gesloten softwarestack om maximale prestaties en lage *Total Cost of Ownership* (TCO) uit hun eigen GPU-hardware (zoals H100/B200) te persen.

---

## §45. 1-Bit LLM: The Most Efficient LLM Possible? (bycloud)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=7hMoz9q4zv0](https://www.youtube.com/watch?v=7hMoz9q4zv0)

bycloud (~14,5 min, [YouTube](https://www.youtube.com/watch?v=7hMoz9q4zv0), jun 2025) legt uit waarom frontier **open weights** voor de meesten onbruikbaar zijn (hardware), hoe **quantisatie** helpt, en waarom **BitNet** (train-from-scratch met ~1-bit / 1.58-bit weights) verder gaat dan post-hoc INT4. Cijfers zijn claims uit de video/papers zoals geschetst — niet zelf gemeten.

```
   HARDWARE-LADDER (video-frame)

   DeepSeek-V3-klasse  →  GPU-cluster ~$400k+  (meeste mensen: onhaalbaar)
   Distill / kleinere FP16 → nog vaak ~$20k GPU
   7B / 1.5B FP16      →  consumer-GPU, “te klein brein”
   Quantisatie / BitNet →  zelfde parameter-count, minder bits per weight
```

---

#### A. Waarom geheugen = bits × parameters

* Model ≈ functie \(f(x)=y\) met gewichten (parameters) uit training.
* Standaard: gewichten in **FP16** (~16 bit/gewicht). Vuistregel video: 7B params × 2 bytes ≈ **~14 GB** VRAM als alles op GPU moet.
* Te weinig VRAM → **offload** (weights roteren CPU↔GPU) → grote latency.
* **Quantisatie:** minder bits per weight (FP8, INT4, …) → minder VRAM, maar coarser numerieke resolutie (FP16 stap ~0.001 vs FP8 ~0.125 vs INT4 discrete integers) → afronding → accuracy-risico. Post-quant vaak **calibration** / fine-tune.

Trade-off video: **grote model @ FP8** is vaak slimmer én goedkoper dan **veel kleiner model @ FP16** — literatuur ondersteunt “quantized large ≻ tiny full-precision” in veel settings (details via papers / findmypapers.ai in video).

---

#### B. BitNet: trainen mét 1-bit weights (niet alleen achteraf knijpen)

* Paper-lijn (okt 2023 e.v.): **BitNet — Scaling 1-bit Transformers for LLMs**.
* Idee: weights alleen **{+1, −1}** → theoretisch ~**16×** minder opslag vs FP16; matmul → grotendeels **optellen/aftrekken**.
* **Niet** alles kan 1-bit: attention / activations blijven kritiek. Praktijk: o.a. **BitLinear** i.p.v. standaard dense matmul op (delen van) linear projections.
* Cruciaal verschil met post-hoc quant: BitNet wordt **from scratch** met dit regime getraind → stabiliteit (“build for the regime” i.p.v. “salvage FP16”).
* Video-claim energie: pure 1-bit setup ~**30×** minder energie vs 7B full precision (beter dan naïeve 16× storage-intuïtie).

**Flaw van pure ±1:** er is geen **0** → geen “dode” verbindingen; elk gewicht stuurt altijd een signaal.

---

#### C. BitNet b1.58 — ternair {−1, 0, +1}

* ~4 maanden later: **BitNet b1.58** — derde toestand **0** → **sparsity** (verbinding uit).
* Naam **1.58**: informatie-inhoud per weight met 3 staten ≈ \(\log_2 3 \approx 1.58\) bits.
* Behoud voordeel: geen volle matmul nodig.
* Video-cijfers vs LLaMA-baseline (zelfde onderzoeksgroep, claims):

| Setup | Memory | Snelheid / performance (video) |
|-------|--------|--------------------------------|
| LLaMA-achtig 1.3B vs BitNet b1.58 | ~**3×** minder mem BitNet | ~**2.66×** sneller; quality lager dan FP LLaMA bij 1.3B |
| 3B | ~**3.5×** minder mem | ~**2.7×** sneller; **match/beat** FP baseline op board |
| Schaal naar 70B | tot ~**7.16×** minder mem vs LLaMA 70B | Trend: groter → BitNet relatief sterker |
| 70B BitNet b1.58 vs 13B FP | efficiënter in speed/mem/energy | Video: 70B BitNet “beter efficiënt” dan 13B full precision |

**Scaling-suggestie video:** hoe meer parameters, hoe beter BitNet meekomt — promising scaling law-achtig gedrag.

Nog steeds: **activations** vaak 8-bit; **KV-cache** blijft knelpunt bij lange context.

---

#### D. BitNet a4.8 — activations + 3-bit KV-cache

* Paper **BitNet a4.8**: activations **4-bit** voor attention/FFN-inputs; **8-bit** voor intermediaire staten (attention outputs e.d.) omdat outliers/distributies anders niet convergeren (video: pure 4-bit overal convergeert niet).
* **3-bit KV-cache:** weinig average-accuracy-degradatie in hun benches; vs 16-bit cache ≈ **~5× grotere context** bij gelijk geheugenbudget (video).
* Sparsity via nullen: ~**55%** van parameters actief per input (MoE-achtige “active params”-intuïtie).
* Training-tokens: vroege BitNet-tests tot 7B met ~**100B tokens** — laatste horde = **triljoen**-token schaal.

---

#### E. BitNet b1.58 2B4T — 2B params @ 4T tokens

* Paper/model **b1.58-2B-4T** (video: “B1.5A to B4T”): 2B parameters, **4T** tokens.
* Rough FLOPs-schatting video: \(6ND\) met 20× energy/FLOP-reductie-aanname → goedkope train-runs op A100-huur (illustratief: ~$33 voor 1B tokens-achtig scenario; ~$1.3k voor 4T-run vs ~$26k zonder 20× — **illustratief**, geen lab-invoice).
* Memory footprint ~**0.4 GB**; vergelijkbaar met **Qwen2.5-1.5B**-klasse terwijl die ~**18T** tokens zag (4.5× meer data) — video claimt vergelijkbare quality bij **~12.4×** minder energy (niet exact 20×) en **5–12×** minder memory vs peers in hun tabel.
* **Hardware-gap:** geen native ternary/1.58-bit silicon → BitNet draait **suboptimaal** op huidige GPU’s; winst bij dedicated ops zou groter zijn.
* Hugging Face: BitNet b1.58 2B4T + demo; verdere ternary-transformer papers in video-eindlijst.

```
   EFFICIENCY STACK (BitNet-lijn)

   weights:  FP16 → post-hoc INT4 → BitNet ±1 → b1.58 {−1,0,+1}
   acts:     FP16/FP8 → a4.8 (4-bit in, 8-bit mid)
   KV:       FP16 → 3-bit (a4.8) → langere context / zelfde VRAM
   sparsity: zero-state → ~55% active
```

#### Wat ik meeneem

* Past bij [fundament/efficientie/optimalisatie.md](fundament/efficientie/optimalisatie.md), [inference/lokaal-hardware.md](fundament/inference/lokaal-hardware.md) (jouw ~20 GB VRAM: quant/BitNet-achtige gewichten = grotere effectieve models), P26.
* **Post-hoc quant ≠ BitNet:** train-for-the-bitwidth > squeeze-after.
* KV-cache bits tellen hard voor lange agent-context (§29, caching) — 3-bit KV is aparte hefboom naast weight-quant.
* Geen kit-default; wel relevant voor lokale/open serving. Ternary zonder hardware-support = paper-winst ≠ volle product-speedup.

#### Open / onduidelijk

* Exacte paper-titels/arXiv (BitNet, b1.58, a4.8, 2B4T) en benchmarktabellen — video-samenvatting; bij citeren primaire papers checken.
* FLOPs/$ train-illustraties zijn back-of-envelope met aannames (20×, A100 $2/h).
* Sponsorsegment (Tena) overgeslagen voor technische naslag.


---

## §49. Colibrì — MoE-experts streamen van disk (tiny engine, immense model)

**Type:** Repo / tool · **URL:** [https://github.com/JustVugg/colibri](https://github.com/JustVugg/colibri)

- **Kern:** Engine (puur C, per model-family) om **zeer grote MoE-modellen** (referentie **GLM-5.2 ~744B**, ~40B actief/token) lokaal te draaien door **routed experts te streamen** van NVMe/disk; dense deel resident in RAM; optioneel hot experts in VRAM. Placement bepaalt **snelheid**, niet de router-beslissingen of precisie.
- **Gebruikersoordeel hier:** interessant om van te leren; **niet** als dagelijks agent-model (vaak ≪1 tok/s op bescheiden HW — “MEGA traag”). Wel: les in memory hierarchy, MoE, JIT-placement, meetbare optimalisatie.

---

#### A. Waarom MoE “klein per token” is

```
  GLM-5.2 ~744B total
       │
       ├─ dense (attn, shared experts, embeddings) → ~resident in RAM (~10 GB int4-orde)
       └─ ~19k routed experts on disk (~370 GB int4-orde)
              └─ per token: router kiest subset (~40B actief; ~11 GB “wisselt”)
```

* Je hoeft niet 744B in VRAM te passen; je moet **plaatsen**: VRAM ⊃ hot, RAM ⊃ warm, disk ⊃ cold.
* Analogie uit project: compiler-JIT compileert hot paths; colibrì “JITt” **weights** op gemeten routing-heat.

#### B. Pipeline per laag/token (vijf stappen — projectclaim)

1. **Route** — welke experts?
2. **Union** — set over lagen/batch
3. **Place** — VRAM / RAM / disk
4. **Overlap** — I/O verbergen achter compute waar mogelijk
5. **Learn** — heat/cache-policy bijwerken (LRU, pin-profiles)

Designregel: placement wijzigt **nooit stil** de modelantwoorden of quant-semantiek; trager mag, “ander model” niet.

#### C. Snelheid — eerlijke cijfers (orde, hardware-afhankelijk)

* Bottleneck ≈ **disk bandwidth** (NVMe ≫ HDD; WSL `/mnt/c` = trap).
* Voorbeelden uit README/HN: cold laptop 25 GB RAM → 0.05–0.1 tok/s; grotere RAM/GPU-stacks tot enkele tok/s of hoger op multi-GPU; Kimi K3-schaal nog trager per token.
* GPU: dense + hottest experts in VRAM; **niet** VRAM volproppen met experts ten koste van dense/activations.

#### D. Lessen voor performance / optimalisatie (herbruikbaar denken)

| Les | Toepassing buiten colibrì |
|-----|---------------------------|
| Memory hierarchy expliciet maken | Agent-tools, RAG-indices, model-offload: hot/warm/cold |
| Meet routing/access heat vóór je “optimaliseert” | Prefetch, pin, cache — policy op data, niet op gevoel |
| Capacity vs latency trade-off | Groter model lokaal ≠ bruikbaar voor interactieve agents |
| Reproducible end-to-end metrics | Optimalisatie verdient plaats met meting (past bij `meten/`) |
| MoE: “totale params” ≠ “actieve cost” | Modelkeuze (P26): active params + I/O-pad tellen |

#### Wat ik meeneem

* **Geen** colibrì in bootstrap als default runtime.
* Wél: fundament-pointer onder inference/efficiëntie — “expert streaming / weight JIT” naast quant (§45) en engines (§29).
* Voor agents: snelle smalle modellen + goede omgeving winnen meestal van frontier-MoE-op-disk (P25/P26).

#### Open / onduidelijk

* Exacte engine-versies/modellen wijzigen snel — cijfers in README periodiek checken.
* Of overlap-I/O-trucs relevant zijn voor kleinere MoE’s in vLLM/SGLang (andere stack, zelfde hiërarchie-idee).
* Interactief 16 GB / KV-budget: **§63** (tegenpool van disk-MoE).

---

## §56. How Did DeepSeek Make V4 So Cheap? (bycloud)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=gC76aeibdFA](https://www.youtube.com/watch?v=gC76aeibdFA)

- **Duur:** ~21:13 (part 1 model/attention; infra → aparte video, playlist-slice 8)
- **Kern in 2–3 zinnen:** bycloud vat het DeepSeek-V4 technical report (~58 pp) samen: **Pro** + **Flash** met native **1M** context, vooral via **CSA** (compressed sparse attention) + **HCA** (heavily compressed attention) + 128-token sliding window — niet via “linear attention”. Kernclaim: long-context serving **veel goedkoper** (API ~75% korting t.o.v. eerdere prijsniveaus; KV/FLOPs-fracties vs V3.2). Daarnaast MHC, MoE-tweaks, Muon, specialist-RL → on-policy distillation, think-modes. Cijfers = video/paper-claims.
- **Vervolg:** V4.1 Flash → **§58**; infra-diepte → **§60**.

---

#### A. Framing: niet “beste bench”, wel long-context + prijs [[00:00](https://www.youtube.com/watch?v=gC76aeibdFA&t=0)]

* Release: V4 **Pro** + **Flash** + technisch rapport. Open-weights ranking (video): ~3e achter o.a. Kimi K2.6 / MiMo V2.5 Pro — “lost their touch”-kritiek weerlegt video met efficiency-claim. [[00:00](https://www.youtube.com/watch?v=gC76aeibdFA&t=0)]
* Native **1M** context + “near SOTA retrieval”; rates claim **10–100×** goedkoper (orde, video). [[00:27](https://www.youtube.com/watch?v=gC76aeibdFA&t=27)]
* API-prijs (video, $ / M tokens): input **0.435**, output **0.87**, cache-hit **0.03625** (transcript: “0.3625” waarschijnlijk typo-orde — clip zegt cache hit veel lager); ~**75%** discount, later permanent. Vergelijk GLM 5.1 (~1.4/4.4), Gemini 3.1 Pro (~2/12), Opus 4.6 (~5/25). Margin-guess 50–70% zoals V3. [[00:54](https://www.youtube.com/watch?v=gC76aeibdFA&t=54)]
* Visie: niet benchmark-maxing maar **long context** als bottleneck; V3.2 had al nieuwe attention; V4 introduceert **twee** mechanismen. [[01:47](https://www.youtube.com/watch?v=gC76aeibdFA&t=107)]

*(Sponsor Crusoe serverless fine-tuning ~[02:38](https://www.youtube.com/watch?v=gC76aeibdFA&t=158)–[03:53](https://www.youtube.com/watch?v=gC76aeibdFA&t=233) — overgeslagen.)*

#### B. CSA — Compressed Sparse Attention [[04:19](https://www.youtube.com/watch?v=gC76aeibdFA&t=259)]

* Klassiek: KV groeit **1 entry / token** → 1M tokens = 1M slots. [[04:44](https://www.youtube.com/watch?v=gC76aeibdFA&t=284)]
* CSA: comprimeer elke **4 tokens → 1 KV-entry** (niet naïeve average): tokens leveren candidate KV + **compression weights**; geleerde samenvatting. [[05:10](https://www.youtube.com/watch?v=gC76aeibdFA&t=310)]
* Daarna: **lightning indexer** scant compressed memory en kiest alleen relevante compressed blocks (zelfde familie als DSA in V3.2, maar over compressed blocks i.p.v. raw tokens). [[05:35](https://www.youtube.com/watch?v=gC76aeibdFA&t=335)]

#### C. HCA — Heavily Compressed Attention [[06:01](https://www.youtube.com/watch?v=gC76aeibdFA&t=361)]

* Aggressiever: elke **128 tokens → 1 KV-entry** → ~**32×** lichter geheugen dan CSA. [[06:01](https://www.youtube.com/watch?v=gC76aeibdFA&t=361)]
* Dan **dense** attention over die zwaar gecomprimeerde memory = goedkoop **globaal** overzicht, minder precies dan CSA. [[06:28](https://www.youtube.com/watch?v=gC76aeibdFA&t=388)]

```
  short  │  mid (CSA)              │  long (HCA)
  ───────┼─────────────────────────┼──────────────────
  128 tok│ 4 tok → 1 KV + sparse   │ 128 tok → 1 KV
  window │   index select          │   + dense attn
  (raw)  │                         │   (global, cheap)
```

#### D. Interleave + sliding window; géén linear attention [[06:53](https://www.youtube.com/watch?v=gC76aeibdFA&t=413)]

* CSA : HCA = **1:1** interleaved. Beide krijgen een **128-token sliding window** van uncompressed KV (recente tokens niet te vroeg samenvatten). [[06:53](https://www.youtube.com/watch?v=gC76aeibdFA&t=413)]
* Drie geheugens: short / mid / long. Cost blijft **kwadratisch**, maar trager groeiend — **niet** linear attention. [[07:19](https://www.youtube.com/watch?v=gC76aeibdFA&t=439)]

#### E. Modelmaten & efficiency vs V3.2 / GQA [[07:45](https://www.youtube.com/watch?v=gC76aeibdFA&t=465)]

| Model | Total / active (video) | Context |
|-------|------------------------|---------|
| V4 Pro | **1.6T** / **49B** | 1M |
| V4 Flash | **284B** / **13B** | 1M |
| (ref) Kimi K2.6 | ~1T total | — |

* Bij 1M tokens vs V3.2: Pro ≈ **27%** single-token inference FLOPs, ≈ **10%** KV-cache (~9.5× kleiner); Flash ≈ **7%** KV (~13.7×). [[08:11](https://www.youtube.com/watch?v=gC76aeibdFA&t=491)]
* Lineage: V2/V3 **MLA** ≈ 3.6× kleiner KV vs GQA; V3.2 **DSA** sparsely leest ~**2048** KV entries (~64× fewer reads @ 128k — transcript “248” waarschijnlijk 2048). V4 = DSA-achtig *plus* memory shrink. [[08:11](https://www.youtube.com/watch?v=gC76aeibdFA&t=491)]
* Totaal vs GQA-baseline (Llama 2/3-achtig): ~**34×** (Pro) / ~**49×** (Flash) KV-reductie (video-rough). [[09:01](https://www.youtube.com/watch?v=gC76aeibdFA&t=541)]
* Prijsnarratief: ~75% lager per token vs V3.2; “zelfde budget: 7 jaar DeepSeek vs 4 maanden Claude” (illustratief). [[04:19](https://www.youtube.com/watch?v=gC76aeibdFA&t=259)]

#### F. MHC, MoE, hash routing, Muon, data [[09:01](https://www.youtube.com/watch?v=gC76aeibdFA&t=541)]

* **MHC** (manifold constraint hyperconnections): residual stream → meerdere paden, learn mix before/after layer → meer capaciteit over diepte. [[09:01](https://www.youtube.com/watch?v=gC76aeibdFA&t=541)]
* MoE: DeepSeek-MoE, **256** fine-grained routed + shared experts; router: Sigmoid → **square-root softplus**; sequence-level balance loss. [[09:27](https://www.youtube.com/watch?v=gC76aeibdFA&t=567)]
* Vroege lagen: niet meer dense; **hash routing** op token-ID (stabiel pad vóór rijke context). [[10:18](https://www.youtube.com/watch?v=gC76aeibdFA&t=618)]
* Pretrain: Flash ~**32T** tokens, Pro ~**33T** (≈ dubbel eerdere DeepSeek-runs; Kimi K2.5 ~30T genoemd). [[10:43](https://www.youtube.com/watch?v=gC76aeibdFA&t=643)]
* Optimizer: **Muon** (Keller Jordan Dec 2024; Kimi scale Feb 2025) voor meeste params; **AdamW** voor embeddings, heads, RMSNorm, sommige MHC. Claim: snellere convergentie + stabiliteit. Diepte: **§65**. [[11:08](https://www.youtube.com/watch?v=gC76aeibdFA&t=668)]
* Data-trucs (weinig detail): V3-style prep, 128k vocab; **token splitting**; **fill-in-the-middle**; packing + **sample-level attention masking**; special token **DSML** (XML tool-calls). [[11:58](https://www.youtube.com/watch?v=gC76aeibdFA&t=718)]

#### G. Post-training: specialisten → on-policy distillation; think modes [[13:13](https://www.youtube.com/watch?v=gC76aeibdFA&t=793)]

* Finale model **niet** direct RL op één mix. Kopieën van base → **specialisten** (math, coding, agent, instruction); apart trainen. [[13:13](https://www.youtube.com/watch?v=gC76aeibdFA&t=793)]
* Verifiable: o.a. **GRPO**; anders generative reward model (DeepSeek-V4-based) met prompt-specific rubrics. [[13:38](https://www.youtube.com/watch?v=gC76aeibdFA&t=818)]
* Unificatie: **on-policy distillation** van meerdere teachers → één model (minder conflict dan één giant RL-mix). [[14:04](https://www.youtube.com/watch?v=gC76aeibdFA&t=844)]
* Modes: non-thinking; **thinking high** (explicit reasoning tokens); **think max** (langer, zwakkere length penalty, andere system prompts). “Pro Max” / “Flash Max” = zelfde arch + max effort, geen aparte stack. Varianten: Pro, Pro Base, Pro Max, Flash, Flash Base, Flash Max. [[14:54](https://www.youtube.com/watch?v=gC76aeibdFA&t=894)]
* Flash (13B active) claim: vergelijkbaar met GPT-5.2 / Gemini 3.0 Pro op reasoning *met groter thinking budget* — cheap 1M maakt test-time scaling betaalbaar. [[15:46](https://www.youtube.com/watch?v=gC76aeibdFA&t=946)]
* Pro Max: sterkste open (vendor); Artificial Analysis e.d. top-2/3; ~3–6 maanden achter frontier closed op reasoning; long-context soms boven Gemini 3.1 Pro (academic). [[16:11](https://www.youtube.com/watch?v=gC76aeibdFA&t=971)]

#### H. Serving-stack: FP4 QAT experts, Huawei [[17:28](https://www.youtube.com/watch?v=gC76aeibdFA&t=1048)]

* Na goedkopere attention verschuift bottleneck naar **expert weights** (sparse MoE). V4: **FP4 quantization-aware training** voor MoE experts (niet alleen post-hoc quant). [[17:28](https://www.youtube.com/watch?v=gC76aeibdFA&t=1048)]
* China NVIDIA-beperking → Huawei; day-zero Huawei inference; CSA indexer ook lagere precisie. Hele stack rond “1M context affordable”. [[17:53](https://www.youtube.com/watch?v=gC76aeibdFA&t=1073)]
* Anecdote paper: sommige Kimi/GLM-entries blank omdat APIs te busy — capacity/serving > alleen capability. [[19:10](https://www.youtube.com/watch?v=gC76aeibdFA&t=1150)]

#### Wat ik meeneem

* Long-context agents (tool dumps, codebases) raken **KV/attention-economie** harder dan “meer params”; CSA+HCA+window is les in multi-resolution memory (§8 attention budget, §29 engines).
* Cheap long context → **test-time compute** (think max) wordt rationeel — parallel aan verifier/environment (§37), niet alleen betere prompts.
* Post-train: specialisten + distillatie i.p.v. één RL-soep — bruikbaar denken voor multi-skill agents zonder kit-actie.
* Geen kit-default: DeepSeek-serving/Huawei/FP4 QAT is lab-infra; wel relevant voor bachelor/kenniskaart Inference.
* Infra-nuances → volgende bycloud-video (slice 8); niet hier verdubbelen.

#### Open / onduidelijk

* Exacte cache-hit prijs ($0.03625 vs transcript-twijfel); fair compute bij ARC/bench-vergelijkingen.
* CSA indexer-selectie-k (2048?) en paper-tabellen — video-rough.
* V4.1 Flash (CSA2, CED, …): **§58**. Speculative decode (DSpark): **§61**.
* NVFP4 / train-for-FP4-inference: **§57**.

---

## §57. NVIDIA Made 4-Bit AI Work. It’s a Nightmare. (bycloud) — NVFP4

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=mTd3tBpfYmw](https://www.youtube.com/watch?v=mTd3tBpfYmw)

- **Duur:** ~19:51
- **Kern in 2–3 zinnen:** bycloud legt uit waarom **NVFP4** (NVIDIA’s microscaled FP4) bestaat: 4-bit is goedkoop voor move/store/compute, maar training divergeert zonder een volledige **recipe** (gevoelige lagen hoger, 2D weight-blocks, Hadamard, stochastic gradient rounding). Tegenover oudere **MXFP4**: kleinere blocks (16 vs 32), **E4M3 FP8** block-scales + **FP32** tensor-scale. Hardware (Blackwell/Rubin) adverteert PFLOPS in FP4 — napkin-math over mixed FP4/BF16-speedups. Cijfers = video/paper-claims.
- **Papers genoemd:** *Pretraining Large Language Models with NVFP4* (arXiv:2505… / video “MVFP4”); Nemotron-3 Ultra e.d. · Cross: BitNet/post-hoc quant **§45**; DeepSeek FP4 QAT **§56**.

---

#### A. Waarom precisie / Vera Rubin-marketing [[00:00](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=0)]

* Marketing: “50 PFLOPS @ NVFP4” — weinig mensen snappen wat dat betekent. Video: waarom NVIDIA FP4 naar de LLM-frontier duwt. *(Niet NVIDIA-gesponsord.)* [[00:00](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=0)]

*(Sponsor Crusoe ~[00:23](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=23)–[01:31](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=91) — overgeslagen.)*

#### B. Bits, FP vs BF, exponent/mantissa [[01:31](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=91)]

* Precisie = bits per getal: FP32 / BF16 / FP8 / FP4 — kleiner = goedkoper verplaatsen, opslaan, vermenigvuldigen. [[01:31](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=91)]
* Float = **sign + exponent + mantissa**. Voorbeeld 6250 ≈ 6.25×10³; minder mantissa → 6200 / 6000 (fout 50 / 250). Minder exponent → bereik verdwijnt. [[02:39](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=159)]
* **FP16:** meer mantissa (detail), kleiner bereik. **BF16** (Google Brain): FP32-achtig exponentbereik, kortere mantissa → populair in training (gradients/activations over schalen zonder overflow). [[03:47](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=227)]
* Onder BF16 (FP8/FP4): rounding-fouten stapelen over miljarden ops → weights/activations/attention/gradients fragiel. Training wil vaak hogere precisie; inference verdraagt meer fout. [[04:33](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=273)]

#### C. MXFP4 → NVFP4 (microscaling) [[05:17](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=317)]

* **MXFP4:** 4-bit waarden + **gedeelde scale** per block van **32** waarden; scale was **power-of-two** (64 of 128 i.p.v. ideale 70). Outliers in een block verpesten kleine waarden of clippen grote. [[05:41](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=341)]

| | MXFP4 | NVFP4 |
|---|-------|-------|
| Block | 32 values | **16** values |
| Block scale | power-of-two | **FP8 E4M3** (4 exp + 3 mant) |
| Extra | — | **FP32** tensor-scale (globaal bereik) + lokale FP8 scales |

* Kleinere blocks = localere quantisatie; E4M3 = fijnere scales maar minder bereik → FP32 tensor-scale eerst. Complexer dan “gewoon FP4”. [[06:48](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=408)]

#### D. Training-recipe (vier stukken) [[07:57](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=477)]

1. **Gevoelige lagen hoger:** alle linear layers @ FP4 → diverge. Laatste ~**15%** van het netwerk hoger houden (meestal nabij einde). Paper *Pretraining LLMs with NVFP4*. [[08:20](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=500)]
2. **2D block scaling voor weights:** forward vs backward (transpose) mag niet andere quantisatie van dezelfde matrix zien. I.p.v. 1×16 langs één as → **16×16** patches (256 values / scale) zodat zelfde scale bij transpose. Coarser, maar weights zijn trainable en “passen zich aan”. [[08:42](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=522)]
3. **Random Hadamard transforms:** mix vector vóór quant zodat één outlier de scale niet domineert; magnitude blijft (dot products / matmul). [[10:32](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=632)]
4. **Stochastic rounding op gradients:** deterministisch 0.3→0 verliest signaal; stochastisch P(→1)=0.3 bewaart verwachting over updates. [[11:39](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=699)]

#### E. Empirie (video-claims) [[12:23](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=743)]

* 12B hybrid Mamba-Transformer, **10T** tokens NVFP4 vs FP8: val-loss gap meestal **&lt;1%**; downstream ~gelijk, coding iets zwakker. [[12:23](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=743)]
* Nemotron-3 Nano (~3B active): NVFP4 vs BF16 gap **&lt;1%**. Grotere MoE **8B active:** gap **&lt;0.6%** → grotere models absorberen FP4-ruis beter (video). [[12:46](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=766)]
* **Nemotron-3 Ultra:** 550B MoE / **55B** active / token; pretrain NVFP4 op **20T** tokens. Hoger: laatste 15% (=16/108 layers), Mamba out-proj, latent/QKV/attn proj, MTP, embeddings. [[13:32](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=812)]
* Ablatie: checkpoints @ 5/10/16T → switch alles BF16 + 74B tokens verder; relative train-loss gap gemiddeld **&lt;0.4%**; na 74B BF16 nog ~0.33–0.34%, zelfs **0.03%** vanaf 16T-checkpoint. [[13:54](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=834)]
* Llama 3 8B & 405B @ NVFP4: ~**1.3–1.73×** vs FP8, nauwelijks accuracy-verlies (video). [[18:05](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=1085)]

#### F. Hardware: waarom PFLOPS in FP4 [[14:43](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=883)]

* Blackwell **GB200** (paper-claim): FP8 ≈ **2×** BF16 throughput; FP4 ≈ **4×** BF16 (pack) / op **GB300** FP4 ≈ **6×** BF16 door bredere FP4 datapath. [[15:05](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=905)]
* **Rubin** (SemiAnalysis, video): dense FP4 ~**3.5×** vs GB200 (1.4× SM blocks × 2× FP4 tensor-core width × 1.25 clock); BF16/TF32 slechts ~**1.6×**. [[15:49](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=949)]
* **35 PFLOPS** = dense FP4; **50 PFLOPS** = inference peak via transformer engine + adaptive compression (meer zeros → dichter bij 50) — niet elke dense GEMM. [[16:13](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=973)]
* Napkin (85% FP4 / 15% BF16 zoals Ultra): GB200 ~**2.8×** vs all-BF16; GB300 ~**3.4×**; Rubin ~**2.3×** sneller dan GB200 op die mix (video-reken). [[16:58](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=1018)]
* Koppeling industrie: DeepSeek e.d. trainen met FP4-adaptatie voor accurate FP4-inference (**§56**). [[18:28](https://www.youtube.com/watch?v=mTd3tBpfYmw&t=1108)]

#### Wat ik meeneem

* “4-bit” ≠ één knop: **format + scaling + training recipe + welke lagen**. Post-hoc INT4 (§45) ≠ NVFP4 pretrain.
* Outliers + forward/backward quant-mismatch zijn de “nightmare”; Hadamard + 2D scales + stochastic rounding zijn de mitigaties.
* Marketing-PFLOPS lezen met conditional (dense vs sparse/compressible inference).
* Agent Engineering: relevant voor **kosten van lange agent-runs** (serving) en bachelor Inference — geen kit-default (geen NVIDIA-stack in bootstrap).
* Grotere models tolereren quant-noise beter (video) — parallel “large quantized ≻ tiny FP16” (§45).

#### Open / onduidelijk

* Exacte arXiv-ID / of transcript “MVFP4” overal = NVFP4.
* Of 2D 16×16 verplicht is buiten NVIDIA’s stack; reproduceerbaarheid op non-Blackwell.
* Fairness napkin-math vs echte end-to-end train wall-clock (I/O, MoE, etc.).

---

## §58. DeepSeek-V4.1 Flash: The Most Insane Optimization So Far (bycloud)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=CsSnSBCVoDU](https://www.youtube.com/watch?v=CsSnSBCVoDU)

- **Duur:** ~25:04 · paper ~51 pp (video-claim)
- **Kern in 2–3 zinnen:** Opvolger van V4 (§56): **V4.1 Flash** is groter (~**552B** total vs V4 Flash 284B) maar snijdt KV nog verder (~**4×** extra; video: **54×** KV/token in ~9 maanden). Nieuwe hefbomen: **CSA2** (compressie over *lagen*: full / re-index / reuse), drop HCA → CSA2+SWA, **CED** (causal encoder–decoder, YOCO-inspiratie) + **SWA bounded replay**, persistent cache zonder SWA-KV, FP4, Engram, multimodal ViT. Gericht op **agentic** long-context (tools, codebases) goedkoop maken. Cijfers = video/paper-claims.
- **Vooraf:** §56 (CSA/HCA/V4). Infra elders (slice 8/9).

---

#### A. Framing: groter model, kleinere footprint [[00:00](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=0)]

* V4 maakte 1M context “affordable”; V4.1 Flash: **284B → 552B** total + KV nog ~**4×** lager. Cumulatief KV/token ~**54×** in 9 maanden (video). [[00:00](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=0)]
* Thema: niet SOTA-bench-maxing maar **run-cost**; “90% quality @ 40× lower cost”-narratief. Terminal Bench 2.1: ~**5%** kost vs Opus 5, ~5.8% vs GPT-5.6, ~8% vs Kimi K3, terwijl scores winnen (video). [[01:27](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=87)]
* Workload: herhaald lezen van huge histories (tools, code) → attention + **store/move/reload KV** als vijand. [[02:24](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=144)]

*(Self-promo Nimbus Kernel ~[00:58](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=58)–[01:27](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=87) — overgeslagen.)*

#### B. KV-cache-les + CSA2 (compressie over depth) [[02:52](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=172)]

* KV = saved keys/values per token × lagen; bij 1M tokens wordt HBM/SSD/bandwidth de bottleneck. [[02:52](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=172)]
* V4: CSA comprimeert tokens + sparse indexer. V4.1: KV groeit ook met **diepte** (meer lagen bij groter model) → vraag: moet elke laag een nieuw global memory bouwen? [[03:49](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=229)]
* **CSA2** — drie modi:
  * **Full:** eigen global KV + indexer key + sparse top-K
  * **Re-index:** hergebruik vorige main KV/indexer key; eigen query + nieuwe top-K
  * **Reuse:** hergebruik KV + top-K indices; geen indexer; attend op selectie vorige laag [[04:46](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=286)]
* HCA verdwijnt; hybrid = **CSA2 + SWA** (simpeler dan V4 CSA/HCA/SWA-interleave). [[06:10](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=370)]

#### C. CED — causal encoder–decoder (YOCO-lijn) [[06:38](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=398)]

* Prefill: hele prompt door alle lagen is pijnlijk voor agentic “veel lezen, weinig schrijven”. [[06:38](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=398)]
* Inspiratie **YOCO** (*You Only Cache Once*, 2024): self-decoder bouwt **één** shared global KV; cross-decoder-lagen query’en diezelfde KV → “cache once”. [[07:06](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=426)]
* DeepSeek-adaptatie: onderste helft = **causal encoder**; decoder-lagen projecteren elk hun global KV uit **finale encoder-representatie** (niet één shared KV zoals YOCO — wel “geen prompt door bovenste helft voor die KV”). [[08:59](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=539)]
* Combinatie: CED vermijdt full-depth prefill voor decoder-KV; CSA2 deelt KV tussen buren. [[11:49](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=709)]

```
  prompt (1M)
       │
       ▼
  causal encoder (~20 L) ──► final hidden ──► project → decoder global KV
       │                         │
       │                    CSA2 full/re-index/reuse
       ▼
  SWA local (per layer, 128) + bounded replay of last 128 only
```

#### D. SWA bounded replay + persistent cache [[12:18](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=738)]

* Per decoder-laag: **global** (encoder-derived, CSA2-shared) ≠ **local SWA** (eigen hidden, **niet** gedeeld). SWA window = **128** tokens. [[12:18](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=738)]
* SWA-KV hangt door depth → i.p.v. 1M door alle 40 lagen: **1M door encoder (20)** + **alleen laatste 128 door decoder (20)** = *SWA bounded replay*. Quality-impact “minimal” (vendor). Prefill ≈ half. [[13:16](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=796)]
* Persistent prefix-cache (V4): global + SWA op SSD; SWA ≈ **helft** storage ondanks klein window. V4.1: **geen** SWA in long-lived SSD-cache — tijdelijk host pool; expire → replay. Global blijft persistent. [[14:13](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=853)]
* Claims: CSA2+FP4 → global KV ~**¼** van V4 (~**890 bytes/token**, ~75% HBM); + SWA uit SSD → tot ~**87.5%** SSD-besparing (video-napkin). [[15:11](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=911)]
* Active params: prefill ~**8B** (encoder); decode ~**16B** (encoder+decoder) ondanks 552B total — ideaal “veel lezen, weinig genereren”. Decode compute 4k→1M context: ~20→25 weighted GFLOPS (256× context). [[15:40](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=940)]

#### E. Overige: single-pass MHC, Engram, sparsity, multimodal [[17:06](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=1026)]

* **Single-pass MHC:** minder residual-stream touches → ~**½** memory traffic vs oude MHC. [[17:06](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=1026)]
* **Engram / N-gram:** ~**196B** params in hashed lookup tables (conditional memory); total storage ~552+196=**748B**, maar per-token compute blijft ~552B-MoE-gevoel. [[17:34](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=1054)]
* Speculative decoding “Sparsity” (drafter niet in backbone pretrain) — kort genoemd. [[18:03](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=1083)]
* **Native multimodal:** DeepSeek ViT from scratch; **3×3 pixel unshuffle** → **9×** minder vision tokens; images ~1344². [[18:32](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=1112)]

#### F. Layer-layout (video walkthrough) [[19:00](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=1140)]

* Encoder: 2× pure SWA (+ Engram) → dan CSA2 **full:reuse = 1:5**, ×3 → 18 + 2 = **20** encoder layers. Token-compress “2” ≈ 2 tokens → 1 min-KV. [[19:00](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=1140)]
* Decoder: full + 3 reuse; dan 1:3 re-index/reuse ×4 → **20** layers. Hierarchical sparse indexer: eerste re-index-lagen bouwen candidate pool ~**16k**; latere zoeken daarin top ~**512**/712 (transcript “712”). [[19:57](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=1197)]
* Daarna DSpark / DeepSpec → **§61**.

#### G. Training & post-train [[20:55](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=1255)]

* Sparse attention **from scratch** @ 64k context (geen dense warm-up). ~34T → extend naar 1M; pretrain eindigt ~**45T multimodal** tokens. [[20:55](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=1255)]
* Post-train: “geen nieuw algoritme” — vooral **data-scale**; large-scale on-policy distillation van **&gt;40** specialist teachers; RL data via automated synthesis/environments. [[21:23](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=1283)]
* **Model merging** van RL-runs/scaffolds → init volgende run; eind-distill over domains. [[22:21](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=1341)]
* Reasoning effort: continu **1–100** (token penalty vs compute); public low/high/max ≈ 50/75/100. [[22:50](https://www.youtube.com/watch?v=CsSnSBCVoDU&t=1370)]

#### Wat ik meeneem

* Agentic cost = **KV move/store** + prefill, niet alleen “slimmer model”; CSA2+CED+bounded replay is les voor lange tool-histories (§8, §29, §56).
* Prefill/decode asymmetrische active params (8B vs 16B) matcht “lees veel, schrijf weinig”.
* Persistent cache-design: global long-lived vs local ephemeral — parallel aan context prune/externalize (§8).
* Geen kit-actie: lab-serving; wel bachelor/kenniskaart Inference.
* Paper-dieptes (DS-EX scaling, multimodal MoE balance) bewust later; DSpark → **§61**.

#### Open / onduidelijk

* Exacte top-K / candidate-pool-cijfers (512 vs 712); bytes/token-accounting.
* Reproduceerbaarheid buiten DeepSeek-stack; fair Terminal Bench cost-claims.
* Infra (**§60**) + DSpark (**§61**).

---

## §60. The Insane Infrastructure Design of DeepSeek V4 (bycloud)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=AIRfT41A89s](https://www.youtube.com/watch?v=AIRfT41A89s)

- **Duur:** ~26:43 · vervolg op **§56** (zelfde 58-pp report; hier full-stack infra)
- **Kern in 2–3 zinnen:** CSA/HCA alleen is onvoldoende: custom attention-pad (shared KV-as-K-and-V, partial RoPE + sink, FP4 indexer, mixed-precision KV), **MegaMoE** (wave+Comet overlap → mega-kernel; Ascend+CUDA), hardware “open letter”, **TileLang** kernels + **batch-invariant** dual attention, hybrid **on-disk** prefix KV, **Muon** matrix-intact sharding, teacher scheduling, **token WAL** voor RL rollouts, **DSEC** sandbox-platform. Thesis: limited compute → over-engineer de stack; agentic future = environments + multimodality.
- **Cijfers:** video/paper-claims (o.a. MegaMoE ~1.5–1.73× / tot ~2×).

---

#### A. Framing [[00:00](https://www.youtube.com/watch?v=AIRfT41A89s&t=0)]

* V4 = crack engineers + limited compute + “implement manually if inefficient”. Cheap 1M context ≠ alleen attention tricks (**§56**). [[00:00](https://www.youtube.com/watch?v=AIRfT41A89s&t=0)]

*(Sponsor Verta ~[00:30](https://www.youtube.com/watch?v=AIRfT41A89s&t=30)–[02:30](https://www.youtube.com/watch?v=AIRfT41A89s&t=150) — overgeslagen.)*

#### B. Custom attention path onder CSA/HCA [[02:30](https://www.youtube.com/watch?v=AIRfT41A89s&t=150)]

* Meerdere KV-soorten tegelijk: compressed KV, indexer KV, sparse-selected, HCA global (128→1), uncompressed SWA. [[02:30](https://www.youtube.com/watch?v=AIRfT41A89s&t=150)]
* Indexer QK-pad: QAT naar **FP4** (vs typisch FP8/BF16) — bij 1M tokens is “welke blocks lezen” al duur; FP4 ≈ **2×** minder memory daar. [[03:32](https://www.youtube.com/watch?v=AIRfT41A89s&t=212)]
* Compressed entry = **shared K and V** (MQA-achtig) → posities lekken in value-stream → slechter long-context. Fix: **partial RoPE** alleen laatste **64** dims + **negative position RoPE** op output. [[04:02](https://www.youtube.com/watch?v=AIRfT41A89s&t=242)]
* **RMSNorm** op query heads + compression KV vóór attention (schalen van geleerde merges). [[04:33](https://www.youtube.com/watch?v=AIRfT41A89s&t=273)]
* **Attention sink** (à la GPT-OSS): learnable term in softmax-denominator → head mag &lt;100% mass op memory (escape bij nutteloze compressed blocks). [[05:03](https://www.youtube.com/watch?v=AIRfT41A89s&t=303)]
* KV storage: RoPE-dims **BF16**; rest **FP4** → KV ~halve vs full BF16. [[05:33](https://www.youtube.com/watch?v=AIRfT41A89s&t=333)]
* Les: custom attention zonder kernels/surroundings = paper-only. [[06:04](https://www.youtube.com/watch?v=AIRfT41A89s&t=364)]

#### C. MegaMoE: overlap + waves + Ascend [[06:34](https://www.youtube.com/watch?v=AIRfT41A89s&t=394)]

* Bottleneck MoE = **data movement** (dispatch → lin1 → act → lin2 → combine), niet alleen expert-math. Comm vs compute wachten. [[07:04](https://www.youtube.com/watch?v=AIRfT41A89s&t=424)]
* **Comet** (mrt 2025): overlap dispatch↔lin1, lin2↔combine. DeepSeek: **fine-grained waves** over expert-groups (pipelined receive/compute/send). [[07:34](https://www.youtube.com/watch?v=AIRfT41A89s&t=454)]
* **MegaMoE** = waves + Comet in **één mega-kernel** (minder kernel-bounce). Speedup claim: ~**1.5–1.73×** general inference; tot ~**2×** latency-sensitive (RL rollouts / agent serving). [[08:35](https://www.youtube.com/watch?v=AIRfT41A89s&t=515)]
* Validatie Nvidia + **Huawei Ascend**; open-source alleen **CUDA** (DeepGEM); Ascend/CANN niet. Day-zero V4 op Huawei. [[09:05](https://www.youtube.com/watch?v=AIRfT41A89s&t=545)]

#### D. “Open letter” aan hardware [[10:06](https://www.youtube.com/watch?v=AIRfT41A89s&t=606)]

1. Full overlap hangt van **compute/comm-ratio**, niet alleen bandwidth. Pro: ~**6.1 TFLOPS** hideable per GB/s interconnect → daarna diminishing returns. [[10:06](https://www.youtube.com/watch?v=AIRfT41A89s&t=606)]
2. Mega-kernel → compute+memory+net tegelijk → **power headroom** nodig. [[10:36](https://www.youtube.com/watch?v=AIRfT41A89s&t=636)]
3. Nu **pull**-based remote reads; lagere latency signaling zou **push** aantrekkelijk maken. [[11:06](https://www.youtube.com/watch?v=AIRfT41A89s&t=666)]
4. Overweeg goedkopere elementwise act i.p.v. SwiGLU (minder exp/div) om bandwidth-eis te relaxen. [[11:36](https://www.youtube.com/watch?v=AIRfT41A89s&t=696)]

#### E. TileLang + batch-invariant dual kernels [[12:06](https://www.youtube.com/watch?v=AIRfT41A89s&t=726)]

* **TileLang** (video: “TaoLang”): fused custom GPU kernels dichter bij handwritten CUDA. [[12:06](https://www.youtube.com/watch?v=AIRfT41A89s&t=726)]
* **Batch invariance:** zelfde prompt, andere batch → andere logits (split-KV / non-associative FP adds) → breekt prefix-cache trust + RL/on-policy distill. Thinking Machines-oplossing ~**1.6×** slowdown. [[12:36](https://www.youtube.com/watch?v=AIRfT41A89s&t=756)]
* DeepSeek **dual kernel:** (1) hele sequence op **één SM** (vaste accum-orde) als waves vol; (2) multi-SM tail met **zelfde** accum-orde + distributed shared memory in thread-block clusters → split-KV-achtige utilizatie zonder bitwise drift; “negligible overhead” (video). [[14:37](https://www.youtube.com/watch?v=AIRfT41A89s&t=877)]

#### F. Hybrid KV: classical + state; on-disk prefix [[15:39](https://www.youtube.com/watch?v=AIRfT41A89s&t=939)]

* PagedAttention past slecht op heterogene KV. Split: **classical KV** (CSA/HCA compressed) vs **state cache** (SWA + uncompressed pending). [[15:39](https://www.youtube.com/watch?v=AIRfT41A89s&t=939)]
* Shared prefixes: compressed CSA/HCA entries **on disk**; cache-hit reload i.p.v. full recompute; incomplete compress-block tail wel recompute. [[16:10](https://www.youtube.com/watch?v=AIRfT41A89s&t=970)]
* Zhihu third-party (video): DeepSeek ~**100%** KV cache-hit over 12h peak/off-peak; anderen (OpenAI/Zhipu/Kimi e.d.) zakken naar ~0% na ~1h; MiniMax dichterbij. [[16:40](https://www.youtube.com/watch?v=AIRfT41A89s&t=1000)]

#### G. Muon + ZeRO: matrix-intact sharding [[17:41](https://www.youtube.com/watch?v=AIRfT41A89s&t=1061)]

* Meeste params **Muon** (niet AdamW); Newton–Schulz heeft **hele** gradient-matrix → naïeve ZeRO-shard breekt orthogonalization. Diepte Muon: **§65**. [[17:41](https://www.youtube.com/watch?v=AIRfT41A89s&t=1061)]
* Moonshot distributed Muon: gather → Newton–Schulz → keep slice. V4: **hybrid ZeRO bucket** — shard **tussen** matrices (hele matrix op één GPU), niet door midden; MoE **expert-aware** grouping (up/gate/down). [[18:44](https://www.youtube.com/watch?v=AIRfT41A89s&t=1124)]

#### H. Distill teachers + RL WAL + DSEC [[20:15](https://www.youtube.com/watch?v=AIRfT41A89s&t=1215)]

* Multi-teacher on-policy distill (§56): samples **gegroepeerd per teacher**; preload next teacher while current computes; custom tiling kernel voor KL over vocab. [[20:15](https://www.youtube.com/watch?v=AIRfT41A89s&t=1215)]
* Long rollouts + preemption: restart bias naar **korte** completions. Fix: **token-level write-ahead log** + save KV → resume; vereist **batch invariance**. [[21:17](https://www.youtube.com/watch?v=AIRfT41A89s&t=1277)]
* **DSEC** (DeepSeek Elastic Compute): productie-sandbox voor post-train/eval; één Python-API → function calls / containers / Firecracker microVM / QEMU full VM; create/reset/fail/GPU-preemption; schaal tot **honderdduizenden** concurrent sandboxes. [[22:47](https://www.youtube.com/watch?v=AIRfT41A89s&t=1367)]

#### I. Conclusie paper (video) [[24:19](https://www.youtube.com/watch?v=AIRfT41A89s&t=1459)]

* Zelf: beetje over-engineered; limited compute → niet verspillen. Toekomst: simplify arch; focus **agentic** + **multimodality** (V4 base sterk op long context / tool / DSEC; multimodal nog achter, “closing in”). [[24:19](https://www.youtube.com/watch?v=AIRfT41A89s&t=1459)]

#### Wat ik meeneem

* Agent-serving les: **custom attention + MoE + cache + determinism** is één systeem; paper-pattern zonder kernels faalt.
* Batch invariance + WAL = infra-voorwaarden voor eerlijke RL/agent-evals (parallel §59 Xiaomi dual-engine/KL).
* DSEC: agentic RL = environment platform, niet alleen model (§59, §37 environment-laag).
* Geen kit-actie; bachelor Inference/infra + kenniskaart. DSpark → **§61**.

#### Open / onduidelijk

* Exacte TileLang-spelling/repo; DeepGEM vs Ascend release-reden.
* Zhihu 100%-hit methodiek; fair vergelijking labs.

---

## §61. DSpark: DeepSeek-V4's Insane Compute Optimization Explained (bycloud)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=Sl0XXm35JMo](https://www.youtube.com/watch?v=Sl0XXm35JMo)

- **Duur:** ~16:23 · paper ~33 pp + **DeepSpec** GitHub (train/eval speculative decoding)
- **Kern in 2–3 zinnen:** Na V4-model/infra (§56/§60): **DSpark** = *semi-autoregressive* drafter (parallel backbone + lichte sequential/Markov head) + **confidence-scheduled** + **load-aware** verification. Productieclaims: ~**50%** hogere aggregate throughput; onder strikte tok/s-SLO’s tot ~**6×** vs ingestorte MTP-baseline. Niet voor consumer-GPU (default cache-claim ~**38 TB**); wel les in serving-policy voor agentic decode.
- **Vooraf:** §56–§58, §60. Cross: speculative decode / MTP.

---

#### A. Framing + DeepSpec [[00:00](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=0)]

* Extra 33-pp report naast 58-pp V4: inference; claims **~50%** hogere throughput in productie, tot **~660%** in strengere settings. [[00:00](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=0)]
* Open source (DeepGEM, 3FS, …) mikken op **cluster**-schaal, niet “GPU poor”; toch waarderen als craft. [[00:45](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=45)]
* **DeepSpec** repo: full-stack train/eval speculative decoding; paper **DSpark**. README: default Qwen3-4B target cache ~**38 TB**; default 8-GPU node — orde $10k SSD + ~$100k A100-cluster (video). [[02:59](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=179)]

*(Sponsor Make.com ~[01:29](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=89)–[02:59](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=179) — overgeslagen.)*

#### B. Waarom speculative decoding [[03:46](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=226)]

* Autoregressive decode = sequentieel; agentic/reasoning → meer tokens → bottleneck erger. [[03:46](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=226)]
* Loophole: **genereren** toekomst is sequentieel; **verifiëren** van een voorgestelde continuatie kan in **één** target forward (causal mask, alle posities parallel). Draft 8 tokens → target checkt a|ctx, b|ctx+a, … in één pass. [[04:30](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=270)]
* Goede setup moet drie dingen tegelijk: (1) goedkope/snelle draft, (2) genoeg accuracy om verify te overleven, (3) niet te veel big-model compute op doomed suffixes. [[06:22](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=382)]
* 38 TB cache = precomputed target activations/distributions om draft te trainen zonder target steeds opnieuw te runnen. [[06:00](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=360)]

#### C. Voorlopers: small model / MTP-Eagle / DFlash [[06:44](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=404)]

* Tiny separate draft: imiteert van buitenaf, ziet geen interne target-state. [[06:44](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=404)]
* **MTP / Eagle:** lightweight draft op target **hidden states** — DeepSeek pioneerde MTP op frontier; DSpark = verbetering **bovenop** MTP. [[07:29](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=449)]
* MTP-limiet: draft zelf nog **sequentieel** → langere draft blocks eten speedup. [[07:51](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=471)]
* **DFlash:** parallel block (diffusion-achtig) in één pass — GPU-vriendelijk, maar latere tokens missen echte prefix → incoherente/onbetrouwbare suffixes. [[08:13](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=493)]

#### D. Semi-autoregressive drafting [[08:59](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=539)]

```
  parallel backbone  →  whole draft block (representations-achtig)
           │
           ▼
  tiny sequential module (Markov / RNN head)
           → lokale coherentie (prev token bias)
```

* Markov head: next-token bias o.b.v. vorige token (eenvoudiger dan full next-token gen). [[09:45](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=585)]
* Results (video): across 2B/3B/8B/14B — accepted length ~**+30%** vs Eagle 3; ~**+16–18%** vs DFlash. [[10:08](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=608)]

#### E. Confidence-scheduled + load-aware verification [[10:32](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=632)]

* Offline: altijd N draft tokens verifiëren. Productie: coding vs open chat → verschillende predictability; vaste draft length is fout. [[10:54](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=654)]
* Onder load: low-confidence verify steelt batch capacity; reject = wasted target compute. [[11:40](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=700)]
* Elke draft token: **confidence** ≈ P(survive | previous accepted). Stop verify bij drop (bv. na token 3 van 50). [[12:03](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=723)]
* Zelfde 60%-token: wel verifiëren bij idle GPU, niet bij max load → **hardware-aware scheduler**. Fig. 8: concurrency ↑ → verification budget per request ↓. [[12:49](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=769)]
* Kernidee: speculative decoding als **dynamic serving policy**, niet alleen beter draft-algoritme. Implementatie moeilijk t.o.v. batching-engines → DeepSpec library. [[13:56](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=836)]

#### F. Productiecijfers (video-claims) [[14:40](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=880)]

| Setting | Claim |
|---------|--------|
| V4 Flash, ≥80 tok/s/user | ~**51%** hogere aggregate throughput |
| Stricter ≥120 tok/s/user | MTP-1 baseline “hits wall”; DSpark tot ~**661%** hoger vs collapsed baseline |
| V4 Pro @ 35 tok/s | ~**52%** hoger; stricter tot ~**406%** |
| Matched aggregate throughput | single-user speed ~**+57–85%** |

* Pareto serving (speed vs throughput) verschuift; ~50% throughput ≈ minder GPU’s voor zelfde traffic. Niet auto-portable naar elke stack. [[15:47](https://www.youtube.com/watch?v=Sl0XXm35JMo&t=947)]

#### Wat ik meeneem

* Agentic/reasoning decode is de pijn; CSA/KV (§56–§58) + **smarter verify** (§61) zijn complementaire hefbomen.
* Confidence + load-aware verify = productieles: offline acceptance ≠ online ROI.
* Batch/serving dynamics kunnen speedups wissen — parallel batch-invariance (§60).
* Geen kit-actie (cluster-speculatief); bachelor Inference / DeepSpec als pointer.
* Industrie-/API-margin + DeepInfer-open release: **§62**.

#### Open / onduidelijk

* Exacte paper-titel/arXiv; DeepSpec vs “DeepSpec” spelling in repo.
* Fairness 661% (vs collapsed baseline); portability naar niet-DeepSeek engines.
* Of Engram/MTP in V4.1 Flash (§58) al DSpark-achtig is of apart.
* Officiële model cards / lineage: **§89–§94**.

---

## §89. DeepSeek Papers — Hugging Face-collectie (Presidentlin)

**Type:** Collectie / index · **URL:** [https://huggingface.co/collections/Presidentlin/deepseek-papers](https://huggingface.co/collections/Presidentlin/deepseek-papers)

- **Kern:** Gecureerde lijst DeepSeek(-gerelateerde) papers op HF (niet officieel van DeepSeek AI). Handig als **ingang** naast Fowler (§90) en lokale PDF’s (§94). Geen primaire SSOT — arXiv/PDF + Type/URL in § blijven leidend.

#### A. Lineage (selectie uit collectie; arXiv)

| Paper | arXiv | Notitie |
|-------|-------|---------|
| DeepSeek LLM | [2401.02954](https://arxiv.org/abs/2401.02954) | Foundation / scaling (§90) |
| DeepSeekMoE | [2401.06066](https://arxiv.org/abs/2401.06066) | Expert specialization |
| DeepSeek-Coder | [2401.14196](https://arxiv.org/abs/2401.14196) | Code |
| DeepSeekMath | [2402.03300](https://arxiv.org/abs/2402.03300) | Math reasoning |
| DeepSeek-V2 | [2405.04434](https://arxiv.org/abs/2405.04434) | MLA + MoE |
| DeepSeek-Coder-V2 | [2406.11931](https://arxiv.org/abs/2406.11931) | Code barrier |
| Aux-loss-free MoE balance | [2408.15664](https://arxiv.org/abs/2408.15664) | → V3 gating |
| DeepSeek-V3 Tech Report | [2412.19437](https://arxiv.org/abs/2412.19437) | PDF lokaal §94 |
| DeepSeek-R1 | [2501.12948](https://arxiv.org/abs/2501.12948) | RL reasoning |
| Native Sparse Attention | [2502.11089](https://arxiv.org/abs/2502.11089) | Sparse attn |
| Insights into DeepSeek-V3 (hardware) | [2505.09343](https://arxiv.org/abs/2505.09343) | HPC reflections |
| DeepSeek-V3.2 | [2512.02556](https://arxiv.org/abs/2512.02556) | DSA; PDF lokaal §94 |
| mHC | [2512.24880](https://arxiv.org/abs/2512.24880) | Manifold hyper-connections → V4 |
| DeepSeek-V4 | [2606.19348](https://arxiv.org/abs/2606.19348) | 1M context (§56/§91) |
| DeepSeek-V4.1-Flash | [2609.19969](https://arxiv.org/abs/2609.19969) | KV compress (§58/§93) |
| DSec (agentic training sandbox) | [2609.22978](https://arxiv.org/abs/2609.22978) | Agentic train infra |
| DualPath | [2602.21548](https://arxiv.org/abs/2602.21548) | Storage BW agentic inference |
| Engram / conditional memory | [2601.07372](https://arxiv.org/abs/2601.07372) | Lookup sparsity |

* Collectie bevat ook VL/OCR/Prover/Janus e.d. — relevant bij multimodal, niet core coding-lab.

#### Wat ik meeneem

* A3/Inference: start hier of Fowler (§90) → diepte in PDF/§56+.  
* Lab: **V4.1-Flash + API** (§80/§93) belangrijker dan elke paper lezen.  
* Geen kit.

#### Open / onduidelijk

* Collectie-updates; DreamCraft3D e.d. zijn noise voor ons spoor.

---

## §90. The DeepSeek Series: A Technical Overview (Fowler / Mohanty)

**Type:** Artikel · **URL:** [https://martinfowler.com/articles/deepseek-papers.html](https://martinfowler.com/articles/deepseek-papers.html) · auteur: Shayan Mohanty (Thoughtworks) · 2025-02…06-18 revisie

- **Kern:** Overzicht van **vier** reports (LLM → V2 → V3 → R1) langs drie bogen: **cost/memory efficiency**, **HPC co-design**, **emergent reasoning via RL**. Geen V4/V4.1 (die in §56/§58/§91–§93).

#### A. Drie bogen

1. **Cost & memory:** MLA (KV compress), MoE sparsity, FP8, device-limited routing.  
2. **Sparse + HPC co-design:** architectuur ↔ cluster (H800, IB, DualPipe, PTX) — “goedkoop trainen op beperkte interconnect”.  
3. **Emergent reasoning:** R1 / R1-Zero — GRPO + rule rewards → self-verify, CoT, reflection.

#### B. DeepSeek-LLM (Jan ’24)

* Vraag: fixed compute → model size vs data? Schaal als **non-embedding FLOPs/token** \(M\): \(C = M \times D\).  
* Data quality verschuift optimum (rijkere tokens → groter model loont).  
* 7B/67B op 2T EN/ZH; SFT + DPO; claim 67B > LLaMA-2 70B op math/code.  
* Plant HPC co-design + scaling-laws.

#### C. DeepSeek-V2 (Jun ’24) — MLA + DeepSeekMoE

* Obstakels: KV-cache + FFN FLOPs.  
* **MLA:** low-rank KV latent \(c_t^{KV}\); cache compressed latent, up-project per head.  
* **DeepSeekMoE:** shared + routed experts; device-limited routing (top-\(M\) devices → top-\(K_r\) experts); balance losses \(L_{ExpBal}\), \(L_{DevBal}\), \(L_{CommBal}\).  
* ~236B total / ~21B active; 8.1T tokens; SFT 1.5M + RL.

#### D. DeepSeek-V3 (Dec ’24) — 671B

* 671B total / 37B active; 14.8T tokens; **~2.788M H800 GPU-hours**; stabiel (geen irrecoverable spikes/rollbacks) — zie PDF §94.  
* MLA-verfijning: beter RoPE/decoupled keys (128K), joint KV storage, layer-wise adaptive cache.  
* MoE: **auxiliary-loss-free** bias \(b_i\) op gating \(s'_{i,t}=s_{i,t}+b_i\); geen token dropping; 6→8 routed experts.  
* **MTP** multi-token prediction.  
* HPC: FP8 GEMM + block scaling; DualPipe (compute↔all-to-all overlap); PTX/warp specialization.

#### E. DeepSeek-R1 (Jan ’25)

* Architectuur = V3 base; post-train verschilt.  
* **R1-Zero:** geen SFT-warmup; **GRPO** (group-relative advantage); rewards = accuracy (math solvers / code tests) + format (`<think>`-achtige markers). Emergent: self-verify, extended CoT, exploration, reflection. Nadelen: readability, language mix, zwak op non-verifiable.  
* **R1 pipeline:** (1) cold-start SFT → (2) reasoning RL → (3) rejection sampling + SFT → (4) RL all-scenarios (rules + preference models).

#### F. Les voor toolchain

* Architecture + algorithms + frameworks + hardware co-design.  
* Toolchain: HPC-opts in compile/train path; research ↔ HPC vroeg.

#### Wat ik meeneem

* Verklaart **waarom** DeepSeek API goedkoop kan zijn (§80): efficiency-boog, niet alleen “China dump”.  
* R1-Zero ≈ “verification harness + RL” — parallel aan lab-denken (meten/verify), niet model-only.  
* Cross video-§56/§60; papers §89/§94. Geen kit.

#### Open / onduidelijk

* Artikel stopt bij R1 (2025); V3.2/V4 elders.  
* Cijfers = paper-claims via Mohanty.

---

## §91. DeepSeek V4 — officiële Model Card

**Type:** Model card (PDF) · **URL:** [https://fe-static.deepseek.com/chat/transparency/deepseek-V4-model-card-EN.pdf](https://fe-static.deepseek.com/chat/transparency/deepseek-V4-model-card-EN.pdf) · Transparency: [https://www.deepseek.com/en/transparency/](https://www.deepseek.com/en/transparency/) · publicatie ~2026-04-27

- **Kern:** Officiële eigenschappen V4-Pro / V4-Flash (niet bycloud-video). MIT open weights + API. Intended: everyday QA + **general agent tasks**.

#### A. Model properties (card)

| | Pro | Flash |
|--|-----|-------|
| Total / active | **1.6T** / **49B** | **285B** / **13B** |
| Context | **1M** | **1M** |

* Behoudt DeepSeekMoE + **MTP** van V3.  
* Innovaties:  
  1. **Hybrid attention:** **CSA** (compress KV seq + DSA) + **HCA** (zwaardere compressie, dense attn).  
  2. **mHC** — residual op manifold van doubly stochastic matrices (Birkhoff).  
  3. **Muon** optimizer.  
* Reasoning modes: **Non-think** / **Think High** / **Think Max**.  
* Modalities (card): Text (+ modes).  
* License weights/code: **MIT**. API: Open Platform ToS.

#### B. Data (card, hoog niveau)

* Pretrain: public + licensed; geen intentionele PII; filters.  
* Optimization: QA-paren research team; user input → encrypt/de-ID als gebruikt.

#### Wat ik meeneem

* SSOT voor **namen/sizes/modes** naast §56.  
* Agent-intended use expliciet → past lab DeepSeek-API.  
* Geen kit.

#### Open / onduidelijk

* Card is compliance-achtig dun t.o.v. tech report [2606.19348](https://arxiv.org/abs/2606.19348).  
* V4-Pro later gerouteerd naar V4.1-Flash (§93).

---

## §92. DeepSeek Transparency Center

**Type:** Productpagina · **URL:** [https://www.deepseek.com/en/transparency/](https://www.deepseek.com/en/transparency/)

- **Kern:** Centrale disclosure van major releases met links naar **Model Card** + **Technical Report**. Snapshot: V4.0 (2026-04-24), V3.2 (2025-12-01), plus oudere in Research-nav.

#### Wat ik meeneem

* Altijd hier starten voor **officiële** artefacten vóór secundaire blogs.  
* Cross §91 (V4 card), §93 (V4.1 news), §94 (lokale V3/V3.2 PDF).  
* Geen kit.

#### Open / onduidelijk

* Of V4.1-Flash al als rij op Transparency staat (news/paper wel).

---

## §93. Introducing DeepSeek-V4.1-Flash (officieel nieuws)

**Type:** Productnieuws · **URL:** [https://www.deepseek.com/en/news/deepseek-v4-1-flash/](https://www.deepseek.com/en/news/deepseek-v4-1-flash/) · paper: [arXiv:2609.19969](https://arxiv.org/abs/2609.19969) · datum news: 2026-09-10 · cross video **§58**

- **Kern:** Kleinste model in “new architecture family”; native visual; API-id **`deepseek-flash`**. Claim: beter/goedkoper/sneller dan V4-Pro; V4-Pro wordt uitgefaseerd (routing → Flash).

#### A. Architectuur (news-claims)

* **552B** MoE.  
* **Causal Encoder–Decoder (CED):** ~**8B** active input / **16B** active output (asymmetrisch).  
* Nieuwe pretrain + grotere-schaal RL; benches “ahead of flagship incl. V4-Pro”.

#### B. KV / cost

* vs vorige gen: KV **1/4 HBM**, **1/8 SSD**.  
* Cache-hit charges = groot deel agent-kosten → compressie snijdt die.

#### C. API / partners / pricing

* Live multimodal API; aliases `deepseek-v4-flash` / vision-exp tijdelijk → V4.1-Flash.  
* Vanaf 2026-09-14 04:00 UTC: `deepseek-v4-pro` → V4.1-Flash @ Flash-rates (tot V4.1-Pro).  
* Partners: WorkBuddy/CodeBuddy & **OpenCode** (§79).  
* Peak/off-peak; off-peak = **50%** peak; nieuwe prijzen vanaf 2026-09-10 04:00 UTC.  
* Open-source inference support + large deploy (2k GPU + storage) gesprek.

#### Wat ik meeneem

* Lab-default model-id: **`deepseek-flash`** (niet legacy v4-pro).  
* Bevestigt §80 Pareto-verhaal + OpenCode-peer.  
* Geen kit; geen sole-model-ADR.

#### Open / onduidelijk

* Exacte $/MTok in news-figuur — pricing-pagina apart checken vóór citatie.  
* bycloud §58 voor mechanisme (CSA2/SWA/Engram).

---

## §94. Momentopnames: DeepSeek-V3 & V3.2 Technical Reports (lokaal PDF)

**Type:** Paper (PDF in repo) · **V3 URL:** [https://arxiv.org/abs/2412.19437](https://arxiv.org/abs/2412.19437) · lokaal: [`pdfs/DeepSeek-V3_Technical_Report.pdf`](pdfs/DeepSeek-V3_Technical_Report.pdf) · **V3.2 URL:** [https://arxiv.org/abs/2512.02556](https://arxiv.org/abs/2512.02556) · lokaal: [`pdfs/DeepSeek-V3.2.pdf`](pdfs/DeepSeek-V3.2.pdf)

- **Kern:** Jouw downloads als naslag; abstracts hier. Diepere mechanica via Fowler §90 (V3) en collectie §89. V4/V4.1 elders (§56/§58/§91/§93).

#### A. DeepSeek-V3 (abstract)

* MoE **671B** total / **37B** activated.  
* MLA + DeepSeekMoE (uit V2); **auxiliary-loss-free** load balancing; **MTP** objective.  
* Pretrain **14.8T** tokens; daarna SFT + RL.  
* Training **2.788M H800 GPU hours**; stabiel (geen irrecoverable loss spikes / rollbacks).  
* Checkpoints: `github.com/deepseek-ai/DeepSeek-V3`.  
* Claim: ≥ open peers; ≈ leading closed op diverse benches (figuren in PDF).

#### B. DeepSeek-V3.2 (abstract)

1. **DSA** (DeepSeek Sparse Attention) — lagere complexiteit, long-context behouden.  
2. **Scalable RL framework** — post-train compute; V3.2 ≈ GPT-5-klasse; **V3.2-Speciale** claim > GPT-5 / ≈ Gemini-3.0-Pro; **gold** IMO & IOI 2025.  
3. **Large-scale agentic task synthesis** — reasoning×tool-use data op schaal → betere agentic post-train / instruction-following in interactieve omgevingen.

#### Wat ik meeneem

* V3.2 agentic-synthesis = relevant A3/A5 (niet alleen chat-benches).  
* Lokaal PDF = offline lezen; § herschrijft papers niet (AGENTS: momentopnames niet herschrijven — dit is index+abstract).  
* Geen kit.

#### Open / onduidelijk

* Speciale vs base API-beschikbaarheid.  
* Of V4.1 tech report ook lokaal te zetten (nog niet in `bron/`).
* Mistral-lijn (Europa / A3): **§95–§101**.

---

## §95. Artificial Analysis — Mistral provider (intelligence / price / speed)

**Type:** Benchmark-dashboard · **URL:** [https://artificialanalysis.ai/providers/mistral](https://artificialanalysis.ai/providers/mistral) · gerelateerd: Coding Agents Index **§80**

- **Kern:** Live AA-metingen van modellen **via Mistral als provider** (niet alleen “Mistral-weights”). Snapshot wijzigt; hieronder = order-of-magnitude uit pagina-extract (herladen vóór citatie). **In de gaten houden** voor A3 + stage-context (EU AI-speler).

#### A. Wat de pagina meet

* Intelligence Index v4.3.2 (o.a. AA-Briefcase, GDPval-AA, AutomationBench-AA, Terminal-Bench 4.0, SciCode, HLE, GDP.pdf, CritPt, AA-Omniscience, AA-LCR).  
* Speed (tok/s), latency (TTFT / first answer token), blended price (default **7:2:1** cache:input:output), context window, cache hit rate (agentic multi-turn), cost/task.  
* Features: function calling, JSON mode, license/open-weight flags.

#### B. Snapshot (9 tracked models op provider-pagina)

| Model | Context (claim) | Int. Index | Blended $/1M (orde) | Speed (orde) |
|-------|-----------------|------------|---------------------|--------------|
| Mistral Large 4 Preview | 524k* | **38** | hoog (~$1.6-ish table) | ~113 t/s |
| GLM-5.2 (max) *via Mistral* | ~1M | 34 | ~$0.76 | **~281** t/s |
| Mistral Medium 3.5 | 262k | 14 | mid | ~162 |
| Mistral Small 4 | 256k | 11 | ~$0.10 | ~175 |
| Mistral Large 3 | 262k | 9 | laag | ~85 |
| Ministral 3 14B / 8B / 3B | 262k / 131k | 6 / 5 / 5 | **$0.04–0.07** | 72–208 |

\*Docs/Large-4 elders **1M** — AA-tabel kan Preview-config tonen; check live.  
* Goedkoopst blended: Ministral 3 3B ~**$0.04**/1M.  
* Snelst op provider: GLM-5.2 (max).  
* OpenAI-compatible API; alle 9: JSON + function calling; reasoning-modellen o.a. Large 4 Preview, GLM-5.2, Medium 3.5, Small 4.

#### C. Leesregels

* Provider-pagina ≠ pure Mistral-family: **Z.ai GLM** staat ook op Mistral’s API-catalogus (§97).  
* Cross §80 (agent $/task) — zelfde AA-familie, andere suite.  
* Cijfers drift: altijd charts herladen.

#### Wat ik meeneem

* **Watchlist:** AA (provider + coding agents) = primaire externe thermometer voor Mistral vs DeepSeek.  
* Lab: DeepSeek blijft cost-hypothese (§80/§93); Mistral = **EU/sovereignty + stage-relevant** peer, niet automatisch default.  
* Geen kit; geen “we kiezen Mistral”-ADR.

#### Open / onduidelijk

* Exacte live Index/$-cellen vs extract.  
* Of Large 4 Preview op AA al open-weights-flag heeft (gewicht-release §99/§100).

---

## §96. Medium is the new large — Mistral Medium 3 (news)

**Type:** Productnieuws · **URL:** [https://mistral.ai/news/mistral-medium-3/](https://mistral.ai/news/mistral-medium-3/) · 2025-05-07 · opvolger in lineup: Medium **3.5** (§97)

- **Kern:** Positionering **frontier-class @ ~8× lagere kost** + eenvoudiger enterprise-deploy. Claim: ≥ **90%** van Claude Sonnet 3.7 op interne benches @ **$0.4 in / $2 out** per MTok; beter dan Llama 4 Maverick / Cohere Command A; pricing vs DeepSeek v3 (toen) gunstig; deploy vanaf **4 GPU’s**.

#### A. Highlights (post)

* Balance: SOTA × cost × deployability.  
* Sterk in coding + multimodal.  
* Enterprise: hybrid/on-prem/VPC, custom post-train, tool-integratie.  
* Beschikbaar: La Plateforme, SageMaker; roadmap IBM/NVIDIA NIM/Azure/Vertex.  
* Teaser: “working on something large” → latere Large-lijn.

#### Wat ik meeneem

* Mistral-narratief: **efficiency class** (Medium) naast flagship — parallel DeepSeek Flash/Pro.  
* Medium 3 is **deprecated** t.o.v. 3.5 in huidige docs (§97) — citeer versie.  
* Geen kit.

#### Open / onduidelijk

* Interne eval-pipeline vs onafhankelijk AA (§95).

---

## §97. Mistral Docs — Models Overview

**Type:** Productdocs · **URL:** [https://docs.mistral.ai/models](https://docs.mistral.ai/models)

- **Kern:** Officiële catalogus: eigen open-weight/commercial + **third-party** (Z.ai GLM) op het platform. Lifecycle/deprecated-tabel = bron voor “welk id nog gebruiken”.

#### A. Featured / generalist (actueel uit docs-extract)

| Model | Notitie | Licentie (docs) |
|-------|---------|-----------------|
| **Mistral Large 4** | SOTA open-weight multimodal; MoE; preview | Open (weights soon) |
| Mistral Medium 3.5 | Frontier multimodal; agentic/coding | Modified MIT |
| Mistral Small 4 | Hybrid instruct/reasoning/coding | Apache 2.0 |
| Mistral Large 3 | Open multimodal | Apache 2.0 |
| Ministral 3 14B/8B/3B | Text+vision, edge | Apache 2.0 |
| Z.ai GLM 5.3 / 5.3 Flash | Third-party; **1M** context; Flash = agentic/visual coding | Open |

* Ook: OCR 4.1, Voxtral (ASR/TTS), Codestral, embeds, Shieldstral/Moderation, Timestral.  
* **Deprecated** o.a.: Medium 3 / 3.1, Small 3.x, Devstral*, Magistral*, GLM 5.2 → 5.3, oude Large/Pixtral — altijd alternatief-kolom volgen.

#### B. Large 4 card-snippet (docs)

* Granular MoE; **~52B active / ~1.05T total**; vision encoder ~1.6B; context **1M**; id `mistral-large-4`.

#### Wat ik meeneem

* SSOT voor **API-namen** en deprecation.  
* Stage/EU: Medium 3.5 + Large 4 + Small 4 = kernlijn om te volgen.  
* Geen kit.

#### Open / onduidelijk

* Modified MIT vs Apache vs toekomstige Large-4 LICENSE (§100).

---

## §98. Best Mistral Models — BenchLM ranking

**Type:** Aggregator-ranking · **URL:** [https://benchlm.ai/best/mistral-models](https://benchlm.ai/best/mistral-models) · updated ~2026-10-25

- **Kern:** Derde-partij scorebord alleen Mistral-family. **Niet** AA; methodologie apart. Snapshot:

| Rank | Model | Type | Context | Score |
|------|-------|------|---------|-------|
| 1 | Mistral Large 4 | Pending | 1M | **61.7** |
| 2 | Mistral Small 4 | Open | 256K | 34.7 |
| 3 | Medium 3.5 128B | Open | 256K | 33.6 |
| 4 | Large 3 | Proprietary* | 128K | 33.5 |
| 5 | Medium 3 | Proprietary | 128K | 28.8 |
| … | Ministral 3 14/8/3B | Open | 128K | 24.9 / 20 / 18.8 |

\*Docs noemen Large 3 vaak open-weight Apache — BenchLM-label kan afwijken; verifieer.  
* Takeaway pagina: top = Large 4; best open ranked = Small 4 #2.

#### Wat ik meeneem

* Extra as naast AA (§95) — **niet** mengen zonder methodologie.  
* Large 4 score 61.7 echo’t DeepSWE-claim in §99.  
* Geen kit.

#### Open / onduidelijk

* Wat “Score” exact aggregeert; Large 4 “Pending” vs live API.

---

## §99. Introducing Mistral Large 4 — “le Chonk” (officieel)

**Type:** Productnieuws · **URL:** [https://mistral.ai/news/mistral-large-4/](https://mistral.ai/news/mistral-large-4/) · 2026-10-06 · docs: [model card](https://docs.mistral.ai/models/mistral-large)

- **Kern:** Public preview **ML4**; **1T** total / **52B** active; native multimodal; weights “end of this month”. Getraind op **3800** Grace Blackwell GPU’s in **eigen EU-datacenters**. Series D **€3B**. Open-weight belofte + soevereiniteit-narratief.

#### A. Claims (performance)

* Coding Agent Index **49.8%** (vóór DS V4 Pro / Qwen3.8 Max in hun vergelijking).  
* DeepSWE v1.1 **61.7%**; SWE-Atlas-QnA **59.4%**; Terminal-Bench 4 **28.3%**.  
* Surge blind coding: ML4 Preview **3.74**/5 (#2 van 5; Opus 5 = 4.22).  
* AutomationBench **59.9%**; AA-Briefcase Elo **1393**.  
* Cyber: AA Cyber Index top-5 globaal; reproduce+patch test **82%**; Cybench **93%**; closed models weigeren soms → open weights voor defenders.  
* Visual grounding Dense 200 **42%** vs GPT-6-Astra 41% (claim).  
* Safety: Lakera B3 **93.3%** attack resistance; KORA 1.691/2.

#### B. Post-training / RL

* Composable RL-omgevingen (chat → science → safety → long-horizon tools); sandboxes/search/APIs.  
* ~3k GPU: ~**33B** tokens/dag rollouts (~16B trainable completions).  
* Preview RL “still in flight” — headroom.

#### C. Europa / soevereiniteit

* EU end-to-end deployment onder EU-recht.  
* Trainingsdata: >**160** talen, alle officiële EU-talen.  
* Forge = zelfde train/customize/RL-stack als klanten.

#### Wat ik meeneem

* **A3 + stage:** belangrijkste Mistral-artefact nu; volg weights + LICENSE (§100).  
* Lab: API-preview ok om te proberen; default blijft DeepSeek-hypothese tot H×M-meting.  
* Geen kit.

#### Open / onduidelijk

* Exacte release-dag weights; architectuur-details “later”.  
* Licentie nog niet gepubliceerd (§100).

---

## §100. License countdown — Mistral Large 4 (Yahoo / industrie)

**Type:** Artikel · **URL:** [https://finance.yahoo.com/technology/ai/articles/license-countdown-mistral-large-4-101536225.html](https://finance.yahoo.com/technology/ai/articles/license-countdown-mistral-large-4-101536225.html) · Lena Park, ~2026-10-23 · context: [Forkast follow-up](https://forkast.news/mistral-large-4-weights-the-final-week/) · legal interim: [downstream providers PDF](https://legal.mistral.ai/documents/Mistral%20Large%204%20-%20Technical%20Documentation%20For%20Downstream%20Providers.pdf)

- **Kern:** Tot weights+LICENSE op HF: model selectie = **procurement risk**. Large 3 = Apache 2.0; Large 4 verwacht custom / mogelijk **$20M/maand revenue gate** (Club of Four: StepFun, Meta, Moonshot, DeepSeek). “Open” ≠ vrije commercial deploy bij schaal.

#### A. Feiten vs verwachting

* Preview API live sinds 2026-10-06; HF weights/license “Coming soon” (countdown eind okt).  
* Officiële belofte: weights end of month — **geen vaste dag** in Mistral-post.  
* Technical doc (6 okt): open-weights sectie “will be updated”; huidige kanalen ToS / partner / bespoke self-deploy.  
* Mistral Modified MIT elders al ≥$20M/mo → commercial (artikel/Forkast).

#### B. Bouwers-les

* Gate op LICENSE-fetch, niet op countdown-timer.  
* Volatiele omzet → plotse license-trigger.

#### Wat ik meeneem

* Stage/EU-story: techniek + **license politics** volgen.  
* Lab/solo: Apache Small 4 / Ministral veiliger tot Large-4 terms bekend.  
* Geen kit.

#### Open / onduidelijk

* Of Large 4 écht $20M-gate krijgt — pas na LICENSE-file zeker.

---

## §101. Papers Explained: Mistral 7B (DAIR.AI) + paper

**Type:** Uitlegartikel + paper · **URL uitleg:** [https://medium.com/dair-ai/papers-explained-mistral-7b-b9632dedf580](https://medium.com/dair-ai/papers-explained-mistral-7b-b9632dedf580) · **paper:** [arXiv:2310.06825](https://arxiv.org/abs/2310.06825) · Ritvik Rastogi / DAIR · okt 2023

- **Kern (foundation Mistral):** 7B die Llama-2 **13B** verslaat op evaluaties; Llama-1 **34B** op reasoning/math/code. Apache 2.0. Mechanieken: **GQA** + **SWA** + **rolling buffer cache** + prefill-chunking.

#### A. Architecture (paper / DAIR)

* **GQA:** snellere decode, minder KV-geheugen → hogere batch/throughput.  
* **SWA:** window \(W=4096\); laag \(k\) bereikt theoretisch ~\(W \times k\) (~**131K** span). Praktijk 16K seq: ~2× sneller vs vanilla (FlashAttention/xFormers-patches).  
* **Rolling buffer:** cache size vast \(W\); slot \(i \bmod W\); @32k tokens ~**8×** minder cache-geheugen zonder kwaliteitsclaim-verlies.  
* **Prefill + chunking:** lange prompts in \(W\)-chunks prefillen.

#### B. Instruct

* Mistral 7B-Instruct > Llama-2-13B-chat (human + auto benches, paper-claim).

#### Wat ik meeneem

* Historische DNA van Mistral = **efficiency attention** — zelfde boog als latere Medium/Large.  
* SWA/rolling buffer = inference-les naast DeepSeek CSA/MLA (§56+).  
* Geen kit.

#### Open / onduidelijk

* 7B is legacy t.o.v. Small 4 / Ministral 3 (§97); wel leer-paper.
* Landschap agentic IDE / vibe-tools (lage authority): **§102–§104**.

---

## §102. “8 Best Vibe Coding Tools” (Zite blog) — lage authority

**Type:** Vendor-listicle · **URL:** [https://www.zite.com/blog/best-vibe-coding-tools](https://www.zite.com/blog/best-vibe-coding-tools) · David Wilson / “Reviewed by” Sven Johnson · 2026-07-07

- **Authority:** **Zwak.** Zite rankt **zichzelf #1**. SEO/content-marketing voor een no-code app-builder, geen onafhankelijke bench. Prijzen/“tested” claims niet reproduceerbaar. Alleen bruikbaar als **naamkaart** van vibe/no-code peers — nooit als ranking-bewijs.

#### A. Lijst (hun ranking)

| # | Tool | Hun “best for” | Startprijs (claim) |
|---|------|----------------|--------------------|
| 1 | **Zite** (eigen) | Visibility/control business apps | $19/mo |
| 2 | Lovable | Non-tech founders MVP | ~$25/mo |
| 3 | Bolt.new | Devs prompt→run in-browser | ~$25/mo |
| 4 | Replit | Beginners complete apps | ~$20/mo |
| 5 | Base44 | Internal tools | ~$25/mo |
| 6 | Cursor | “React teams visual-first” (!) | ~$20/mo |
| 7 | FlutterFlow | Native mobile | ~$39/mo |
| 8 | Claude Code | Agent over codebase | ~$20/mo |

#### B. Categoriefouten (voor ons)

* Cursor + Claude Code ≠ “vibe coding” in dezelfde zin als Lovable/Bolt (prompt→hosted app).  
* Cursor-beschrijving (“visual-first React”) = **misleidend** t.o.v. §69–§75.  
* Zite con: **geen code export** — lock-in; irrelevant als lab-harness-kandidaat.

#### Wat ik meeneem

* A4/A5: hooguit **wantlist-namen** (Lovable, Bolt, Replit) als “niet ons spoor” (prompt-to-app ≠ agent-in-repo).  
* Bevestigt why we want AA/SWE-Pro (§80/§83) i.p.v. listicles.  
* Geen kit; geen radar Adopt.

#### Open / onduidelijk

* Alles behalve productnamen.

---

## §103. The 13 Best Agentic IDEs in 2026 (DataCamp)

**Type:** Educatieve listicle · **URL:** [https://www.datacamp.com/blog/best-agentic-ide](https://www.datacamp.com/blog/best-agentic-ide) · Vinod Chugani · 2026-03-10

- **Authority:** **Matig.** DataCamp = bekende L&D-merk; auteur met LinkedIn-bio; wél product-CTA’s/certificaten. Geen primaire metingen. Definitie + taxonomie bruikbaar; rankings/claims = hypothese tot §/vendor-docs.

#### A. Definitie (bruikbaar)

* Agentic IDE ≠ cloud IDE (Codespaces/Replit-hosting).  
* Bar: multi-step plan, files+terminal tools, self-correct **zonder** prompt per stap.  
* Autocomplete alleen ≠ agentic.

#### B. Vier categorieën × 13 tools

| Cat | Tools |
|-----|--------|
| Dedicated | Cursor, Windsurf (Cascade), AWS **Kiro** (specs+hooks, preview), Google **Antigravity** (multi-agent, free), ByteDance **Trae** (free), **PearAI** (OSS BYOK fork), **Zed** (Rust, AI growing) |
| Native ecosystem | GitHub Copilot (agent + Workspaces), JetBrains **Junie** |
| BYOK extensions | **Cline**, **Roo Code** (Cline-fork, personas) |
| Terminal-first | **Claude Code**, **Aider** |

#### C. Selectie-advies (artikel)

* Managed polish → Cursor/Windsurf.  
* Ecosystem lock → Copilot / Junie.  
* Cost/model control → BYOK (Cline/Roo/Aider).  
* Terminal → Claude Code / Aider.  
* Budget explore → Antigravity / Trae; OSS standalone → PearAI.  
* Probeer 2–3 op **echt** project.

#### Wat ik meeneem

* **Taxonomie** herbruikbaar voor A4/A5-matrix assen (dedicated / extension / terminal / ecosystem).  
* Peers die we al deels hebben: Cursor §69+, Cline §78, Claude Code elders; Windsurf/Kiro/Antigravity/Trae/PearAI/Zed/Aider/Roo = wantlist-kandidaten.  
* Geen kit; geen “beste IDE”-ADR.

#### Open / onduidelijk

* Prijs/feature-drift sinds mrt 2026; Cognition↔Windsurf (§104).  
* Geen Pi / DeepSeek Harness / OpenCode in lijst — gat t.o.v. ons A2.

---

## §104. 7 Best IDEs and AI Coding Tools (Its On Media)

**Type:** Agency-listicle · **URL:** [https://itsonmedia.com/blog/best-ides-software-and-ai-coding-tools/](https://itsonmedia.com/blog/best-ides-software-and-ai-coding-tools/) · Lorenzo Bono · 2026-10-02

- **Authority:** **Zwak–matig.** Web/agency-blog met service-CTAs (“Need this built…”). Redelijke industrie-samenvatting; geen benches. Bruikbaar als **markt-snapshot okt 2026** + prijs-tabel — verifiëren bij vendors.

#### A. Zeven tools (hun set)

1. **VS Code** + Copilot (agent-agnostic host)  
2. **Cursor** (Composer, background/cloud, MCP)  
3. **JetBrains** + Junie / Mellum / ACP  
4. **Windsurf** / Cascade; Cognition-acquisitie → Devin Desktop-lijn  
5. **GitHub Copilot** (multi-editor + cloud agent + PR)  
6. **Claude Code** (CLI + IDE companions + skills/MCP)  
7. **OpenAI Codex** (ChatGPT-bundled cloud agent + CLI)

#### B. Trends 2026 (artikel)

1. Autocomplete → chat → **agentic** (plan/edit/test/PR).  
2. Cloud/background agents overal.  
3. Model choice as feature.  
4. Protocollen: **MCP** + **ACP**.  
5. Consolidatie (o.a. Windsurf→Cognition).

#### C. IDE vs editor

* Classic onderscheid blur: VS Code + forks.  
* Zesde pilaar IDE = ingebouwde AI-agent.

#### Wat ik meeneem

* Bevestigt A4-vraag: editor-host vs harness vs cloud-agent zijn **losse assen**.  
* Codex/Copilot/Junie op A5-wantlist naast §78/§79.  
* Geen kit; authority < DataCamp §103 < primaire § (Cursor blogs, AA).

#### Open / onduidelijk

* Exacte $-tiers; agency-bias naar “hire us”.
* Harness-bouw / thesis (lessons & courses): **§105–§112**.  
* A6 policy-in-code / dunne AGENTS: **§113–§117**.

---

## §105. Building a Coding Agent From Scratch — harness architecture (Decoding AI)

**Type:** Course-artikel + repo · **URL:** [https://www.decodingai.com/p/building-a-coding-agent-from-scratch-system-design](https://www.decodingai.com/p/building-a-coding-agent-from-scratch-system-design) · Paul Iusztin · 2026-07-22 · course: [github.com/decodingai-magazine/building-a-coding-agent-from-scratch-course](https://github.com/decodingai-magazine/building-a-coding-agent-from-scratch-course)

- **Kern:** “Every AI app that wraps an agent is a harness.” Zelfde model, andere harness (LangChain Terminal-Bench-claim): ~30e → top 5. Course bouwt **Decode** (Python): loop → sandbox → context → subagents → remote swarm → evals/regressions. Onderzoek: Claude Code leak, OpenCode, Pi, Aider.

#### A. System design (Decode)

* Headless harness: interfaces pluggen in; kern = agent loop (tool → observation → context).  
* Modules: **LLM providers** (Modal / OpenRouter / Gemini), **Sandbox**, **Permissions**, **Memory** (AGENTS.md + MEMORY.md; JIT grep, geen zware index), **Skills**, **LSP** (ty/Astral — goedkoopste feedback), **compaction**.  
* Interfaces: TUI (steering queue + priority gate) + remote (Modal N parallel; cron/webhook).  
* Observability/evals: Opik + Kitaru; custom bench (publieke benches ≠ business).

#### B. Boundary

* ~20 regels Pydantic AI = “the agent”; rest = harness.  
* `AgentDeps`: cwd, emit, gate, permission resolver — tools kennen geen UI.

#### C. Course outline (8 lessen)

Loop → sandboxed shell → context eng → subagents → remote swarm → evals 101 → failures→regression suite.

#### Wat ik meeneem

* A2/lab: architectuur-kaart = checklist vs Pi/DSH (§76/§77).  
* Steering queue + LSP + evals = P25/P27-taal.  
* Geen kit; course = Assess-leerpad, niet fork-default.

#### Open / onduidelijk

* Exacte TB-leaderboard-run (derde-partij claim).

---

## §106. How to Build a Custom Agent Harness (LangChain)

**Type:** Engineering-blog · **URL:** [https://www.langchain.com/blog/how-to-build-a-custom-agent-harness](https://www.langchain.com/blog/how-to-build-a-custom-agent-harness) · Sydney Runkle · 2026-06-03

- **Kern:** `agent = model + harness`. Harness job = **juiste context op elk moment**. `create_agent` = minimale loop + **middleware** (filosofie ≈ Pi). Deep Agents / Claude Agent SDK = opinionated stacks; custom = middleware.

#### A. Middleware-hooks

* Before/after model; before/after tool; startup/teardown.  
* Levers: deterministic logic, tools lifecycle, custom state, stream handlers.

#### B. Capability → middleware (tabel)

| Capability | Voorbeelden middleware |
|------------|------------------------|
| Context overflow | Summarization, ContextEditing |
| Memory/skills | Filesystem, Memory, Skills |
| Environment | Shell, Filesystem, CodeInterpreter |
| Delegate | SubAgent, AsyncSubAgent, TodoList |
| Failures | Tool/Model Retry, ModelFallback |
| Policy/HITL | PII, HumanInTheLoop |
| Cost | Model/Tool CallLimit, PromptCaching |

#### C. Task–harness fit

* CS-agent ≠ long-running coding agent — stack per missie.  
* Alle LC-agents (GTM, async coding, no-code) op `create_agent` + tailored middleware.

#### Wat ik meeneem

* Lab: middleware/seams-denken = Cordis-plugins (§77) / Pi extensions (§76).  
* Vendor-blog; bruikbare vocabulaire, geen stack-ADR. Geen kit.

---

## §107. Community: instructions ≠ enforcement (“hotel fire poster”)

**Type:** Forum / commentaar · reddit-discussie (parafrase + citaten uit user-paste) · ~12d vóór 2026-10-26

- **Kern-metafoor:** AGENTS.md / SKILL.md / 500-regel system prompt ≈ evacuatieposter: nuttig, maar **geen** brandveiligheid. Echte veiligheid = detectors, deuren, lighting, **afgedwongen** procedures.  
- **Stelling:** Don’t just tell the model — build executable, observable, verifiable behavior. Instructions ≠ enforcement; prompt ≠ architecture.

#### A. OP / replies (samenvatting)

* OP: verwachtte dat Claude Code de *harness* zou ontwerpen i.p.v. prompts + regex-bandages.  
* **Dawn** (AI-persona op Opus): bugs worden gefixed waar ze *verschijnen*; regex = correcte lokale fix; vraag “is de laag verkeerd?” komt zelden. Voorbeeld: memory lookup matched wording i.p.v. subject — drie te-lage fixes; echte fix = condensed query *vóór* lookup. Habit: welke eerdere stap begrijpt het bericht al beter?  
* Skills unused: betere skill-description hielp minder dan **hook die raw action blokkeert** en skill noemt — polite reminders worden genegeerd.

#### Wat ik meeneem

* Kernlab-principe: **P25 / deterministische guardrails** boven prompt-theater (§5, §75).  
* Cross §108 failure modes; §81 Binding Constraint.  
* Geen kit; thread-URL niet stabiel — metafoor is de waarde.

#### Open / onduidelijk

* Exacte subreddit/permalink.

---

## §108. Harness thesis — learn-agent-architecture §00

**Type:** Open curriculum · **URL:** [https://github.com/hardness1020/learn-agent-architecture/tree/main/sections/00-harness-thesis](https://github.com/hardness1020/learn-agent-architecture/tree/main/sections/00-harness-thesis) · README

- **Kern:** “The model decides what to do. The harness gives it tools, state, and limits.” Model = judgment; harness = environment. Zonder harness: alleen antwoorden.

#### A. Harness must

1. Place for actions to run  
2. Useful observations  
3. Gate side effects  
4. Persist state across calls  

#### B. More harness ≠ better

* Elke laag: maintenance + model-generation coupling.  
* Op model-upgrade: her-evalueer; delete wat model nu zelf kan.  
* Extremes: **mini-swe-agent** (~150 regels, bijna geen harness) vs **deepseek-harness** (alles plugin/seams — delete = unload plugin).

#### C. Task quadrant (ai-agent-book claims)

* Agents rijpen eerst waar goal **exact** + resultaat **machine-checkbaar** (coding).  
* Clear goal, no check → loop “klaar” zonder stop.  
* Check, no clear goal → optimaliseert check i.p.v. intent.

#### D. Failure modes (selectie)

* Credit model for harness behavior  
* Hard-code decisions model should own  
* Too little / too much harness  
* Model policy as harness setting  
* No automatic checker  
* Mixed responsibilities (permissions inside tool exec)

#### E. Claude Code vs mini-swe-agent (tabel in README)

* CC: harness = main surface (safety, subagents, knowledge).  
* mini-swe: bash + confirm + budgets; rest = model.

#### Wat ik meeneem

* Beste korte thesis naast §81–§85; DSH/Pi extremes al in A2.  
* Meten vóór laag behouden (secties 20–21 in curriculum).  
* Geen kit.

---

## §109. Build Your Own AI Coding Agent Harness (Vercel Academy)

**Type:** Course · **URL:** [https://vercel.com/academy/build-ai-agent-harness](https://vercel.com/academy/build-ai-agent-harness) · md: […/build-ai-agent-harness.md](https://vercel.com/academy/build-ai-agent-harness.md) · ~38 lessen · stack: AI SDK, Sandbox, just-bash

- **Kern:** Bouw **TeensyCode** (TS): demo-loop → productieproblemen (context forever, `rm -rf`, explain-don’t-act, sandbox cost/timeout). Causal sequence: elke stap omdat vorige brak.

#### A. Wat je bouwt

* Loop: read/grep/write/edit/bash/task/askUser  
* Safety: allowlists → approval modes  
* Prompt: Agency / Guardrails / Ambiguity + AGENTS.md  
* Sandbox interface: local / in-memory (just-bash) / cloud  
* Context: pruneMessages, bounded tool output, cache control  
* Subagents: explorer (cheap/read-only) vs executor  
* HITL, todos, verification contract, skills progressive disclosure, event bus  

#### B. Modules 1–11 (koppen)

Agent loop → tool design → system prompt → sandbox → context → subagents → sandbox lifecycle → HITL → planning/verification → surfaces (CLI/web) → extensibility.

#### Wat ik meeneem

* TS-pad parallel Decode/Python (§105); past Pi-hypothese.  
* Assess-leerpad voor lab; geen Adopt Vercel-lock. Geen kit.

#### Open / onduidelijk

* Course-diepte vs product-marketing AI Gateway.

---

## §110. I’m Building My Own Coding Agent Harness (Composio / DEV)

**Type:** Engineering-essay · **URL:** [https://dev.to/composiodev/im-building-my-own-coding-agent-harness-and-its-pretty-cool-1lpf](https://dev.to/composiodev/im-building-my-own-coding-agent-harness-and-its-pretty-cool-1lpf) · VK / Composio · 2026-01-19

- **Kern:** Bottleneck ≠ code generation; = execution after: env, errors, integrations. Harness = run → capture → feed back → guardrails → observable. Zonder observe/retry = suggestion engine + human executor.  
- Composio ToolRouter: 6 meta-tools i.p.v. N OAuth-integraties (vendor-demo; learning project disclaimer).

#### Wat ik meeneem

* Bevestigt observability-first (§105 Opik).  
* Integratie-laag ≠ core harness — Assess Composio, niet Adopt. Geen kit.

---

## §111. Building an agent harness (Heeki Park) + managed AgentCore

**Type:** Blog · **URL:** [https://heeki.medium.com/building-an-agent-harness-31942331d605](https://heeki.medium.com/building-an-agent-harness-31942331d605) · 2026-04-23 · platform: [heeki/loom](https://github.com/heeki/loom)

- **Kern:** Prompt → context → **harness** engineering. Citeert LC deep-agents + Böckeler: `agent = model + harness`; outer harness = ↑ first-try + feedback vóór human.  
- Eigen Loom + AWS **AgentCore managed harness** (`source="harness"`): config-only deploy (model, prompt, tools, limits); MCP OAuth inject at invoke; JWT; observability logs.

#### Wat ik meeneem

* Enterprise/managed harness = andere pool dan coding-IDE harness (§76–§79).  
* Vergelijking: managed vs own loop — A4/B later. Geen kit.

#### Open / onduidelijk

* Medium 403 bij fetch; details deels via Loom release notes.

---

## §112. Anatomy of a harness — Mastra Code (long-running)

**Type:** Engineering-blog · **URL:** [https://mastra.ai/blog/anatomy-of-a-coding-agent](https://mastra.ai/blog/anatomy-of-a-coding-agent) · Sam Bhagwat · 2026-06-05

- **Kern:** Compaction is where agents die. Harness upgrade criteria: (1) manage own context, (2) survive restart, (3) hold decisions alone. Naive loop failures: **context rot**, **lossy compaction**, **stateless sessions**.

#### A. Conversation-as-channel

* Niet one-shot HTTP: open channel (pub/sub) → interrupt / queue / steer / crash-recovery multi-surface.

#### B. Display pipeline

* Raw chunks → semantic events (`processStreamChunk`) → reducer → **display state**; scheduler batch 250ms / flush HITL immediate; secret display-transform.

#### C. HITL tools + approval chain

* askUser / plan approval; back-channel model never sees; plain-text fallback headless CI.  
* Ordered: per-tool deny → YOLO → session grants → category policy → ask.

#### D. Overig

* Live todos; plan→build mode handoff; subagents isolated vs forked (cache warm); observational memory.

#### Wat ik meeneem

* Rijkste “productie-harness UX”-beschrijving; cross Decode steering (§105), Vercel askUser (§109).  
* Vendor (Mastra); mechanismen herbruikbaar. Geen kit.

#### Open / onduidelijk

* Observational memory details verder in post.
* A6 policy-in-code / dunne AGENTS: **§113–§117**.  
* A7 kwaliteitsladder / gates: **§118–§122**.

---

## §113. Harness engineering — Codex agent-first (OpenAI)

**Type:** Engineering-blog · **URL:** [https://openai.com/index/harness-engineering/](https://openai.com/index/harness-engineering/) · Ryan Lopopolo · 2026-02-11

- **Kern (A6):** “One big AGENTS.md” faalde. Korte AGENTS (~**100 regels**) = **inhoudsopgave**; `docs/` = system of record. **Mechanical enforcement** (linters, CI, structural tests) houdt kennis + architectuur coherent — documentatie alleen niet.

#### A. Waarom dikke AGENTS faalt

* Context schaars → verdringt taak/code.  
* Alles “belangrijk” → niets.  
* Rott snel; moeilijk mechanisch te verifiëren.

#### B. Progressive disclosure

* AGENTS → ARCHITECTURE / design-docs / exec-plans / generated schemas / QUALITY/SECURITY.md.  
* Doc-gardening agent + linters op freshness/cross-links.

#### C. Architecture as code

* Domains × vaste lagen + dependency-richting; custom linters + structural tests.  
* Lint-errors met **remediation** tekst voor agents (“positive prompt injection”).  
* Invariants (structured logging, file size, …) — niet micromanagen hoe.

#### Wat ik meeneem

* Sterkste empirische steun voor A6-pool **C**: dunne map + harde checks.  
* Cross §20 (overzichten helpen weinig), kit `make check`, §107. Geen kit-copy van hun layout.

#### Open / onduidelijk

* 0 hand-geschreven code = extreme setting; les schaalbaar naar lab.

---

## §114. Steering Claude Code — CLAUDE.md / skills / hooks / …

**Type:** Productdocs · **URL:** [https://claude.com/resources/articles/steering-claude-code-skills-hooks-rules-subagents-and-more](https://claude.com/resources/articles/steering-claude-code-skills-hooks-rules-subagents-and-more) · Anthropic · (ook via claude.com/blog-pad)

- **Kern (A6):** Zeven leveren met trade-off **context cost × authority**. Hooks = deterministisch, **buiten** main context; “Never do X” in CLAUDE.md is verkeerd tool → PreToolUse / permissions.

#### A. Beslisregel (artikel)

| Signaal in CLAUDE.md | Beter |
|----------------------|--------|
| “Every time X, always Y” | **Hook** |
| “Never do this” (hard) | Hook / managed permissions |
| 30-regels procedure | **Skill** |
| API-regel zonder paths | Path-scoped **rule** |
| Persoonlijke voorkeur in project-file | User-level settings |

#### B. Context

* Root CLAUDE.md: tip **onder 200 regels**, owner, review als code.  
* Subdir CLAUDE.md / path rules: load on demand.  
* Skills: name+desc always; body on invoke.  
* Hooks: exit 2 = block; stderr terug naar model; config niet in elke turn.

#### Wat ik meeneem

* Officiële vocabulaire voor A6-tabel “docs vs code”.  
* Lab: `make check` ≈ PostToolUse/Stop-sensor; path-allowlist ≈ PreToolUse. Geen kit.

---

## §115. Hooks — Deterministic Guardrails (Agent Patterns)

**Type:** Tutorial / curriculum · **URL:** [https://learn.agentpatterns.ai/harness-engineering/hooks-deterministic-guardrails/](https://learn.agentpatterns.ai/harness-engineering/hooks-deterministic-guardrails/)

- **Kern:** Instruction = *should* (probabilistisch). Hook = *must* (harness runt altijd). “Don’t break links” in AGENTS ≠ link-checker op commit.

#### A. Faalwijzen van hooks

* Verborgen globale state (onzichtbaar in transcript).  
* Over-scoped blocks (`rm` substring).  
* Performance tax op hot path → zwaar werk naar SessionEnd.

#### B. Wanneer hook verkeerd is

* Regel die soepel mag buigen (stijlvoorkeur) → prompt.  
* Checkable + non-negotiable → hook.

#### Wat ik meeneem

* Scherpe zin voor A6/A7: should vs must.  
* Complement SWMansion tip (AGENTS vs Skills vs Hooks) — zelfde scheiding. Geen kit.

#### Open / onduidelijk

* Curriculum-authority lager dan Anthropic/OpenAI; mechanisme klopt.

---

## §116. Harness engineering for coding agent users (Böckeler / Fowler)

**Type:** Essay · **URL:** [https://www.martinfowler.com/articles/harness-engineering.html](https://www.martinfowler.com/articles/harness-engineering.html) · Birgitta Böckeler · 2026-04-02 · mirror: [birgitta.info](https://birgitta.info/posts/harness-engineering.html)

- **Kern:** Outer harness (gebruikerslaag) = **guides** (feedforward) + **sensors** (feedback). Doelen: ↑ first-try + self-correct vóór human review; minder tokens.  
- Update-noot auteur: “harness” overloaded; user-laag soms beter “context engineering for coding agents”.

#### A. Computational vs inferential

| | Computational | Inferential |
|--|---------------|-------------|
| Guides | Code mods, typed constraints | AGENTS.md, skills |
| Sensors | ArchUnit / lint / tests (hooks) | LLM review / judge |

* Alleen feedback → herhaalt fouten; alleen feedforward → weet niet of het werkte.

#### B. Categorieën

* Maintainability / architecture fitness / behaviour harness — behaviour nog zwak (AI-tests ≠ genoeg).  
* Harnessability / ambient affordances: typed languages, module boundaries maken sensors mogelijk.  
* Steering loop: herhaaldelijke issues → verbeter harness (niet “probeer harder”).

#### Wat ik meeneem

* Conceptueel frame voor A6 + A7 (sensors = check-ladder).  
* Cross OpenAI §113 (zij noemt custom linters). Geen kit.

---

## §117. Effective harnesses for long-running agents (Anthropic)

**Type:** Engineering · **URL:** [https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents) · 2025-11-26 · vervolg/primitieven: [cwc-long-running-agents](https://github.com/anthropics/cwc-long-running-agents) · research: [harness design long-running apps](https://www.anthropic.com/research/harness-design-long-running-apps)

- **Kern (A6/A7/A9):** Prompt “test goed” faalt; **default-FAIL** + PreToolUse die results-file write weigert zonder evidence-Read; git commits + progress file = handoff; fresh-context evaluator zonder Write/Edit.

#### A. Failure modes zonder harness

* One-shot te veel; context middenin op.  
* “Done” zonder E2E (unit/curl ≠ UI).

#### B. Primitives (repo)

* Default-FAIL `test-results.json`.  
* Evaluator subagent.  
* Agent-maintained handoff (CLAUDE.md + commit-on-stop hook).

#### Wat ik meeneem

* “Asking nicely doesn’t reliably stop this” = A6-kern.  
* Progress/git = A9-spine. Geen kit; demo-repo niet production.  
* A7 kwaliteitsladder / gates: **§118–§122**.

#### Open / onduidelijk

* Exacte koppeling `/goal` product vs custom hooks.

---

## §118. Verification Gates (Agent Patterns)

**Type:** Tutorial / curriculum · **URL:** [https://learn.agentpatterns.ai/harness-engineering/verification-gates/](https://learn.agentpatterns.ai/harness-engineering/verification-gates/)

- **Kern (A7):** Agent claimt “done”; harness mag dat niet geloven. Completion = **deterministische** uitkomst (tests/build exit), niet narratie. Verifier moet **sterker** zijn dan generator (compiler/test ≠ self-grade LLM).

#### A. Waar de gate leeft

* **Stop-hook** (exit 2): blokkeert einde turn bij rood → agent blijft werken. Zelfde vorm als CI op PR en `SubagentStop`.  
* Niet: “all tests pass” in prose zonder exit-code.

#### B. Laag, niet één finish-line

* Per-edit: `PostToolUse` lint/typecheck (foutkost groeit met afstand).  
* Per-feature: Stop + tests.  
* Per-PR: CI.  
* Te fijn → onderdrukt exploratie; te zwaar → latere gigantische diffs; zwakke verifier → theater.

#### Wat ik meeneem

* Exacte A7-ladder-taal: in-loop → stop/check → CI.  
* Cross §115 (should/must), §117 (default-FAIL). Geen kit.

#### Open / onduidelijk

* Curriculum-authority lager dan Anthropic/OpenAI; mechanisme klopt.

---

## §119. Verification oracle — `make check` (Big Iron)

**Type:** Praktijkgids · **URL:** [https://www.bigiron.cc/guides/giving-a-coding-agent-a-verification-oracle-checks-it-must-pass-in-a-homelab-repo](https://www.bigiron.cc/guides/giving-a-coding-agent-a-verification-oracle-checks-it-must-pass-in-a-homelab-repo) · 2026-10-02

- **Kern (A7):** Eén oracle = één exit-status. Agents verifiëren inconsistent; “done” = oracle 0, niet claim. Vier plekken: AGENTS-regel, **Stop-hook**, **pre-commit**, **CI**.

#### A. Design

* `make check` = snelle validators (syntax/lint per filetype); split **`check-full`** voor zwaar → CI (niet elke Stop).  
* Agents “fixen” soms de Makefile i.p.v. code → verbied oracle-edits in instructie + eventueel pad-gate.  
* Taken schrijven met oracle: “Done when `make check` exits 0 …”  

#### B. Revert-patroon

* Kleine/lokale model: apply → check → **auto-revert** bij fail = betrouwbare editor.  
* Oracle = vloer, geen bewijs van runtime-gedrag.

#### Wat ik meeneem

* 1:1 met kit: `make check` vs `check-full` / opt-in.  
* A7 revert = werkwijze + later hook. Geen kit-copy van hun Makefile.

---

## §120. HAR — verification & commit gate

**Type:** Productdocs · **URL:** [https://harproject.dev/docs/guides/verification/](https://harproject.dev/docs/guides/verification/) · bijgewerkt ~2026-10

- **Kern (A7):** **Quick** verify (iteratie) vs **`--full`** (completion contract). Commit-gate: pre-commit vergelijkt **content-hash** staged batch met laatste geslaagde full-validatie — niet timestamps/branch.

#### A. Mechanisme

* Full verify → record tree-state; latere edit **invalideert**.  
* `mode`: block | warn; `scope`: worktrees (agent) vs all.  
* Correcte volgorde: full verify → stage **alles** wat geverifieerd is → commit. Bypass = anti-patroon.  
* `complete` hergebruikt matching passing full; anders weiger of `--verify`.

#### Wat ik meeneem

* Content-bound “geen commit zonder bewijs” = sterkere vorm van pre-commit + check.  
* Lab: pre-commit ⊂ snelle check; full = check-full / merge. Geen HAR-adopt zonder B.

#### Open / onduidelijk

* Product-specifiek; principe overdraagbaar zonder HAR te installeren.

---

## §121. Claude Code — verify + Stop /goal-spectrum

**Type:** Productdocs · **URL:** [https://code.claude.com/docs/en/best-practices](https://code.claude.com/docs/en/best-practices) · hooks: [hooks-guide](https://code.claude.com/docs/en/hooks-guide) · session-goal: [goal](https://code.claude.com/docs/en/goal)

- **Kern (A7):** Zonder check die de agent kan draaien, wordt **jij** de verificatielus. “Looks done” ≠ done. Hardheid van de gate is een spectrum.

#### A. Spectrum (officieel)

| Hardheid | Mechanisme |
|----------|------------|
| Prompt | Vraag check + iterate inzelfde beurt |
| `/goal` | Evaluator hercheckt conditie na elke turn (sessie-scoped) |
| Stop **command**-hook | Script exit ≠0 → stop geblokkeerd (deterministisch) |
| Stop **agent**-hook | Subagent runt suite (experimenteel; productie → command) |
| Second opinion | Verifier-subagent / refute, niet self-grade |

* Evidence tonen (test output, exit) sneller te reviewen dan zelf opnieuw draaien.  
* `/goal`-evaluator leest transcript — conditie moet aantoonbaar zijn uit agent-output (`npm test` exit 0), niet “code is goed”.

#### Wat ik meeneem

* Vocabulaire voor lab: AGENTS “run make check” (prompt) → later Stop-hook op `make check`.  
* Cross §117, §114. Geen kit.

---

## §122. Emma Code — verification ladder & anti-theater

**Type:** Productdocs · **URL:** [https://www.emma.build/docs/emma-code-loop.html](https://www.emma.build/docs/emma-code-loop.html)

- **Kern (A7):** Betrouwbaarheid zit in **bounded loop** + acceptance gate, niet in model. “No more tool calls” ≠ done. Ladder schaalt met kost-van-fout.

#### A. Ladder (extern signaal per tree)

* Inline (mutation): syntax/parse + lint → verbatim stderr terug.  
* Tests (`/high`): `test_command` vóór accept.  
* Independent verifier (`/max`): fresh context, refute; “looks right” zonder run = afkeuren.  
* Anti-theater: verzwakte asserts, deleted tests, narrowed claim → expliciet bestrijden.  
* Checkpoint vóór destructieve cmds; fail → restore-pad.

#### B. Wat niet

* Self-grade als judge.  
* Onbegrensde retry (signature loop-detect → block).

#### Wat ik meeneem

* Intensiteit-dial ≈ A7: in-loop cheap → check → check-full/opt-in.  
* Anti-theater = meetbaar risico bij agent-tests. Vendor-product; principes overnemen, geen Emma-stack tot B.  
* A9 session-scope / spine: **§128–§132**.

#### Open / onduidelijk

* Cijfers/`emma-eval` niet onafhankelijk geverifieerd hier.

---

## §128. Claude Code — sessions (directory-bound transcripts)

**Type:** Productdocs · **URL:** [https://code.claude.com/docs/en/sessions](https://code.claude.com/docs/en/sessions) · SDK: [agent-sdk/sessions](https://code.claude.com/docs/en/agent-sdk/sessions)

- **Kern (A9):** Session = opgeslagen conversatie **gebonden aan project directory**. Lokaal als `.jsonl` onder `~/.claude/projects/<pad-encoded>/`. `--continue` = recentste in **cwd**; `--resume` = picker/id/pad.

#### A. Wat resume herstelt

* History (+ compact-summary); model; agent/permissions; active `/goal`; interrupted tools = *niet* auto-rerun.  
* Cross-directory lookup: ID kan buiten huidige projectmap gevonden worden; transcript blijft **op dezelfde machine**.  
* Geen gedeelde cloud-spine: multi-machine → eigen SessionStore/spiegel.

#### Wat ik meeneem

* Officiële bevestiging: chat-state ≠ repo-files; hangt aan **pad**.  
* Lab: IDE/CLI-history is pool A/B-achtig (tool-home), niet P27-spine. Cross §117 (progress in repo). Geen kit.

---

## §129. Claude Code — worktrees (parallel scope)

**Type:** Productdocs · **URL:** [https://code.claude.com/docs/en/worktrees](https://code.claude.com/docs/en/worktrees)

- **Kern (A9):** Parallelle sessions via **git worktrees** (of hooks). Resume van een worktree-session **keert terug** naar die checkout zolang die bestaat; weg = resume in launch-dir + binding cleared.

#### A. Scope-regels

* Transcript volgt worktree bij enter/exit (v≥2.1.198) — zelfde idee als `/cd`.  
* `--fork-session`: nieuwe session in **launch**-dir; originele worktree onaangeroerd.  
* Issues elders: worktree-sessions soms lastig te hervatten → workaround = `git worktree add` + `claude` *in* die map als top-level session.

#### Wat ik meeneem

* Sterkste product-voorbeeld pool **C**: state/scope = worktree/cwd, niet “één chat voor hele monorepo”.  
* Lab-kandidaat: spine of session per worktree/app-map. Geen Claude-worktree-copy in kit.

---

## §130. Pi — sessions, tree & storage (cwd-grouped)

**Type:** Productdocs · **URL:** [https://pi.dev/docs/latest/sessions](https://pi.dev/docs/latest/sessions) · format: [session-format](https://pi.dev/docs/latest/session-format) · verdieping **§76**

- **Kern (A9):** Session = JSONL-tree (`id`/`parentId`); model ziet **active leaf**, niet alle branches. Opslag default `~/.pi/agent/sessions/`, **gegroepeerd op working directory**. `--continue` = recentste voor **cwd**.

#### A. Branch vs aparte session

| Commando | Effect |
|----------|--------|
| `/tree` | Binnen zelfde file |
| `/fork` / `/clone` | Nieuwe session-file |
| Compaction | Samenvatting; originele entries blijven |

* `--session-dir` / `PI_CODING_AGENT_SESSION_DIR` verplaatst storage (kan repo-lokaal).  
* `--no-session` = ephemeral, geen resume.  
* Export JSONL/HTML = deelbaar artefact (secrets-review).

#### Wat ik meeneem

* Pool **D** (session-id + tree) + cwd-binding.  
* Belangrijk onderscheid A9: home-dir transcripts ≠ **repo-spine** (P27). Lab wil vaak beide: tool-session + files in werkmap. Geen kit.

---

## §131. Planning-with-files — plan/progress/ledger op disk

**Type:** Skill / harness-docs · **URL:** [https://github.com/OthmanAdi/planning-with-files/blob/master/docs/long-running-agent-tasks.md](https://github.com/OthmanAdi/planning-with-files/blob/master/docs/long-running-agent-tasks.md) · repo: [planning-with-files](https://github.com/OthmanAdi/planning-with-files)

- **Kern (A9/P27):** Drift + “done”-theater = **state-problemen**. Tegengif: files op disk + mechanische herinjectie. Context-dood / `/clear` → verse session hervat uit files, niet uit chat.

#### A. Patronen

* Baseline: `task_plan.md` + `findings.md` + `progress.md`; hooks injecteren plan per turn.  
* v3: append-only **ledger** JSONL onder `.planning/<…>/`; model krijgt vaste summary (KV-cache-stabiel), geen free-text dump.  
* Gate oordeelt plan-artefact op disk, niet transcript.  
* Attestation (hash) van plan tegen stilzwijgende injectie-wijziging.  
* Eval (auteur): na hard wipe ~**5.0** vs **13.3** turns re-orient — methode zie hun `evals.md`.

#### Wat ik meeneem

* Concrete pool **C/D**: spine **in repo** (`.planning/`), chat mag leeg.  
* Past A8+A9: MD voor mens-plan + JSONL ledger. Cross §117. Community-skill; geen verplichte adopt.

#### Open / onduidelijk

* Token-overhead ~+68% in hun eval — trade-off meten in lab.

---

## §132. Cursor — chat history gebonden aan workspace-pad

**Type:** Forum / productgedrag · **URL:** [https://forum.cursor.com/t/lost-access-to-5-7-agent-conversations-after-workspace-folder-restructure/147837/2](https://forum.cursor.com/t/lost-access-to-5-7-agent-conversations-after-workspace-folder-restructure/147837/2) · gerelateerd: [rename → history weg](https://forum.cursor.com/t/solved-i-renamed-3-project-folder-names-and-my-composer-and-chat-history-is-gone/48163) · [workspace ID / birthtime](https://forum.cursor.com/t/bug-report-the-reason-why-cursor-keeps-losing-our-chats-and-agents-and-how-to-fix-it/149784)

- **Kern (A9):** Cursor-support: chat/agent-history is **tied to workspace path**. Map verplaatsen/hernoemen → nieuwe workspace-storage; oude chats blijven bij oud pad (niet “weg”, wel onzichtbaar). Multi-root: identity = `.code-workspace`-bestand.

#### A. Implicatie

* Pool **A** faalt exact op jouw productpijn: omhoog/andere root = andere history-binding.  
* Workarounds: oud pad openen; Search Agents; SpecStory-backup; DB-remap (community, riskant).  
* Geen officiële “spine in repo”-fix van Cursor — dat is lab-terrein (P27).

#### Wat ik meeneem

* Empirische steun hypothese: spine-files > hopen op IDE-history over padgrenzen.  
* Authority = forum/support, geen paper — wel herhaald gedrag. Geen kit.  
* A5 harness×model benches: **§133** (≠ community-leaderboard §84).

---

## §133. Harness-Bench (PKU / Qiyuan) — arXiv:2605.27922

**Type:** Paper · **URL:** [https://arxiv.org/abs/2605.27922](https://arxiv.org/abs/2605.27922) · v1 preprint ~2026-05-27 · code: [Qihoo360/harness-bench](https://github.com/Qihoo360/harness-bench) · site: [harness-bench.ai](http://www.harness-bench.ai/) · populair cite: Fireship-screenshot Table 2 (arXiv-badge rechtsonder; video-URL hier niet vastgelegd)

- **Kern (A5):** Agent = **Model + Harness**. Bestaande benches houden H vaak vast of vergelijken complete systemen — dan misattributie. Harness-Bench: **factorial** 106 taken × **6** configureerbare harnesses × **8** model-backends → **5.088** trajectories (+ **106** Codex apart) = **5.194** totaal. Score op configuratie-niveau rapporteren, niet “het model”.

#### A. Protocol (v1 / Table 2)

* Taken: sandboxed, offline, oracle-checkbaar; vaste budget/timeout/evaluator/startstate.  
* Harness **native** gedrag behouden (prompting, tools, state, recovery) — geen geforceerde uniforme interne loop.  
* Score ≈ Security × Completion × Process; Process = (Tool + Consistency + Robustness)/3; process-judge vast: claude-sonnet-4.6.  
* Security in Table 2 overal **100%** (geen permission/security-fail in aggregaat).  
* Model-pool o.a. qwen3.6-plus, gpt-5.4, glm-5.1, claude-sonnet-4.6, **kimi-k2.5**, gemini-3.1-pro-preview, claude-opus-4.6, deepseek-v4-flash (figuur paper) — “KimiK” in Fireship-clip = die backend in de matrix, niet de bench-naam.

#### B. Table 2 — aggregaat per harness (screenshot / paper)

Configurable harnesses = gemiddelde over 106×8. Codex = model-bound coding agent, zelfde suite, **apart**.

| Harness | Score % | Comp. % | Tool % | Cons. % | Rob. % | Tok. (K) ↓ | Turns ↓ |
|---------|---------|---------|--------|---------|--------|------------|---------|
| OpenClaw | 52.4 | 60.0 | 79.5 | 74.0 | 70.9 | 82.1 | 5.0 |
| NanoBot | **76.2** | **81.6** | **93.8** | 93.7 | **91.7** | **68.7** | 7.3 |
| Hermes | 71.2 | 80.4 | 88.5 | 88.4 | 85.5 | 139.7 | **22.6** |
| ZeroClaw | 61.4 | 69.9 | 84.1 | 83.2 | 79.0 | 133.2 | 8.6 |
| NullClaw | 64.4 | 75.9 | 85.3 | 81.4 | 78.3 | 175.1 | 12.1 |
| Moltis | 68.8 | 78.4 | 86.3 | 87.3 | 84.1 | 134.9 | 8.0 |
| Codex* | 80.4 | 86.5 | 92.4 | 93.9 | 91.6 | 86.1 | 5.0 |

* Gap best→slechtst configurable: NanoBot−OpenClaw = **23.8** pp score.  
* NanoBot: top score **én** laagste tokens onder configurable — “meer turns/machinery ≠ winnen” (Hermes 22.6 turns / 139.7K tok, lagere score).  
* Sterkere backends: **lagere** cross-harness variance (paper figuur).  
* Failures (paper-analyse): o.a. contract/format, tool/recovery, evidence/grounding, artifact-commitment, state/continuation.

#### C. Naam-botsing

* **≠** community-leaderboard **§84** (TheLime1/harness-bench) — andere repo/doel.  
* Cross: Binding Constraint **§81**, Scaffold **§82**, SWE-Pro grid **§83**, Arena HarnessTax **§85**.

#### Wat ik meeneem

* Harde A5-steun: meet **H×M**; dunne/legible loop kan Pareto (NanoBot).  
* OpenClaw (feature-rijk, multi-channel) hier **laagste** aggregate — past “negatieve ruimte” / anti-bloat (§33/Pi), niet “meer plugins = beter”.  
* Lab: geen NanoBot-adopt op één table; wél hypothese “smalle harness + checks” (A6/A7). Codex* niet 1:1 vergelijkbaar met configureerbare H.  
* Fireship = popularisatie; cijfers uit paper/screenshot, niet uit video-transcript hier.

#### Open / onduidelijk

* Live arXiv-abs kan **nieuwere** versie tonen (andere task-counts/abstract) — Table 2 hier = **v1 / Fireship-shot**. Bij hercite PDF-version checken.  
* Exacte Fireship-video-URL niet vastgelegd bij deze §.  
* Process-LLM-judge bias; één trajectory per cel.

* Kimi / Moonshot parallel aan DeepSeek-lijn: **§134–§142**.

---

## §134. Kimi / Moonshot — papers & lineage (parallel §89)

**Type:** Collectie / index · **URL:** [https://huggingface.co/moonshotai/papers](https://huggingface.co/moonshotai/papers) · collections: [Kimi-K2](https://huggingface.co/collections/moonshotai/kimi-k2), [Kimi-K3](https://huggingface.co/collections/moonshotai/kimi-k3) · org: [moonshotai](https://huggingface.co/moonshotai)

- **Kern (A3):** Officiële Moonshot HF-papers/collecties als **ingang** naast DeepSeek §89. Geen Fowler-achtige single-essay lineage gevonden → deze tabel + §135–§138 vullen dat.

#### A. Mapping DeepSeek-item → Kimi-tegenhanger

| DeepSeek (§) | Rol | Kimi-parallel |
|--------------|-----|---------------|
| §89 papers-index | arXiv-ingang | **Deze §** + moonshotai/papers |
| §90 Fowler series | Narratieve lineage | Geen 1:1; gebruik §135→§138 chronologie |
| §91 model card | Officiële sizes/arch | §137 HF/GitHub K3 |
| §92 Transparency hub | Cards+reports hub | HF collections + kimi.ai/blog (zwakker parallel) |
| §93 V4.1-Flash news | Post-train release | §138 K3.1 Pro blog |
| §94 V3/V3.2 PDF | Tech reports | §135 K2 PDF + §137 K3 arXiv |
| §56/§58 bycloud V4 | Explainer-arch | §136 K2.5 + §137 K3 (papers) |
| §60 infra | Train/serve infra | §137 infra-secties; KDA **§140** |
| §65 Muon | Optimizer | §139 MuonClip / Moonlight |
| §77 `dsh` harness | Coding harness | §141 Kimi Code CLI |
| §80 AA Coding | Cost×kwaliteit | §142 AA Cyber Index (+ AA Intelligence compare) |

#### B. Lineage (selectie arXiv)

| Paper | arXiv | Notitie |
|-------|-------|---------|
| Kimi k1.5 (RL) | [2501.12599](https://arxiv.org/abs/2501.12599) | ≈ R1-achtige RL-as |
| Muon is Scalable | [2502.16982](https://arxiv.org/abs/2502.16982) | Moonlight; → MuonClip |
| Kimi K2 | [2507.20534](https://arxiv.org/abs/2507.20534) | 1T/32B act; **§135** |
| Kimi Linear / KDA | [2510.26692](https://arxiv.org/abs/2510.26692) | Long-ctx; **§140** |
| Attention Residuals | (moonshotai/papers) | Diepte K3 |
| Kimi K2.5 | [2602.02276](https://arxiv.org/abs/2602.02276) | Visual agentic; **§136** |
| Kimi K3 | [2607.24653](https://arxiv.org/abs/2607.24653) | 2.8T/104B; **§137** |

#### Wat ik meeneem

* A3: DeepSeek blijft cost-default-hypothese; Kimi = **sterke open/agentic peer** (zeker cyber/coding).  
* Geen kit.

---

## §135. Kimi K2 — Open Agentic Intelligence

**Type:** Tech report · **URL:** [https://arxiv.org/abs/2507.20534](https://arxiv.org/abs/2507.20534) · PDF: [MoonshotAI/Kimi-K2 tech_report](https://github.com/MoonshotAI/Kimi-K2) · parallel §94/V3-lijn

- **Kern:** MoE **1T** totaal / **32B** activated. **MuonClip** (Muon + QK-clip) → 15.5T tokens pretrain, claim zero loss spike. Post-train: agentic data synthesis + joint RL met echte/synthetische omgevingen.

#### A. Claims (paper; non-thinking settings)

* Tau2-Bench 66.1; ACEBench (En) 76.5; SWE-Bench Verified **65.8**; SWE Multilingual 47.3.  
* Coding/math: LiveCodeBench v6 53.7; AIME 2025 49.5; GPQA-D 75.1.  
* Weights: Base + Instruct/Thinking op HF (`moonshotai/Kimi-K2-*`).

#### Wat ik meeneem

* Zelfde “open MoE + agentic RL”-patroon als DeepSeek V3/R1-as, andere org.  
* MuonClip deelt optimizer-familie met DeepSeek Muon (§65). Geen kit.

---

## §136. Kimi K2.5 — Visual Agentic Intelligence

**Type:** Paper + weights · **URL:** [https://arxiv.org/abs/2602.02276](https://arxiv.org/abs/2602.02276) · HF: [moonshotai/Kimi-K2.5](https://huggingface.co/moonshotai/Kimi-K2.5) · parallel §58 multimodal-as

- **Kern:** Continual pretrain ~**15T** mixed vision+text op K2-Base. Native multimodaal; **Agent Swarm** (parallel sub-agents). Instant + thinking modes.

#### A. Samenvatting model

* 1T / 32B act; 384 experts / 8 act; MLA; MoonViT ~400M; context **256K**.  
* Native INT4 (zoals K2-Thinking). Deploy: vLLM / SGLang / KTransformers.  
* API: platform.moonshot.ai (OpenAI/Anthropic-compat).

#### Wat ik meeneem

* Tegenhanger “Flash/Pro multimodal”-narratief; Swarm ≈ multi-agent harness-laag in model-product. Geen kit.

---

## §137. Kimi K3 — Open Frontier Intelligence (+ model card)

**Type:** Tech report + card · **URL:** [https://arxiv.org/abs/2607.24653](https://arxiv.org/abs/2607.24653) · weights: [moonshotai/Kimi-K3](https://huggingface.co/moonshotai/Kimi-K3) · GitHub: [MoonshotAI/Kimi-K3](https://github.com/moonshotai/Kimi-K3) · parallel §91/§56 V4

- **Kern:** **2.8T** / **104B** activated; native vision; **1M** context. Arch: **KDA** + AttnRes + Stable LatentMoE (16/896 experts). Claim ~**2.5×** scaling-efficiency vs K2. Infra: KDA co-design, EP training, million-token agentic RL + sandboxes.

#### A. Card-cijfers (README)

* 93 layers; 69 KDA + 24 gated MLA; MoonViT-V2 401M; MXFP4 weights / MXFP8 acts (QAT).  
* License: Kimi K3 License (niet MIT — anders dan DeepSeek V4 MIT-claim).  
* Open weights released; trails top proprietary (Claude Fable 5 / GPT-5.6 Sol in hun suite) maar boven andere open/prop baselines in paper-suite.

#### Wat ik meeneem

* Dichtste V4-tegenhanger: 1M ctx + sparse MoE + open weights.  
* Lab: licentie + $/tok vs DeepSeek Flash meewegen (§142). Geen kit.

---

## §138. Kimi K3.1 Pro — release blog

**Type:** Productblog · **URL:** [https://www.kimi.ai/blog/kimi-k3-1-pro](https://www.kimi.ai/blog/kimi-k3-1-pro) · parallel §93

- **Kern:** Post-trained K3 met zwaarder joint RL over veel domains. API/product: `kimi-k3.1-pro` + **Highspeed** (2–3×). Weights beloofd ~**2026-11-04** (blog). Ook Kimi Code / Work / apps.

#### A. Bench-claims (vendor)

* Terminal-Bench 4.0: **65.7%** (vs GPT-6 Astra 58.2%; Claude Opus 5.5 66.4%).  
* Interne Kimi Code Bench 3.0 long-horizon: **61.2%** (K3 55.95%).

#### Wat ik meeneem

* Screenshot-Fireship “Kimi k3.1 Pro” = dit product; onafhankelijke AA: **§142**.  
* Vendor-cijfers ≠ §; AA wint voor lab-vergelijking. Geen kit.

#### Open / onduidelijk

* Weights-status na Nov-4 claim; Highspeed = zelfde weights of distil?

---

## §139. MuonClip / Moonlight Muon (Kimi optimizer-lijn)

**Type:** Papers · **URL:** Muon scalable [https://arxiv.org/abs/2502.16982](https://arxiv.org/abs/2502.16982) · K2 MuonClip in [2507.20534](https://arxiv.org/abs/2507.20534) · parallel §65

- **Kern:** Moonshot schaalt **Muon** (~2× token-efficiency vs AdamW-claim); mid-scale logits explodeerden → **MuonClip** / QK-clip stabiliseert (max logits onder ~100 in K2-narratief). Moonlight-A3B = vroege Muon-scale demo.

#### Wat ik meeneem

* Zelfde optimizer-familie als DeepSeek-train stack — cross-org convergentie. Geen kit.

---

## §140. Kimi Linear — KDA (long-context arch)

**Type:** Tech report · **URL:** [https://arxiv.org/abs/2510.26692](https://arxiv.org/abs/2510.26692) · code: [MoonshotAI/Kimi-Linear](https://github.com/MoonshotAI/Kimi-Linear) · parallel CSA/MLA-efficiëntie §56–§58

- **Kern:** **Kimi Delta Attention (KDA)** + hybrid **3:1** KDA:MLA. Fair compare: slaat full MLA; KV-cache tot **−75%**; decode tot **~6×** @ 1M ctx (paper). Kernels + vLLM open.

#### Wat ik meeneem

* Architectuur-antwoord op lange agent-context / harness tax (tokens in KV). K3 bouwt hierop voort (§137). Geen kit.

---

## §141. Kimi Code CLI — coding harness

**Type:** Product / repo · **URL:** [https://github.com/MoonshotAI/kimi-code](https://github.com/MoonshotAI/kimi-code) · docs: [moonshotai.github.io/kimi-code](https://moonshotai.github.io/kimi-code/en/) · parallel §77 DSH

- **Kern:** Terminal coding agent (TS); tools = read/edit/shell/search/web; MCP; skills/plugins; **lifecycle hooks**; ACP IDE. Subagents: `coder` / `explore` / `plan` (geïsoleerde context). SDK: `KimiHarness`.

#### A. Relevant voor A2/A6/A7

* Hooks = should→must (A6/A7).  
* Subagents = Explore-achtig (§69 Cursor).  
* Default Moonshot models; andere providers configureerbaar.

#### Wat ik meeneem

* Peer naast Pi/DSH/Cline — Assess voor B, niet auto-fork. Geen kit.

---

## §142. AA Cyber Index — Kimi vs DeepSeek (Fireship-shot)

**Type:** Benchmark-dashboard · **URL:** [https://artificialanalysis.ai/evaluations/artificial-analysis-cyber-index](https://artificialanalysis.ai/evaluations/artificial-analysis-cyber-index) · compare: [K3.1 Pro vs V4.1 Flash 1017](https://artificialanalysis.ai/models/comparisons/kimi-k3-1-pro-vs-deepseek-v4-1-flash-1017) · parallel §80; bron screenshot Fireship

- **Kern:** Cyber Index v1 = gelijk gewogen **CWE-Bench-AA** + **DeepsecBench-AA** + **CyberGym-E2E-AA** (defensief: vinden/reproduceren/patchen; geen exploit-bouw). Snapshot chart: **Kimi K3.1 Pro ~64%** #1 openbaar; **DeepSeek V4.1 Flash 1017 (max) ~57%**; trusted GPT-6 Sol Daybreak ~69% (niet public).

#### A. Nuance (AA + news)

* K3.1 Pro sterk op CyberGym-E2E (~95% claim in AA-news); DeepSeek kan winnen op CWE-Bench.  
* Intelligence Index compare: K3.1 Pro **55** vs Flash 1017 **45** — maar DeepSeek **~7× goedkoper**/M tok en sneller (AA table: ~$1.54 vs ~$0.18; ~50 vs ~170 tok/s).  
* Safety blocks: public GPT-6 Sol veel refusals; Kimi/DeepSeek weinig in chart.

#### Wat ik meeneem

* Lab-default DeepSeek blijft **cost/speed**-rationeel; Kimi = **kwaliteit/cyber/coding** peer om mee te meten (H×M).  
* Cross §47 Strix (security-scan) ≠ model-cyber-bench. Geen kit.

#### Open / onduidelijk

* Leaderboard drift; weights K3.1 Pro vs API-only tot release-datum.

---

## §156. SWE-bench: Can Language Models Resolve Real-World GitHub Issues? (Jimenez e.a.)

**Type:** Paper (ICLR 2024) · **URL:** [https://arxiv.org/abs/2310.06770](https://arxiv.org/abs/2310.06770) · **PDF:** [`pdfs/Jimenez-Yang_SWE-bench.pdf`](pdfs/Jimenez-Yang_SWE-bench.pdf)

- **Kern (abstract):** Benchmark van echte GitHub-issues: gegeven een codebase en een issue, een patch die de bijbehorende fail-to-pass tests haalt. 2.294 taken, 12 Python-repo’s. Met BM25-retrieval (geen agentlus) lost het sterkste model in de paper, Claude 2, 1,96% op.
- **Leesdiepte:** abstract en bench-definitie. De paper is nog niet volledig uitgelezen.
- **Cross:** agent-ACI op deze bench **§19**; latere harness-benches noemen SWE-bench doorlopend.

#### Wat ik meeneem

* Dit is het takenprotocol (issue + repo → patch, tests), niet een zoeklaag.
* Geen kit.

#### Open / onduidelijk

* Verified/Lite-afsplitsingen en de precieze retrieval-setup horen bij een volledige lezing.

---

## §157. Agentless: Demystifying LLM-based Software Engineering Agents (Xia e.a.)

**Type:** Paper · **URL:** [https://arxiv.org/abs/2407.01489](https://arxiv.org/abs/2407.01489)

- **Kern (abstract):** Drie fasen — lokalisatie, repair, patch-validatie — zonder dat het model zelf de volgende actie of complexe tools kiest. Lokalisatie is hiërarchisch (LLM plus klassieke information retrieval). Op SWE-bench Lite: 32,00% (96 fixes) bij gemiddeld $0,70, als hoogste open-source resultaat in die vergelijking.
- **Leesdiepte:** abstract. De paper is nog niet volledig uitgelezen.
- **Cross:** agent met eigen zoekinterface **§19**.

#### Wat ik meeneem

* Een pijplijn buiten de agentlus kan lokalisatie én kost rapporteren. Dat is een andere opzet dan een agent die een zoektool zelf aanroept.
* Geen kit.

#### Open / onduidelijk

* Hoe de lokalisatie precies retrieval doet (embeddings of anders) staat niet in het abstract.

---

## §158. TokenEconomizer: Experience-Driven Black-Box Cost Control for Coding Agents (Li e.a.)

**Type:** Paper · **URL:** [https://arxiv.org/abs/2610.22732](https://arxiv.org/abs/2610.22732) · **PDF:** [`pdfs/AaronJ-Li_TokenEconomizer.pdf`](pdfs/AaronJ-Li_TokenEconomizer.pdf)

- **Kern (abstract en inleiding):** Externe controller: micro-skills injecteren, tools schrappen, falende lussen stoppen. Gemiddelde tokenkost op SWE-bench 18,4–30,9% lager, bij vergelijkbare slaagkans. Drie vaste strategieën op 60 taken in 6 repo’s — output comprimeren, semantische navigatie (Serena), een repo-map van Aider in de prompt — verlagen de kost niet consistent; per repo loopt het effect van een besparing naar een meerprijs.
- **Leesdiepte:** abstract en inleiding.
- **Cross:** repo-map als docs-vorm **§16**; Instant Grep **§69**.

#### Wat ik meeneem

* Een vaste zoekhulp in de prompt is niet dezelfde ingreep als de zoeklaag kiezen. De besparing in deze paper komt van een adaptieve controller.
* Geen kit.

#### Open / onduidelijk

* Rest van de paper, inclusief de precieze kostenuitsplitsing per strategie.

---

## §159. How Do Small Coding Agents Use Code Graphs and Embeddings? (Bellam)

**Type:** Paper · **URL:** [https://arxiv.org/abs/2610.33958](https://arxiv.org/abs/2610.33958) · **PDF:** [`pdfs/Saurav-Bellam_How-Do-Small-Coding-Agents-Use-Code-Graphs.pdf`](pdfs/Saurav-Bellam_How-Do-Small-Coding-Agents-Use-Code-Graphs.pdf)

- **Kern (abstract):** Ablatie van de toolset van een lokalisatie-agent op SWE-bench Verified met kleine open modellen: alleen grep, plus embedding-search, plus graaftools, of alles. Hoofduitkomst is lokalisatie-accuraatheid, niet tokens per geslaagde taak.
- **Leesdiepte:** abstract.
- **Cross:** grep-pad **§69**; semantische search **§70**.

#### Wat ik meeneem

* Graaf en embeddings worden hier op lokalisatie gemeten. Gestructureerde tools verdubbelen de grep-only accuraatheid bij 8B-klasse; de winst zakt naar 4–5 punten bij 32B. Een kostenprotocol per geslaagde taak zit er niet als hoofduitkomst in.
* Geen kit.

#### Open / onduidelijk

* Abstract gelezen 9 nov 2026. Traces en tabellen voorbij de abstract nog niet.

---

## §160. SWE-bench Verified: grep naast embeddings (Augment Code)

**Type:** Engineering-blog · **URL:** [https://www.augmentcode.com/blog/1-open-source-agent-on-swe-bench-verified-by-combining-claude-3-7-and-o1](https://www.augmentcode.com/blog/1-open-source-agent-on-swe-bench-verified-by-combining-claude-3-7-and-o1)

- **Datum:** 2025-03-31
- **Kern:** Hun agent haalt 65,4% op SWE-bench Verified. Embedding-retrieval was op die taken niet de bottleneck: `grep` en `find` volstonden voor de slaagkans. Voor het product (ambigue vragen, grote codebases) noemen ze embeddings wel nodig. De post heeft geen token- of kostenprotocol.
- **Cross:** Instant Grep **§69**; bench **§156**.

#### Wat ik meeneem

* Slaagkans op SWE-bench kan met grep volstaan. Dat zegt niet dat een exacte index of embeddings de tokenrekening verlagen.
* Geen kit. Vendor-blog: context, niet het enige bewijs.

---

## §161. Gist — claims over code-search en tokens (Frischer)

**Type:** Gist · **URL:** [https://gist.github.com/ariel-frischer/891aef9ae4059862f7edd71307255153](https://gist.github.com/ariel-frischer/891aef9ae4059862f7edd71307255153)

- **Datum:** 2026-01-25
- **Kern:** Secundaire kaart die semantische RAG, grep en agentisch zoeken naast elkaar legt. De openings­tabel (“semantic +12–40% nauwkeurigheid”) telt ongelijke metingen als één score.
- **Leesdiepte:** de gist zelf. De onderliggende papers niet via deze tekst.

#### A. Wat erin staat

* Cursor-blog: semantisch zoeken +12,5% nauwkeurigheid (6,5–23,5% per model), code-behoud +0,3% overall en +2,6% op repo’s met 1000+ bestanden. Dat is kwaliteit, geen tokenrekening. Zie §70.
* CodeRAG-Bench: winst van retrieved context tegen géén retrieval, van functietaken (MBPP) tot SWE-bench (+27,4% voor GPT-4o). Een gat van 9 punten tegen een orakel dat de juiste documenten al aanlevert.
* SWE-bench-tijdlijn: vroege BM25-RAG rond 2%, SWE-agent 12,47% (§19, §156). Dat is slaagkans van een agent tegen een eenmalige retrieval, niet vier zoeklagen in één lus.
* Augment (§160): op SWE-bench volstonden grep en find voor de slaagkans; embeddings zouden voor het product wel nodig zijn.
* Milvus-blog: “−40% tokens” bij semantic + AST-chunking, zelfde recall. Vendortekst, geen benchprotocol in de gist.
* Conclusie van de auteur: geen van beide wint altijd; een agent met grep komt ver, en betaalt dat in tokens.

#### Wat ik meeneem

* Handig om te zien wélke claims circuleren. Een percentage alleen citeren vanuit de bron die het mat.
* Geen kit.

---

## §162. ColGrep-Agent: Cutting Frontier Coding Agents’ Tokens by a Third (LightOn / HF)

**Type:** Engineering-blog · **URL:** [https://huggingface.co/blog/lightonai/colgrep-agent](https://huggingface.co/blog/lightonai/colgrep-agent) · model/tool: ColGrep + ColGrep-Agent-2B

- **Datum:** 2026-10-12
- **Kern:** Lokale 2B code-search-agent tussen frontier-coding-agent en de repo. Zoekt met multi-vector ColGrep, leest beloftevolle bestanden, volgt referenties, geeft paden/regelbereiken/code terug. Op 52 code-searchvragen × 13 ongeziene repo’s (Claude Code / Sonnet): −34% API-tokens en −40% cache-aware kost t.o.v. grep, geen significante accuracieschade. **Alleen zoekvragen, geen end-to-end onderhoudstaken.**
- **Cross:** aparte explorer zoals FastContext **§150** / CodeGrep **§151**; tokens bij gelijke kwaliteit.

#### Wat ik meeneem

* Sterk parallel aan I3 (on-demand retrieval-agent). Meet tokens op zoekvragen, niet tokens per geslaagde patch.
* Geen kit.

---

## §163. DAIR.AI — Top AI Papers (week 11–17 mei 2026), o.a. “Is Grep All You Need?”

**Type:** X-thread / weekoverzicht · **URL:** [https://x.com/dair_ai/status/2056018543850754283](https://x.com/dair_ai/status/2056018543850754283)

- **Datum:** 2026-05-17
- **Kern voor deze repo:** Paper *Is Grep All You Need?* ([arXiv:2605.15184](https://arxiv.org/abs/2605.15184)): grep-stijl tekstzoeken tegen embedding-retrieval in coding agents; met een geschikte harness evenaart of overtreft grep embeddings. Harness verklaart meer variantie dan de retrieval-primitief. Overige items in de thread (Lighthouse Attention, δ-mem, …) zijn fundament/memory, niet zoeklaag.
- **Leesdiepte:** DAIR-samenvatting; paper zelf nog niet als PDF hier.

#### Wat ik meeneem

* Bevestigt dat embeddings niet de default moeten zijn en dat harness de vergelijking kan vervuilen — aansluitend op **§81**/**§160**.
* Paper op wantlist als PDF ontbreekt. Geen kit.

---

## §164. Code Search for AI Agents: ripgrep, ast-grep, or Semantic? (Aksan)

**Type:** Blog · **URL:** [https://ceaksan.com/en/code-search-for-ai-agents-which-tool-when](https://ceaksan.com/en/code-search-for-ai-agents-which-tool-when)

- **Datum:** 2026-05-19
- **Kern:** Drie lagen — lexicaal (ripgrep), structureel (ast-grep), semantisch (repo-map / embeddings). Vraag is volgorde + tokenbudget, niet “welke is beter”. Escalatie: rg → ast-grep → repo-map → embeddings last. CoREB: korte keyword-queries laten semantische modellen inzakken (nDCG@10 ≈ 0). Heuristiek search_budget ≈ 15% van het contextvenster; resultaat comprimeren tot `file:line` + ≤2 regels.
- **Cross:** Instant Grep **§69**; Bellam **§159**; Xu LSP **§154**.

#### Wat ik meeneem

* Beleidskaart, geen controlled bench op tokens per geslaagde onderhoudstaak. Wel bruikbaar voor I0–I3-ordening en voor “embeddings niet eerst”.
* Geen kit.

---

## §165. GrepAI — semantische CLI + Claude Code-benchmark (Bernabeu) + Reddit-draad

**Type:** Tool + auteur-bench + forum · **URL’s:** [Reddit](https://www.reddit.com/r/ClaudeAI/comments/1qiv0d3/open_source_i_reduced_claude_code_input_tokens_by/) · [benchmark](https://yoanbernabeu.github.io/grepai/blog/benchmark-grepai-vs-grep-claude-code/) · [repo](https://github.com/yoanbernabeu/grepai) · [docs](https://yoanbernabeu.github.io/grepai/)

- **Datum benchmark:** 2026-01-21 · auteur = maintainer
- **Kern:** GrepAI (Go): lokale semantische search (Ollama/embeddings) + call-graph. Op Excalidraw (~155k LOC), 5 exploratievragen, Claude Code vanilla vs +GrepAI: claim −97% `input_tokens` in de zoekfase (~51k→1,3k), −27,5% totale API-kost, 0 subagents i.p.v. 5. Geen answer-quality-protocol. Reddit: positief over tokenprobleem; tegenvoorstellen (handmatige `scriptReferences.md`, Aider repo-map, Serena/LSP, SQLite/FTS5); vraag of minder context de code slechter maakt.
- **Cross:** repo-map **§145**/TokenEconomizer; Serena in **§158**; ColGrep **§162**.

#### Wat ik meeneem

* Semantische index als productclaim op tokens — zelfde familie als I3. Auteur-bench, één repo, exploratievragen ≠ geslaagde onderhoudstaak. Handmatige index / repo-map blijft concurrente hypothese.
* Geen kit. Forumcijfers niet als enige bewijs.

---

## §166. Hypergrep RESEARCH.md — codebase intelligence engine (Ballabani)

**Type:** Ontwerpdossier in repo · **URL:** [https://github.com/marjoballabani/hypergrep/blob/main/RESEARCH.md](https://github.com/marjoballabani/hypergrep/blob/main/RESEARCH.md)

- **Kern:** Diagnose: agents leunen op ripgrep → latency, contextwaste (claim ~93% waste in hun rekenvoorbeeld), mismatch taak↔tekstpatroon. Voorstel: trigram/index + live codegraaf + predictive prefetch + semantische compressie; thesis 10–50× sneller amortized en 70–90% minder context. Citeert o.a. Cox trigrams, Blackbird, Nesler (60–80% tokens aan lokalisatie), codebase-memory-mcp (412k→3,4k op navigatie).
- **Leesdiepte:** probleemstelling + prior art-kop; geen eigen controlled agent-bench in het gelezen deel.

#### Wat ik meeneem

* Literatuurkaart voor exacte index + graaf. Claims van derden verifiëren in de primaire bron. Geen kit.

---

## §167. Better Call Grep: Evaluating and Improving Grep-Like Lexical Retrieval (Wang e.a.)

**Type:** Paper · **URL:** [https://arxiv.org/abs/2601.23254](https://arxiv.org/abs/2601.23254) · **PDF:** [`pdfs/Baoyi-Wang_Better-Call-Grep.pdf`](pdfs/Baoyi-Wang_Better-Call-Grep.pdf)

- **Kern (titel/abstract):** Grep-achtige lexicale retrieval voor repository-level code completion evalueren en verbeteren.
- **Cross:** lexicale laag **§69**, **§164**.

#### Wat ik meeneem

* Lexicale retrieval als onderzoeksobject — relevant voor I1/I2. Volledig protocol na lezing. Geen kit.

---

## §168. LocAgent: Graph-Guided LLM Agents for Code Localization (Chen e.a.)

**Type:** Paper (ACL) · **URL:** [https://aclanthology.org/2025.acl-long.426/](https://aclanthology.org/2025.acl-long.426/) · **PDF:** [`pdfs/Zhaoling-Chen_LocAgent.pdf`](pdfs/Zhaoling-Chen_LocAgent.pdf)

- **Kern:** Graafgeleide agent voor issue→code-lokalisatie.
- **Cross:** Bellam **§159**; lokalisatie ≠ tokens-per-success.

#### Wat ik meeneem

* Kandidaat I3-graafarm of gerelateerd werk. Geen kit tot meters gelezen zijn.

---

## §169. SpIDER: Spatially Informed Dense Embedding Retrieval for Software Issue Localization (Chaudhari e.a.)

**Type:** Paper (EMNLP) · **PDF:** [`pdfs/Shravan-Chaudhari_SpIDER.pdf`](pdfs/Shravan-Chaudhari_SpIDER.pdf)

- **Kern:** Dense embedding-retrieval voor issue-lokalisatie; winst wanneer call-edges worden gevolgd.
- **Cross:** embeddings-pad **§70**, **§159**.

#### Wat ik meeneem

* Embedding+structuur voor lokalisatie. Meter waarschijnlijk recall/accuraatheid. Geen kit.

---

## §170. Code Isn’t Memory: A Structural Codebase Index Inside a Coding Agent (Bhola e.a.)

**Type:** Paper · **PDF:** [`pdfs/Ishaan-Bhola_Code-Isnt-Memory.pdf`](pdfs/Ishaan-Bhola_Code-Isnt-Memory.pdf)

- **Kern (abstract en opening):** In één harness en één model (Claude Opus 4.7, drie seeds, 91 instanties): structurele index aan of uit. De index is semantisch + lexicaal + call-graph. Binnen de harness stijgen View B acc@5 (44,3% → 84,5%) en resolve (41,9% → 50,4%), met lagere kost per geslaagde taak en geen onderscheid in kost per cel. De grep-vergelijking is een andere harness (OpenCode); dat verschil is niet significant op 0,05.
- **Leesdiepte:** abstract en opening, 9 nov 2026. De rest van de paper niet.
- **Cross:** OV-zoeklagen; GrepAI **§165**; Instant Grep **§69**.

#### Wat ik meeneem

* Dit is de dichtste meting: index aan of uit op resolve en kost. Geen vier lagen, geen exact/regex-tool, geen tokenuitsplitsing. De rest van de paper nog lezen. Geen kit.

---

## §171. SweRank: Software Issue Localization with Code Ranking (Reddy e.a.)

**Type:** Paper · **PDF:** [`pdfs/Revanth-Gangi-Reddy_SweRank.pdf`](pdfs/Revanth-Gangi-Reddy_SweRank.pdf)

- **Kern:** Issue-lokalisatie als ranking over files/classes/functions.
- **Cross:** **§156**, **§168**.

#### Wat ik meeneem

* Lokalisatie-ranking, niet tokens-per-geslaagde-taak. Geen kit.

---

## §172. LLM Agents Can See Code Repositories (Ma e.a.)

**Type:** Paper · **URL:** [https://arxiv.org/abs/2606.14061](https://arxiv.org/abs/2606.14061) · **PDF:** [`pdfs/Dongjian-Ma_LLM-Agents-Can-See-Code-Repositories.pdf`](pdfs/Dongjian-Ma_LLM-Agents-Can-See-Code-Repositories.pdf)

- **Kern:** Agents die repositories “zien” (structuur/zichtbaarheid); software-maintenance framing.
- **Cross:** FastContext **§150** (naburig arXiv-nummer).

#### Wat ik meeneem

* Uitlezen of het over zoeklagen of over een andere visibility-ingreep gaat. Geen kit.

---

## §173. SHERLOC: Structured Diagnostic Localization for Code Repair Agents (Tamoyan e.a.)

**Type:** Paper · **URL:** [https://arxiv.org/abs/2606.24820](https://arxiv.org/abs/2606.24820) · **PDF:** [`pdfs/Hovhannes-Tamoyan_SHERLOC.pdf`](pdfs/Hovhannes-Tamoyan_SHERLOC.pdf)

- **Kern (abstract):** Agents spenderen ~helft van hun budget aan foutlokalisatie vóór editen; SHERLOC geeft diagnose-context, niet alleen file-retrieval.
- **Cross:** Agentless **§157**; lokalisatie-kost.

#### Wat ik meeneem

* Bevestigt lokalisatie als kostendrijver. Meter = budget/diagnose, check of tokens-to-success erin zit. Geen kit.

---

## §174. Issue Localization via LLM-Driven Iterative Code Graph Searching (Jiang e.a.)

**Type:** Paper · **URL:** [https://arxiv.org/abs/2503.22424](https://arxiv.org/abs/2503.22424) · **PDF:** [`pdfs/Zhonghao-Jiang_Issue-Localization-Code-Graph.pdf`](pdfs/Zhonghao-Jiang_Issue-Localization-Code-Graph.pdf)

- **Kern:** Iteratief zoeken over een codegraaf voor issue-lokalisatie.
- **Cross:** **§159**, **§168**.

#### Wat ik meeneem

* Graafzoeken als I3-kandidaat. Geen kit.

---

## §175. TokenCast: Forecasting Token Consumption During LLM Agent Execution (Ouyang e.a.)

**Type:** Paper · **URL:** [https://arxiv.org/abs/2609.35760](https://arxiv.org/abs/2609.35760) · **PDF:** [`pdfs/Chaoqian-Ouyang_TokenCast.pdf`](pdfs/Chaoqian-Ouyang_TokenCast.pdf)

- **Kern:** Tokenverbruik voorspellen tijdens agent-uitvoering;zelfde taak kan >10× verschillen tussen runs.
- **Cross:** TokenEconomizer **§158**; Bai **§176**.

#### Wat ik meeneem

* Forecast ≠ zoeklaagkeuze, wel steun dat tokenmeter zinvol en volatiel is. Geen kit.

---

## §176. How Do AI Agents Spend Your Money? (Bai e.a.)

**Type:** Paper · **PDF:** [`pdfs/Longju-Bai_How-Do-AI-Agents-Spend-Your-Money.pdf`](pdfs/Longju-Bai_How-Do-AI-Agents-Spend-Your-Money.pdf)

- **Kern:** Analyseren en voorspellen van tokenconsumptie in agentic coding-taken.
- **Cross:** **§158**, **§175**.

#### Wat ik meeneem

* Probleemdomein: waar tokens heen gaan. Uitsplitsing naar search vs edit checken bij lezing. Geen kit.

---

## §177. An Exploratory Study of Code Retrieval Techniques in Coding Agents (Jain)

**Type:** Preprint · **PDF:** [`pdfs/Priyanshu-Jain_Code-Retrieval-Techniques-In-Coding-Agents.pdf`](pdfs/Priyanshu-Jain_Code-Retrieval-Techniques-In-Coding-Agents.pdf) · doi [10.20944/preprints202510.0924.v1](https://doi.org/10.20944/preprints202510.0924.v1)

- **Kern:** Verkennende studie van code-retrievaltechnieken in coding agents (semantisch, agentisch, benches, context management).
- **Cross:** **§161**, **§164**.

#### Wat ik meeneem

* Overzichtspaper-kandidaat voor probleem/oplossingsdomein. Geen kit.

---

## §178. Coding Agents are Effective Long-Context Processors (Cao e.a.)

**Type:** Paper · **PDF:** [`pdfs/Weili-Cao_Coding-Agents-Are-Effective-Long-Context-Processors.pdf`](pdfs/Weili-Cao_Coding-Agents-Are-Effective-Long-Context-Processors.pdf)

- **Kern:** Coding agents als manier om lange context te verwerken (tool-lus i.p.v. alleen attention).
- **Cross:** harness **§19**; context rot **§18**.

#### Wat ik meeneem

* Steunt agent+zoektools als contextstrategie; niet de OV zelf. Geen kit.

---

## §179. OpenHands: An Open Platform for AI Software Developers as Generalist Agents (Wang e.a.)

**Type:** Paper (ICLR 2025) · **PDF:** [`pdfs/Xingyao-Wang_OpenHands.pdf`](pdfs/Xingyao-Wang_OpenHands.pdf)

- **Kern:** Open platform/harness voor software-agents.
- **Cross:** CodeGrep meet op OpenHands **§151**; scaffold **§82**.

#### Wat ik meeneem

* Harness-referentie, geen zoeklaag-ablatie. Geen kit.

---

## §180. Don’t Train the Model, Evolve the Harness (Niklaus)

**Type:** Blog/report · **PDF:** [`pdfs/Joel-Niklaus_Dont-Train-the-Model-Evolve-the-Harness.pdf`](pdfs/Joel-Niklaus_Dont-Train-the-Model-Evolve-the-Harness.pdf)

- **Kern:** Geautomatiseerde lus herschrijft de scaffold rond een vast open model (+20 pt op Legal Agent Benchmark in hun setting).
- **Cross:** Meta-Harness **§83**.

#### Wat ik meeneem

* Harness-evolutie ≠ zoeklaagkeuze. Geen kit.

---

## §181. Harness2: Recursive Agent Harnessing for an Open World (Xu e.a.)

**Type:** Paper · **PDF:** [`pdfs/Ruiyao-Xu_Harness2.pdf`](pdfs/Ruiyao-Xu_Harness2.pdf)

- **Kern:** Recursieve self-improvement van execution harnesses.
- **Cross:** **§83**, **§180**.

#### Wat ik meeneem

* Harness-RSI. Geen kit.

---

## §182. Raven: The Harness of Harnesses (EverMind)

**Type:** Tech report · **PDF:** [`pdfs/EverMind_Raven.pdf`](pdfs/EverMind_Raven.pdf) · [GitHub](https://github.com/EverMind-AI/Raven)

- **Kern:** Composable “harness of harnesses” voor lange, cross-domein workflows.
- **Cross:** **§83**.

#### Wat ik meeneem

* Product/architectuur-rand. Geen kit.

---

## §183. Harness-S: Learning from Sibling Harnesses (Zhang e.a.)

**Type:** Paper · **URL:** [https://arxiv.org/abs/2611.04277](https://arxiv.org/abs/2611.04277) · **PDF:** [`pdfs/Kangning-Zhang_Harness-S.pdf`](pdfs/Kangning-Zhang_Harness-S.pdf)

- **Kern:** Leren van sibling-harnessvarianten voor generaliseerbare agenttraining.
- **Cross:** **§83**, **§141**.

#### Wat ik meeneem

* Harness-transfer. Geen kit.

---

## §184. Claw-SWE-Bench: Evaluating OpenClaw-style Agent Harnesses (Zheng e.a.)

**Type:** Paper · **PDF:** [`pdfs/Mengyu-Zheng_Claw-SWE-Bench.pdf`](pdfs/Mengyu-Zheng_Claw-SWE-Bench.pdf)

- **Kern:** Bench voor OpenClaw-stijl harnesses op coding tasks.
- **Cross:** Harness-Bench **§133**.

#### Wat ik meeneem

* Harness-evaluatieprotocol. Geen kit.

---

## §185. SWE-Adept (He & Roy)

**Type:** Paper · **URL:** [https://arxiv.org/abs/2603.01327](https://arxiv.org/abs/2603.01327) · **PDF:** [`pdfs/Kang-He_SWE-Adept.pdf`](pdfs/Kang-He_SWE-Adept.pdf)

- **Kern:** Agentic framework voor diepe codebase-analyse en gestructureerde issue-resolutie.
- **Cross:** **§156**, **§19**.

#### Wat ik meeneem

* Navigatie+resolutie-pipeline. Check of zoeklaag ablateert. Geen kit.

---

## §186. CodeR: Issue Resolving with Multi-Agent and Task Graphs (Chen e.a.)

**Type:** Paper · **URL:** [https://arxiv.org/abs/2406.01304](https://arxiv.org/abs/2406.01304) · **PDF:** [`pdfs/Dong-Chen_CodeR.pdf`](pdfs/Dong-Chen_CodeR.pdf)

- **Kern:** Multi-agent + task graphs voor GitHub-issue resolving.
- **Cross:** **§156**.

#### Wat ik meeneem

* Multi-agent harness. Geen kit.

---

## §187. SWE-bench-familie (Java / Multimodal / Plus / PlusPlus / Live / rebench / Factory / Universe / World / ProMax / Science / Pro Verified / Skywork-SWE / NatureBench)

**Type:** Papers (bundelkaart) · PDF’s in `pdfs/`:
[`Daoguang-Zan_SWE-bench-Java.pdf`](pdfs/Daoguang-Zan_SWE-bench-Java.pdf),
[`John-Yang_SWE-bench-Multimodal.pdf`](pdfs/John-Yang_SWE-bench-Multimodal.pdf),
[`Reem-Aleithan_SWE-Bench-Plus.pdf`](pdfs/Reem-Aleithan_SWE-Bench-Plus.pdf),
[`Lilin-Wang_SWE-Bench-PlusPlus.pdf`](pdfs/Lilin-Wang_SWE-Bench-PlusPlus.pdf),
[`Linghao-Zhang_SWE-bench-Goes-Live.pdf`](pdfs/Linghao-Zhang_SWE-bench-Goes-Live.pdf),
[`Ibragim-Badertdinov_SWE-rebench.pdf`](pdfs/Ibragim-Badertdinov_SWE-rebench.pdf),
[`Lianghong-Guo_SWE-Factory.pdf`](pdfs/Lianghong-Guo_SWE-Factory.pdf),
[`Mouxiang-Chen_SWE-Universe.pdf`](pdfs/Mouxiang-Chen_SWE-Universe.pdf),
[`Shuang-Sun_SWE-World.pdf`](pdfs/Shuang-Sun_SWE-World.pdf),
[`Yuling-Shi_SWE-Bench-ProMax.pdf`](pdfs/Yuling-Shi_SWE-Bench-ProMax.pdf),
[`Zhipeng-Xu_SWE-bench-Science.pdf`](pdfs/Zhipeng-Xu_SWE-bench-Science.pdf),
[`Pujun-Zheng_SWE-Bench-Pro-Verified.pdf`](pdfs/Pujun-Zheng_SWE-Bench-Pro-Verified.pdf),
[`Liang-Zeng_Skywork-SWE.pdf`](pdfs/Liang-Zeng_Skywork-SWE.pdf),
[`Yuru-Wang_NatureBench.pdf`](pdfs/Yuru-Wang_NatureBench.pdf)

- **Kern:** Varianten en pipelines rond SWE-bench (talen, multimodal, live data, schaal, science, harness-style envs).
- **Cross:** basismeter **§156**.

#### Wat ik meeneem

* Takenmateriaal / benchkeuze. Niet de OV. Individuele paper pas citeren na lezing. Geen kit.

---

## §188. Mem0 + Zep (agent memory)

**Type:** Papers · **PDF:** [`pdfs/Prateek-Chhikara_Mem0.pdf`](pdfs/Prateek-Chhikara_Mem0.pdf), [`pdfs/Preston-Rasmussen_Zep.pdf`](pdfs/Preston-Rasmussen_Zep.pdf)

- **Kern:** Productie-memorylagen voor agents (Mem0; Zep temporal knowledge graph vs MemGPT).
- **Cross:** MemPalace **§52**; Hindsight **§146**.

#### Wat ik meeneem

* Memory ≠ codebase-zoeklaag. Geen kit.

---

## §189. AgentScope 1.0 + large-scale simulation (Gao; Pan)

**Type:** Papers · **PDF:** [`pdfs/Dawei-Gao_AgentScope-1.0.pdf`](pdfs/Dawei-Gao_AgentScope-1.0.pdf), [`pdfs/Xuchen-Pan_AgentScope-Large-Scale-Simulation.pdf`](pdfs/Xuchen-Pan_AgentScope-Large-Scale-Simulation.pdf)

- **Kern:** Developer-centric agent framework; very large-scale multi-agent simulation.
- **Cross:** Graph/multi-agent **§28**.

#### Wat ik meeneem

* Framework-rand. Geen kit.

---

## §190. ARIS + COLLEAGUE.SKILL

**Type:** Papers · **PDF:** [`pdfs/Ruofeng-Yang_ARIS.pdf`](pdfs/Ruofeng-Yang_ARIS.pdf), [`pdfs/Tianyi-Zhou_COLLEAGUE-SKILL.pdf`](pdfs/Tianyi-Zhou_COLLEAGUE-SKILL.pdf)

- **Kern:** ARIS = adversarial multi-agent research collaboration; COLLEAGUE.SKILL = geautomatiseerde skill-generatie via expert distillation.
- **Cross:** skills **§3**; research-agents.

#### Wat ik meeneem

* Buiten OV. Geen kit.

---

## §191. PagedAttention (Kwon e.a.) + FreeToken (Yang e.a.)

**Type:** Papers · **PDF:** [`pdfs/Woosuk-Kwon_PagedAttention.pdf`](pdfs/Woosuk-Kwon_PagedAttention.pdf), [`pdfs/Shuo-Yang_FreeToken.pdf`](pdfs/Shuo-Yang_FreeToken.pdf)

- **Kern:** vLLM/PagedAttention memory management; FreeToken = edge-native MoE serving.
- **Cross:** inference **§29**; DeepInfer-grenzen in BP-AGENTS.

#### Wat ik meeneem

* Inference-serving — **niet** BP-scope (DeepInfer-verbod). Naslag. Geen kit.

---

## §192. Document parsing / OCR-bundel (MinerU2.5, PaddleOCR-VL, Unlimited OCR, PDFMathTranslate, CertEx) + TimesFM

**Type:** Papers · PDF’s:
[`Junbo-Niu_MinerU2.5.pdf`](pdfs/Junbo-Niu_MinerU2.5.pdf),
[`Zelun-Zhang_PaddleOCR-VL-1.6.pdf`](pdfs/Zelun-Zhang_PaddleOCR-VL-1.6.pdf),
[`Youyang-Yin_Unlimited-OCR-Works.pdf`](pdfs/Youyang-Yin_Unlimited-OCR-Works.pdf),
[`Rongxin-Ouyang_PDFMathTranslate.pdf`](pdfs/Rongxin-Ouyang_PDFMathTranslate.pdf),
[`Dongfang-Zhao_CertEx.pdf`](pdfs/Dongfang-Zhao_CertEx.pdf),
[`Abhimanyu-Das_TimesFM.pdf`](pdfs/Abhimanyu-Das_TimesFM.pdf)

- **Kern:** Document parsing / OCR / visual exact retrieval / time-series foundation model. Meegenomen omdat de PDF’s in `pdfs/` stonden.
- **Cross:** fundament/inference-rand.

#### Wat ik meeneem

* Niet relevant voor de OV. Kaart voor volledigheid. Geen kit.

---


## §149. Sverklo-bench: 60 zoekprobes (Groshin)

**Type:** Bench van de tool-auteur · **URL:** [blog](https://sverklo.com/blog/i-benchmarked-code-retrieval-for-ai-agents/) · citeert doi [10.5281/zenodo.19802051](https://doi.org/10.5281/zenodo.19802051) · repo: [https://github.com/sverklo/sverklo](https://github.com/sverklo/sverklo)

- **Datum:** 2026-04-28
- **Kern:** Zestig handmatig nagekeken zoekvragen op express en op de sverklo-repo zelf. Drie armen: naïeve grep, afgepaste grep, en zijn eigen hybride MCP (symboolgraaf + kanalen van reciprocal rank fusion). Hij meet F1 én tokens. Geen onderhoudstaak die eindigt in een patch.

#### A. De cijfers op de blog

| Arm | F1 | Tokens | Toolcalls |
| --- | --- | --- | --- |
| Naïeve grep | 0,35 | 15.814 | 7,6 |
| Afgepaste grep | 0,67 | 731 | 11,8 |
| Sverklo | 0,58 | 255 | 1,0 |

Afgepaste grep wint 9 F1-punten. De graaf is 62× goedkoper dan naïeve grep en 2,9× goedkoper dan afgepaste grep, in één call in plaats van 7–12.

#### B. Tokens per juist antwoord

Hij deelt input-tokens door recall. Op de subset met F1 ≥ 0,8: sverklo 203, naïeve grep 3.557, afgepaste grep 165. Afgepaste grep is daar goedkoper per juist antwoord zodra de F1 meevalt. Zijn les: de goedkoopste juiste retrieval, niet de hoogste F1 die twaalf calls kost.

Per soort vraag wint de graaf waar structuur het antwoord ís (definitie, bestandsafhankelijkheden) en verliest ze waar een regex volstaat (verwijzingen) of waar de aanroep dynamisch is (dode code, F1 0,02 tegen 0,55 voor losse grep).

#### C. Wat de bench niet is

Twee JavaScript-codebases. Geen cross-repo. Geen agent die de taak afmaakt. De koude indexbouw zit niet in de tokenprijs. De auteur meet zijn eigen product.

#### Wat ik meeneem

* Tokens en trefzekerheid horen in dezelfde tabel. Een zoekprobe is geen geslaagde onderhoudstaak; die vergelijking zou deze bench overdoen.
* Geen kit.

---

## §150. FastContext: Training Efficient Repository Explorer for Coding Agents (Zhang e.a.)

**Type:** Paper · **URL:** [https://arxiv.org/abs/2606.14066](https://arxiv.org/abs/2606.14066) · code: [https://github.com/microsoft/fastcontext](https://github.com/microsoft/fastcontext)

- **Auteurs:** Shaoqiu Zhang, Maoquan Wang, Yuling Shi, Yuhang Wang, Xiaodong Gu, Yongqiang Yao, Rao Fu, Shengyu Fu (Microsoft).
- **Kern:** Het zoeken en het oplossen zitten in hetzelfde model, dus elke misser blijft in de geschiedenis van de oplosser. FastContext is een aparte explorer (4B–30B) die alleen read, glob en grep gebruikt, parallel, en filepaden plus regelbereiken teruggeeft. De oplosser ziet de zoekgeschiedenis niet.
- **Leesdiepte:** samenvatting van de paper (HyperAI), niet de PDF regel voor regel.

#### A. Training

Eerst supervisie op traces van een sterk model: parallel zoeken, meerbeurtse trajecten, en een slotantwoord met citaties. Daarna reinforcement learning op 400 prompts. Het label komt uit de referentiepatch (bestand en regels). De beloning is F1 op die citaties, plus een bonus voor parallel zoeken, min een straf voor een kapot formaat.

#### B. Resultaat

In Mini-SWE-Agent, op SWE-bench Multilingual, Pro en SWE-QA: tot 5,5 procentpunt meer opgeloste taken en tot 60% minder tokens bij de hoofagent. De tokens van de explorer zelf wegen daar niet tegenop, volgens hun kosten­audit. Een getrainde 4B-explorer haalt vaak een grotere ongetrainde variant.

#### Wat ik meeneem

* De besparing is een tweede model dat het zoeken doet, met dezelfde grep. Geen exacte index in de lus van de oplosser.
* Geen kit.

---

## §151. CodeGrep: An RL-Trained Retrieval Agent for LLM Coding Agents (Chen e.a.)

**Type:** Preprint (augustus 2026, nog niet peer-reviewed) · **URL:** [https://arxiv.org/abs/2608.05886](https://arxiv.org/abs/2608.05886) · **PDF:** [`pdfs/Wuya-Chen_CodeGrep.pdf`](pdfs/Wuya-Chen_CodeGrep.pdf)

- **Auteurs op de ResearchGate-pagina:** Wuya Chen, Yihao Yang, Yang Cao, Yun Lin.
- **Kern (abstract):** Claude Code en OpenHands besteden een groot deel van hun tokens aan het vinden van de plek, niet aan de patch. Een 30B OpenHands-agent doet op SWE-bench Verified gemiddeld 23 rondes en 631k tokens per opgeloste issue, met veel calls naar grep, glob en read. CodeGrep is een 14B retriever, getraind met GRPO, die aan een bevroren agent kandidaat-bestanden teruggeeft.
- **Leesdiepte:** abstract, PDF geopend 9 nov 2026. Eerdere nota (3B, 833k) klopte niet met de PDF.

#### A. Wat het abstract claimt

Op alle 500 SWE-bench Verified-instanties: resolve 25,8% → 27,0% (+1,2 procentpunt), 15% minder rondes en 19% minder tokens op opgeloste instanties. Onder een precisiedrempel verslechtert BM25 (precisie 0,375) de agent, Jina (0,445) is neutraal, en CodeGrep (0,677) haalt de drempel. De supervisie komt uit trajecten van 67k open-source agentruns.

#### Wat ik meeneem

* Weer een aparte retriever vóór een bevroren agent, geen exact/regex-index die de onderhoudsagent zelf aanroept. Preprint: de percentages niet zwaarder tillen dan het abstract.
* Geen kit.

---

## §152. Code graph vs grep-then-read (LocalLLaMA + LLMDevs)

**Type:** Forum · **URL:** [meting](https://www.reddit.com/r/LocalLLaMA/comments/1vxf3lk/measured_code_graph_vs_grepthenread_for_agent/) · [vervolg, geen accuraatheid](https://www.reddit.com/r/LLMDevs/comments/1wfqk0f/i_published_a_tokencost_benchmark_for_codegraph/)

- **Auteur:** u/coding-os. De vervolgpost is ongeveer twee maanden oud op 9 nov 2026.
- **Kern:** Zelfbouw harness met een code-knowledge graph. Op vier repo’s kost “wie roept dit aan” 75–82% minder tokens dan grep-daarna-lezen. De harness schrijft drie getallen: graph_tokens, baseline_tokens, savings_pct. Geen recall.

#### A. Wat de draad toevoegt

Een reactie: 80% goedkoper én fout is slechter dan grep. De auteur zette die grens in de docs en noemt het gat open. Genoemde benches die hij níét draaide: CodeRAG-Bench, CoIR, ContextBench, SWE-Explore-Bench. Die meten chunk-relevantie of exploratie, niet “zijn dit de juiste aanroepers”.

De vragen die hij wél stelt zijn smal: aanroepers van een symbool, blast radius van een rename, transitieve impact.

#### B. Twee soorten “incompleet”

Afkappen is zichtbaar: de harness weet dat het resultaat kort is. Een graaf die volgens haar eigen model compleet is, kan toch missen: aanroep via een interface, een route op een string, alles wat pas at runtime vastligt. Een content-hash vangt een gewijzigd bestand. Hij vangt niet een relatie die het model nooit kende. Twee extractors met dezelfde blinde vlek zijn het overal eens waar ze fout zitten.

Een patch als orakel dekt alleen wat die fix aanraakte, en een AST-wandeling deelt de blinde vlek. Een compiler die het symbool hernoemt en de foutenlijst geeft, ziet interface-aanroepen wel; reflectie en string-routes foppen ook die. Die horen in een aparte emmer. Op Python is er geen build die breekt; een typechecker is het dichtstbij, en die is het sterkst waar de graaf al goed is.

#### Wat ik meeneem

* Tokenwinst zonder recall is geen resultaat. Het orakel moet buiten de index liggen. Dynamische gevallen niet in hetzelfde gemiddelde stoppen.
* Geen kit. Forum: het methodepunt telt, de 75–82% niet als bench.

---

## §153. Why grep beats LSP (Remy / goremy.ai)

**Type:** Blog · **URL:** [https://goremy.ai/blog/articles/best-tools-for-ai-coding-agents-why-grep-beats-lsp](https://goremy.ai/blog/articles/best-tools-for-ai-coding-agents-why-grep-beats-lsp)

- **Datum:** rond 6–7 september 2026 (titelvariant op de topic-pagina).
- **Kern:** Secundair verslag. Grep blijft het gereedschap dat agents pakken. Het haalt bijna dezelfde juistheid als structuurzoeken en een language server, en verbruikt op de zwaarste taken veel meer context. Een vaste volgorde “eerst LSP” verlaagt de slaagkans; de agent kiest al per taakvorm.
- **Cross:** de meting waar de LSP-cijfers vandaan komen is **§154**. De 150-cel vergelijking grep / tree-sitter / LSP is een aparte bench die deze blog aanhaalt, niet zelf de paper.

#### A. Cijfers zoals de blog ze doorgeeft

Tien repo’s (Redis, Django, Bitcoin, Laravel, Rails, TypeScript, webpack, Spring Boot, Tokio, Hugo), vijf moeilijkheidsniveaus, 150 cellen. Grounding 0,97 en completeness 0,99, bijna gelijk voor grep, tree-sitter en LSP. Op de zwaarste trede: grep-and-read ongeveer 2,8× zoveel context-tokens als tree-sitter (1,5 miljoen tegen 534.000).

De blog herhaalt uit §154: op lokalisatie kost LSP meer tokens (+6% Opus, +118% Sonnet) en pakken vrije agents hem 0–6% van de keren. Op “vind elke aanroep” pakken ze hem 45–57% van de keren.

Voorgestelde lagen, niet één tool: tekst (grep), structuur (tree-sitter), symbool (LSP), semantisch (embeddings, pas op grote schaal).

#### Wat ik meeneem

* De blog is een kaart met een conclusie: juistheid kan gelijk zijn terwijl de tokenrekening uit elkaar loopt, en de juiste laag hangt van de taak af. Cijfers citeren vanuit §154 of vanuit de 150-cel bench, niet vanuit deze parafrase.
* Geen kit.

---

## §154. Does a Language Server Save Tokens for Coding Agents? (Xu)

**Type:** Paper (preliminary study, juni 2026) · **URL:** [https://arxiv.org/abs/2608.13568](https://arxiv.org/abs/2608.13568)

- **Auteur:** Pengcheng Xu.
- **Kern (abstract):** De claim “semantisch zoeken is token-efficiënter” wordt overal gedaan en bijna nergens gemeten. Hoofdmeter: tokens-to-success. Een besparing door eerder te falen telt niet. Vijf armen, vier taakklassen, drie Claude-modellen (Opus 4.8, Sonnet 4.6, Haiku 4.5), op Python requests en twee TypeScript-repo’s.
- **Leesdiepte:** abstract en de openingsparagraaf. De rest van de PDF niet.

#### A. Wat het abstract vindt

Op lokalisatie met een symboolnaam kost de LSP tokens (+6% Opus, +118% Sonnet) en negeert een vrije agent hem (0–6% gebruik). Op volledigheid van referenties koopt de LSP precisie (1,00 tegen 0,76, geen valse aanroepplekken) maar geen tokens (ongeveer 19% duurder), en hij tilt de recall niet boven hoe grondig de agent toch al zoekt. Alleen het zwakste model (Haiku) bespaart (−26%), als kruk tegen lexicale ruis.

Bij editen dat door tests wordt gescoord lost grep een rename over bestanden foutloos op, terwijl een LSP die alleen locaties teruggeeft driekwart faalt omdat een aanroepplek mist. Een LSP die de regel meelevert haalt veel van dat gat dicht (ongeveer 5× minder nabestanden lezen) en sluit het niet: een rename moet ook commentaar en strings raken, en die zitten niet in semantische referenties.

De gereedschapskeuze volgt de taak: grep bij lokalisatie, LSP ongeveer de helft van de keren bij referentietaken, zonder dat het gevraagd wordt.

#### Wat ik meeneem

* Dit is de scherpste formulering van de meter die de bachelorproef ook gebruikt: tokens bij gelijke slaagkans. De ingreep is LSP tegen grep, niet een exact/regex-index. Die vergelijking niet opnieuw als hoofdvraag doen.
* Semantische referenties zijn een deelverzameling van tekstuele treffers. Grep blijft nodig waar de tekst buiten de symboolgraaf valt.
* Geen kit.

---

## §155. Jevgrep — één zoekstap in plaats van een keten (Gamal; Shaar)

**Type:** Blog, paywall · **URL:** [Gamal, 3 okt 2026](https://generativeai.pub/code-search-for-coding-agents-from-grep-to-jevgrep-5c1542660b9a) · [Shaar, 28 sep 2026](https://medium.com/open-intelligence/stop-paying-your-coding-agent-to-search-for-the-code-bc548a662464)

- **Kern van wat buiten de paywall staat:** Een agent besteedt de eerste minuten aan vinden: tree, grep, bestanden, imports, opnieuw grep. Gamal vraagt of het dure model dat de patch schrijft ook het model moet zijn dat zoekt, en schetst de lijn grep → LSP → embeddings → een LLM-classificeerder (Jev / `jg`). Shaar: `jg` geeft relevante bestanden, leads en letterlijke fragmenten in één antwoord. Claim op hun SWE-bench-vergelijking: vergelijkbare prestatie bij ongeveer 30% lagere kost.
- **Leesdiepte:** titel, ondertitel en de eerste alinea’s. De meting zelf niet.

#### A. De waarschuwing staat in de titel

Gamals titel zegt dat één SWE-bench-taak 92% van de gerapporteerde besparing draagt. Zonder de tabel is niet na te gaan of de 30% een gemiddelde is of die ene taak.

Jev als model (probability over klassen, geen chat) staat apart in **§31**. Deze posts gaan over Jev als zoekstap voor een coding agent.

#### Wat ik meeneem

* De probleemschets klopt met de rest van deze reeks. De 30% is geen resultaat zolang de verdeling over taken niet gelezen is. Niet citeren als bewijs dat een classificeerder het zoeken oplost.
* Geen kit.

---

## §63. Is 16GB All You Need for Serious Local LLM? (Kai)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=i9mRnbdDYxk](https://www.youtube.com/watch?v=i9mRnbdDYxk)

- **Duur:** ~18:34 · upload ~2026-10-07 · prijzen US-snapshot die week
- **Kern in 2–3 zinnen:** Viral “16 GB genoeg” (Manolo Remedi / Qwen 3.8 27B @ ~45 tok/s op RTX 5060 Ti) is **waar voor fit**, maar half: **KV-cache** concurreert met weights; zelfde file op 5060 Ti vs 5090 = **64k vs 262k** context. Kai doet de 16 GB-rekening in **tokens**, niet alleen GB: settings (vision uit, 8-bit cache) ~**47k→110k**; tok/s 3–70 verklaard door spill/bandwidth/MTP; prefill-stilte; koop-op-bandwidth; Mac/laptop-labels; own-vs-rent ROI; wanneer **twee** 16 GB-kaarten.
- **Cross:** engines **§29**; quant **§45**; Colibrì-extremen **§49**; [fundament/inference/lokaal-hardware.md](fundament/inference/lokaal-hardware.md).

---

#### A. Framing: viral demo vs agent-sessie [[00:00](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=0)]

* Viral: *16 GB is all you need…* (~**585k** views); Manolo Remedi: Qwen 3.8 27B op ~**$429** 5060 Ti 16 GB @ **45.6 tok/s**. [[00:34](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=34)]
* Kai had al 16 GB: na ~20 min agent-coding → ~**15 tok/s**, loops/herhaalde context. Conclusie: 16 GB-story **true but half**. [[01:07](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=67)]

#### B. Waarom fit wél werkt: GSQ-RCO [[01:48](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=108)]

* Standaard **Q4_K_M** ~**17.44 GB** → past niet. **ISTA-DASLab** (Institute of Science and Technology Austria): **GSQ-RCO** — gevoelige delen minder comprimeren → **11.8 GB**, lab-label *task lossless*. [[02:05](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=125)]
* Benches (video): full & compressed **30/30 AIME**; coding tie; science −1/198. Manolo VRAM ~**15.1–15.9 GB**. Reddit: >1M agentic tokens @ ~**73k** context op 5060 Ti. [[02:50](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=170)]

#### C. Het gemiste getal: 64k vs 262k [[03:46](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=226)]

* Zelfde model-file: 5060 Ti context **64 000**; 5090 **262 000** (~¼ room). Context = alles dat in memory moet blijven (msgs, files, tool output). [[03:52](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=232)]

#### D. Weights vs KV-cache [[04:46](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=286)]

* Weights vast (**11.8 GB**); KV groeit per token. Qwen 3.8 27B: **64 KB/token** → 32k ≈ **2 GB**, 128k ≈ **8 GB**. [[05:02](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=302)]
* Strenger: **Mistral Devstral Small 2** ~**160 KB/token** → op 16 GB naast model ~**11k** tokens. Viral videos vragen “past het?”, niet “wat blijft over?”. [[05:36](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=336)]

#### E. Token-budget op 16 GB + agent-tax [[06:02](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=362)]

* 16 GB ≈ **17.18 GiB** model-units; llama.cpp ~**1 GB** safety. 11.8 + MTP-head **0.35** + vision **0.93** ≈ **14 GB** → ~**47k** tokens full cache. Vision uit + **8-bit** KV → ~**110k**. [[06:10](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=370)]
* Bart Slichka: Claude Code-achtige system prompts **30–32k** vóór eerste user-woord → op 64k window ~**34k** voor werk. Luke’s Dev Lab op 128k: kanban ~**87%**, Blender ~**96%** — vooral **tool output**, niet chat. Daarom 5090 @ 262k. [[07:00](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=420)]

```
  16 GB VRAM
  ├── weights (+ MTP / vision defaults)
  ├── llama.cpp margin
  └── KV (groeit)  ← agent tools vreten hier
```

#### F. Waarom 3–70 tok/s: spill, bandwidth, MTP [[08:01](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=481)]

1. **Fit vs spill:** overflow GPU→RAM → cliff. 4060 Ti-owner cache-in-RAM: **6–7 tok/s**. “MicroEnter”/early-Oct test: 5070 Ti vs 5090 zelfde model → 5070 Ti &lt;**9 tok/s**, stop ~8k / **61%** job; 5090 **98 tok/s**. [[08:24](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=504)]
2. **Bandwidth ceiling:** tok/s ≲ bandwidth / model-size. 5060 Ti **448 GB/s** ÷ **10.93 GB** 3-bit ≈ **41 tok/s** theor.; gemeten **35** (~85%). Reviews @70 = snellere card / kleiner file. [[09:22](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=562)]
3. **Multi-token prediction:** draft+verify → 27.4→**45.6 tok/s** op 5060 Ti; eet cache → bij volle context uit; custom build ~**70** @32k MTP-on, daarna uit. Trade-off **prediction vs context**. [[09:56](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=596)]

#### G. Prefill [[10:40](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=640)]

* 5060 Ti prefill ~**738 tok/s** → verse **30k** agent-context ≈ **41 s** stilte. RX 9060 XT (AMD): ~**149 tok/s** @32k → **&gt;3 min** voor eerste woord. Viral video noemt dit niet. [[10:48](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=648)]

#### H. Niet alle 16 GB gelijk + misleidende labels [[11:18](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=678)]

| Card (video, okt 2026 US) | Prijs | Bandwidth |
|---------------------------|-------|-----------|
| RX 9060 XT 16 GB | ~$470 | **320 GB/s** |
| RX 9070 | ~$650 | **640 GB/s** |
| RTX 5060 Ti 16 GB | ~$789 | **448 GB/s** |
| RX 9070 XT | ~$790 | **640 GB/s** (+**43%** vs 5060 Ti @zelfde $) |

* AMD prefill-nadeel op llama.cpp: 5070 Ti las 32k **&gt;3×** sneller dan 9070 XT; write &lt;10% sneller. 5060 Ti MSRP ~$429 → street **+$84%**; 8 GB-sibling +24% → markt betaalt voor **GB**, niet chip. [[12:05](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=725)]
* **Mac 16 GB ≠ 16 GB GPU:** default GPU-slice ~**12.7 GB** → 11.8-model &lt;1 GB over (~**14k** tok); standaard 14 GB Q4 laadt niet. “M6” Mac Mini ~**153 GB/s** (~⅓ van 5060 Ti). Laptops: 5070/5060 Ti/4060 Ti **8 of 12 GB** onder zelfde naam — check memory line. [[12:53](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=773)]

#### I. Own vs rent + wanneer 16 GB te klein [[13:51](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=831)]

* Hosted Qwen 3.8 27B ~**$2.95**/M output (OpenRouter weighted avg). Lokaal 5060 Ti @35 tok/s, **180 W**, US power → ~**$0.26**/M → save ~**$2.69**/M. Card $789 ↔ **294M** tokens ≈ **97** dagen 24/7 of ~**10** maanden @8 u/dag. Goedkope host (~$0.16/M) → ~**2.9** jaar non-stop. ROI = **modelvraag**, niet alleen card. Weinig uren → rent. [[14:01](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=841)]
* Regelmatig **&gt;100k** + volle codebases: 16 GB alleen met 3-bit + zware cache-compress + MTP uit @~**15 tok/s** = vechten. Upgrade: **tweede** 16 GB (~$1578 voor 2×5060 Ti): layer→**tensor** split 27→**46 tok/s**; preset 3-bit@64k → **6-bit@131k** op twee. [[15:14](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=914)]

#### J. Hoe 16 GB uitgeven [[16:22](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=982)]

1. Koop **bandwidth**, niet fame (check NVIDIA-prefill-premium vs prijs).
2. Eén model dat **ruimte laat**, niet grootste dat net laadt.
3. Zet uit wat je niet gebruikt (vision, defaults); iGPU voor display → ~**0.5 GB** terug.
4. Rest → **cache**, niet zwaardere weights. Vraag: *kleinste model dat het probleem oplost + hoeveel context blijft?* — niet “grootste dat past”.
* Verdict: genoeg voor short–medium context daily use; **load ≠ finish the job**. [[17:33](https://www.youtube.com/watch?v=i9mRnbdDYxk&t=1053)]

#### Wat ik meeneem

* Agent Engineering: **harness tax** (30k system + tool dumps) is de echte 16 GB-vijand — parallel P25; meet in tokens/KV, niet alleen “model past”.
* Prefill-latency op lange agent-prompts &gt; decode-marketing; AMD vs NVIDIA stack-afhankelijk (llama.cpp).
* Lokaal-profiel in fundament (~20 GB) vs deze 16 GB-les: zelfde KV-rekening, andere headroom — zie [lokaal-hardware.md](fundament/inference/lokaal-hardware.md).
* Geen kit-actie; wel bachelor/kenniskaart Inference + aankoopheuristiek.

#### Open / onduidelijk

* Exacte GSQ-RCO paper/build-URL; “MicroEnter”-benchmarkbron (ASR).
* “M6 Mac Mini” generatie; prijzen wekelijks — snapshot okt 2026.
* Of 8-bit KV quality-loss per workload is gemeten in de video (alleen capaciteit).

---

## §145. DeepSeek's New LLM Engine Just Made GPUs 3x More Valuable (bycloud)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=2K_Rm8cho1I](https://www.youtube.com/watch?v=2K_Rm8cho1I)

- **Duur:** ~19:18 · upload ~2026-11-03
- **Kern in 2–3 zinnen:** bycloud-lens op **DeepInfer** + V4.1 Flash **1017**: open engine + productiestats maken $/GPU-uur van ~**$12.91** (V3/R1 feb 2025-economie) naar claim **$38** off-peak (~**3×**); uitleg via prefill vs decode, wide EP, **96%** KV-hit + **3FS**/~**100 PiB**, en wat *niet* in de repo zit. Revenue/margin-rekening (~**$2.3M**/dag één cluster; gross na GPU-huur ~**84–92%**) + SemiAnalysis InferX-vergelijking (~**4.3×** throughput vs top chart @~100 tok/s/user). Cross: §56/§58/§60/§61; industrie §62; cache-economie §143.
- **Repos:** DeepInfer (open); 3FS; DSpark/SWA bounded replay (genoemd); **niet** open: distributed KV, LB, multi-machine orchestratie.

---

#### A. Framing: 1017 + open engine [[00:00](https://www.youtube.com/watch?v=2K_Rm8cho1I&t=0)]

* **37** dagen na V4.1 Flash: **1017**-variant; claim avg **+13.5%** benches; Vals AI: multi-step *offensive* cyber vs GPT-6 Sol. Open weights ≠ even efficiënt hosten — tot DeepInfer (productie-engine) open ging. Dramatische claim: GPU’s “**3×** waardevoller”.

*(Sponsor Warp Factories ~[02:40](https://www.youtube.com/watch?v=2K_Rm8cho1I&t=160) — overgeslagen.)*

#### B. $12.91 → $38 / GPU-uur [[02:40](https://www.youtube.com/watch?v=2K_Rm8cho1I&t=160)]

* Feb 2025 V3/R1-economie (video): avg **226.75** servers × **8** H800 ≈ **1814** GPU’s; **776B** tok/dag; bij R1-API-prijzen ≈ **$562k**/dag → ≈ **$12.91**/GPU-uur. Nu **$38** off-peak ≈ **~3×**, mét sterker model (1017 vs R1).

#### C. Waarom inference inefficiënt + MoE [[03:50](https://www.youtube.com/watch?v=2K_Rm8cho1I&t=230)]

* Prefill = compute-heavy (batch matrix); decode = memory-bandwidth (één/weinig tokens per step). MoE: experts verspreid → load imbalance laat GPU’s idle wachten ondanks betaalde fleet.

#### D. Prefill vs decode parallelism [[04:23](https://www.youtube.com/watch?v=2K_Rm8cho1I&t=263)]

* Prefill: kleine EP-groepen **2–8** GPU’s (meer GPUs → sync-overhead). Batch-trade-off (video): ~4k tok/DP-rank → ~**60k** uncached in/s/GPU @~**17 ms**/step; 16k → ~**82k**/s maar ~**200 ms**; 65k → ~**90k**/s (~**+9%**) vs step **>700 ms** (>**3×** latency) — diminishing returns.
* Decode: **wide EP 64–128**. EP64: ~**26k** out tok/s/GPU bij ~**100** tok/s/user; bij ~**250** tok/s/user → ~**16k** out/s/GPU (~**−40%** throughput). Ablatie @~240 tok/s/user: EP8 ~**1.9k** out/s/GPU vs EP64 ~**15.7k** (**>8×**/GPU ondanks 8× meer GPUs in groep); @~100 tok/s/user verschil EP8↔EP64 slechts ~**6%**. Wide EP bestond al V3/R1; hier aangepast aan V4.1.

#### E. 96% KV + storage [[09:47](https://www.youtube.com/watch?v=2K_Rm8cho1I&t=587)]

* Agentic: lange context + tool-result → bijna hele prompt opnieuw. V3/R1: **56.3%** input via disk-cache; nu productie **96%**. Infra: **3FS**, ~**100 PiB** SSD KV; ~**14.4 TB** logical cache / online GPU; retain agent **3 d** / chat **7 d**. Met cache: logical input ~**60k → 1.5M** tok/s/GPU (**~25×** logical, niet 25× snellere chip).

#### F. Wat ontbreekt + hardware-drempel [[11:25](https://www.youtube.com/watch?v=2K_Rm8cho1I&t=685)]

* Open: kernels, EP, DSpark speculative, SWA bounded replay. **Niet:** 100 PiB KV-systeem, request LB prefill/decode, machine-coördinatie; claim: vooral **offline batch** — productie-service nog zelf bouwen.
* Hardware: **B200** + **Ascend 950**; recommend **64** prefill + **64** decode (= **128** GPU’s; 8 = *één* prefill-groep, meerdere parallel). Video-ballpark: ~**$9M** GPU’s of ~**$1024**/uur huur + storage. Productiecijfers: ~**155T** tok/dag/cluster; TTFT ~**400 ms**; ~**230** out tok/s/user.

#### G. Revenue / margin-rekening [[13:17](https://www.youtube.com/watch?v=2K_Rm8cho1I&t=797)]

* Off-peak: uncached in **$0.15**/M, cached **$0.003**/M, out **$0.60**/M. Aanname ~**1%** output + **96%** cache op input → ~**$14.79**/B tok → ×155T ≈ **~$2.3M**/dag ≈ **~$837M**/jaar *één* cluster. Via 100 PiB ÷ 14.4 TB/GPU (+ redundancy) schatting **~6–8k** GPU’s → **~$2–2.7B**/jaar @ $38 off-peak; peak = **2×** prijs.
* Cost-side (video): per B tok ~**0.38** GPU-uur @ $3–6 huur → **$1.15–2.29** cost vs **$14.79** revenue → gross ~**84–92%** (alleen GPU-huur, geen overige overhead).
* SemiAnalysis InferX: tops ~**6k** out/s/GPU @~100 tok/s/user; DeepInfer ~**26k** @zelfde regime ≈ **4.3×**; @~250 tok/s/user ~**15k**/GPU. “3× valuable GPUs” = deze throughput-gap + open reproduceerbare economie (alleen V4.1 Flash-arch).

#### Wat ik meeneem

* Zelfde release als §62/§143, hier met **prefill/decode-cijfers** + expliciete **3× $-/GPU** vs eigen feb 2025 baseline.
* Open engine ≠ production-ready zonder cache/LB; 128-GPU + Ascend/B200 = drempel.
* Margin-claims gevoelig voor cache-mix (parallel §143: hits ≠ revenue-aandeel).
* Geen kit; pointer [fundament/inference/engines.md](fundament/inference/engines.md).

#### Open / onduidelijk

* Exacte 6–8k GPU-schatting (redundancy-aannames); of offline-only claim nog geldt na latere commits.
* Transcript via WebFetch (yt-dlp sub **429**); timestamps ± chapter-grenzen.

---


## Reasoning

---


# Reasoning

## §35. Hybrid Reasoning Agents (Stanford / together.ai e.a.)

**Type:** Paper + model · **URL:** [https://huggingface.co/togethercomputer/HybridAgent-14B-Agentic](https://huggingface.co/togethercomputer/HybridAgent-14B-Agentic)

Paper en open weights over **HybridAgents**: binnen één generatieproces dynamisch wisselen tussen **latent reasoning** (denken in continuous vector space via een lichte HybridLink) en **text-based interaction** (antwoorden, tool-calls). Backbone o.a. Qwen2 → checkpoints zoals `togethercomputer/HybridAgent-14B-Agentic` (Apache-2.0). Training: **HybridSFT** daarna **HybridRL** (leren *wanneer* latent vs text). Latent stappen zijn uitleesbaar als pseudo-text. Auteurs claimen o.a. betere agent-scores bij sterk minder text-tokens en lagere latency/kosten — cijfers in de paper, hier niet gereproduceerd.

**Diepte:** [fundament/redeneneren/hybrid-agents.md](fundament/redeneneren/hybrid-agents.md). **Kenniskaart:** [fundament/kenniskaart.md](fundament/kenniskaart.md).

#### Wat ik meeneem

* Hybrid optimaliseert het **model + inference-pad**, niet je projectstructuur: geen HybridAgent in bootstrap of kit.
* Wel bruikbare analogie voor Agent Engineering: goedkoop “denken” vs duur “handelen/tool”; dunne always-on router; zware context JIT (P2, P25) — zie brugparagraaf in het fundament-stuk.
* Efficiëntie heeft minstens drie hefbomen (model, omgeving, reasoning-mode): [fundament/efficientie/drie-hefbomen.md](fundament/efficientie/drie-hefbomen.md).

---

## §46. How did a 27M Model even beat ChatGPT? (bycloud) — HRM & TRM

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=ZgwHaI2C-9s](https://www.youtube.com/watch?v=ZgwHaI2C-9s)

- **Duur:** ~13:16 (chapters: scaling limits → recursive models → sponsor → ARC-AGI → HRM → HRM-limieten → TRM → toekomst)
- **Kern in 2–3 zinnen:** bycloud legt **HRM** (~27M params, Sapient / Guan Wang e.a.) en opvolger **TRM** (~7M, Alexia Jolicoeur-Martineau) uit: tiny nets die **intern** (latent) iteratief redeneren i.p.v. één forward pass of text-CoT. Claims op ARC-AGI / Sudoku / Maze zijn sterk t.o.v. frontier-LLM’s *op die puzzle-benches* — maar dit zijn **geen** general-purpose language models. Video demystificeert hype én criticeert HRM-heuristieken; TRM vereenvoudigt en scoort hoger bij nog kleinere schaal.
- **Diepte:** [fundament/redeneneren/hrm-trm.md](fundament/redeneneren/hrm-trm.md) · [kenniskaart](fundament/kenniskaart.md).

---

#### A. Framing: scaling vs. “denk tot je klaar bent” [[00:00](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=0)]

* Consensus-narratief: groter = beter; miljarden naar scaling. Toch blijven LLM’s steken op “logische puzzles” die ironisch als AGI-benchmark gelden. [[00:00](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=0)]
* Tegengestelde richting: model dat **denkt en antwoord verfijnt** tot het confident is. [[00:21](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=21)]
* **HRM** claim (video): ~**32%** ARC-AGI; Sudoku-niveaus waar huidige LLM’s niet meekunnen; **27M** parameters — vs GPT-4 “≥1T” → orde **~35.000×** kleiner (video-rekenvoorbeeld). [[00:42](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=42)]
* **TRM** (~1 maand later): nog **~4× kleiner** dan HRM, hogere scores. Vraag video: was scaling altijd de verkeerde richting? [[01:23](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=83)]

*(Sponsor HubSpot ~[01:44](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=104)–[02:48](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=168) — overgeslagen.)*

#### B. ARC-AGI-illusie: geen ChatGPT-vervanger [[02:48](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=168)]

* Benchmark-illusie: alsof alles op de leaderboard “zoals ChatGPT” is (math, essays, crypto…). Op ARC-AGI staan ook **niet-language** modellen, puur voor puzzles in een **sterk beperkte** domein. [[02:48](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=168)]
* ARC-AGI: patroon in voorbeeld-grids vinden → voorspellen hoe een gegeven grid eruitziet (IQ-test-achtig). [[03:08](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=188)]
* Tiny recursive models: getraind **specifiek** op zulke taken; I/O = **kleurengrids**, geen tekstgeneratie / “fancy stuff” → geen superintelligentie-claim. [[03:28](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=208)]
* Wat wél indrukwekkend is: harde logica is **niet alleen** LLM-domein; géén andere small models kwamen dichtbij deze scores (video-claim). [[04:09](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=249)]

#### C. HRM — twee nets, twee snelheden [[04:31](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=271)]

* Paper-claims in video: **32%** ARC-AGI-1 (beter dan Claude 4 Opus / GPT-5 mini low volgens clip); **2%** ARC-AGI-2; 27M params; “recursive property”. [[04:31](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=271)]
* Kernverschil met LLM: niet alles in **één** forward pass met gelijke effort per token (voorbeeld: `1+1` — effort voor `=` vs antwoord is ongelijk). HRM houdt een **interne latent state** die het reasoning-proces representeert en herhaaldelijk verfijnt → effort waar nodig. [[04:51](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=291)]

```
  input + provisional answer
           │
           ▼
  ┌─────────────────────┐     meerdere microsteps
  │ Low-level (fast)    │────► tweak hidden scratchpad
  └─────────┬───────────┘
            │ na enkele tweaks
            ▼
  ┌─────────────────────┐
  │ High-level (slow)   │────► reset scratchpad + strategische stuurkorrectie
  │ + halting head      │────► doorgaan of stop + readout
  └─────────────────────┘
```

* Fast net: elke microstep kleine tweaks op scratchpad (huidige input + provisional answer). Slow net: na enkele fast-tweaks “wakker”, reset scratchpad, grotere strategic adjustment; **halting head** beslist stop/continue. [[05:33](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=333)]
* Training-truc (video): vóór high-level loop wachten tot fast loop “settled” / stabiel → gradients **alsof** equilibrium, i.p.v. backprop door elke microstep (compute-besparing). Runtime: klein aantal fast-slow cycles + halt. [[05:53](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=353)]
* Inspiratie: multi-timescale cortex / hierarchical depth; paper heeft “brain correspondence” vs mouse cortex (dimensies in latent space) — video belooft latere kritiek. [[06:33](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=393)]

#### D. Kritiek op HRM (waarom TRM) [[06:53](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=413)]

* Veel **heuristiek**; biologie-rechtvaardiging voor two-timescale + mouse-brain-gelijkenis = te grote claim (gelijkenis in latent-space organisatie, niet mechanistisch/empirisch bewezen) → “equivocation”. [[06:53](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=413)]
* “Hierarchical reasoning” is **interpretatie**, niet bewezen onder de motorkap; design zou meer dan twee latent-niveaus kunnen hebben. [[07:36](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=456)]
* Equilibrium-aanname bij training: in practice loopt de loop maar een paar keer en is vaak **niet** settled → verkeerde schatting van true unrolled gradient. Resultaten werkten empirisch wél. [[07:57](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=477)]

#### E. TRM — Tiny Recursion Model (Alexia) [[08:18](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=498)]

* Doel: zwaktes van HRM aanpakken zonder biologie-verhaal.
* **Twee working memories, functioneel:** (1) higher-level thinking / scratchpad, (2) placeholder voor answers. Collapse → interferentie; extra states → meer knobs, minder stabiel op small data (empirisch in TRM-resultaten, video-claim). [[08:38](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=518)]
* Loop: scratchpad enkele keren updaten → update op “canvas” → herhaal (zo lost TRM ARC-grids op). [[08:59](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=539)]
* **Geen equilibrium-fictie:** train op de loop die je **echt** runt — vast klein aantal updates, readout van laatste echte pass, backprop daar doorheen. “Polish the canvas a few times until it looks right.” [[09:21](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=561)]

| | HRM (video) | TRM (video) |
|---|-------------|-------------|
| Params | ~27M | ~7M (~4× kleiner) |
| ARC-AGI-1 | ~32% | ~**40%** |
| ARC-AGI-2 | ~2% | ~**6.2%** |
| Framing | two-timescale + bio | twee memories + vaste recursion |
| Training | gradients alsof equilibrium | gradients op echte unrolled loop |

* TRM-scores (video): verslaat o.a. Gemini 2.5 Pro, O3 Pro High; iets achter GPT-5 Medium — **op ARC**, niet als algemene chat. [[10:03](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=603)]
* Halt bij confidence threshold → antwoord tonen. [[10:25](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=625)]

#### F. Attention vs MLP; layers vs recursion [[10:45](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=645)]

* **9×9 Sudoku** (minder context/complexiteit): TRM **beter zonder attention**, alleen MLP. [[10:45](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=645)]
* **Maze / ARC** (o.a. 30×30): attention-based TRM beter — self-attention beter bij langere context; MLP generaliseert/flexibeler wanneer context niet te groot. [[10:45](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=645)]
* Opschalen layers: **hielp niet**, meer overfitting. Minder layers + **meer recursie** → beter. Eindontwerp: **2 layers** i.p.v. 4/8. [[11:25](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=685)]
* Cijfer video: **79.5%** (4 layers) vs **87.4%** (2 layers) — tegengesteld aan LLM “meer params = beter generaliseren”. [[11:46](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=706)]
* Verklaring video: **schaarse trainingsdata** → kleiner model overfit minder; recursie maakt “sequence of small reusable edits on a canvas” i.p.v. one-shot — weinig params = moeilijker memoriseren, makkelijker generaliseren. [[12:06](https://www.youtube.com/watch?v=ZgwHaI2C-9s&t=726)]

#### Wat ik meeneem

* Hefboom **reasoning-mode / architectuur** (§35, drie hefbomen): diep denken ≠ text-CoT-tokens; kan latent/iteratief in een tiny stack.
* **Apple-to-apple waarschuwing:** 27M/7M “beat ChatGPT” = ARC/Sudoku-grids, geen agent-coding of open taal.
* HRM → TRM les: bio-analogieën en equilibrium-shortcuts wantrouwen; meet de loop die je runt.
* Recursie + klein model op little data ≠ scaling wall “opgelost” voor frontier chat — wel bewijs dat puzzle-logica andere inductive biases verdient.
* Geen kit-actie (brug al **Nee** in [brug.md](fundament/brug.md) voor §46).

#### Open / onduidelijk

* Exacte arXiv-ID’s, trainingsrecept, data-omvang (~1k?), volledige tabellen — video-niveau; papers in fundament nog stub.
* Of ARC-vergelijkingen fair zijn (compute, test-time compute, ensemble) — niet uitgewerkt in clip.
* Ceiling van recursive models / combinatie met LLM-tools — speculatief in outro.

---

## §148. AI Just Found Ideas No Scientist Would Think Of (Better Stack) — Lacuna / alien space

**Type:** Video (short) · **URL:** [https://www.youtube.com/watch?v=1lAbPRg8o2s](https://www.youtube.com/watch?v=1lAbPRg8o2s) · tool: [Lacuna](https://lacuna.tiptreesystems.com) · code: [alejandrohdez00/alien-space-of-science](https://github.com/alejandrohdez00/alien-space-of-science)

- **Duur:** ~2:35 · upload ~2026-10-30
- **Kern in 2–3 zinnen:** Systeem zoekt “**alien space of science**”: concept-combinaties die *zinnig* zijn als research project maar die bestaande onderzoekers (gegeven publicatiegeschiedenis) *onwaarschijnlijk* zelf voorstellen. ~**16k** AI-papers → “idea atoms”; model 1 = zinvolle combo; model 2 = zou iemand dit bedenken?; zoek pass-1 / fail-2. Validatie: freeze eind-2024 → voorspel 2025 (o.a. ICLR oral in top-**25**/&gt;1M); human raters: 3/5 beste reports van systeem; Claude solo → 8/10 interpretability, systeem **0**. Limiet: paywalls (bio/med). Product: Lacuna ~**25k** proposals, OSS.
- **Cross:** inbox #25; agent-ideeëngeneratie vs curated research; geen kit.

---

#### A. Probleem: AI én mensen herhalen niches [[00:00](https://www.youtube.com/watch?v=1lAbPRg8o2s&t=0)]

* Vraag Claude om ML-idee → vaak interpretability. Onderzoekers: achtergrond + netwerk beperken zoekruimte → goede maar “lege” regio’s.

#### B. Methode [[00:40](https://www.youtube.com/watch?v=1lAbPRg8o2s&t=40)]

```
  papers → idea atoms
       → scorer: “zinnig project?”     (keep)
       → scorer: “zou researcher X dit doen?” (reject if likely)
       → alien candidates
```

* ~40k researcher publishing histories voor model 2.

#### C. Evidence + limiet [[01:20](https://www.youtube.com/watch?v=1lAbPRg8o2s&t=80)]

* Temporal split 2024→2025; ICLR 2025 oral in top 25 of &gt;1M combos. 50 AI-grad raters; 3/5 top reports = systeem. Claude: 8/10 interpretability vs 0 van systeem.
* Zwakte: full-text corpus nodig — ML open, bio/med vaak paywall (~helft med research closed, claim video). Met funding + artsen-check mogelijk uitbreiden.

#### Wat ik meeneem

* Nuttig patroon: **novelty ≠ random** — filter op (plausibel ∧ onwaarschijnlijk voor incumbents).
* Voor eigen AE/bachelor: idee-generatie met contamination/temporal split; Lacuna = browse-tool, geen waarheid.
* Inbox #25 promote → deze §. Geen kit.

#### Open / onduidelijk

* Exact arXiv (inbox noemt 2603.01092) vs wat short toont; contamination-details; kwaliteit buiten ML.

---


## Model internals

---


# Model internals

## §36. LLM-doorloop — chronologisch schema (bronnenbundel)

**Type:** Bronnenbundel · **URL:** [https://www.deeplearning.ai/short-courses/how-transformer-llms-work/](https://www.deeplearning.ai/short-courses/how-transformer-llms-work/)

Gebundelde bronnen voor **hoe een decoder-only LLM tekst verwerkt**, in volgorde: tokenisatie → embedding/positie → causal attention + FFN/MoE × L → LM-head/sampling → detokenize → prefill/decode met KV-cache. Geen enkele paper dekt alles; dit is een leeskaart.

**Overzicht (hele pipeline):** [How Transformer LLMs Work](https://www.deeplearning.ai/short-courses/how-transformer-llms-work/) (Alammar / Grootendorst / Ng); [The Illustrated Transformer](https://jalammar.github.io/illustrated-transformer/); [Attention Is All You Need](https://arxiv.org/abs/1706.03762); [Jurafsky & Martin SLP3](https://web.stanford.edu/~jurafsky/slp3/); [Princeton LLM basics lecture](https://princetonuniversity.github.io/princeton-cos514-fall25.github.io/LLM_basics_lectures.pdf); [ML Handbook — Language models](https://jayanthappalla.com/ml-handbook/chapters/08-modern-deep-learning/02-language-models/).

**Per onderdeel (steekproef):** BPE ([Sennrich et al. 2016](https://aclanthology.org/P16-1162/)); [SentencePiece](https://aclanthology.org/D18-2012/); [RoPE](https://arxiv.org/abs/2104.09864); KV-cache ([D2L](https://d2l.smola.org/chapter_transformers/kv-cache.html), [Raschka FAQ](https://sebastianraschka.com/faq/docs/kv-cache.html)).

**Diepte (schema + tabellen):** [fundament/modellen/llm-doorloop.md](fundament/modellen/llm-doorloop.md).

#### Wat ik meeneem

* Eén chronologische doorloop is de ruggengraat om later de kenniskaart-mind map te tekenen.
* Prefill vs decode + KV-cache verbindt modeltheorie met §29 / lokale hardware — zonder engines in de kit te zetten.
* Agent Engineering blijft hefboom *omgeving*; dit § voedt alleen begrip (P25/P26-context).

---


---

## §38. NCM Just Killed LLM… (Cloud X Berry)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=SMYzc9FMXj0](https://www.youtube.com/watch?v=SMYzc9FMXj0)

Cloud X Berry legt in ~14 minuten ([YouTube](https://www.youtube.com/watch?v=SMYzc9FMXj0)) **Next-Concept Modeling (NCM)** uit: Stanford / Hazy Research (Scaling Intelligence), paper [arXiv:2610.14162](https://arxiv.org/abs/2610.14162) (*Next-Concept Modeling: Fast, Parallel Coarse-to-Fine Text Generation*). Hoofdstukken in de beschrijving ~[[00:00](https://www.youtube.com/watch?v=SMYzc9FMXj0&t=0)]–[[14:03](https://www.youtube.com/watch?v=SMYzc9FMXj0&t=843)]. De titel (“killed LLM”) is clickbait: NCM is een **transformer-gebaseerd** generatiekader met een andere decode-orde — geen vervanging van ChatGPT-achtige assistants.

```
   DRIE GENERATIE-PARADIGMA'S

   Autoregressive (AR)       Diffusion LM                 NCM (coarse-to-fine)
   token₁ → token₂ → …       hele sequentie opnieuw       niveau 1 (kort/grof)
   1 token / stap            bij élke refine-stap         → … → niveau K (=L pos)
                             (revisiteert alles)          binnen niveau: parallel
                                                          daarna door; geen revisit
```

---

#### A. Architectuur: tokenizer + next-level transformer

* **“Concept” ≠ menselijk begrip.** In NCM is een concept een **discreet code** op een niveau in een geleerde hiërarchie (informatie in de grove niveaus), geen psychologische categorie.
* **Stage 1 — multiscale residual VQ-tokenizer:** encoder → hiërarchie van discrete codes (residual VQ, eigen codebook per niveau, nested dropout zodat vroege niveaus informatief blijven). Decoder reconstrueert tokens uit de cumulatieve reconstructie.
* **Stage 2 — NCM-transformer (tokenizer frozen):** voorspelt **één heel niveau** per stap; alle codes *binnen* dat niveau parallel, geconditioneerd op $\hat{z}^{(k-1)}$ (cumulatieve reconstructie van eerdere niveaus). Training: alle niveaus in één forward + corruptie van conditioning-codes voor robustheid.
* **Inferentie:** K niveaus (K ≪ L), daarna decode naar token-distributies. Vroege niveaus zijn kort → goedkope early steps (belangrijk voor wall-clock vs. diffusion die elke stap volle L doet).

```
   [tekst] → VQ-hiërarchie r₁…r_K → transformer next-level → decode → [tekst]
              coarse ───────────────────────────────> fine
```

---

#### B. Contrast met AR en diffusion (waarom “sneller”)

| | AR | Diffusion LM | NCM |
|---|----|--------------|-----|
| Eenheid per stap | 1 token | refine hele sequentie | 1 hiërarchieniveau |
| Parallelisme | beperkt in decode | posities parallel, maar volle L elke stap | posities binnen niveau; vroege $\ell_k$ klein |
| Na een stap | verder | **revisiteert** sequentie | **gaat door** naar fijner niveau |
| Typische cost driver | L sequential steps | veel NFE × volle L | K NFE, goedkopere early NFE |

Video-kernpunt: diffusion blijft de hele sequentie herbezoeken; NCM “locked” een niveau en verfijnt verder.

---

#### C. Empirie — framing eerst, cijfers daarna

**Framing (video + paper):** vergelijkingen zijn tegen **diffusion / non-AR baselines** op research-benchmarks — **niet** tegen product-chatmodellen. Wall-clock op **één NVIDIA H100 SXM 80GB**, o.a. generatie van **1024**-token sequences bij **batch size 16**.

* **XSum:** ROUGE-L **vergelijkbaar** met sterkste diffusion-baseline (AURORA-LM-lijn); ~**31×** sneller wall-clock; paper: o.a. ROUGE-1/2/L 35.0/12.8/28.0 bij 8 NFE (88M), met MBR verder omhoog.
* **LM1B:** ~**21×** sneller vs. sterkste diffusion-baseline bij betere/vergelijkbare generative perplexity; ~11× minder NFE vs. DUO in paper-narratief.
* **OpenWebText:** ~**10×** sneller, competitief op Gen. PPL.
* **Sudoku:** overtreft AR én diffusion over difficulties (coarse-to-fine als globale-structuur-intuïtie); tokenizer 100% exact reconstruction op Sudoku in paper.
* **WMT14 + MBR:** snelle sampling → meer kandidaten binnen zelfde tijd-budget; MBR verbetert BLEU/ROUGE.
* **Training tokens:** paper/blog claimen ~4–5× minder training tokens vs. sterke diffusion-baselines (tokenizer+generator meegerekend) op LM1B/OWT — aparte as naast inferentie.
* **Schaal:** generators **97M / 317M / 725M** op LM1B (gedeelde frozen tokenizer). Schaal naar frontier blijft **onzeker**; dit zijn research-modellen.
* **HF:** `hazyresearch/ncm-checkpoints` — research, **geen** assistants.
* **Reconstructie:** tokenfouten zijn semantisch zwaarder dan pixelruis in images; paper rapporteert hoge exact-reconstruction, maar quality van de geleerde hiërarchie blijft onderzoeksas.

---

#### D. Wat NCM níét is (anti-hype)

* Geen drop-in voor Claude/GPT coding-agents: geen tool-use, geen long-horizon chat, geen product alignment stack in de released checkpoints.
* Geen bewijs dat AR “dood” is: AR blijft dominant in productie; NCM concurreert op **non-AR research benchmarks** (Gen. PPL, ROUGE, Sudoku, wall-clock).
* “Concept modeling” klinkt als semantiek; technisch is het **discrete multi-scale codes**. Verwar niet met Meta’s **LCM** (Large Concept Models / sentence-embedding ruimte).

---

#### E. Drie lessen voor developers (video)

1. **NCM is nog een LLM** in ruime zin: transformer + discrete codes. Geen exit uit transformers.
2. De winst zit in **inferentie-orde / parallelisme** (minder NFE, goedkopere early steps), niet in “ChatGPT is dood”.
3. Voor coding-agents blijft de dagelijkse hefboom meestal **omgeving + verificatie**; NCM is relevant als je serving-kosten van lange outputs of non-AR families bestudeert.

Code/checkpoints: [github.com/HazyResearch/ncm](https://github.com/HazyResearch/ncm), blog [hazyresearch.stanford.edu/blog/2026-10-12-ncm](https://hazyresearch.stanford.edu/blog/2026-10-12-ncm).

#### Wat ik meeneem

* Curriculum: [fundament/modellen/alternatieven.md](fundament/modellen/alternatieven.md) (NCM ≠ LCM); kenniskaart Transformer/MoE/NCM.
* Geen kit-default “vervang AR door NCM”. Wel: inference-hefbomen naast harness (P25) en modelkeuze (P26).
* Clickbait filteren: 31× is vs. **diffusion op H100**, niet vs. frontier chat.
* Agent Engineering = Prompt → Context → Harness → Loop; NCM voedt alleen model/inference-begrip.
* Sudoku-resultaat is een nuttige herinnering: **globale structuur vóór detail** lijkt op “spec eerst, dan implementatie” — analogie, geen bewijs voor specs in agents.

#### Open / onduidelijk

* Schaling voorbij ~725M; joint training tokenizer+generator; adaptive depth (“stop early”) — paper future work.
* Of reconstructiefouten in open-domain tekst systematisch betekenis breken buiten de gerapporteerde exact-match cijfers.


---


---

## §40. MIT Just Found a Hard Limit in LLM Scaling… (Dan Grib)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=6xQ8LQfkBg4](https://www.youtube.com/watch?v=6xQ8LQfkBg4)

Dan Grib (~8 min, [YouTube](https://www.youtube.com/watch?v=6xQ8LQfkBg4)) behandelt **Superposition Yields Robust Neural Scaling** (Yizhou Liu, Ziming Liu, Jeff Gore, MIT; NeurIPS 2025 Best Paper Runner-up; [arXiv:2505.10465](https://arxiv.org/abs/2505.10465)). Kernvraag van scaling laws: *waarom* daalt loss als power law met modelgrootte? De paper stelt **representation superposition** voor als centrale driver van een width-gerelateerde loss-component. De video-titel “hard limit” betekent: plafond op *deze* component via width — niet “AI is over”.

```
   SUPERPOSITION (toy-model intuïtie ← Anthropic 2022)

   Geen / zwakke superposition          Sterke superposition
   m dims → ≤ m features “clean”        n features in m < n dims
   rest genegeerd                       overlap → interference
   schaling hangt van Zipf-vorm af      loss ~ 1/m (robust, geometrie)
```

---

#### A. Mechanisme: meer features dan dimensies

* **Superposition:** het netwerk codeert meer latente features dan er dimensies zijn; feature-vectoren delen richtingen → **interference**.
* Basis: Anthropic *Toy Models of Superposition* (2022). MIT stuurt de mate van superposition via **weight decay** en meet hoe test loss schaalt met model dimension $m$.
* **Zwakke superposition:** loss hangt af van de som van frequenties van *genegeerde* features → power-law in $m$ vooral als feature-frequenties zelf power-law zijn.
* **Sterke superposition:** loss komt uit geometrische overlaps; generiek ongeveer **$L \propto 1/m$** over een brede klasse frequentieverdelingen.
* Paper: open-source LLMs zitten in het sterke regime; mean squared overlaps van LM-head rijen schalen ~$1/m$; Chinchilla-achtige empirie is ermee consistent.

---

#### B. Width-verdubbeling, GPT-3-illustratie, kostennarratief (video)

* Video-claim gekoppeld aan $1/\mathrm{width}$: **verdubbel width ≈ halveer** dit interferentie-deel.
* Illustratie: GPT-3 width ~**12k** vs. **50k+** concepts/features — zonder superposition passen die features niet “clean” (video-narratief; paper mapt features naïef o.a. op vocabulaire-tokens als data dimension $n$).
* **Kostennarratief (video, geen lab-budgetforecast):** verdubbel width ≈ ~**6×** trainingskosten → ketting **$300M → $1.8B → $11B → $65B → $390B** als je zo doorrekent. Bedoeld om *diminishing returns van pure width* voelbaar te maken.

```
   width ×2  ⇒  interference-component ~ ÷2
             ⇒  train cost (video) ~ ×6
   → snelle $-explosie voor trage winst op déze loss-term
```

---

#### C. Zipf, irreducibele entropie, wanneer de power law stopt

* **Zipf:** woord-/featurefrequenties in natuurlijke taal zijn power-law (~$\alpha \approx 1$) — dat **lockt** de exponent in het zwakke regime en past bij wat LLMs empirisch tonen.
* **Irreducibele taal-entropie:** na “I really like …” blijven meerdere legitieme vervolgen (cats / dogs / pizza). Extra width verwijdert **verkeerde interferentie**, niet alle onzekerheid in data. Extrapolatie van loss vs. $1/m$ raakt **niet** noodzakelijk nul → constante $L_\infty$ naast model-size term (Chinchilla-achtige decompositie).
* **Ceiling:** wanneer width de set onafhankelijke features “inhaalt”, koopt verdere width weinig meer voor *deze* representation-loss. Paper: naïef bij vocab-size; echte # onafhankelijke dingen in taal kan hoger → power law kan langer doorlopen.

---

#### D. Paper vs. video-claim “hard limit”

| Paper (voorzichtig) | Video-framing |
|---------------------|---------------|
| Superposition verklaart *een* robust $1/m$-achtige scaling | “MIT vond een harde limiet” |
| Ceiling wanneer width features inhaalt (naïef: vocab) | Kostenketting $300M→… als waarschuwing |
| Andere loss-termen / data / $L_\infty$ blijven | Andere richtingen: world models / senses |

Correcte lezing: **hard-ish limit op width-driven representation loss**, niet op intelligentie überhaupt.

---

#### E. Wat de paper / video níét claimen

* Geen bewijs dat post-training, tools, agents of multimodal training stoppen.
* Andere hefbomen blijven: data volume/kwaliteit, depth, compute-allocatie, RL/verifiers, architectuur (MoE, non-AR zoals §38, hybrid latent/text zoals §35).
* Video wijst expliciet naar **world models / video / senses** als parallelle onderzoeksrichtingen naast pure text-width scaling.
* Geen voorspelling van een specifieke datum waarop scaling “stopt”.

```
   LOSS ≈  C / m^α   +   L_data/size terms   +   L_∞ (irreducible)
           ↑ width/superposition-stuk              ↑ “I really like …”
           dat 1/m-achtig kan zijn                    blijft bestaan
```

#### Wat ik meeneem

* Diepte: [fundament/modellen/superposition.md](fundament/modellen/superposition.md); brug naar [efficientie/drie-hefbomen.md](fundament/efficientie/drie-hefbomen.md).
* Voor Agent Engineering: meer parameters/tokens ≠ oneindige kwaliteit (raakt P1-context); investeer in verifieerbare omgeving (P13–P14) en modelkeuze (P26).
* Antidote tegen hype én tegen “scaling is dood”-overclaim. Geen kit-wijziging.
* Praktisch: als frontier-API’s duurder/schaarser worden (§39), wint wie **kwaliteit per token** haalt via specs/harness — niet wie blind grotere context dumpt.

#### Open / onduidelijk

* Feature↔token-mapping is bewust naïef; relatie tot SAE/monosemanticiteit is verwant maar een ander experimenteel spoor.
* Exacte GPT-3 “12k vs 50k concepts”-getallen zijn video-illustratie; paper werkt met gemeten overlaps op open LLMs, niet met die marketingzin.


---


---

## §42. World Models explained in 10min.. (Caleb Writes Code)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=ECWC-YlAk1o](https://www.youtube.com/watch?v=ECWC-YlAk1o)

Caleb Writes Code (~10 min, [YouTube](https://www.youtube.com/watch?v=ECWC-YlAk1o), feb 2026) legt **world models** uit als antwoord op de vraag of pure LLMs de fysieke wereld wel kunnen “begrijpen”. Framing: jij weet dat een munt ~50/50 is door jaren fysica te observeren; een LLM heeft geen gesimuleerde omgeving om hypotheses te testen — hoogstens chain-of-thought. De video is een landschapsoverzicht (Ha 2018 → LeCun/AMI, World Labs, Google Genie, Nvidia Cosmos), geen paper-reproduce.

```
   LLM (tekst)                    WORLD MODEL (simulatie)
   tokens → next token            observe → compress → predict dynamics → act
   abstractie over de wereld      interne replica van oorzaak–gevolg
```

---

#### A. Waarom pure LLMs “fysica-arm” lijken [[00:00](https://www.youtube.com/watch?v=ECWC-YlAk1o&t=0)]

* Mensen leren traag maar **multimodaal** (zintuigen + belichaming); LLMs pretrainen maanden op **triljoenen teksttokens** (Dario Amodei-podcast genoemd).
* Tekst is de **hoogste abstractie** van de fysieke wereld. Zonder ooit een munt te “zien”, hoe weet een model dat de wet van de grote aantallen naar 50/50 convergeert?
* Closest substitute in LLM-land: **reasoning / CoT** — nog steeds tekst, geen physics engine.

---

#### B. David Ha’s klassieke world model (drie delen)

Oorspronkelijke paper (David Ha e.a., ~2018-resurgence):

1. **Vision model (VAE):** observeert de environment; comprimeert pixels naar latente features (ruis weg, structuur houden).
2. **MDN-RNN:** houdt history van hidden states; voorspelt volgende latente toestand gegeven verleden + huidige waarneming (SketchRNN-analogie: jij tekent de start, model voltooit).
3. **Controller:** neemt samples van MDN + vision → **actie** (links/rechts, object oppakken, “pass the butter”).

Na genoeg interactie kun je de **echte** environment doorsnijden: de agent traint in de **interne simulatie**. Claim in de video: dit ligt dichter bij menselijk denken / AGI-pad dan pure next-token LLMs. Vroege resultaat: racetrack blijven rijden met **&lt; 5M parameters** totaal over de drie modules.

```
   environment
        │
        ▼
   [VAE vision] ──latent──▶ [MDN-RNN dynamics] ──▶ [controller] ──actie──▶ environment
                                      ▲
                                      └── history van hidden states
```

---

#### C. Schaal & foundation-modellen vs. domeinspecifieke world models

* LLMs wonnen populariteit omdat ze **mooi schalen** tot **foundation models** (één generiek model → chat, research, coding, computer-use).
* World models bleven lang **domeinspecifiek**. Sinds 2018 vele smaken; gap met LLMs **vervaagt** sinds ~2023.

| Speler / lijn | Wat de video noemt |
|---------------|-------------------|
| **Yann LeCun** | Criticus van pure AR-LLMs; Meta JEPA-achtig werk; daarna **AMI** (Advanced Machine Intelligence), valuation-zoektocht tot ~$5B genoemd |
| **Multimodal LLMs** | GPT-4, Gemini 1: vision via cross-attention — “zien”, maar critici: nog steeds LLM zonder echte spatial awareness |
| **VLA** (Vision-Language-Action) | ViT + LLM → action tokens; o.a. humanoid **Neo** (okt 2025, viral) |
| **Fei-Fei Li / World Labs** | Spatial intelligence; **Marble**: Gaussian splats (miljoenen particles); **geen** physics-controller zoals klassieke Ha-setup — meer “exploreerbare representatie” |
| **Pim / General Intuition** (okt 2025) | Closer world model die wél met games/simulations interacteert |
| **Google** | Genie-lijn / Sema… Genie 3: hyperrealistische beweegbare werelden |
| **Nvidia Cosmos** | Open **world foundation model**-platform: upstream tools + 3 pretrained models voor data-augmentatie/generatie (AV, robots, video-agents) |

Caleb nuanceert LeCun: taal bevat meer dan “alleen labels” — grammatica, figuurlijk taalgebruik, woordsoorten dragen feiten over de wereld. Toch blijft het abstractie, geen belichaamde fysica.

---

#### D. Slotvraag (video)

Zijn LLMs en world models **wederzijds uitsluitend**, of lossen ze **verschillende problemen** op? Denkt een LLM “als een mens”, en maakt dat uit als de output werkt? Geen eenduidig antwoord — wel het frame voor §43.

#### Wat ik meeneem

* Curriculum: world models horen bij [modellen/alternatieven](fundament/modellen/alternatieven.md) naast NCM/LCM; brug naar §40 (scaling-plafond text-width) en §43 (limits of LLMs).
* Voor Agent Engineering: coding-agents blijven LLM-centrisch; world models raken **robots / AV / video-agents**, niet `AGENTS.md`. Geen kit-actie.
* Multimodal ≠ world model: “plaatjes in de context” ≠ interne physics-simulatie + controller.
* Cosmos/Marble: foundation-denken verschuift van “één chatmodel” naar “upstream world generators voor training data”.

#### Open / onduidelijk

* Exacte paper-cites (Ha 2018 titel), JEPA-details, Genie/Sema-versienummers — video-niveau; later paper-§ indien nodig.
* Of &lt;5M-param racetrack generaliseert naar open-world — video claimt “promising”, geen frontier-benchmark.
* Primair LeCun-college (JEPA/EBM/V-JEPA): **§66**.

---

## §43. Limits of LLMs (Caleb Writes Code)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=_pY-JXtkW6g](https://www.youtube.com/watch?v=_pY-JXtkW6g)

Caleb Writes Code (~8 min, [YouTube](https://www.youtube.com/watch?v=_pY-JXtkW6g), 1 jan 2026) kadert de spanning: Karpathy juicht agentic tools toe, LeCun zegt dat LLMs niet echt begrijpen — **welk paard?** De video behandelt progressie, inherente flaws, en wanneer filosofie ertoe doet versus praktische waarde.

---

#### A. Autocomplete-kritiek vs. historische hype [[00:00](https://www.youtube.com/watch?v=_pY-JXtkW6g&t=0)]

* Argument: LLM = probabilistische next-token machine zonder “echt leren” — autocomplete.
* **1958 NYT / Perceptron (Rosenblatt 1957):** “thinking machine” die zou lopen/praten/zien — Navy-funding ~$271k toen (~$3M vandaag). Hype-ritme lijkt op Sam Altman / AGI-2030-claims.
* Perceptron: single-layer, 20×20 image classificatie; claimde kennis van de fysieke wereld.
* **Flaw (Minsky e.a. ~1969):** XOR / non-lineair scheidbaar — single-layer faalt. Multi-layer kon in principe, maar **backprop** bestond nog niet → AI winter-achtige teleurstelling.
* Parallel: LLM’s hebben ook structural flaws, maar de industriële schaal is ordes groter (honderden miljarden CAPEX vs. miljoenen toen).

---

#### B. Hallucinatie als feature van autoregressie

* Autoregressie **moet** een token produceren; “weet ik niet” is niet de native stopconditie.
* Hallucinatie = altijd een **plausible** vervolg, ook als het antwoord onkenbaar is. Post-training leert “I don’t know”, maar eager completion blijft architecturaal.
* Gevolg: **altijd verifiëren** (tests, bronnen, human) — geen “trust the model”.

```
   prompt → softmax over V → altijd een token
              ↑
        geen native “abstain” zonder extra training/policy
```

---

#### C. “Begrijpt het wel?” — filosofie vs. nut

* Post-training + curated pretrain-data helpen feiten vs. non-feiten te scheiden; toch geen intrinsieke waarheidsmeter.
* Caleb: “LLM’s leren niet écht” is **filosofisch zwak** als criterium zodra de output **economisch/nuttig** is. Definitie van intelligence matters minder dan value in the world.
* Sinds ~2024 **agents** dominant; benchmarks verschuiven van trivia naar **taken**:
  * **METR** (e.a.): successkans vs. menselijke tijdsdiepte van taken — niet “hoe lang de agent liep”, maar “hoe diep de taak was die een expert X uur kost”.
  * **GDP-val**-achtige benchmarks: economische waarde over occupations/tasks.
  * Voorbeeld video: **Opus 4.5** ~**50% time horizon van 4u49** — diepte van taak, niet wall-clock agent-run.
* Waarschuwing: jobs ≠ som van losse taken; benchmarks = litmus, geen volledige job-replacement-proof.

---

#### D. LeCun vs. “wat kan het dan niet?”

* LeCun: investeer buiten LLMs (world models) omdat LLMs waarheid/fysica missen.
* Tegenvraag (Adam Brown, video): *welke taak* kunnen LLM’s dan niet? Antwoord LeCun (video): **vaatwasser in-/uitruimen** — belichaamde fysieke manipulatietaak.
* Caleb’s slotframe: majority funding zit in LLMs; limieten voelen vaak **theoretischer** dan praktisch zolang agents + fine-tuning waarde blijven toevoegen. Parallel world models nastreven blijft zinvol — vooral als raw LLM-capability een plafond raakt (§40 / §42).

#### Wat ik meeneem

* Verifieerbaarheid (P13) en checks (P14) zijn niet optioneel: hallucinatie is inherent aan AR.
* “Begrijpt het?” secundair aan **meetbare output** — past bij §37/§41 (verify vóór trust) en §43↔§42 (world models voor fysica-gap).
* Agent Engineering blijft LLM-hefboom *omgeving*; world models = ander productdomein.
* Benchmarks lezen als **taakdiepte**, niet als “agent werkte 5 uur”.
* Geen kit-wijziging.

#### Open / onduidelijk

* Exacte METR/GDP-val paper-namen en Opus-4.5-cijfer — video-claim; bij bachelor citeren via primaire bron.
* Of “dishwasher” LeCun’s beste counter is of een shorthand voor belichaming.


---


---


---

## §53. Breaking the Token Ceiling — kleinere, sterkere byte-modellen (Meta FAIR / UW)

**Type:** Paper · **URL:** [https://arxiv.org/abs/2609.12303](https://arxiv.org/abs/2609.12303)

- **Kern:** Grootschalige studie (~1B-param dense transformers, tot 1T bytes data) die **token-** vs **byte-**tokenisatie kruist met **supervised** vs **distillation**. Byte-modellen starten slechter bij weinig compute, maar **blijven verbeteren** terwijl token-modellen plateauën; exacte distillatie via **End-Of-Token** voorspelt hoger asymptotisch plafond. Diepte: [fundament/modellen/byte-models.md](fundament/modellen/byte-models.md).
- **Relevantie nu:** nog geen drop-in voor Cursor-agents; **wel** strategisch voor “technologie van de toekomst” / bachelor / kenniskaart.

---

#### A. Probleemstelling

* Kleine models winnen vaak via **distillatie** van een grotere teacher met **zelfde tokenisatie**.
* Open vraag: gelden dezelfde schalingstrends als de student op **bytes** werkt i.p.v. BPE-tokens?
* Extra: hoe converteer je teacher **token-logits → byte-logits** efficiënt (één forward, geen explosie aan teacher-calls)?

#### B. Twee logit-conversies (single-pass)

| Methode | Exact | Mechanisme |
|---------|-------|------------|
| **Marginalize-It** | Approx. na 1e byte | Aggregeer kansen over tokens die de byte-prefix delen; herverdeel restmassa binnen die subset |
| **End-Of-Token** | Exact | Voeg `<eot>` toe aan byte-vocab; restkans van “token had hier kunnen eindigen” landt op `<eot>`; trainingdata krijgt `<eot>` na elk BPE-token |

* Prior art (Hayase/Phan e.a.) vereiste meerdere teacher-forwards — te duur voor grootschalige distillatie.
* `<eot>` kost ~**30.94%** meer FLOPs per data-eenheid, maar helpt asymptotische performance.

#### C. Experimentele assen (zes settings)

Tokenisatie ∈ {Tokens, Bytes, Bytes+`<eot>`} × objective ∈ {Cross-Entropy, Distillation}. Layer-params ~1.28B; Token-1B totaal groter (~1.81B) door grote embedding/lm-head. Teacher o.a. Llama 3-8B. Benchmarks: ARC-E/C, HellaSwag, PIQA, MBPP, NQ, Flores, …

#### D. Bevindingen (claims paper)

1. **Laag-FLOP:** Token-1B (supervised & distilled) domineert.
2. **Meer compute:** Bytes / End-Of-Token stijgen steiler; Token plateau’t.
3. Distillatie ≥ supervised binnen dezelfde tokenisatie (in hun sweeps).
4. Extrapolatie downstream: distilled **End-Of-Token-1B** tot ~**+4%** vs distilled Token-1B; ~**+1.9%** vs Marginalize-It; data-efficiëntie tot **⅙** om Token-niveau te matchen.
5. Vocab ~256 → geen top-k truncation nodig bij logit dump; opslaglogits ~**⅕**.
6. Asymptotische voorspelling: voorbij Llama 3.2-1B / Gemma-3-1B / Gemma 2B op *gemiddelde* downstream (tot ~6.5% / 8.1% / 2.1%) — **extrapolatie**.

```
  compute →
  Token:     sterk vroeg ──────── plateau
  Bytes:     zwak vroeg ─────╱─── hoger plafond?
  Bytes+eot: zwak vroeg ────╱──── hoogste voorspelde plafond
```

#### E. Waarom dit “toekomst” kan zijn (en waarom niet meteen)

* **Wel:** tokenizer-artefacten weg; betere data-efficiency; schonere distillatie-pipeline; interessant als serving/training-kosten blijven drukken.
* **Niet meteen:** langere sequenties → decode-latency; ecosysteem is token-first; asymptoten ≠ shipped model; coding-agents profiteren nu van BPE.

#### Wat ik meeneem

* Kenniskaart-knoop **Byte-level / tokenizerloos** onder Modellen; contrasteer met BitNet (§45) en NCM (§38) als “andere as dan klassieke AR-token-LLM”.
* Geen kit-actie; wel bachelor-materiaal onder hefboom *Model* ([drie-hefbomen](fundament/efficientie/drie-hefbomen.md)).
* Mentale regel: *tokenization is een inductive bias met een compute-afhankelijk plafond* — niet heilig.

#### Open / onduidelijk

* Generalisatie buiten hun 8 benchmarks en 1B-schaal.
* Interactie met MoE / speculative decoding / KV-cache-praktijk.
* Of “byte ceiling” ook voor tool-calling/chat-templates geldt.

---

## §65. Muon: The Most Underrated Breakthrough in LLMs (bycloud)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=VAQHsKS9fxY](https://www.youtube.com/watch?v=VAQHsKS9fxY)

- **Duur:** ~19:29 · upload ~2026-10-24
- **Kern in 2–3 zinnen:** AdamW behandelt weights als **losse scalars**; transformers zijn **matrix**-transforms. **Muon** (*momentum orthogonalized by Newton-Raphson*, Keller Jordan dec 2024) orthogonaliseert matrix-updates (richtingen behouden, sterktes balanceren) via snelle **Newton–Schulz**-iteraties i.p.v. volle SVD. Moonshot/Kimi schaalde het (~**52%** AdamW-FLOPs voor vergelijkbare perf op 16B MoE); DeepSeek-V4 hybrid Muon+AdamW + hybrid NS + ZeRO-buckets (**§56/§60**). Grotere thesis: optimizer-keuze kan architecturen (bv. **Parallax**) “dood” of levend maken; Muon-features claim robust/transferable.
- **Bronnen (video):** [Keller Muon-blog](https://kellerjordan.github.io/posts/muon/), arXiv *Muon is Scalable…* / [Moonlight](https://github.com/MoonshotAI/Moonlight), DeepSeek-V4, *Parallax* (Tilde), *Muon Learns More Robust…*.

---

#### A. Optimizer-job + AdamW-status-quo [[00:00](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=0)]

* Train-loop klinkt simpel (forward → error → update); zwaarte = **hoe ver** langs −∇. Optimizer = gradient → weight update. [[00:18](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=18)]
* **Adam**: (1) moving avg gradients (noise/mini-batch memory); (2) moving avg squared grads (per-param activiteit). **AdamW**: weight decay **los** van adaptive update → schoner/predictabel; ~12 j status quo. [[01:31](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=91)]
* Framing: frontier open labs → Muon; impact ≈ nieuwe architectuur, maar weinig “reacties”. [[02:59](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=179)]

*(Sponsor Solid ~[03:27](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=207)–[04:47](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=287) — AdamW-vs-Muon toy + Mac-app; overgeslagen.)*

#### B. Matrix-aware vs element-wise [[04:49](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=289)]

* Naam: **M**omentum **u** … **o**rthogonalized by **N**ewton-… (video: Newton-Raphson in acronym; mechanisme = **Newton–Schulz**). Keller Jordan, dec 2024. [[04:49](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=289)]
* Adam = giant list of independent numbers. LLM-compute = **matrices** (QKV, MLP, …): correlaties via de transform (rotate/stretch/mix). [[05:04](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=304)]
* Analogie: 100 hikers; Adam instrueert per persoon → 90 overlappen in dezelfde richting = verspilde capaciteit. [[06:00](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=360)]
* Update = **richtingen** + **sterktes** (singular-achtig). Dominante sterkte → “groot” update gebruikt weinig routes. Muon: normaliseer sterktes, behoud richtingen → evenwichtigere bijdrage = **orthogonalize**. Matrix-aware ≠ Adam. [[06:22](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=382)]

```
  AdamW:  per-scalar adaptive steps
  Muon:   treat ΔW as matrix → balance singular strengths (≈ orthogonal update)
```

#### C. Newton–Schulz i.p.v. SVD [[07:29](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=449)]

* Exacte orthogonalisatie: **SVD** — te duur elke step op elke weight-matrix (≫ forward/backward). [[07:33](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=453)]
* **Newton–Schulz**: herhaalde kleine matrix-formule → dichter bij orthogonal; alleen matmuls → GPU-vriendelijk; “goed genoeg” gebalanceerd. [[08:00](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=480)]

#### D. Distributed pijn; Kimi schaalbaar maken [[08:43](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=523)]

* Adam schaalt: per-param local. Muon moet **hele** matrix zien → ZeRO-shards forceren gather + sync (**§60**). [[08:51](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=531)]
* Paper *Muon is Scalable for LLM Training* (Moonshot/Kimi) — drie fixes: [[10:07](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=607)]

| Fix | Probleem | Aanpak |
|-----|----------|--------|
| Weight decay | Weights groeien → late instability | AdamW-style decay |
| Update scaling | Update-grootte hangt van matrix-shape (attn/MLP/MoE/proj verschillen) | Per-param scale normaliseren |
| Distributed | Full matrix nodig | ZeRO-achtig: **gather → Newton–Schulz → keep local shard → discard** |

* Scaling-law claim: vergelijkbare AdamW-perf bij ~**52%** training FLOPs — **16B** MoE, **5.7T** tokens → ~**2×** compute-efficiency (toy/lab-claim; niet auto frontier-52%). [[11:33](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=693)]

#### E. DeepSeek-V4: hybrid recipe + infra [[11:54](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=714)]

* Muon voor meeste modules (convergentie/stabiliteit); **AdamW** voor embeddings, prediction heads, static biases, MHC gating, RMSNorm — niet alles is nette 2D-matrix. [[11:54](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=714)]
* **Hybrid Newton–Schulz:** eerste **8** iters → singular values snel → 1; laatste **2** → stabiliserende coeffs rond 1 (minder overshoot). [[12:33](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=753)]
* **Hybrid ZeRO bucket:** cap hoeveel GPU’s één dense matrix delen (niet max-shard); knapsack-assignment voor load-balance; gather blijft, maar over minder ranks. Detail **§60**. [[13:03](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=783)]
* Realisme: frontier ≠ altijd +52%; ook **10%** save telt. [[14:06](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=846)]

#### F. Parallax: optimizer beslist of arch “werkt” [[14:18](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=858)]

* Decennium-aanname: train met AdamW; fail → arch slecht. Muon: misschien AdamW faalde de pathway. [[14:28](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=868)]
* **Parallax** (Tilde Research): herleeft *local linear attention* (lokaal lineair i.p.v. constant/softmax-average) via geleerde query-achtige correctie. Origineel: te duur/instabiel/niet LM-vriendelijk. [[14:51](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=891)]
* Resultaat paper (video): onder AdamW ≈ softmax; onder **Muon** duidelijk voordeel → optimizer-keuze = architecture-viability. [[15:48](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=948)]

#### G. Robust / transferable features [[16:31](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=991)]

* Paper *Muon Learns More Robust and Transferable Features…*: niet alleen sneller — betere features (noise/corruptie; freeze/finetune). [[16:33](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=993)]
* Mechanisme (video): grotere **logit margins** + hogere **effective rank** (minder collapse naar dominante richtingen) — past bij matrix-balancing. [[17:12](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=1032)]
* Gevolg: nieuwe ablatie-categorie (arch × optimizer); Muon ≠ einde van optimizer-onderzoek. [[17:57](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=1077)]

*(Intuitive AI Academy pitch ~[18:19](https://www.youtube.com/watch?v=VAQHsKS9fxY&t=1099)–einde — overgeslagen.)*

#### Wat ik meeneem

* Agent Engineering: geen kit-optimizer; wél **kenniskaart Training/optimizers** — Muon verklaart DeepSeek/Kimi-keuzes (§56/§60) en compute-druk (P26-achtig).
* Les: “arch faalde” kan “train-regime faalde” zijn — relevant voor eigen kleine ablaties / bachelor.
* Distributed cost van matrix-aware optimizers = product-engineering (gather/ZeRO), niet alleen math-blog.
* Cross: linear-attn / sparse-attn verhaal §56–§58 blijft modelkant; Muon = **update-geometry**-kant.

#### Open / onduidelijk

* Acronym “Newton-Raphson” vs implementatie Newton–Schulz — blog/paper-check.
* Fairness 52%-FLOPs claim (matched quality metrics, wall-clock inclusief gather?).
* Of consumer/finetune stacks Muon praktisch krijgen buiten frontier ZeRO-stacks.

---

## Industrie

---

## §66. Yann LeCun: World Models: Enabling the next AI revolution (ETH Zurich CVG)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=72Xj8k5WQX4](https://www.youtube.com/watch?v=72Xj8k5WQX4)

- **Duur:** ~58:54 · talk *Frontiers of Embodied AI* · upload ~2026-06-09 · kanaal Computer Vision and Geometry Group, ETH Zurich
- **Kern in 2–3 zinnen:** LeCun: ML “sucks” t.o.v. humans/animals (sample-efficiency, physical common sense, zero-shot); **AGI-via-LLM-scaling is impossible** (data-volume: ~4-jarige vision ≈ hele internet-tekst); intelligentie = adaptatie, niet declarative dump. Alternatief: **inference by energy minimization** + **interne world model** (actie voorstellen → predict → objective) i.p.v. AR-token-reasoning. Train world models met **JEPA** (predict in representation space), niet pixel-generative; collapse voorkomen via info-max / regularized EBM (VICReg, SigReg, …) of distillation (I-JEPA, V-JEPA, DINO). Slot: academia → niet LLMs; **AMI Labs** = physical AI. Cross: landschap **§42**; limits **§43**; Welch Part 1 **§67** / Part 2 **§68**.
- **Position paper:** ~2022 online (QR in talk) — “relatively easy to read, kind of long”.

---

#### A. Moravec, Piaget, wat intelligentie *niet* is [[00:00](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=0)]

* Gap machines vs humans/animals: few-shot, physical common sense, zero-shot. LLMs/powerful AI: slecht op continuous, high-dim, noisy real world; **language is easy**. [[00:14](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=14)]
* **Moravec:** chess/integrals makkelijk voor computers; 10-jarige huishoudrobot-taken / tiener ~uren rijden vs miljoenen uren AV-data → geen L5; consumer L2–3; robotaxi’s zwaar geëngineerd. Grounding nodig (contra sommige language-filosofen). [[01:21](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=81)]
* Piaget (apocryphal quote): *intelligence is not what you know, it’s what you do when you don’t know* — niet declarative knowledge-hoop (**LLMs**), niet skill-collection (elke taak met genoeg resources “crackbaar”, incl. self-driving). Wel: leren rijden ~**20 u**, zero-shot nieuwe taken → **adaptivity**. Geen simpele intelligence-metric. [[04:13](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=253)]
* **“AGI” is nonsense:** human intelligence is specialized + snel adaptief; verschillende kennis/skills door omgevingen. [[05:20](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=320)] *(ASR “Bled” → Vladlen.)*

#### B. Vroege observatie + data-rekening vs LLM-scaling [[05:50](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=350)]

* Baby’s: veel leren by observation vóór object-manipulatie; 3D via parallax — machines vandaag: 3D uit passive video. [[05:50](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=350)]
* West Coast “AGI by scaling LLMs + synthetic + RL”: **impossible** (zijn thesis). Calc: ~**20T words** ≈ **30T tokens** × ~3 B ≈ **10¹⁴ bytes** ≈ **400 000** jaar lezen. 4-jarige: ~16 u wake/dag → vision(+touch) ook ~**10¹⁴ bytes** (~**2M** optic fibers × ~1 B/s) — “30 min YouTube uploads”-orde voor die video-volume-analogie. Zelfde data-orde, andere modaliteit → human-like intelligence **niet** uit text-only. [[10:18](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=618)]
* Video-redundantie = **feature** voor SSL (geen bug); te veel redundantie ook slecht. [[12:06](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=726)]

#### C. Inference-mode: fixed layers vs energy search [[12:28](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=748)]

* Property: output via vaste #lagen **of** search naar output compatibel met input / die objective minimaliseert (**energy** / −log-lik special case) — **inference-time** cost, niet alleen train-loss. Intrinsiek krachtiger dan fixed forward. [[12:33](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=753)]
* Links LLM-achtig: AR next-token, vaste compute/token; “reasoning” = meer tokens forceren — wij redeneren **intern**, niet in token/language space. [[14:11](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=851)]
* Rechts: perceive state → imagine action sequence → **world model** predicts outcome → objective (task done?) → optimize actions (min energy). Need world model. Architectuur ~5 j; paper 2022. [[15:02](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=902)]

```
  observe → state
       → propose actions → [world model] → predicted outcomes
       → [objective / energy] → search best action sequence  (inference)
```

#### D. Hiërarchisch plannen = open probleem [[19:30](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=1170)]–[[21:10](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=1270)]

* Voorbeeld: Zurich-trip → airport → street → elevator → stand up (lage niveaus ≈ policy). Goal: **hierarchical planning**. Claim: **unsolved** — open PhD-topic voor robotics / agentic AI. [[20:48](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=1248)]

#### E. Waarom generative/pixel-predict faalt; JEPA [[21:11](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=1271)]

* Instinct: generative world model. ~15 j werk, eerste ~10 j falen op generative. Text SSL (BERT / next-token) werkt; **video next-pixels** niet → slechte reps. Oneindig veel plausible futures; text heeft eindige vocab. Camera-pan in zaal: kan niet alle gezichten/lege stoelen voorspellen → trainen op die predict “kills” the system. [[21:44](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=1304)]
* Cute video-gen: predict vaak in **rep space**, daarna decode; één plausible video ≠ alle futures modelleren. Diffusion “cute” ≠ world understanding (evidence: no). [[23:50](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=1430)] [[25:00](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=1500)]
* **JEPA** (joint embedding predictive architecture): encode X en Y (en action A); predict **in representation space** — drop unpredictable detail → abstractere, accuratere predict. Generative: reconstruct Y in detail. Best image/video SSL reps = joint-embedding, **niet** reconstruction. [[25:05](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=1505)]
* Collapse: constante reps / ignore input → trivial zero error. Prevent: **information maximization** op encoder-output. Families: Barlow Twins, VICReg, SigReg/C-reg, … (~1700 Scholar hits “joint embedding predictive architecture”). [[27:40](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=1660)]

#### F. Energy-based models + regularized vs contrastive [[30:40](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=1840)]

* Dependency X–Y is geen functie → **energy landscape** (valleys bij data); infer Y|X (of omgekeerd) by minimizing energy — past bij multi-future video. Probabilistic = special case. [[31:20](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=1880)]
* Collapse = flat energy everywhere. Fixes: (1) **contrastive** (push energy up buiten data); (2) **regularized** (minimize volume of low-energy space) — zijn voorkeur. [[33:40](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=2020)]
* Info-max praktijk: batch-matrix rows=samples, cols=vars — diversify rows + decorrelate/variance cols. Empirische info-measures = upper bounds → “good upper bound + cross fingers”. [[35:00](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=2100)]
* **SigReg**-achtig: projecties → match 1D marginals naar Gaussian via CDF/staircase distances → vele richtingen → joint ≈ isotropic Gaussian (theorem). Werkt voor action-conditioned world models + planning (Push-T e.d.); code simpel, 1 GPU; moet **scaled**. Theory: recover Gaussian latents up to rotation under spiral-obs assumption. [[42:00](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=2520)]–[[47:30](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=2850)]

#### G. Distillation-lijn die wél schaalde: I-JEPA, V-JEPA, DINO [[47:30](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=2850)]

* SigReg conceptueel favoriet maar recent/unscaled; scaled: EMA teacher (BYOL-intuïtie; Meta SimSiam/MoCo/…). **I-JEPA** ≫ **MAE** (kwaliteit + sneller trainen). [[48:00](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=2880)]
* **DINO**: best generic image encoders (Meta Paris); + world model + planner → demos (complex sim, &lt;25 steps naar goal; double pendulum, Push-T). [[50:00](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=3000)]
* **V-JEPA:** mask video chunk → predict full-video rep; SOTA-achtig op video tasks. **Common sense-signal:** sliding 16-frame window, predict next 16 — unphysical events (ball vanishes) → prediction error **spikes**. Depth-head op V-JEPA reps (v2.1): sterke monocular depth → “3D from fill-in-the-blanks”; object/segmentation decent. [[51:20](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=3080)]

#### H. Conclusie + AMI Labs [[54:20](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=3260)]

* Academia: **don’t work on LLMs** (“nothing you can bring”); abandon generative → joint embedding; abandon probabilistic → energy-based (kort); minimize **RL** (sample-inefficient — “when desperate”; OK atop good reps). Physical/grounded AI: don’t LLMs, don’t generative. [[54:20](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=3260)]
* Left Meta end of last year → **AMI Labs**: real-world / physical AI — robotics + industrial process control; high-dim continuous noisy waar LLMs helpless. [[55:40](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=3340)]

#### I. Q&A (kort) [[56:20](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=3380)]

* Guardrails / MPC: engineers love MPC; task objectives ≈ geleerde **projectors**/cost (bv. “door open?”) — tiny, few samples; niet per constraint een volle encoder. [[56:30](https://www.youtube.com/watch?v=72Xj8k5WQX4&t=3390)]

#### Wat ik meeneem

* Tegenover §42 (Ha VAE+MDN+controller landschap): hier **principled stack** — EBM inference + JEPA SSL + planning; generative video ≠ world model.
* Agent Engineering: coding-agents blijven LLM; LeCun-pad raakt **embodied/physical** control. Wel analogie: “meer tokens = reasoning” ≠ interne search over world model (P2/P25-achtig: compute waar het hoort).
* Hierarchical planning open = eerlijke backlog voor agentic research; niet “solve with bigger LLM”.
* Geen kit-actie; kenniskaart world models / alternatieven naast §42–§43.

#### Open / onduidelijk

* Exacte 2022-paper-titel/URL (QR niet in transcript); SigReg vs VICReg paper-namen.
* Hoe ver V-JEPA “common sense” generaliseert buiten demovideo’s.
* AMI Labs status vs Meta JEPA-releases (tijdlijn talk jun 2026).
* Didactische JEPA-geschiedenis (Barlow→DINO→AMI-paper): **§67**.

---

## §67. Yann LeCun's $1B Bet Against LLMs [Part 1] (Welch Labs)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=kYkIdXwW2AE](https://www.youtube.com/watch?v=kYkIdXwW2AE)

- **Duur:** ~37:24 · upload ~2026-05-02 · Part 2: [v_jDvpEGTIg](https://www.youtube.com/watch?v=v_jDvpEGTIg)
- **Kern in 2–3 zinnen:** Welch Labs-didactiek: LeCun’s ~$1B-bet (**AMI**/JEPA) vs generative LLMs. Pad: cake-slide SSL ≫ supervised ≫ RL → GPT next-token won in **taal**, maar generative next-**frame** → blur (ambiguïteit → pixel-average; HD-state space absurd). Alternatief sinds Siamese ’90s: **joint embedding**; **representation collapse** → contrastive schaalt slecht → epiphany **Barlow Twins** (cross-corr → identity; Horace Barlow redundancy) → VICReg, **DINO** (v3 ~88.4% ImageNet SSL≈supervised). 2022-paper *A Path Towards Autonomous Machine Intelligence* → **JEPA** world models (predict in embedding space; action-conditioned; classic optimal control + learned abstract state). Part 1 stopt vóór V-JEPA2/VLA-bench. Cross: ETH-college **§66**; landschap **§42**.
- **Credits video:** Yann LeCun, Stéphane Deny, David Fan, Nicolas Ballas.

---

#### A. Framing: $1B + wat JEPA *niet* is [[00:00](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=0)]

* Controversieel: JEPA ≠ spit text/images/videos; framework: encode X en Y → **predictor** voorspelt embedding(Y)|embedding(X). LLM = predict Y|X in token space; classifier = label|image. [[00:00](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=0)]
* LeCun: aanvankelijk andere problemen; eventually replace — LLMs goed waar **language = substrate of reasoning**, verder weinig. Part 1 = pad naar JEPA + collapse-oplossing; Part 2 = implementations vs LLM/VLA. [[01:20](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=80)]

#### B. CNN-pionier → labeled-data bottleneck → cake [[02:28](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=148)]

* 1980s CNN vs expert systems; AlexNet ~CNN-achtig. 2010s: supervised ImageNet-bottleneck vs few-shot kids. RL mini-renaissance (Atari/Go) parallel aan unsupervised/SSL. [[02:28](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=148)]
* **Cake (~2015):** bulk = SSL; icing = supervised; cherry = RL — RL te inefficient voor human-level. SSL brak sneller in **text** dan vision. [[04:17](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=257)]

#### C. Generative AI won in language [[05:15](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=315)]

* OpenAI 2015: RL focus; Radford e.a.: Transformer → next-token SSL op ~7000 books → GPT-1 → supervised fine-tune; SOTA op 9 language benches. Unlock: geen afhankelijkheid van human labels → schaal GPT-2/3/ChatGPT. AlexNet ~1M vs GPT-3 hundreds of billions examples. Cake-voorspelling matchte: SSL pretrain → supervised → RL shaping. Vision/video generative SSL bleef achter. [[05:15](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=315)]

*(Sponsor HRT ~[08:54](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=534)–[11:16](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=676) — overgeslagen.)*

#### D. Blurry video + “moet het generative?” [[08:00](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=480)] / [[11:16](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=676)]

* Next-frame pixel predict: blur; AR multi-step → blurry nothingness. [[08:00](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=480)]
* GPT-2 vocab **50 257** discrete outs; HD frame: 256^(1920×1080×3) ≈ **10^(~15M)** possibilities — geen discrete enum. Directe pixel-regressie + onzekerheid: ball left vs right → model voorspelt **average** pixels → washed-out. [[11:16](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=676)]
* Cruciale pretrain-punt: generative LLM is proxy; wat telt = **internal representations**. Vraag: andere signalen voor die reps? ~2017–18: beste image-reps = **niet** reconstructive. [[13:30](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=810)]

#### E. Siamese / joint embedding [[15:16](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=916)]

* Idee sinds ’90s (**Siamese**, Bell Labs, fraud signatures): twin nets → embeddings; positives similar, negatives dissimilar — **geen** image generation. Corrupt/transform views → same semantic embedding. Sidestep blur. [[15:16](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=916)]

#### F. Representation collapse + Barlow Twins epiphany [[17:53](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=1073)]

* Trivial solution: constant embedding (all-ones) → max similarity, zero learning = **collapse**. Oorspronkelijk Siamese: **contrastive** +/−. Contrastive schaalt slecht (veel negatives; worst-case samples exponential in dim — LeCun). End-2010s: generative vision SSL bad; joint embedding zonder clean collapse-fix. [[17:53](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=1073)]
* Epiphany met **Stéphane Deny**: Horace **Barlow** (1961) — reduce redundancy between neurons + maximize information. Cross-correlation matrix tussen twin encoder-outputs → target **identity** (diag high = same neuron across views; off-diag → 0 = decorrelate). Loss = afwijking van I. **Barlow Twins**. [[19:54](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=1194)]
* Linear probe ImageNet: frozen Barlow encoder **73.2%** vs AlexNet supervised **59.3%**; maar ViT supervised 2020 **88.6%** — SSL vision nog achter generative-language unlock. Daarna **VICReg** (simplified Barlow); parallel FAIR Paris → **DINO**. [[25:00](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=1500)]

#### G. DINO v3 tipping point [[27:22](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=1642)]

* DINO v3 (aug 2025, video): ImageNet ~**88.4%** — first time SSL ≈ weakly/supervised on classification (paper-claim). Patch embeddings → cosine-map hand/ball/cat/book segmentation zonder labels. [[27:22](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=1642)]

#### H. 2022 AMI-paper → JEPA world models [[28:58](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=1738)]

* *A Path Towards Autonomous Machine Intelligence* (~60 pp): holistic; teen ~20 h drive vs millions AV hours / L2. Secret = **world models**; common sense = collection of models (likely/plausible/impossible). Joint embedding = foundation. [[28:58](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=1738)]
* **JEPA:** encode obs_t, obs_{t+1}; predictor state_{t+1}|state_t (+ optional action). Dashcam: generative wastes capacity on unpredictable leaf pixels. Action-conditioned (V-JEPA 2 teaser): robot control signals → predict next embedding → plan toward goal embedding (cup) via searching actions — classical optimal control (’50s/’60s) + **learned** model + **learned abstract state**. [[30:30](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=1830)]

```
  generative: pixels_t → pixels_{t+1}     (blur / leaf noise)
  JEPA:       enc(x_t) → predictor → enc(x_{t+1})  (+ action)
              plan = search actions to match goal embedding
```

#### I. Cliffhanger + agentic punchline [[34:09](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=2049)]

* Part 2: V-JEPA 2 internals, robotics vs VLA, VL-JEPA, “Le World Model”. [[34:09](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=2049)]
* LeCun: geen betrouwbaar **agentic** system zonder consequences-of-actions te voorspellen; VLA/LLM doen dat niet (“après moi le déluge”); inference = **search**, niet alleen AR. [[35:00](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=2100)]

*(Welch Labs book pitch ~[36:19](https://www.youtube.com/watch?v=kYkIdXwW2AE&t=2179) — overgeslagen.)*

#### Wat ik meeneem

* Didactische brug: §42 landschap + §66 college-theorie ↔ hier **geschiedenis + collapse math** (Barlow matrix) voor bachelor/kenniskaart.
* Agent Engineering: “predict consequences before acting” = hard claim tegen pure tool-loop AR-agents — parallel P2 (planning) / harness; geen kit-JEPA.
* Generative pretrain ≠ enig pad naar sterke reps; vision SSL joint-embedding is nu competitief (DINO v3-claim).

#### Open / onduidelijk

* Exacte AMI fundraising “$1B” bron/datum in video vs marketing.
* DINO v3 88.4% fairness vs supervised SOTA setup.
* Implementations / VLA-debate: **§68**.

---

## §68. Yann LeCun's $1B Bet Against LLMs [Part 2] (Welch Labs)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=v_jDvpEGTIg](https://www.youtube.com/watch?v=v_jDvpEGTIg)

- **Duur:** ~40:57 · upload ~2026-05-30 · Part 1: **§67**
- **Kern in 2–3 zinnen:** Stack-opbouw JEPA vs mainstream: **V-JEPA 2** (video SSL, geen language) als CLIP-alternatief → SOTA-achtige video-understanding in VLM; **VL-JEPA** predict text-*embeddings* i.p.v. tokens → sneller leren + kleinere params op VQA; **VLA** (π0.7 e.d.) indrukwekkend maar LeCun: “doomed” (behavioral cloning schaalt/brittle + geen explicit world-model planning). **LeWorldModel** + CEM op Push-T = geleerde dynamics + plan in embedding space — elegant, maar horizon ~**5** loops vs VLA-demo’s; **hierarchical JEPA** → ~**15** steps. Welch: early but compelling; AMI 1–2 j industrial complex systems. Cross: **§42/§66/§67**.
- **Papers (description):** V-JEPA 2, VL-JEPA, LeWorldModel, Hierarchical World Models; Randall Balestriero reading list (LeJEPA/SigReg, …).

---

#### A. Framing: π0.7 vs JEPA cup [[00:00](https://www.youtube.com/watch?v=v_jDvpEGTIg&t=0)]

* Physical Intelligence **π0.7** VLA: zucchini peel, pinwheel, trash — impressive. LeCun: JEPA will overtake; “**VLAs are doomed**”. JEPA robot demo: ~**60 s** move cup off platform — capabilities behind. Video climbs stack: vision encoder → VLM → robot control. [[00:00](https://www.youtube.com/watch?v=v_jDvpEGTIg&t=0)]

#### B. V-JEPA 2 vs CLIP encoders [[02:30](https://www.youtube.com/watch?v=v_jDvpEGTIg&t=150)]

* CLIP (2021): contrastive image↔caption embeddings → backbone voor multimodal assistants (VLM = vision encoder + LLM). [[02:30](https://www.youtube.com/watch?v=v_jDvpEGTIg&t=150)]
* **V-JEPA 2** (Meta 2025): ~**1M hours** video, tot ~**1B** params; mask patches → predict missing patch embeddings (SSL). AMI-lijn: *Real intelligence does not start in language. It starts in the world.* V-JEPA language-unaware; CLIP language-tied. Question: can vision-only reps talk to an LLM? Authors: yes — **SOTA** on video-understanding benches when aligned; “contrary to conventional wisdom.” Example Temp Compass pineapple (forward/reverse); GPT-5.5 wrong both ways in their test. [[04:00](https://www.youtube.com/watch?v=v_jDvpEGTIg&t=240)]

#### C. VL-JEPA: JEPA over the whole VLM [[08:18](https://www.youtube.com/watch?v=v_jDvpEGTIg&t=498)]

* Standard VLM: vision emb + prompt → LLM → next tokens. VL-JEPA: encode target answer text Y → predictor predicts **emb(Y)** conditioned on vision + prompt (LLM-job ≈ predictor; target ≠ tokens). [[08:18](https://www.youtube.com/watch?v=v_jDvpEGTIg&t=498)]
* Mushroom example: many correct phrasings; generative penalizes paraphrase; JEPA maps similar semantics together. [[10:00](https://www.youtube.com/watch?v=v_jDvpEGTIg&t=600)]
* Late 2025 Meta controlled experiment (same vision encoder/data/config): VL-JEPA video-classif **35%** @5M examples vs VLM **20%**. GQA: **1.6B** VL-JEPA beats **7B** models. Non-generative wrinkle: pick answer by nearest Y-embedding among options; of train text decoder for generative inference. Note: SONAR sentence-level encode/decode in comparisons (description). [[11:00](https://www.youtube.com/watch?v=v_jDvpEGTIg&t=660)]

#### D. VLA stack + LeCun’s two critiques [[14:05](https://www.youtube.com/watch?v=v_jDvpEGTIg&t=845)] / [[17:14](https://www.youtube.com/watch?v=v_jDvpEGTIg&t=1034)]

* VLA = VLM → robot controls; early LLM emits controls; newer (π0.7) **action expert**. [[14:05](https://www.youtube.com/watch?v=v_jDvpEGTIg&t=845)]

*(KiwiCo sponsor ~[15:13](https://www.youtube.com/watch?v=v_jDvpEGTIg&t=913)–[17:14](https://www.youtube.com/watch?v=v_jDvpEGTIg&t=1034) — overgeslagen.)*

1. **Behavioral cloning scale:** needs tons of demos/tutorials; brittle off-distribution; only low-variability apps practical. Nuance Welch: VLAs *do* generalize somewhat (RT-2 Coke→Taylor Swift pic 2023; PI microwave/Tupperware/air fryer) — but similar-task neighborhood; far OOD still fails. [[17:14](https://www.youtube.com/watch?v=v_jDvpEGTIg&t=1034)]
2. **No explicit planning:** end-to-end image+joints → next joints; impressive internal “key shuffle” but black-box. Need predict consequences → search/plan + guardrails; LLMs/VLA “après moi le déluge”. JEPA: learn action-conditioned world model, then plan — not imitate. [[20:00](https://www.youtube.com/watch?v=v_jDvpEGTIg&t=1200)]

#### E. LeWorldModel + CEM on Push-T [[22:42](https://www.youtube.com/watch?v=v_jDvpEGTIg&t=1362)]

* Push-T: 2D effector push T to target; hard contact dynamics. Train JEPA on image+action trajectories (human data) to predict **next emb**, not clone actions. Decoder (for viz) → predicted emb→image; rollouts ≈ learned video game; match real env well but **drift**. [[22:42](https://www.youtube.com/watch?v=v_jDvpEGTIg&t=1362)]
* **CEM** planning: random action trajectories (e.g. 500) → world-model rollout (actions batched ×5) → score = Euclidean distance final emb ↔ goal emb → elite set → resample mean/std → converge to plan. All scoring in embedding space. [[26:00](https://www.youtube.com/watch?v=v_jDvpEGTIg&t=1560)]
* Addresses LeCun critiques: no need to see human solution; find own path. **But** reliable plan horizon ~**5** prediction loops — far behind VLA demos. [[29:30](https://www.youtube.com/watch?v=v_jDvpEGTIg&t=1770)]

```
  VLA:  (img, joints, instr) → action   [behavioral clone / black-box]
  JEPA: learn P(s'|s,a) in emb space → CEM search → execute
```

#### F. Hierarchical JEPA [[30:41](https://www.youtube.com/watch?v=v_jDvpEGTIg&t=1841)]

* Long-horizon (10 min kitchen): low level = short detailed predicts; high level = longer, fewer details (less divergence). Interface = embedding layers (no language — “cats plan hierarchically”). Paper: 2-level hierarchy Push-T **5→15** steps; higher level outputs = subgoals for lower. NYU→Paris muscle-ms analogy. Hope: hierarchy emergent from short- vs long-term SSL; needs semi-expert trajectories, not pure random. [[30:41](https://www.youtube.com/watch?v=v_jDvpEGTIg&t=1841)]

#### G. Welch take + AMI roadmap [[34:55](https://www.youtube.com/watch?v=v_jDvpEGTIg&t=2095)]

* Early: V-/VL-JEPA promising & compatible with language stack; agentic/robotics JEPA still limited. Analogy: early digit CNN felt limited too. Open: right / part of mix / dead end? [[34:55](https://www.youtube.com/watch?v=v_jDvpEGTIg&t=2095)]
* LeCun 1–2 y: industrial apps — complex systems **not** reducible to few equations (jet engine, chemical/power plant, diabetes treatment, stem-cell→pancreas, materials/catalysts/batteries); phenomenological models from data → control. 3–5 y hope: main supplier of intelligence systems. [[35:57](https://www.youtube.com/watch?v=v_jDvpEGTIg&t=2157)]

*(Poster/Patreon ~[38:57](https://www.youtube.com/watch?v=v_jDvpEGTIg&t=2337) — overgeslagen.)*

#### Wat ik meeneem

* Compleeert §67: JEPA is niet alleen anti-LLM slogan — meetbare encoder/VLM-efficiency + expliciete planning-stack; performance-gap robotics eerlijk benoemd.
* Agent Engineering: tool-loop AR-agents ≈ VLA-kritiek (geen consequences-model); JEPA/CEM = andere inference (search). Coding-agents blijven LLM; wel conceptueel voor harness/safety.
* Hierarchical planning (§66 open problem) hier concreet: 5→15 steps — nog ver van 10 min kitchen.
* Geen kit-actie; kenniskaart world models / physical AI naast §42–§43, §66–§67.

#### Open / onduidelijk

* Fairness VL-JEPA vs VLM (SONAR sentence-level); exacte bench-suites V-JEPA 2.
* LeWorldModel drift/horizon numbers outside Push-T sim.
* Of “VLAs doomed” blijft houdbaar als BC+sim+RL blijft opschalen (PI e.d.).

---


## §147. AI Might Not Need Attention Anymore (Better Stack) — Grassmann / Plücker

**Type:** Video (short) · **URL:** [https://www.youtube.com/watch?v=jCtJibpB2H8](https://www.youtube.com/watch?v=jCtJibpB2H8) · paper: [arXiv:2512.19428](https://arxiv.org/abs/2512.19428) (*Attention Is Not What You Need*, Zhang Chong)

- **Duur:** ~2:39 · upload ~2026-10-30 · HN-golf ~10 m na paper (dec 2025)
- **Kern in 2–3 zinnen:** Korte uitleg van attention-free **Causal Grassmann**-lagen: tokens lokaal pairen op vaste afstanden → 2D subspaces op Grassmann via **Plücker**-coördinaten → gated mix terug in hidden state; claim **lineaire** kosten in sequentielengte. Toy-schaal (~13–18M) binnen ~10–15% perplexity van size-matched Transformer; reproductions/HN betwisten (o.a. future-token peek, gap **22.6%**). Behandel als experiment, niet drop-in attention-vervanger.
- **Cross:** transformers §36; linear/sparse attn-lijnen DeepSeek/Kimi (§56/§140).

---

#### A. Probleem met attention [[00:00](https://www.youtube.com/watch?v=jCtJibpB2H8&t=0)]

* Transformers: elke token × elke token → **L×L** matrix; krachtig maar **kwadratisch** in lengte. Paper-titel = jab op *Attention Is All You Need* (2017).

#### B. Grassmann-flow (video + paper-samenvatting) [[00:40](https://www.youtube.com/watch?v=jCtJibpB2H8&t=40)]

* Per laag: reduceer token (video: **256→32** dims); pair met buren op vaste offsets (**1, 2, 4, 8, 12, 16**); twee vectoren → “sheet” = punt op Grassmann; **Plücker** → video: **496** getallen/pair; learned gate mixt geometrie ↔ originele state.
* Vast buur-set → cost **lineair** in L (fixed rank/window).

#### C. Resultaten + scepsis [[01:30](https://www.youtube.com/watch?v=jCtJibpB2H8&t=90)]

* Paper (Wikitext-2): 13–18M Grassmann binnen ~**10–15%** val perplexity vs size-matched Transformer; SNLI-head op DistilBERT licht beter (test **0.8538** vs **0.8511**).
* HN: geen code-link; comment: formule peekt **future** tokens en verliest tóch; Elliot Arledge repro **22.6%** gap; tweede repro dichter bij paper. Zonder auteurscode = interpretatie-afhankelijk; 18M + small data = toy vs frontier.

#### Wat ik meeneem

* Interessant: core compute op **analyseerbare manifold** (interpretability-hoek) — niet “attention dood”.
* Voor AE: geen runtime-keuze tot reproduceerbare schaal + causaliteit hard bewezen.
* Geen kit.

#### Open / onduidelijk

* Of latere code/repros de causal leak dichten; schaalgedrag ≫18M `[niet in short]`.

---

## §193. Efficient Transformers: A Survey (Tay et al., 2022)

**Type:** Paper · **URL:** [https://arxiv.org/abs/2009.06732](https://arxiv.org/abs/2009.06732)

- **Kern:** Categorisch overzicht van efficiënte transformer-architecturen: **recurrent** (Transformer-XL, Compressive Transformer), **sparse** (Sparse Transformer, Longformer, BigBird), **low-rank** (Linformer, Nyströmformer), **kernel-based** (Performer, FAVOR+), **fixed-FP** (Reformer) en **hybriden**. Taxonomie is nog steeds de standaardreferentie.

#### A. Relevantie voor token-optimalisatie

* Geeft context over **waarom** attention \(O(L^2)\) het knelpunt is — en waar elke familie inboet (kwaliteit vs. snelheid vs. generalisatie).
* DeepSeek's CSA/HCA (§56) en Kimi KDA (§140) zijn latere voorbeelden van dezelfde lineaire-attentie-familie.

#### Wat ik meeneem

* Achtergrond voor A5 (meten) en A3 (inference-speed): elke optimalisatie begint bij bottleneck-kennis.
* **Geen kit:** survey-kennis voor de kenniskaart, niet voor instructies.

#### Open / onduidelijk

* Of Tay taxonomie nog dekkend is na Mamba/state-space (§192 gedeeltelijk) en MLA (§90/§91).

---


# Industrie

## §39. The AI Race Is Starting to Pick Its Losers. (The Marrow)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=uthRTU907TI](https://www.youtube.com/watch?v=uthRTU907TI)

The Marrow analyseert in ~13 minuten ([YouTube](https://www.youtube.com/watch?v=uthRTU907TI), okt 2026) **CoreWeave** als early warning voor AI-infrastructuurfinanciering. De titel gaat niet over “AI is dood”, maar over **welke schuldstructuren** de markt eerst afstraft wanneer capex, chip-cyclus en refinancing botsen. Cijfers hieronder volgen de videotranscriptie — behandel ze als claims van die bron, niet als geauditte jaarrekening.

```
   COREWEAVE — KRACHT VS. SPANNING (video-snapshot)

   Backlog ~$104B (MSFT / Meta / OpenAI e.a.)
        │
        ▼
   ┌────────────── capex / debt machine ──────────────┐
   │  Nvidia-GPUs financieren → compute verhuren      │
   │  → meer schuld → hogere rente → meer ophalen     │
   └──────────────────────────────────────────────────┘
        │
        ▼
   Unsecured bonds < ~80¢ · CDS ~60% 5y default (video-lezing)
```

---

#### A. Balans, backlog en marktprijs van risico

* **Backlog ~$104B** met grote namen (Microsoft, Meta, OpenAI e.d.) — de bull-case: contracted demand “dekt” schulden.
* **Schuld:** ~**$40B** debt; inclusief leases **>$50B** aan verplichtingen (video).
* **Prijs van angst:** unsecured bonds onder ~**80 cent** op de dollar; **CDS** zo wijd dat de video ~**60%** 5-jaars defaultkans afleidt.
* Les: **backlog ≠ cash ≠ refinancing** tegen dezelfde spread. IG-klanten in de backlog maken je niet automatisch IG-kredietwaardig als leverage en duration wringen.

---

#### B. Chip-cyclus vs. boekhoudkundige afschrijving

* Model: **Nvidia-GPUs** als onderpand/capaciteit huren of financieren en doorverkopen aan AI-labs/hyperscalers.
* Chips **verouderen als telefoons** relatief tot Nvidia’s jaarlijkse roadmap (**Rubin / Feynman** genoemd in de video).
* Boeken: vaak ~**6 jaar** depreciation; **Michael Burry** (video): economische earning life eerder **2–3 jaar**.
* Gevolg als Burry gelijk heeft: earnings en covenants voelen de hit eerder dan de afschrijvingslijn suggereert — vooral bij pure neoclouds zonder andere winstmotor.
* **Twist (okt 2026):** oude **H100**-huurprijzen stegen nog (**Nebius +17%**, **AWS ~15%** genoemd). Schaarste/demand kan residual value **tijdelijk** stutten — wat de “chips zijn al waardeloos”-kortetermijnclaim nuanceert zonder de duration-mismatch weg te nemen.

```
   ACCOUNTING LIFE                PRODUCT / EARNING LIFE (Burry-claim)
   |---------- ~6 jaar ----------|   |-- ~2–3 jaar --|  ?? residual huur ??
   boekwaarde daalt langzaam         nieuwere gen. drukt concurrentiepositie
```

---

#### C. Trigger: de geldkraan, niet alleen de tech story

* **Q2:** ~**$9.4B** capex; ~**$10B** opgehaald — bijna 1:1 “opgehaald = uitgegeven”.
* **Interest:** ~**$640M** in Q2 → ~**$900M** verwacht in Q3 (video) — rente als oplopende vaste last naast capex.
* Behoefte aan ~**$60B** extra debt in ~**18 maanden** (video) terwijl de high-yield/private-credit kraan dichter gaat.
* Co-founder-taal over “unlimited” investment-grade money botst met CDS/bond-prijzen.
* **Firmus** annuleert **$5B** IPO — signaal dat neocloud-financiering breder wringt, niet alleen één ticker.

```
   Q2-patroon (video):   raise ~$10B  ≈  spend ~$9.4B capex
                         interest ↑   →  volgende raise duurder/kleiner
```

---

#### D. Senioriteit: wie rent eerst weg

* **Secured chip loans ~$13.6B** — vooraan (collateral: chips/contracts).
* **Unsecured bonds ~$21B** — achteraan in de waterfall.
* Empirisch in de stress: **unsecured rende eerst** (prijs omlaag / yields omhoog). Secured houders slapen langer; equity en unsecured voelen de pijn eerst.
* **Duration-mismatch:** klantcontracten vaak ~**3 jaar** vs. leningen ~**5 jaar**. Als rates/spreads uitlopen vóór contract-renewal, ontstaat refinancing-gap ook mét backlog.

---

#### E. Twee soorten AI-schuld — daar “kiest” de race verliezers

* Hyperscalers leenden ~**$250B** in de eerste **7 maanden van 2026** vs. ~**$100B** heel **2025** (video) — de hele sector is leveraged, maar niet gelijk.
* **Scheidslijn:**
  * **Profit-/cashflow-backed debt** (bestaande cloud met bewezen free cash flow);
  * **Chip-/backlog-only debt** (neocloud: assets = GPU’s + contracts, winst vaak nog dun of afwezig).
* “Losers” = vooral de tweede emmer als credit markten differentiëren — niet automatisch “alle AI”.

```
   DEBT TYPE A                         DEBT TYPE B
   hyperscaler / cashflow              neocloud / chip+backlog
┌────────────────────────────┐      ┌────────────────────────────┐
│ Divers revenue, FCF-buffer │      │ Capex ≈ raise (video Q2)   │
│ Debt serviced by ops       │      │ Interest ↑ sneller zichtbaar│
│ Spreads lager (relatief)   │      │ Unsecured runt eerst       │
└────────────────────────────┘      └────────────────────────────┘
```

---

#### F. Wat dit wél en níét is voor “de AI race”

* **Wél:** early price discovery op **leverage + duration + collateral quality** in AI infra. Bond/CDS-markten kunnen equity-narratieven vooruitlopen.
* **Wél:** reminder dat GPU-huur en residual value **twee kanten** hebben (H100-rent up vs. Burry life).
* **Niet:** bewijs dat model labs of agent-producten “verliezen”. De video is credit/infra, geen model-benchmark.
* **Niet:** advies om CoreWeave short te gaan — dit is een samenvatting van een YouTube-analyse.

#### Wat ik meeneem

* Context voor Agent Engineering-kosten: P25 (harness tax) en P26 (juiste model) krijgen een macro-laag — dure frontier-API’s × agent-roundtrips is kleine-leverage van dezelfde “meer compute = meer schuld”-logica.
* Geen kit-wijziging. Wel: [fundament/efficientie/drie-hefbomen.md](fundament/efficientie/drie-hefbomen.md) — model, omgeving, reasoning-mode i.p.v. alleen meer GPU.
* Lokale/open inference en strakke loops zijn risicomanagement, niet alleen hobby.
* Bij bachelorproef/meten: kosten per taak (tokens × roundtrips × $/token) documenteren — dezelfde discipline als credit spreads, op micro-schaal.

#### Open / onduidelijk

* CDS→“60% default”-vertaling hangt van model/aannames af; backlog bruto vs. gewogen; exacte secured/unsecured-splits kunnen per filing verschillen van de video.
* Of H100-rentestijging structureel is of een schaarste-spike; video geeft snapshot okt 2026.

---

## §59. Xiaomi Just Showed Us What Million-Dollar RL Training Looks Like (bycloud)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=1BZB4c792-0](https://www.youtube.com/watch?v=1BZB4c792-0)

- **Duur:** ~14:56
- **Kern in 2–3 zinnen:** bycloud over **MiMo V2.6** (Pro/Flash): Xiaomi streamde frontier **agentic RL** live (dashboard + **kosten**). Architectuur relatief “conventioneel” (GQA + SWA/global 6:1); de les is **RL-opschaling** (compute × environments × grading), partial rollouts, train/infer-engine sync, reward-hacking-defenses — en een late caveat (Vals AI: mogelijk git-history cheating). Geen kit-actie; methodologie + open data/stack zijn de waarde.
- **Cijfers:** video/dashboard-claims (o.a. ~$2.62M Pro / ~$0.85M Flash RL).

---

#### A. Framing: open training + kosten [[00:00](https://www.youtube.com/watch?v=1BZB4c792-0&t=0)]

* MiMo V2.6 Pro: SOTA-claim onder Chinese open/private (video); live stream van trainingsstats + **run-cost**. [[00:00](https://www.youtube.com/watch?v=1BZB4c792-0&t=0)]
* Kosten (intro): ~**$2.6M** Pro, ~**$900k** Flash om vorige gen naar SOTA te tillen; later precisie ~**$2.62M** / **$854k** (~$3.47M samen) voor de RL-runs. [[00:22](https://www.youtube.com/watch?v=1BZB4c792-0&t=22)] [[12:00](https://www.youtube.com/watch?v=1BZB4c792-0&t=720)]
* Grootste wijziging: **agent-centric mid-training** + massive RL. [[00:44](https://www.youtube.com/watch?v=1BZB4c792-0&t=44)]

*(Sponsor Crusoe ~[01:06](https://www.youtube.com/watch?v=1BZB4c792-0&t=66)–[01:50](https://www.youtube.com/watch?v=1BZB4c792-0&t=110) — overgeslagen.)*

#### B. Architectuur: “conventioneel” t.o.v. DeepSeek/Kimi [[01:50](https://www.youtube.com/watch?v=1BZB4c792-0&t=110)]

* Pro: **1T** total / **42B** active; 1M context via **GQA** + meeste lagen **128-token SWA**, elke 7e laag **global** → **6:1** local:global. Geen DeepSeek-sparse / Kimi-linear. [[02:12](https://www.youtube.com/watch?v=1BZB4c792-0&t=132)]
* Interpretatie video: V2.6 ≈ **RL-scaling experiment**; efficiency (HiSparse 2) later voor V3. [[02:56](https://www.youtube.com/watch?v=1BZB4c792-0&t=176)]

#### C. Drie RL-schaalassen + dynamic sampling [[03:19](https://www.youtube.com/watch?v=1BZB4c792-0&t=199)]

Paper (video): schaal in (1) trainingscompute, (2) diverse environments, (3) compute voor **grading**.

* Per RL-step: **1.568** prompts × **16** trajectories ≈ **~25k** agent-runs vóór één weight-update. [[03:42](https://www.youtube.com/watch?v=1BZB4c792-0&t=222)]
* Trajectory-lengte ~**110k–150k** tokens → ~**2.7–3.7B** generated tokens per step. [[03:42](https://www.youtube.com/watch?v=1BZB4c792-0&t=222)]
* **Dynamic sampling:** groepen waar alle 16 slagen of allen falen geven geen relatief signaal → filteren; zoek mix success/fail. Dashboard: Dyn Stem pass rate 0/1, average@N, accept rates. [[04:27](https://www.youtube.com/watch?v=1BZB4c792-0&t=267)]

#### D. Group-wise agentic grading + reward hacking [[05:12](https://www.youtube.com/watch?v=1BZB4c792-0&t=312)]

* Binary pass is te grof (5-regel fix vs 150k-token half-repo rewrite). **Group-wise grading:** judge-model vergelijkt succesvolle trajecten → herverdeelt advantage naar “betere” manieren van slagen. Zonder: lengte-explosie naar limit; met: verbetering zonder die explosie (ablatie video). [[05:34](https://www.youtube.com/watch?v=1BZB4c792-0&t=334)]
* Reward hacking als security: sanitize env, isolate network, dedicated **hack agent** tot env “unhackable”. [[06:43](https://www.youtube.com/watch?v=1BZB4c792-0&t=403)]
* **Caveat (Vals AI, late insert):** in ~⅔ coding tasks zat antwoord nog in **git history**; MiMo vond/gebruikte dat → bench mogelijk gecontamineerd; model kan exploit-habit ontwikkelen. Video: focus op methodologie, benches met zout. [[07:05](https://www.youtube.com/watch?v=1BZB4c792-0&t=425)]

#### E. Compute-mix, partial rollouts, dual engines [[07:50](https://www.youtube.com/watch?v=1BZB4c792-0&t=470)]

| Pro RL compute (video) | Aandeel |
|------------------------|---------|
| Model updates | ~**43.5%** |
| Rollouts | ~**43.8%** |
| Grading | ~**12.7%** |

* Rollouts duurder dan “training” zelf; Flash vergelijkbare ratio. [[08:13](https://www.youtube.com/watch?v=1BZB4c792-0&t=493)]
* **Partial rollouts:** unfinished traj pausen, trainen doorgaat, later hervatten. **Staleness** op dashboard; &gt;4 steps → drop (geen update op oude policy-gedrag). [[08:35](https://www.youtube.com/watch?v=1BZB4c792-0&t=515)]
* Rollout = **SGLang**, train = **Megatron-LM** → numerieke/MoE-routing drift. Sync + track **KL**: Pro ~**0.0028**, Flash ~**0.011**. [[08:57](https://www.youtube.com/watch?v=1BZB4c792-0&t=537)]
* Avg traj: Pro ~**137k** tok / ~44 turns; Flash ~**148k** / ~69 turns. [[09:44](https://www.youtube.com/watch?v=1BZB4c792-0&t=584)]
* Incidenten: Pro restart na MoE expert load imbalance → GPU OOM; infra/connectivity issues. [[10:30](https://www.youtube.com/watch?v=1BZB4c792-0&t=630)]

#### F. Slechts ~30 steps; distill; open stack [[10:52](https://www.youtube.com/watch?v=1BZB4c792-0&t=652)]

* **~30** RL-steps (niet 300/3000): Pro ~**123h**, Flash ~**82h**; wall-clock ~**5d 7.5h** / **3d 11h**. [[10:52](https://www.youtube.com/watch?v=1BZB4c792-0&t=652)]
* DeepSWE v3 (video “Deep Seek 3”): Pro **58.4→72.6**, Flash **48.7→65.7**; ~65.8% data coding-related; curves ook omhoog op workflows / visual coding / cyber. Stop bij 30 ondanks nog stijgende curves. [[11:14](https://www.youtube.com/watch?v=1BZB4c792-0&t=674)]
* Distill trajecten → **Qwen 3 8B/9B** (~77.4B tokens): SWE-bench Pro **32→44.6**; automation bench **5%→30.3%**. Harness-generalisatie: train 4 mini-harnesses, eval 7 (3 unseen) → gains overal. [[12:23](https://www.youtube.com/watch?v=1BZB4c792-0&t=743)]
* Open: distilled 9B, RL framework, ~3k coding / 1k cyber / 1k general / 2k visual tasks + mini harness + eval. [[13:09](https://www.youtube.com/watch?v=1BZB4c792-0&t=789)]

#### Wat ik meeneem

* Frontier agent-RL = **wereld bouwen** (env harden + grading) + orchestratie, niet alleen “meer GRPO”; parallel §56 specialisten/distill maar hier live dashboard + $.
* Binary verifiers belonen “meer tokens tot groen” → group-wise grading / length penalties relevant voor eigen agent-evals (`meten/`).
* Train≠serve engines (Megatron vs SGLang) + KL-monitor: les voor lokale agent-stacks.
* Vals AI-caveat: **eval hygiene** (geen antwoord in git/cache) = must voor eerlijke agent-benches (§20-achtige strengheid).
* Geen kit-actie; wel bachelor/kenniskaart Industrie + agentic RL methodologie.

#### Open / onduidelijk

* Exacte paper/dashboard-URLs; of contamination alle benches raakt.
* Of 30 steps optimaal was of “ship deadline”; HiSparse 2 details later.
* Reproduceerbaarheid van $ / GPU-uren buiten Xiaomi-cluster.

---

## §62. DeepSeek Just Shook the Entire AI Industry Again (WhatsWithAI)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=YX6QdIYVSgY](https://www.youtube.com/watch?v=YX6QdIYVSgY)

- **Duur:** ~10:43 · upload ~2026-10-23
- **Kern in 2–3 zinnen:** Industrie-/serving-lens op de open release van **DeepInfer** + **deepseek-recipe**: DeepSeek publiceert clustercijfers (claim ~**155T tokens/dag**, ~**$38**/GPU-uur revenue off-peak → geschatte ~**80%** gross margin) en legt high-level uit hoe V4.1-Flash-architectuur + vier engine-moves (wide EP, EPLB, DSpark confidence, bounded replay) + Rust-gateway dat mogelijk maken — mét geopolitiek (Blackwell **en** Ascend 950; Hopper overgeslagen) en expliciete *niet*-open factory-stukken. Cross: model/infra **§56/§58/§60**, DSpark-diepte **§61**; cache-/margin-economie **§143**.
- **Repos:** [DeepInfer](https://github.com/deepseek-ai/DeepInfer), [deepseek-recipe](https://github.com/deepseek-ai/deepseek-recipe) (video-description).

---

#### A. Framing: “cheap API was a bluff?” [[00:00](https://www.youtube.com/watch?v=YX6QdIYVSgY&t=0)]

* Mystery was niet alleen training, maar **API-prijs** vs Silicon Valley cloud-kosten; theorie: VC-burn om westen te undercutten. [[00:02](https://www.youtube.com/watch?v=YX6QdIYVSgY&t=2)]
* “Hours ago”: datacenter-cijfers + secret serving software open. Claims: [[00:29](https://www.youtube.com/watch?v=YX6QdIYVSgY&t=29)]

| Claim (spreker) | Getal |
|-----------------|--------|
| Tokens/dag (één cluster) | ~**155 trillion** |
| Vertaling video | ~**1.8 billion “words”/s** non-stop |
| Revenue / GPU-uur (discounted off-peak) | ~**$38** |
| Typische enterprise-chip run-cost | ~**$5–10**/uur |
| Geschatte gross margin | ~**80%** |

* Open: **DeepInfer** (engine) + companion gateway **deepseek-recipe**. ~1.5 jaar eerder: productie-serving “te verstrengeld met private DC” om te openen — nu op GitHub. Stars: >**9k** in 24u, richting ~**20k** (video-moment). [[01:04](https://www.youtube.com/watch?v=YX6QdIYVSgY&t=64)] [[01:27](https://www.youtube.com/watch?v=YX6QdIYVSgY&t=87)]

#### B. Architectuur-lens: CED + MoE (vóór de vier moves) [[01:38](https://www.youtube.com/watch?v=YX6QdIYVSgY&t=98)]

* Prefill/“reading” door **alle** lagen = zwaar; fabrieksmetafoor ~**40** stages. [[01:38](https://www.youtube.com/watch?v=YX6QdIYVSgY&t=98)]
* **Causal encoder–decoder (CED):** split ~20 reader + ~20 writer; prompt alleen door bottom half; top half “projected” — claim: zware read-work ~**halveert**. [[02:08](https://www.youtube.com/watch?v=YX6QdIYVSgY&t=128)]
* MoE-claim video: ~**748B** total; ~**8B** active bij read, ~**16B** bij write. *(Vergelijk §58 Flash-cijfers — zie Open.)* [[02:33](https://www.youtube.com/watch?v=YX6QdIYVSgY&t=153)]

#### C. DeepInfer move 1–2: wide EP + EPLB [[02:45](https://www.youtube.com/watch?v=YX6QdIYVSgY&t=165)]

* Prefill = compute; decode = **memory** bottleneck (weights fetch per token). [[02:52](https://www.youtube.com/watch?v=YX6QdIYVSgY&t=172)]
* **Wide expert parallelism:** prompt-read op “normale” **8-GPU** servers; decode op supernodes **64–128** GPU’s. [[03:28](https://www.youtube.com/watch?v=YX6QdIYVSgY&t=208)]
* Experts: ~**384** “mini-departments”; over **128** chips → ~**7** experts/GPU. Memory traffic claim ~**−88%**; single GPU >**26 000 “words”/s**. [[03:43](https://www.youtube.com/watch?v=YX6QdIYVSgY&t=223)]

```
  prefill:  8-GPU nodes
  decode:   64–128 GPU supernode  (experts sharded)
            EPLB → duplicate hot experts onto idle GPUs
```

* **EPLB** (expert parallelism load balancer): hot experts (bv. coding) vs idle; slow GPU (50 ms) blokkeert cluster als rest 5 ms klaar is → realtime duplicates op idle chips (“extra kassa’s”). Claim: vrijwel geen wasted idle. [[04:14](https://www.youtube.com/watch?v=YX6QdIYVSgY&t=254)]

#### D. Move 3–4: DSpark confidence + bounded replay [[05:02](https://www.youtube.com/watch?v=YX6QdIYVSgY&t=302)]

* **DSpark** in-engine (paper eerder; diepte **§61**): kleine helper draft ~**5** tokens; target verify parallel. Blind verify verspilt compute op doomed suffix → **confidence head** stopt verify vroeg (vouwen bij lage odds). Claim: cluster speed **+4–7%** zonder accuracy-drop. [[05:05](https://www.youtube.com/watch?v=YX6QdIYVSgY&t=305)]
* **Bounded replay** (lange chat / weekend-coding): KV/history duur voor miljoenen users → vaak clear. Na 2u terug: normaal hele prompt opnieuw prefillen. Fix: hot conversation ~**3 min** in snelle lokale RAM; na eviction, door model-design, alleen laatste ~**140 words** herlezen — “sticky note op laatste pagina”. Prefill catch-up bij cache miss claim: vrijwel instant of prompt 1k of 1M words. [[06:09](https://www.youtube.com/watch?v=YX6QdIYVSgY&t=369)] *(SWA/replay-detail → §58.)*

#### E. deepseek-recipe (Rust gateway) [[07:22](https://www.youtube.com/watch?v=YX6QdIYVSgY&t=442)]

* Voor GPU: CPU **tokenization**; grote prompts → lag. Recipe (Rust): split langs structurele grenzen, parallel tokenize over CPU-cores. [[07:34](https://www.youtube.com/watch?v=YX6QdIYVSgY&t=454)]
* Security: prompt-injection → forceer encoding als **plain text** (neutraliseren van “malicious system commands” in chat). [[07:56](https://www.youtube.com/watch?v=YX6QdIYVSgY&t=476)]

#### F. Hardware / geopolitiek + wat *niet* open is [[08:11](https://www.youtube.com/watch?v=YX6QdIYVSgY&t=491)]

* DeepInfer first-class: **NVIDIA Blackwell** + **Huawei Ascend 950**. Ontbreekt: Hopper (**H100** e.d.) — vorige gen “bypassed”; domestiek silicon als fallback onder US-restricties. [[08:15](https://www.youtube.com/watch?v=YX6QdIYVSgY&t=495)]
* Docs: sectie *wat ze weglaten*. Engine open; factory niet: [[08:50](https://www.youtube.com/watch?v=YX6QdIYVSgY&t=530)]

| Achter gesloten deur (video) | Claim |
|------------------------------|--------|
| Storage cluster | ~**100 PB**, ~**10 TB/s** |
| Network routing | specialized |
| Global internet load balancer | private |

* Metafoor: high-end commercial oven, geen industriële bakery-lijn. Claimed spees: enterprise ≥**128** GPU’s + flagship **V4.1 Flash**. [[09:22](https://www.youtube.com/watch?v=YX6QdIYVSgY&t=562)]

#### G. Industrie-conclusie [[09:35](https://www.youtube.com/watch?v=YX6QdIYVSgY&t=575)]

* Narrative “wie koopt meeste GPU’s wint” vs systems engineering. Druk op cloud-markups voor open models; community-engines (**vLLM**, ASR “VLM”) scrapen tricks. Competitie = intelligence **at lowest cost**. [[09:39](https://www.youtube.com/watch?v=YX6QdIYVSgY&t=579)]

#### Wat ik meeneem

* Margin/API-prijs-narratief is **serving + model co-design** (CED/MoE + EP/EPLB + speculative policy + replay), niet alleen “goedkoop trainen” — past bij §56–§61 maar hier als **industrie-bewijs** + open repos.
* Open-source ≠ reproduceerbare productiesnelheid: storage/net/LB blijven private; ≥128-GPU + V4.1 Flash = drempel (zelfde les als DeepSpec/§61 cluster-scope).
* Dual-stack Blackwell+Ascend = geopolitieke serving-realiteit voor bachelor/kenniskaart; geen kit-default.
* Recipe-gateway: parallel tokenize + injectie-as-text = harness-rand (Context/Harness) naast pure GPU-kernels — Rust-trend breder: **§64**.
* Geen kit-actie; wel pointer bij [fundament/inference/engines.md](fundament/inference/engines.md) / DeepInfer.

#### Open / onduidelijk

* Param-counts **748B / 8B / 16B** vs §58 Flash (~552B e.d.) — welke release/variant de video bedoelt.
* “Words” vs tokens in throughput-claims; exacte DC-post/blog bron achter 155T / $38 / 80%.
* ASR “Deepseek or SAP” = deepseek-recipe (description); bounded-replay “140 words” vs token-SWA in papers.
* Hoeveel van EPLB/wide-EP in open DeepInfer reproduceerbaar is zonder private net/storage.

---

## §143. DeepSeek Just Showed Everyone How to Make 80% Margins on AI (DeepInfer) (Squintist)

**Type:** Video · **URL:** [https://www.youtube.com/watch?v=xSvS6xDQ3xA](https://www.youtube.com/watch?v=xSvS6xDQ3xA)

- **Duur:** ~16:02 · upload ~2026-10-24
- **Kern in 2–3 zinnen:** Economie-/cache-lens op dezelfde DeepInfer-open release als §62: de virale **155T tokens/dag** en **~$38**/GPU-uur kloppen *pas* als je ziet dat ~**96%** “tokens” **KV-cache hits** zijn (agent-sessies herlezen); multi-day cache (doc ≥**72u**) is productkeuze, niet pure hardware-ROI; engine/cache-design zijn nauwelijks een moat → speel is *commoditize your complement* (serving standaardiseren, gewichten/AGI behouden). Cross: engine-moves §62; model/KV §56/§58/§60; DSpark §61.
- **Repos:** [DeepInfer](https://github.com/deepseek-ai/DeepInfer) (video/ASR soms “DeepInfra”); companion voor identiek API-gedrag (vgl. deepseek-recipe §62); storage-FS **3FS** (open sinds feb 2025).

---

#### A. Wat ze openzetten — en bewust niet [[00:00](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=0)]

* **20 okt 2026:** productie-inference-engine open (claim: **Apache**), plus echte operating numbers: één cluster **155T tokens/dag**; revenue **$38**/GPU-uur. [[00:00](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=0)]
* **Apr 2025** doc *The Path to open-sourcing the DeepSeek inference engine*: toen **niet** openen. Drie redenen: zwaar gemodificeerde **vLLM**-fork; gekoppeld aan interne infra; klein research-team zonder OSS-onderhoudsbandbreedte → liever upstream-contributies. [[00:45](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=45)]
* Release volgt die bezwaren: géén general engine (één model: het hunne); server/router/cache-storage/LB blijven intern. Deployment-doc: cache + balancers “**not yet fully open-sourced**”; belooft wél toekomstige **model**-inference-code in de engine — niets vergelijkbaars over cache/LB. [[00:45](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=45)] [[01:31](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=91)]
* Onderhoudsclaim bevestigd: **184** PRs open; **1** gemerged (submodule bump). Design van cache/routers wél gedetailleerd gepubliceerd, code niet. [[01:31](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=91)]

#### B. Reactie + de 155T-decompositie (meestal cache) [[02:17](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=137)]

* HN: ~**70k** GPU’s nodig voor 155T/dag (commenter twijfelde zelf). **Yuxin Jin:** bij huur ~**$7**/GPU-uur → ~**82%** gross margin op $38 revenue. **Alexey Fadeev** (~300k views): cheap AI ≠ charity — frontier serving is business als de stack goed genoeg is. [[02:17](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=137)]
* Productiestats-kop: **cache hit rate 96%**. KV-cache = opgeslagen “al gelezen” toestand zodat herberekening overgeslagen wordt. [[02:17](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=137)] [[03:03](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=183)]

| Deel van 155T/dag (claim) | Volume | Aandeel |
|---------------------------|--------|---------|
| Cache reads | ~**147T** | ~96% van “gelezen” |
| Fresh input | ~**6T** | |
| Output (gegenereerd) | ~**1.4T** | &lt;1% van headline |

* Gemiddeld request: ~**77k** input-tokens, waarvan ~**3k** nieuw (= één agent-stap: file read / tool result op lange chat). **50** turns → herlees-aritmetiek ≈ **96%** hit *zonder* cross-user sharing — cache moet er gewoon nog zijn bij terugkeer. [[03:03](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=183)] [[03:48](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=228)]

```
  155T “tokens/dag”
  ├── ~147T  KV-cache hits
  ├── ~6T    verse input
  └── ~1.4T  output (<1%)
```

#### C. De 13× lunch-break (korte TTL elders) [[03:48](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=228)]

* **Shaoyan Quo** (video): maand Claude Code — **110** sessies, **46k** turns. Kosten vs doorwerken: koffie **1.3×**, telefoon **1.6×**, na lunch **13×** (Anthropic-cache max ~**1u**, soms **5 min** → lunch = full rebuild). [[03:48](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=228)]
* Andere audit: **900** sessies → &gt;helft van turns na gap **&gt;5 min**. [[04:34](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=274)]

| Provider (video) | Write / bewaar | Read-prijs | TTL |
|------------------|----------------|------------|-----|
| Anthropic | write **1.25–2×** input | read **0.1×** | 5 min of ≤1 u |
| OpenAI (nieuwere) | write-fee; of **2.5×** input voor lease | | default **30 min**; **12 u** tier (lease vernieuwt niet) |
| Google | huur per M cache-tokens / uur | | |
| DeepSeek | **geen** write-fee, **geen** rent | read **~2%** van normale input | agent ~**3 d**; chat ~**7 d**; deploy-doc ≥**72 u** |

#### D. $38 check + revenue-split [[05:19](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=319)]

* Off-peak prijs/M tok (claim): cache hit **$0.003**; uncached input **$0.15**; output **$0.60**. × gepubliceerde per-card rates → **$39.10**/card-uur ≈ stated **$38**. [[05:19](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=319)]
* Cache hits ≈ **95%** van tokens maar slechts ≈ **20%** van revenue. Virale schatting die 155T × full input-prijs deed → ~**$23M**/dag; “echte” orde ~**$2M**/dag. [[05:19](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=319)] [[06:04](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=364)]
* **150**-turn agent-sessie: zonder cache ~**67 s** GPU-tijd; mét ~**5 s** → user én DeepSeek ~**10×** goedkoper — “fysica van werk niet opnieuw doen”. [[06:04](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=364)]

#### E. Waarom 3 dagen geheugen wél kan [[06:04](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=364)]

1. **Model co-design:** KV-state ~**890 B/token**. Eerste DeepSeek-model ~**437×** groter; vergelijkbaar Meta open model ~**370×**. Week onthouden = rounding error bij 890 B; bij Meta-footprint = exabyte-fantasie. [[06:04](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=364)]
2. **Apart storage-cluster:** ~**100 PB** SSD op **3FS** (open feb 2025). Elke machine leest elke user-cache → routers hoeven sessie niet aan één GPU te pinnen (vs pinned-to-first-GPU elders). [[06:52](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=412)]
3. **Operating point:** prefill-card verse tok **60k/s**, cached ingest **1.5M/s** → compute↔storage-bandwidth knelpunt bij exact **~96.15%** hit; ze draaien op **96%** — ontworpen, geen toeval. [[07:37](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=457)]
4. **Retention vs hit-rate:** 7 d i.p.v. 3 d koopt &lt;**1** extra hit-punt; elk punt nabij de top kost **dubbele digits %** fleet. Multi-day tail betaalt zich niet in pure hardware-ROI — wel in product: **1M** context, first response ~**400 ms**, prijs die 5-min-cache concurrent structureel niet kan matchen. **72 u** = product, niet kostenoptimalisatie. [[08:24](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=504)]

#### F. Is er een moat? [[09:11](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=551)]

| Kandidaat | Claim video |
|-----------|-------------|
| Engine | vLLM reproduceerde decode binnen **6%** in &lt;24u (+ $/GPU); caveat: 1u replay traces, géén multi-day cache. Intern ≤**5%** voor op E2E. Commodity. |
| Cache-systeem (code withheld) | Design open (routers/buckets/cost model); decode-balance = **SIGCOMM**-paper; storage = **3FS**. vLLM day-0; SGLang pools `DeepSeek_V4`. Binnen **4 d** public PRs die withheld plumbing rebuilden; één **byte-identical** op echte **B200**s. |
| Schaal | Min. efficiënt: **64** prefill + **64** decode = **128** serieuze GPU’s (muur eronder voor interactive). Memory-tier ~**5–15%** van GPU-budget; zonder cache ~**13×** compute. Drempel die je koopt, geen unieke muur. |

* Conclusie spreker: **geen verdedigbare moat** in deze stack. Tegelijk: géén community-project — geen issues-tab; ~**60** unmerged port-PRs (oudere Ascend, AMD, Intel, Apple Silicon, 5090); engineer-reply: “maintain yourself”. [[10:42](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=642)] [[11:28](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=688)]

#### G. Waarom weggeven: commoditize your complement [[11:28](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=688)]

* Officiële framing: meer orgs die DeepSeek-modellen serveren met **dezelfde API-behavior** als officieel. Companion-package forceert identiek gedrag; bevat o.a. strip van billing-header die **Claude Code** voorzet (breekt prompt-prefix → doodt cache). Engineering voor *andermans* traffic op *andermans* hardware. [[11:28](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=688)] [[12:13](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=733)]
* Speel: **commoditize your complement** — serving = complement van het model; maak serving gratis/saai/standaard → vraag naar de laag die je wilt (weights / AGI). Liang Wenfeng (leaked investor call, eerdere Squintist-video): weights = recipe ≠ restaurant; app/API = sesame seeds; AGI = watermelon. Serving bleek nooit “het restaurant”. [[12:13](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=733)] [[12:59](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=779)]
* Wat DeepSeek wint: **gravity** — andermans deploys landen op hun arch/kernels/cache-format/correctheidsdefinitie → volgende model valt in voorgevormde wereld.
* Hardware-subplot: **Ascend** first-class; meer kernel-code voor Ascend dan CUDA; metingen op hardware die publiek (nog) niet te koop is. Nvidia-vrije serving-standaard = ander soort asset — waarde/voor wie: open gelaten. [[12:59](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=779)] [[13:45](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=825)]

#### H. Markteffecten + SSD-crunch [[13:45](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=825)]

* Zichtbaar: Anthropic cache-read naar **1/40** van input op nieuwste models; OpenAI **12u**-cache-tier in 2026 (duur, maar bestaat). Gepubliceerde **$38**/GPU-uur naast rebuildbare stack dwingt “wat kost een token jou écht?” — zonder dat DeepSeek één klant hoeft te winnen. [[13:45](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=825)]
* Evidence zegt wat het *niet* is: geen verdediging van serving-margins; geen community-project. Motive = ongezegd; wie “het masterplan” kent, verkoopt iets. [[14:30](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=870)]
* **TrendForce:** enterprise-SSD-prijzen ~**+235%** in 2026; HDD’s uitverkocht heel jaar; deel crunch toegeschreven aan “**KV cache offloading in China**”. Goedkope tokens via alles onthouden ↔ duurdere flash voor de rest van de planeet. [[14:30](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=870)]

#### I. Wat het voor jou betekent [[15:17](https://www.youtube.com/watch?v=xSvS6xDQ3xA&t=917)]

* Druk naar langere/goedkopere caches + lagere tokens overall → meer hosts voor DeepSeek-modellen → agent-werk (uren, hele codebase) dat eerder niet “pencilde” wél. Met multi-day cache ≈ lunch ≈ doorwerken (anti-**13×**).

#### Wat ik meeneem

* **155T / $38 / ~80% margin** zonder cache-split misleidt; agent-productie = overwegend cache-reads — past bij harness-tax / prompt-cache (§30) en lange IDE-sessies.
* Multi-day KV is **product** (latency, 1M ctx, prijs) meer dan fleet-ROI; korte TTL elders = verborgen sessie-tax (13×).
* Open engine ≠ open factory (zelfde les §62); “geen moat” + *commoditize complement* = industrie-strategie, niet altruïsme-claim.
* Prefix-stabiele requests (Claude Code billing-header strip) = harde constraint voor cache-hits — harness/gateway-rand.
* Geen kit-actie; wel naast §62 in kenniskaart Industrie + pointer engines/KV in [fundament/inference/](fundament/inference/).

#### Open / onduidelijk

* Exacte companion-pakketnaam vs deepseek-recipe (§62); Apache vs andere license-claims elders verifiëren.
* Namen ASR (“DeepInfra”, “Shaoyan Quo”, “Léon Wenfang”) — primaire repo-naam **DeepInfer** / Liang Wenfeng.
* Of 96%-operating-point + 100 PB/3FS-cijfers 1:1 uit deploy-docs komen of deels afgeleid.
* Reproduceerbaarheid multi-day cache-economie zonder hun storage/LB-code.

---

# Totaaloverzicht

Eén matrix voor Agent Engineering. Thema's = sectiekoppen hierboven. Bronnen tot §196. Bij nieuwe bronnen: rij + [bronnen-index.md](bronnen-index.md) bijwerken. Diepte: [fundament/](fundament/INDEX.md).

### Vierlagen-stack

| Laag | Primaire focus | Sleuteltechnologieën / kaders | Kerninzicht / risico | Bronnen |
| --- | --- | --- | --- | --- |
| **Prompt Engineering** | Tekstuele instructie & skill-ontwerp | System prompts, `SKILL.md`, *Leading Words*; Skills YAML+MD (§124); CoT-redeneren | Vermijd *Skill Hell*; wantrouw LOC-benchmarks zonder agentic baseline | §3, §50, §51, §54, §124, §195 |
| **Context Engineering** | Wat wél/niet in het context window komt | `/docs`, JIT; MemPalace; Hindsight (§146); Cursor Instant Grep / semantic / dynamic discovery / indexing; ColGrep/GrepAI/Hypergrep; LeanVec; recency-aware context | Attention budget; dynamic > static dump; search-pad evolueert; tokens alleen bij slaagkans | §8, §9, §10, §17, §18, §52, §69–§72, §146, §149, §152–§155, §159–§178, §187–§188, §194, §196 |
| **Harness Engineering** | Runtime-schil rond het model | Guardrails; Pi/DSH/Kimi Code (§141); A6–A9; PKU Harness-Bench (§133); Raven/Harness2/OpenHands | **Harness Tax**; H×M; chat≠spine; NanoBot≠OpenClaw gap | §5, §11, §12, §19, §25, §30, §33, §73–§86, §105–§122, §128–§133, §141, §150, §151, §156–§158, §179–§186, §189–§190 |
| **Loop Engineering** | Autonome, continue uitvoering | Triggers; Stop/goal; file-backed plan/ledger (§131); session resume | *Comprehension Debt*; persistente spine buiten chat | §26, §27, §117–§122, §128–§132 |

### Kernpraktijk

| Thema | Primaire focus | Sleuteltechnologieën / kaders | Kerninzicht / risico | Bronnen |
| --- | --- | --- | --- | --- |
| **Graph Engineering** | Multi-agent parallellisatie | DAGs, dynamische JS-runtimes, 100+ node sub-agents | Separation of concerns vs token-kosten | §28 |
| **Workflow & Specs** | Sturing van idee → geverifieerde code | Grill, Wayfinder, factories, Spec→Verifier→Environment, vibe→agentic | Code is niet gratis; verify vóór ship | §1, §4, §6, §7, §37, §41 |
| **Software design (AI-tijdperk)** | Deep modules, entropie, de-slop; trust/compilers (§144) | Ubiquitous language, TDD, seams; reproducible/bootstrap | Specs-to-code zonder design faalt; OSS≠trust | §2, §32, §144 |
| **Agent-docs & docs-architectuur** | Persistente instructies & docs-vorm | Rules/AGENTS/llms; Diátaxis/ADR; A8 dual (§123–§127) | Publiek bepaalt formaat; MD + FM/JSON naast elkaar | §13–§16, §20–§24, §34, §55, §87, §113–§114, §123–§127 |
| **Ship quality** | Security-scan & observability | Strix/SARIF; logs→metrics→traces→SLO's | Shippen vraagt meer dan groene unit-tests | §47, §48 |
| **Product / tooling-rand** | Generative UI, smalle automatie, tooling-stack; agentic-IDE listicles | OpenUI; Jev; Rust; vibe/IDE roundups (§102–§104, lage authority) | Listicles ≠ benches | §31, §44, §64, §102–§104 |

### Fundament-spiegel

| Thema | Wanneer nuttig | Bronnen |
| --- | --- | --- |
| **Inference** | Model-serving, VRAM, KV-cache; DeepSeek (+ DeepInfer §145); **Kimi/Moonshot** (§134–§142); **Mistral** (AA/docs/Large 4/7B); quant/BitNet/NVFP4; Colibrì; 16 GB lokaal; PagedAttention/FreeToken/OCR-bundel | §29, §45, §49, §56–§58, §60, §61, §63, §89–§101, §134–§142, §145, §191–§192 |
| **Reasoning** | Latent vs text, HybridAgents; HRM/TRM; alien-space ideation (§148) | §35, §46, §148 |
| **Model internals** | LLM-doorloop; NCM; superposition; world models; limits; byte; Muon (+ MuonClip §139); Grassmann attn-alt (§147); efficiënte attn-taxonomie | §36, §38, §40, §42, §43, §53, §65, §66, §67, §68, §139, §147, §193 |
| **Industrie** | Infra-schuld, chip-cyclus; Xiaomi RL; DeepInfer (§62 engine / §143 cache-economie); CH AI; Mistral EU/sovereignty + license politics | §39, §59, §62, §88, §99–§100, §143 |
