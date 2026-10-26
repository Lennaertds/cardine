# Ideeën en open vragen (niet kwijtraken)

> **Rol:** Jouw ruwe vragen/hypothesen voor spoor 3 — vastgelegd vóór ze in § of ADR landen.
> **Niet hier:** feiten met URL (§ in Agent_Engineering `bron/`); harde keuzes (`docs/decisions/`); uitvoerplan (`specs/`).

Stand: 2026-10-26. Bron van **volgorde**: [onderzoek-programma.md](onderzoek-programma.md). Status per vraag: `open` / `deels (§…)` / `later B`.

## A — Onderzoek (feiten → AE `bron/`)

| # | Jouw vraag (parafrase) | Slice | Status | Opmerking |
|---|------------------------|-------|--------|-----------|
| 1 | Wat heeft Cursor; hergebruik vs verbeteren vs niet sturen? | A1 | deels (§9, §13, **§69–§75**) | Nog optioneel: Cloud Agents-env, Router, longer-horizon training blogs |
| 2 | Andere harnesses (DeepSeek Harness, Pi, peers); hergebruik/verbeteren? | A2 | deels (**§76–§79**, **§105–§112**, §33) | Decode/Vercel/Mastra = leerpad; enforcement > prompts (§107) |
| 3 | Mistral + open-source modellen / efficiëntie? | A3 | deels (DeepSeek **§89–§94**; Mistral **§95–§101**) | AA Mistral watch; Large 4 weights/LICENSE volgen; stage Parijs = motivatie (geen ADR) |
| 4 | Hoe zit een IDE in elkaar: talen, fork, integraties? | A4 | open (namen §103–§104) | Echte diepte: VS Code architecture/LSP; listicles alleen taxonomie |
| 5 | IDEs/harnesses tot op het bot vergelijken (technisch + benchmarks) | A5 | deels (**§80–§86**) | Matrix nog te maken; Binding Constraint + SWE-Pro grid + HarnessTax; BenchGen=Assess (§86) |
| 6 | Standaard in **docs** vs in **code/harness** afdwingen — wat kost minder (tokens + fouten)? | A6 | deels (**§113–§117** + §107) | Domein `structure`; pool C empirisch gesteund; meetplan open |
| 7 | Welke **kwaliteitsgates** wanneer, en wat doet de agent bij rood (revert / stop)? | A7 | deels (**§118–§122** + §117) | Ladder check → check-full → opt-in; lab-tabel + revert-zin nog |
| 8 | Welk **formaat** per documentsoort (mens vs agent-only)? | A8 | deels (**§123–§127**) | Dual by audience gesteund; lab-tabel nog |
| 9 | Waar leeft **session/spine** als je van map wisselt — chat, root, of files? | A9 | deels (**§128–§132** + §117) | Pool A faalt (Cursor-pad); C/D gesteund; conventie nog |

## A6 — verduidelijkt

### Wat de vraag *niet* is

- Niet: “welke P1–P28 zijn belangrijk?” (dat staat al in AE).  
- Niet: “schrijven we betere AGENTS.md?” (inhoud/lengte → A6 + §13–§24).  
- Niet: stack kiezen (B).

### Wat de vraag wél is

Het lab heeft domein **structure**: de projectstandaard *laten meewegen* in de agent-loop ([PRODUCT](../product/PRODUCT.md), [GLOSSARY](../context/GLOSSARY.md)).

Spectrum (drie polen):

| Pool | Voorbeeld | Kost | Faalwijze |
|------|-----------|------|-----------|
| **A — Docs-only** | Lange `AGENTS.md` / RULES; model “moet gehoorzamen” | Tokens elke turn (harness tax); drift | Model negeert / vergeet / interpreteert creatief (§20, §107) |
| **B — Code/harness** | `make check`, path-allowlist, hooks die toolcalls weigeren, seams in ARCHITECTURE | Bouw + onderhoud | Te star / te veel harness (§108) |
| **C — Dual** | Korte intent in markdown + afdwingen in runtime | Beide, maar docs blijven dun | Duplicatie als docs ≠ code |

