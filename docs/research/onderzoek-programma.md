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
| A1 | Cursor | Wat heeft Cursor; hergebruik vs verbeteren vs *niet* sturen? | §9, §13, **§69**. Optioneel later verdiepen. |
| A2 | Andere harnesses | Pi, DeepSeek Harness, peers. Hergebruik/verbeteren? | Nu open ([spec](../work/specs/onderzoek-a2-harnesses.md)). §33 aanscherpen; Harness ≠ model-§56+. |
| A5 | Vergelijking | Harnesses/IDE’s tot op het bot: technisch + benchmarks | Matrix `vergelijking-harness-ide.md` met §-links. |
| A4 | IDE-anatomie | Talen, fork-opties, integraties; editor vs harness | Bronnen: architecture docs, extension API, LSP — niet alleen YouTube. |
| A3 | Open models / Mistral | Efficiëntie, lokale runtime | Model *in* harness; inference-§ hergebruiken. |
| A6 | Principes in app | Pijlers vast in applicatie vs alleen projectdocs — overhead? | Hypothese structure-domein; meten. |
| A7 | Check/test-lus | Continu testen, revert vóór push, wat naast `make check` / pre-prod? | Kit + § + `meten/`; geen essays in BACKLOG. |
| A8 | Agent-docformaat | Markdown vs ander formaat; user-nooit-gelezen files (logs, decisions) | Diátaxis/AGENTS-§; dual/machine-first hypothese. |
| A9 | Session / scope | Agent-history per folder i.p.v. project; tijdelijke state-files | Productpijn + lab-spine (P27). |
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
| A6–A9 | Mix: papers, kit-eigen praktijk, experiment-notities | § waar feiten; hypothese blijft in ideeen-bestand tot bewezen |

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
- Harness / tax / Pi: §5, §25, §30, §33  
- DeepSeek **modellen**/infra: §56–§58, §60 (≠ coding-harness)  
- Cursor search/index nu: **§69**  
- Meten: AE `meten/` + §19/§20  
- Docs-vorm: §14–§16, §22–§24  

Volgend vrij §-nummer: zie AE `bron/INDEX.md` / einde `bronnen.md` (nu: na §69).

## Hypothesen (nog geen ADR)

- v1 = minimale harness **of** editor-extension — geen full IDE-fork.  
- Verbeterhoek = **structure/indexing t.o.v. projectstandaard**, niet feature-pariteit met Cursor (§69).  
- Stack waarschijnlijk TypeScript als basis≈Pi — pas vast na A2/A5.  
- A6: vaste pijlers in de app kunnen *minder* prompt-overhead geven dan alles in project-markdown — te meten.  
- A8: machine-first formaat voor agent-only docs (logs/decisions) mag; user-facing blijft Markdown.  
- A9: expliciete session/spine-files > hopen op IDE-chatgeschiedenis over workspace-grenzen.

## Doel van dit lab (context)

Solo leerlab (+ later thesis-lezer; productisatie voorwaardelijk). Succes = meetbare agent-loop die de standaard respecteert. Zie [CONTEXT.md](../context/CONTEXT.md).
