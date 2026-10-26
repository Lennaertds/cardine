# Onderzoeksprogramma — spoor 3 (vóór stack/fork)

> **Rol:** Richtlijn voor agents: wat onderzoeken, in welke volgorde, waar schrijven.
> **Niet hier:** feiten/samenvattingen (die horen in Agent_Engineering `bron/`); harde stack-keuzes (ADR pas ná genoeg §).

Stand: oktober 2026. Kennis-SSOT = sibling **Agent_Engineering** (`bron/bronnen.md`, index, fundament). Deze repo = lab + hypothesen + later code.

## Regel: A vóór harde B

1. **A — onderzoek** → nieuwe `§` in Agent_Engineering `bron/bronnen.md` (+ rij in `bronnen-index.md` + totaaloverzicht).
2. **Hypothesen** → hier: `wantlist.md`, dit bestand, eventueel korte notities onder `research/`.
3. **B — keuzes** → ADR in `docs/decisions/` pas als A1–A2–A5 genoeg assen hebben. Geen `--starter` / stack tot expliciete ja van de mens.
4. **Bouwen** → daarna in `apps/` / harness-code.

Parallel mag een dunne wantlist/hypothese; geen “we forken X”-ADR op gevoel.

## Volgorde (verplicht)

| # | Slice | Vraag | Opmerkingen |
|---|--------|-------|-------------|
| A1 | Cursor | Wat heeft Cursor; wat kunnen wij hergebruiken vs. verbeteren vs. *niet* sturen (index, loop)? | §9, §13 + **§69** Instant Grep (lokaal; embeddings-search afgebouwd). |
| A2 | Andere harnesses | Pi, DeepSeek Harness, peers (Cline/OpenCode/…). Wat hergebruiken/verbeteren? | Pi al §33 — “Wat ik meeneem voor lab” aanscherpen; DeepSeek **Harness** ≠ DeepSeek-model-§ (§56+). |
| A5 | Vergelijking | Harnesses/IDE’s tot op het bot: technisch + benchmarks | Pas na A1–A2; matrix in deze repo met §-links. |
| A4 | IDE-anatomie | Talen, fork-opties, integraties; editor vs harness | Geen full-IDE-fork als default-hypothese voor v1. |
| A3 | Open models / Mistral e.d. | Efficiëntie, lokale runtime | Beïnvloedt *modelkeuze in harness*, niet eerst de IDE-vorm. Bestaande inference-§ hergebruiken. |
| — | Overige | Nieuwe hits | Eerst § in AE; dan wantlist/radar hier. |
| B | Keuzes | Stack, basis (Pi vs extension vs …), wat we verbeteren, meetplan | ADR + `meten/`-condities (Cursor+kit vs dit lab). |

## Waar schrijven

| Wat | Waar | Niet |
|-----|------|------|
| Feiten, mechanismen, cijfers, benchmarks | **Agent_Engineering** `bron/bronnen.md` (§) + index | Niet dupliceren naar hier |
| Diepte | AE `bron/fundament/` als § te kort is | Always-on in AGENTS |
| Bronnen nog te lezen | Deze repo `docs/research/wantlist.md` | |
| Vergelijkingsmatrix (werkblad) | Deze repo `docs/research/` (bv. `vergelijking-harness-ide.md`) met links naar § | Cijfers zonder §-bron |
| Hypothesen / open vragen | `RESEARCH.md`, dit bestand, wantlist | Als feit presenteren |
| Harde keuzes | `docs/decisions/*.md` (ADR) | Voor A5 klaar is |
| Uitvoerbaar werk | `make spec` → BACKLOG-index + `specs/<slug>.md` | Lange essays in BACKLOG |
| Kit/standaard AE wijzigen | Alleen via AE brug + ja mens | Nooit vanuit dit lab “even de kit” |

Prompt voor dichte video-§: AE `bron/fundament/prompts/youtube-samenvatting.md`. Elke §: **Type**, **URL**, inhoud, **Wat ik meeneem** (spoor 3 + eventueel “geen kit”).

## Al bekende AE-ankers (niet opnieuw leeg §’en)

- IDE-docs / rules: §9, §13, §14, §20  
- Harness / tax / Pi: §5, §25, §30, §33  
- DeepSeek **modellen**/infra: §56–§58, §60 (≠ coding-harness)  
- Meten: AE `meten/` + §19/§20  

Volgend vrij §-nummer: zie AE `bron/INDEX.md` / einde `bronnen.md` (nu: na §69).

## Hypothesen (nog geen ADR)

- v1 = minimale harness **of** editor-extension — geen full IDE-fork.  
- Verbeterhoek = **structure/indexing t.o.v. projectstandaard**, niet feature-pariteit met Cursor.  
- Stack waarschijnlijk TypeScript als basis≈Pi — pas vast na A2/A5.  

## Doel van dit lab (context)

Solo leerlab (+ later thesis-lezer). Succes = meetbare agent-loop die de standaard respecteert; geen product voor derden tot aparte productisatie-ADR.
