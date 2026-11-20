# Onderzoeksprogramma — spoor 3 (vóór stack/fork)

> **Rol:** Richtlijn voor agents: wat onderzoeken, in welke volgorde, waar schrijven.
> **Niet hier:** feiten/samenvattingen (die horen in Agent_Engineering `bron/`); harde stack-keuzes (ADR pas ná genoeg §); ruwe ideeënlijst ([ideeen-en-vragen.md](ideeen-en-vragen.md)).

Stand: oktober 2026. Kennis-SSOT = sibling **Agent_Engineering** (`bron/bronnen.md`, index, fundament). Deze repo = lab + hypothesen + later code.

## Regel: A vóór harde B

1. **A — onderzoek** → nieuwe `§` in Agent_Engineering `bron/bronnen.md` (+ rij in `bronnen-index.md` + totaaloverzicht).
2. **Hypothesen / ideeën niet kwijt** → hier: [ideeen-en-vragen.md](ideeen-en-vragen.md), `wantlist.md`, dit bestand.
3. **B — keuzes** → ADR in `docs/decisions/` pas als A1–A2–A5 genoeg assen hebben (A6–A9 voeden B, blokkeren B niet). Geen `--starter` / stack tot expliciete ja van de mens.
4. **Bouwen** → daarna in `apps/` / harness-code.

Parallel mag een dunne wantlist/hypothese; geen “we forken X”-ADR op gevoel.

## Volgorde (verplicht)