Jouw hypothese (parafrase): **C met dunne docs** — vaste pijlers in de app/harness → *minder* prompt-overhead én betere naleving dan “alles in project-markdown”.

Dat is exact de brandposter-les (§107): instructions ≠ enforcement. Empirie/vendor-practice: **§113–§117**.

### Feiten uit nieuwe § (A6)

| § | Bron | Voor A6 |
|---|------|---------|
| §113 | OpenAI harness engineering | Dikke AGENTS faalde; ~100 regels = TOC; docs SoR; **mechanical** linters/CI |
| §114 | Anthropic steering Claude Code | “Never X” / “always Y” → **hooks**; skills voor procedures; CLAUDE.md dun |
| §115 | Agent Patterns hooks | Prompt = *should*; hook = *must*; link-check ≠ “don’t break links” in AGENTS |
| §116 | Böckeler / Fowler | Guides + sensors; computational (lint) vs inferential (LLM judge) |
| §117 | Anthropic long-running harness | “Asking nicely” faalt; default-FAIL + PreToolUse evidence-gate |

### Hoe opzoeken (rest)

1. **Al gelezen ankers:** §20, §34/§55, §107–§108, §5/§30/P25 + **§113–§117**.  
2. **Kit als levend voorbeeld:** `make check`, link-check, bootstrap — beleid als *commando*, niet als paragraaf. Noteer: welke regels zijn al “code”, welke alleen tekst?  
3. **Peers (mechanismen):** Pi (§76), DSH (§77), Cursor (§74) — waar zit policy t.o.v. hooks/AGENTS?  
4. **Mini-experiment (pas na stack):** zelfde taak 2× — (A) dikke AGENTS, (B) dunne AGENTS + harde check/hook — meet tokens + naleving. Log in `meten/`, geen ADR.

### Deliverable A6 (klaar als)

- Één zin decision-candidate voor B (nog geen ADR): bv. “structure = allowlist + checks; AGENTS ≤ N regels intent”.  
- Tabel: welke standaard-regels → docs / code / beide.  
- Bronnen-pool: **§113–§117** (+ §107) — genoeg voor decision-candidate; experiment nog open.

### Open keuzes voor jou (later, 1 antwoord genoeg)

Wil je A6 meten op **tokens**, op **naleving** (agent breekt RULES), of beide? Default voorstel: **beide**, lichte sample.

## A7 — verduidelijkt

### Wat de vraag *niet* is

- Niet: “welke unit tests schrijven we voor de product-app?” (dat volgt features).  
- Niet: CI-vendor kiezen (GitHub Actions vs …) vóór team-module.  
- Niet: Strix/security als always-on in elke `make check` (kit: opt-in; lab heeft nog geen netwerk-facing app).  
- Niet: A6 opnieuw (policy in docs vs code) — A7 = **wanneer** checks draaien en **wat bij falen**.

### Wat de vraag wél is

Als de agent code/docs wijzigt: hoe voorkom je dat rommel landt op main / jouw machine “kapot” blijft?

Kit-scheiding (al bestaand, AE `bestaand-project/3-feedbacklus`, IDE `AGENTS.md`):

| Gate | Wat | Wanneer | Agent-gedrag bij rood |
|------|-----|---------|------------------------|
| **In-loop** | LSP / gerichte test / `make <app>-test` | Tijdens slice | Fix of stop; geen “klaar” claimen |
| **`make check`** | Lint/types/unit, **geen** netwerk/DB | Einde slice / vóór afronden | **Niet** afronden; fix of revert wijziging |
| **pre-commit** | Subset hooks | Bij `git commit` | Commit weigeren |
| **`make check-full`** | + integratie/e2e/deps-audit/native STRICT | Pre-merge / pre-release | Niet mergen tot groen |
| **Opt-in** | `security-scan*` (Strix), `obs-*`, `perf-*`, … | Pre-prod / bij risico | Apart; niet always-on (P25) |

