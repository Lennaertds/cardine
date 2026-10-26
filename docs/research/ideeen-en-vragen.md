# Ideeën en open vragen (niet kwijtraken)

> **Rol:** Jouw ruwe vragen/hypothesen voor spoor 3 — vastgelegd vóór ze in § of ADR landen.
> **Niet hier:** feiten met URL (§ in Agent_Engineering `bron/`); harde keuzes (`docs/decisions/`); uitvoerplan (`specs/`).

Stand: 2026-10-26. Bron van **volgorde**: [onderzoek-programma.md](onderzoek-programma.md). Status per vraag: `open` / `deels (§…)` / `later B`.

## A — Onderzoek (feiten → AE `bron/`)

| # | Jouw vraag (parafrase) | Slice | Status | Opmerking |
|---|------------------------|-------|--------|-----------|
| 1 | Wat heeft Cursor; hergebruik vs verbeteren vs niet sturen? | A1 | deels (§9, §13, **§69**) | Eventueel later: Agent-tools, Cloud Agents, composer — alleen als gat blijft |
| 2 | Andere harnesses (DeepSeek Harness, Pi, peers); hergebruik/verbeteren? | A2 | open | Nu: [spec A2](../work/specs/onderzoek-a2-harnesses.md). DeepSeek **Harness** ≠ model-§56+ |
| 3 | Mistral + open-source modellen / efficiëntie? | A3 | open | Na A5; hergebruik inference-§ |
| 4 | Hoe zit een IDE in elkaar: talen, fork, integraties? | A4 | open | Bronnen ≠ alleen YouTube: VS Code architecture, extension API, LSP, fork-opties |
| 5 | IDEs/harnesses tot op het bot vergelijken (technisch + benchmarks) | A5 | open | Matrix hier: `vergelijking-harness-ide.md` (nog te maken); cellen = §-links |
| 6 | Principes/pijlers **in de app vastzetten** i.p.v. alleen in projectdocs — minder overhead? | A6 | open | Hypothese lab: structure-domein. Meten vs “alles in AGENTS.md” |
| 7 | Continu testen; fouten terugdraaien vóór push; grote pre-prod run; wat naast `make check`? | A7 | open | Overlap kit (`check` / `check-full` / Strix / hooks); § + eventueel AE `meten/` |
| 8 | Ander formaat dan Markdown voor agent-docs? Welke files user nooit leest (logs, decisions) → ander format ok? | A8 | open | Raakt Diátaxis/AGENTS (§14–§24); hypothese: dual format of machine-first |
| 9 | Agent-history/context vast aan **folder** i.p.v. project; omhoog = lege history — tijdelijke state-files? | A9 | open | Productpijn Cursor/workspace; lab: session/spine-bestanden (P27) |

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

## Hoe we dit aanpakken (kort)

Zie [onderzoek-programma.md](onderzoek-programma.md) § “Bronsoorten”. Samengevat: YouTube/artikels blijven §-waardig waar ze mechanismen geven; voor A4–A5–A7–A9 ook **docs, papers, repo-README’s, benchmarks, eigen metingen** — niet forceren in één video-§.