| # | Slice | Vraag | Opmerkingen |
|---|--------|-------|-------------|
| A1 | Cursor | Wat heeft Cursor; hergebruik vs verbeteren vs *niet* sturen? | §9, §13, **§69–§75** (Instant Grep, semantic, indexing, dynamic context, Composer, harness, Codex). |
| A2 | Andere harnesses | Pi, DeepSeek Harness, peers. Hergebruik/verbeteren? | **§76–§79** (+ §33). Bouw/thesis: **§105–§112**. DeepSeek Harness ≠ model-§. |
| A5 | Vergelijking | Harnesses/IDE’s tot op het bot: technisch + benchmarks | Matrix `vergelijking-harness-ide.md` met §-links. Ankers: **§80–§86** + **§133** (PKU Harness-Bench / Fireship Table 2). |
| A4 | IDE-anatomie | Talen, fork-opties, integraties; editor vs harness vs indexing | Shortlist + criteria: [ADR 0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md). Bronnen: native/TUI architecture, plugin/RPC, LSP — niet Electron-first. |
| A3 | Open models / Mistral | Efficiëntie, lokale runtime; EU/stage | DeepSeek **§56–§58, §89–§94**; Kimi/Moonshot **§134–§142**; Mistral **§95–§101** (AA watch + Large 4). |
| A6 | Structure: docs vs code | Waar leeft de standaard — alleen markdown (prompt) of ook afgedwongen in de harness/app? | Zie [ideeen § A6](ideeen-en-vragen.md#a6--verduidelijkt); **§113–§117** + §107; kit `make check`. |
| A7 | Feedback-/kwaliteitslussen | Welke gates wanneer (in-loop → pre-commit → check → check-full → pre-prod) en wat bij rood (revert)? | Zie [ideeen § A7](ideeen-en-vragen.md#a7--verduidelijkt); **§118–§122** + §117; kit P13. |
| A8 | Doc-formaat per publiek | Markdown voor mensen vs machine-first (YAML/JSON/…) voor agent-only artefacten | Zie [ideeen § A8](ideeen-en-vragen.md#a8--verduidelijkt); **§123–§127** + §14–§24. |
| A9 | Session-scope / spine | Waar hangt agent-state — IDE-chat, repo-root, subfolder, of expliciete spine-files? | Zie [ideeen § A9](ideeen-en-vragen.md#a9--verduidelijkt); **§128–§132** + §117; P27. |
| — | Overige | Nieuwe hits | Eerst § in AE; dan wantlist/radar hier. |
| B | Keuzes | Stack, fork/basis, wat verbeteren, meetplan | ADR + `meten/` — **niet** vóór A5. |

Uitvoervolgorde sessies: **A1 → A2 → A5 → A4 → A3**, daarna A6–A9 (of parallel dunne wantlist). B alleen na mens-ja.

## Bronsoorten (niet alles is YouTube)

| Slice | Typische bronnen | §-vorm |
|-------|------------------|--------|
| A1–A2 | Productdocs, engineering blogs, repo README, (video als mechanisme) | Dichte § zoals §69 |
| A3 | Papers, model-cards, inference-blogs (bestaande §56+ e.d.) | § + eventueel fundament |
| A4 | VS Code/Zed architecture, extension API, LSP-spec, fork-vergelijkingen | § per bron of bundel; geen marketing-TL;DR |
| A5 | SWE-bench / ACI / harness-papers + eigen meetcondities | Matrix hier + cijfers alleen met § |
| A6 | Empirie AGENTS (§20); enforcement (§107–§108, **§113–§117**); kit-checks | **Vorm** in ideeen (dual + tabel); experiment na stack |
| A7 | Kit check-ladder; **§118–§122** (+ §117); Strix §47 | **Vorm** (ladder + revert-zin); experiment na stack |
| A8 | §14–§24 + **§123–§127** | **Vorm** (dual-regel + formaat-tabel) |
| A9 | P27; **§128–§132**; §76/§77/§112 | **Vorm** (C′ + `.agent/` gitignore); pijn-notities optioneel |

Prompt voor dichte video-§ blijft: AE `bron/fundament/prompts/youtube-samenvatting.md`. Voor non-video: zelfde eisen (Type, URL, mechanisme, Wat ik meeneem, geen verzinsels).

## Waar schrijven

| Wat | Waar | Niet |
|-----|------|------|
| Feiten, mechanismen, cijfers, benchmarks | **Agent_Engineering** `bron/bronnen.md` (§) + index | Niet dupliceren naar hier |
| Diepte | AE `bron/fundament/` als § te kort is | Always-on in AGENTS |
| Ruwe vragen / hypothesen | [ideeen-en-vragen.md](ideeen-en-vragen.md) | Als feit presenteren |
| Bronnen nog te lezen | [wantlist.md](wantlist.md) | |
| Vergelijkingsmatrix | `vergelijking-harness-ide.md` (nog te maken) met §-links | Cijfers zonder § |
| Harde keuzes | `docs/decisions/*.md` (ADR) | Voor A5 klaar is |
| Uitvoerbaar werk | `make spec` → BACKLOG + `specs/<slug>.md` | Lange essays in BACKLOG |
| Kit/standaard AE wijzigen | Alleen via AE brug + ja mens | Nooit vanuit dit lab “even de kit” |

## Al bekende AE-ankers (niet opnieuw leeg §’en)

- IDE-docs / rules: §9, §13, §14, §20  
- Harness / tax / Pi: §5, §25, §30, §33; bouw/thesis **§105–§112**; A6 **§113–§117**; A7 gates **§118–§122** (enforcement §107)  
- DeepSeek **modellen**/infra: §56–§58, §60, **§89–§94** (≠ coding-harness §77)  
- Kimi/Moonshot (A3 peer): **§134–§142** (lineage, K2→K3.1, MuonClip, KDA, Kimi Code, AA Cyber)  
- Mistral (EU/A3): **§95–§101**; AA provider watch §95 + coding §80  
- Cursor search/index nu: **§69**  
- Meten: AE `meten/` + §19/§20; A7-ladder ↔ C4 “zonder check”  
- Docs-vorm: §14–§16, §22–§24; A8 **§123–§127**; A9 session-scope **§128–§132** (P27)  

Volgend vrij §-nummer: zie AE `bron/INDEX.md` (nu: na **§142**). Clusters: A5 **§80–§86** + **§133**; DeepSeek **§89–§94**; Kimi **§134–§142**; Mistral **§95–§101**; listicles **§102–§104**; harness-bouw **§105–§112**; A6–A9 **§113–§132**.

## Hypothesen (nog geen ADR) — aangescherpt 2026-10-26

Zie detail + tabellen in [ideeen-en-vragen.md](ideeen-en-vragen.md). Kort:

- **v1:** eigen **indexing** (exact-first) + hergebruikte harness (Pi-/DSH-achtig) + **upstream Zed** als IDE-shell ([ADR 0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md)) — geen IDE-fork, geen IDE from-scratch, geen Electron, geen inference-serving. Shortlist: [ADR 0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md).  
- **Verbeterhoek vs Cursor:** indexing als kern (§69); + structure-enforcement + check-ladder + folder-spine + dual formats — niet feature-pariteit.  
- **Default LLM:** DeepSeek API (cost); Kimi peer voor kwaliteit/cyber (§142); frontier optioneel.  
- **H×M:** ranking-transfer ≈0 (§83); meet altijd harness mee (§81).  
- **A6 vorm:** dual — AGENTS ≤ ~100 regels TOC; harde regels in check/hooks.  
- **A7 vorm:** `make check` verplicht eind-slice; check-full/opt-in zwaarder; rood → geen push / restore.  
- **A8 vorm:** publiek → formaat; ADR blijft MD.  
- **A9 vorm:** spine in `<cwd>/.agent/` (gitignore); chat mag leeg na padwissel.

## Doel van dit lab (context)

Solo leerlab (+ later thesis-lezer; productisatie voorwaardelijk). Succes = meetbare agent-loop die de standaard respecteert. Zie [CONTEXT.md](../context/CONTEXT.md).