“Continu testen” = vooral **in-loop + check**, niet “elke keystroke check-full”.

“Fouten terugdraaien vóór push” = bij rood na agent-werk: `git checkout`/`restore`/`revert` of worktree weg — **geen** push van half-kapotte state. Harness kan dit later afdwingen (hook); nu = werkwijze + meten.

### Relatie met A6

- A6: *waar* regels leven (prompt vs executable).  
- A7: *wanneer* executable gates vuren en *escape hatch* (revert).  
 overlap: `make check` is al policy-as-code — A7 vult de **ladder** in.

### Feiten uit nieuwe § (A7)

| § | Bron | Voor A7 |
|---|------|---------|
| §118 | Agent Patterns verification gates | Stop exit 2; laag edit→feature→CI; verifier > generator |
| §119 | Big Iron `make check` oracle | Vier plekken (AGENTS/Stop/pre-commit/CI); check vs check-full; auto-revert-patroon |
| §120 | HAR verify + commit gate | Quick vs full; content-hash: geen commit zonder matching full-verify |
| §121 | Claude Code best practices | Prompt → `/goal` → Stop-hook → second opinion; evidence tonen |
| §122 | Emma verification ladder | Intensiteit-dial; anti-theater; checkpoint vóór destructie |
| §117 | Anthropic long-running (al) | Default-FAIL + evidence-gate |

### Hoe opzoeken (rest)

1. **Kit/docs:** IDE/AE `AGENTS.md` afronden; `make help`; how-to native-ci/security-scan; AE `bestaand-project/3-feedbacklus.md`; `meten/` C4.  
2. **Al gelezen ankers:** §47, §105/§109, §26 + **§118–§122**.  
3. **Peers:** Cursor keep-rate (§74) = post-hoc, niet jouw ladder.  
4. **Experiment later:** (A) geen check tot push vs (B) check+revert — broken commits / tijd-tot-groen.

### Deliverable A7 (klaar als)

- Tabel “lab v1 ladder”: welke gate verplicht / opt-in / nooit always-on.  
- Eén zin revert-beleid voor agents (bv. “rood `make check` → geen commit; restore slice”).  
- Bronnen-pool: **§118–§122** (+ §117) — genoeg voor ladder-taal; lab-tabel + experiment nog open.

### Open keuzes voor jou (later)

Is lab-default: agent mag **alleen** committen na groen `make check`, of mag committen met WIP-branch zolang niet gepusht? Default voorstel: **geen push zonder check**; commit op feature-branch ok als pre-commit groen.

## A8 — verduidelijkt

### Wat de vraag *niet* is

- Niet: “Markdown afschaffen” of “alles YAML”.  
- Niet: Diátaxis vervangen (dat = *soort* doc: tutorial/how-to/explanation/reference — §22).  
- Niet: A6 (waar policy leeft) of A9 (waar session-state leeft).  
- Niet: betere *prose* in AGENTS (lengte/inhoud) — wel: of AGENTS **mens+agent** Markdown moet blijven.

### Wat de vraag wél is

Documenten hebben een **publiek**. Sommige lees jij; sommige alleen de agent/tooling.

| Artefact (kit/lab) | Primair publiek | Vandaag | Kandidaat A8 |
|--------------------|-----------------|---------|--------------|
| PRODUCT, RULES, ARCHITECTURE, how-to | Mens (+ agent JIT) | Markdown | **Blijft MD** |
| `AGENTS.md` / `.cursorrules` | Agent (mens skimt) | Markdown | MD blijft default; kort houden (A6) |
| ADR (`docs/decisions/`) | Mens (waarom) | Markdown | MD voor leesbaarheid; optioneel machine-index ernaast |
| `llms.txt` / repo-map (§15–§16) | Agent | MD / gegenereerd | MD of gegenereerde text ok |
| Agent logs / traces / tool transcripts | Agent + debug | vaak JSONL/JSON | **Machine-first ok** |
| Experiment metrics / bench rows | Scripts | YAML/CSV/JSON | Machine-first |
| Skills frontmatter | Agent loader | MD + YAML FM | Dual al normaal |
| Session/spine (overlap A9) | Agent | ? | Machine-first kandidaat |

