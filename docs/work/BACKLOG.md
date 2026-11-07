# Backlog

> **Rol:** **Index** van open werk: één korte regel per item + link naar de spec. Geen plan, slices of essay hier.
> **Niet hier:** het plan ([specs/](specs/)), afgewerkt werk (git en `logs/`), besluiten (`decisions/`).

Nieuw item op **Nu** (of Geparkeerd met een plan): alleen via `make spec s=<slug>` — die zet de indexregel én de spec. Handmatig een lange rij in deze tabel plakken is fout. **Straks** mag één korte regel zonder spec (tot je hem promoveert met `make spec`). Categorie is een kolom, geen map.

## Volgorde (totaalproduct)

Werk **één stap tegelijk** (of parallel alleen waar “//” staat). Samenhang: [totaalproduct.md](../product/totaalproduct.md).

| Stap | Spec | Waarom deze plek |
|------|------|------------------|
| 0 | [totaalproduct-onderdelen](specs/totaalproduct-onderdelen.md) | Kader/docs — grotendeels gedaan; alleen bijsturen |
| 1 | [onderdeel-ide-shell](specs/onderdeel-ide-shell.md) | Hangpunt voor UI, events, harness-embed; A4 non-Electron eerst |
| 2 | [onderdeel-indexing](specs/onderdeel-indexing.md) | Primaire waarde; compose Zoekt/SCIP/… (meeste tijd hier) |
| 3 | [onderdeel-fs-events](specs/onderdeel-fs-events.md) | Contract pas zinvol als indexing process-model (X2) richting heeft |
| 4 | [onderdeel-harness](specs/onderdeel-harness.md) | Loop die indexing/tools aansluit; DSH-neiging vs Pi |
| 5 | [onderdeel-tools](specs/onderdeel-tools.md) | // met/na harness — permissions hangen aan H1 |
| 6 | [onderdeel-llm](specs/onderdeel-llm.md) | Default provider nadat harness providers kan hosten |
| 7 | [onderdeel-structure](specs/onderdeel-structure.md) | A6/A7 → ADR als hooks in harness bekend zijn |
| 8 | [onderdeel-session-spine](specs/onderdeel-session-spine.md) | A9 dicht bij structure/harness-sessions |
| 9 | [onderdeel-agent-ui](specs/onderdeel-agent-ui.md) | Laatst: hangt van IDE-shell + harness-surface |
| — | [bootstrap-geen-stack-tot-adr](specs/bootstrap-geen-stack-tot-adr.md) | Doorlopend: geen `apps`/generators tot ADR |

Geen code/`--starter` tot de relevante ADR’s (na stap 1–6 minimaal). Research-ankers (gedaan): A2; A4 zit in stap 1; A5 voedt stap 4/6.

## Nu

| Volg | Item | Categorie | Status |
|------|------|-----------|--------|
| 0 | [totaalproduct-onderdelen](specs/totaalproduct-onderdelen.md) | product | gedaan (kader); bijsturen indien nodig |
| 1 | [onderdeel-ide-shell](specs/onderdeel-ide-shell.md) | product | neiging Zed-host+ACP (fork nee); smoke nog open |
| **2** | [onderdeel-indexing](specs/onderdeel-indexing.md) | product | **nu** — compose jarvis/Zoekt+SCIP; fork nee; volgende: smoke |
| 3 | [onderdeel-fs-events](specs/onderdeel-fs-events.md) | product | na 2 (X2) — F1–F5 |
| 4 | [onderdeel-harness](specs/onderdeel-harness.md) | product | na 2–3 — H1–H5; DSH-neiging |
| 5 | [onderdeel-tools](specs/onderdeel-tools.md) | product | // 4 — T1–T5 |
| 6 | [onderdeel-llm](specs/onderdeel-llm.md) | product | na 4 — L1–L5; DeepSeek-hypothese |
| 7 | [onderdeel-structure](specs/onderdeel-structure.md) | product | na 4 — S1–S4 |
| 8 | [onderdeel-session-spine](specs/onderdeel-session-spine.md) | product | na 7 / // 7 — P1–P4 |
| 9 | [onderdeel-agent-ui](specs/onderdeel-agent-ui.md) | product | na 1+4 — U1–U4 |
| — | [bootstrap-geen-stack-tot-adr](specs/bootstrap-geen-stack-tot-adr.md) | bootstrap | open (guardrail) |
| ✓ | [cursor-vervang-lagen](specs/cursor-vervang-lagen.md) | research | gedaan — A4-shortlist blijft bruikbaar voor stap 1 |
| ✓ | [onderzoek-a2-harnesses](specs/onderzoek-a2-harnesses.md) | research | gedaan (§76–§79); voedt stap 4 |

## Straks

| Item | Categorie | Waarom later |
|------|-----------|--------------|
| A5-matrix H×M (na genoeg harness/LLM-richting) | research | Voedt ADR stap 4/6 |
| B: ADR’s in volgorde stap 1→6 (IDE, indexing, harness, LLM, …) | decisions | Pas na scores + expliciete ja |
| Runtime + `--starter` / generators | apps | Na ADR’s; bootstrap bewaakt |
| LLM keys via `.env` | harness | Na stap 6 ADR |
| Productdocs verdiepen per afgeronde stap | product | `product/*.md` bestaan (vorm) |
| Seam-tests | architecture | Pas na stack |
| OTel / `make obs-*` | observability | Geen app |
| Performance-budgets + `bench.sh` | performance | Geen meetpad zonder runtime |
| Strix-install + key | security | Geen netwerk-facing app nog |
| Digest-feeds + week-cron | research | gedaan |

## Geparkeerd

| Item | Categorie | Wacht op |
|------|-----------|----------|
| Thesis-deliverable als toetsbaar doel | product | Lab meetbaar + runtime |
| Pi-fork | apps | Expliciete runtime-keuze = Pi |
| Productisatie: portfolio + gratis release (OS of closed) | product | Lab-kwaliteit “echt goed” + expliciete keuze |
| Prod-hosting / multi-user auth | architecture | Productisatie-ADR |