Hypothese: **dual by audience** — wat mensen moeten begrijpen = Markdown; wat alleen geladen/gegreept/gevalideerd wordt = schema’d formaat (YAML/JSON/JSONL) mét tool/check, niet “dump in context als prose”. Empirie/practice: **§123–§127**.

### Feiten uit nieuwe § (A8)

| § | Bron | Voor A8 |
|---|------|---------|
| §123 | ModernizeSpec agent context | `AGENTS.md` prose + `.agents/*.json` + manifest; progressive load |
| §124 | Anthropic Agent Skills | YAML FM always; MD body on trigger; scripts = code niet prose |
| §125 | llms.txt v2 | Constrained MD (mens+LLM+parser); niet XML; detail achter links |
| §126 | Structured MADR | ADR: MD body + YAML FM; index/CI uit FM — MD blijft SoR |
| §127 | Cursor Rules | `.mdc` FM = *wanneer laden*; `AGENTS.md` = plain MD; geen dubbele bron |

### Relatie met A6 / A7 / A9

| Slice | Focus |
|-------|--------|
| A6 | Policy: docs vs **code** |
| A7 | **Wanneer** checks; revert |
| A8 | **Formaat** van docs/artefacten per lezer |
| A9 | **Waar** session-state (folder/spine-files) |

### Hoe opzoeken (rest)

1. **Al gelezen:** §14–§16, §20, §22–§23, §34 + **§123–§127**.  
2. **Kit-inventaris:** non-MD paden (`.pre-commit-config.yaml`, `tasks.yaml`, compose, SARIF) = precedent.  
3. **Peers:** Pi JSON (§76), DSH log (§77), Decode/Mastra streams (§105/§112).  
4. **Experiment later:** MD-log vs JSONL + tool — tokens / foutkans.

### Deliverable A8 (klaar als)

- Tabel lab v1: pad/globs → formaat → wie leest → mag agent schrijven.  
- Harde regel-kandidaat: “geen machine-only secrets in MD; geen mens-only intent alleen in JSON zonder samenvatting.”  
- Bronnen-pool: **§123–§127** — genoeg voor dual-regel; lab-tabel nog. Geen massale ADR→YAML.

### Open keuzes voor jou (later)

ADR’s: altijd Markdown, of Markdown + FM/index? Default (nu met §126): **MD canoniek**; optionele YAML frontmatter / gegenereerde index — geen aparte YAML-SoR.

## A9 — verduidelijkt

### Wat de vraag *niet* is

- Niet: “welke LLM-provider” of context-window-grootte (A3 / inference).  
- Niet: compaction-algoritme diep uitwerken (wel: *waar* de status na compaction blijft — P27).  
- Niet: A8-formaat alleen (JSONL vs MD) — A9 = **binding/scope** van die state.  
- Niet: multi-agent orchestratie als productfeature (later).

### Wat de vraag wél is

**Productpijn:** in Cursor (en soortgelijke IDEs) hangt chat/agent-history vaak aan **workspace/project**. Ga je een map omhoog, open je een andere root, of wissel je window — history voelt “leeg” of verkeerd. Jij wilt dat nuttige state de **werkmap / taak** volgt, niet per se de IDE-workspace.

P27 (AE): autonome loop heeft stopconditie + **persistente spine buiten de chat** (bestanden/tracker: wat geprobeerd, wat werkte).

Spectrum:

| Pool | Voorbeeld | Pro | Contra |
|------|-----------|-----|--------|
| **A — IDE-chat only** | Cursor Composer-thread | Nul setup | Verdwijnt bij scope-wissel; niet deelbaar/CI |
| **B — Repo-root altijd** | Eén `SESSION.md` in projectroot | Simpel | Verkeerde context bij multi-pakket / nested work |
| **C — Per folder / worktree** | Spine in `apps/foo/.agent/` of git worktree | Volgt echte cwd | Meer paden; ignore/secrets discipline |
| **D — Expliciete session-id** | Pi tree-sessions / DSH session log / Mastra thread-id | Hernemen, fork, multi-surface | Bouwkost harness |

Hypothese lab: **C of D** — expliciete spine-files (tijdelijk of versioned) > hopen op IDE-history over workspace-grenzen. “Omhoog = lege chat” mag; **spine blijft**. Empirie/practice: **§128–§132** (+ §117).

### Feiten uit nieuwe § (A9)

| § | Bron | Voor A9 |
|---|------|---------|
| §128 | Claude Code sessions | Transcript onder `~/.claude/projects/` keyed op **directory**; continue = cwd |
| §129 | Claude Code worktrees | Scope = worktree; resume re-enters checkout (pool C) |
| §130 | Pi sessions | JSONL-tree; opslag cwd-grouped in `~/.pi/…` — session-id ≠ repo-spine |
| §131 | Planning-with-files | `task_plan`/`progress`/ledger **in repo**; clear → hervat van disk |
| §132 | Cursor forum/support | History **tied to workspace path** — pool A faalt bij move/rename |
| §117 | Anthropic long-running (al) | `progress.txt` + git = handoff tussen fresh contexts |

### Relatie met A6–A8

| Slice | Focus |
|-------|--------|
| A6 | Policy in docs vs code |
| A7 | Checks / revert |
| A8 | Formaat van artefacten |
| A9 | **Waar** session-state gebonden is (scope) |

A8+A9 samen: bv. `/.agent/session.jsonl` (machine) + korte `STATUS.md` (mens) in de actieve map.

### Hoe opzoeken (rest)

1. **P27 + kit:** BACKLOG/specs/logs als mens-spine.  
2. **Al gelezen peers:** §76/§77/§112/§105 + **§128–§132**.  
3. **Eigen pijn:** 3 momenten “history weg” → eis.  
4. **Experiment later:** IDE-chat vs folder-spine na re-open child dir.

### Deliverable A9 (klaar als)

- Keuze-kandidaat scope: root / cwd / worktree / session-id (nog geen ADR).  
- Conventie: pad + gitignore + wat in chat mag.  
- Bronnen-pool: **§128–§132** — genoeg voor “spine > IDE-pad”; lab-conventie nog.

### Open keuzes voor jou (later)

Spine **committen** of **gitignore**? Default lab: **gitignore** + optioneel export naar `docs/work/logs`.

## B — Keuzes op papier (ná genoeg A)

Niet nu uitvoeren. Pas na A1–A2–A5 (minimaal) + expliciete ja:

- Welke **stack** (Pi/TS/…)?
- Welke **basis** (fork Pi / VS Code-extension / terminal-only / …)?
- Wat verbeteren we t.o.v. Cursor/peers (structure, indexing, checks, session-state, …)?
- Meetplan: Cursor+kit vs dit lab (`meten/`).

Vastleggen als ADR’s in `docs/decisions/` — zie programma § B. Tot die tijd: hypothesen hieronder en in het programma.

## Overige ideeën (park)

| Idee | Waarheen later |
|------|----------------|
| Eigen API-keys (DeepSeek goedkoop e.d.) | Al in CONTEXT/RULES; harness-config na stack |
| Gratis product / portfolio / OS vs closed | BACKLOG Geparkeerd productisatie |
| Thesis-lezer als tweede persona | CONTEXT |
| Stage Mistral (Parijs) / EU AI | Motivatie A3; kennis in §95–§101 — geen solicit-plan hier |

## Hoe we dit aanpakken (kort)

Zie [onderzoek-programma.md](onderzoek-programma.md) § “Bronsoorten”. Samengevat: YouTube/artikels blijven §-waardig waar ze mechanismen geven; voor A4–A5–A7–A9 ook **docs, papers, repo-README’s, benchmarks, eigen metingen** — niet forceren in één video-§.
