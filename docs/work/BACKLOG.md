# Backlog

> **Rol:** **Index** van open werk: één korte regel per item + link naar de spec. Geen plan, slices of essay hier.
> **Niet hier:** het plan ([specs/](specs/)), afgewerkt werk (git en `logs/`), besluiten (`decisions/`).

Nieuw item op **Nu** (of Geparkeerd met een plan): alleen via `make spec s=<slug>` — die zet de indexregel én de spec. Handmatig een lange rij in deze tabel plakken is fout. **Straks** mag één korte regel zonder spec (tot je hem promoveert met `make spec`). Categorie is een kolom, geen map.

## Nu

| Item | Categorie | Status |
|------|-----------|--------|
| [totaalproduct-onderdelen](specs/totaalproduct-onderdelen.md) | product | open — kaart + 9 onderdeel-specs; slice 1 |
| [onderdeel-ide-shell](specs/onderdeel-ide-shell.md) | product | open — keuzes I1–I6 |
| [onderdeel-fs-events](specs/onderdeel-fs-events.md) | product | open — keuzes F1–F5 |
| [onderdeel-indexing](specs/onderdeel-indexing.md) | product | open — keuzes X1–X7; zie `product/indexing.md` |
| [onderdeel-tools](specs/onderdeel-tools.md) | product | open — keuzes T1–T5 |
| [onderdeel-harness](specs/onderdeel-harness.md) | product | open — keuzes H1–H5; DSH-neiging |
| [onderdeel-llm](specs/onderdeel-llm.md) | product | open — keuzes L1–L5; DeepSeek-hypothese |
| [onderdeel-structure](specs/onderdeel-structure.md) | product | open — keuzes S1–S4 |
| [onderdeel-agent-ui](specs/onderdeel-agent-ui.md) | product | open — keuzes U1–U4 |
| [onderdeel-session-spine](specs/onderdeel-session-spine.md) | product | open — keuzes P1–P4 |
| [cursor-vervang-lagen](specs/cursor-vervang-lagen.md) | research | gedaan (kaart → totaalproduct); A4-shortlist blijft |
| [onderzoek-a2-harnesses](specs/onderzoek-a2-harnesses.md) | research | gedaan (§76–§79); volgende A5 |
| [bootstrap-geen-stack-tot-adr](specs/bootstrap-geen-stack-tot-adr.md) | bootstrap | open |

## Straks

| Item | Categorie | Waarom later |
|------|-----------|--------------|
| A4-scorematrix + A5 — start bij [onderdeel-ide-shell](specs/onderdeel-ide-shell.md) / indexing | research | B na ja |
| B: ADR per onderdeel (IDE, indexing-compose, harness, LLM, …) | decisions | Pas na scores + expliciete ja |
| Runtime-keuze + `--starter` / generators | apps | ADR vereist vóór code |
| LLM-providerconfig keys via `.env` | harness | Na LLM-ADR; keys nooit in git |
| Productdocs per onderdeel vullen na onderzoek/ADR | product | 9× `product/*.md` bestaan (vorm); verdiepen per slice |
| Seam-tests (harness↔structure/indexing, …) | architecture | Pas na stack |
| OTel / `make obs-*` | observability | Geen app |
| Performance-budgets + `bench.sh` | performance | Geen meetpad zonder runtime |
| Strix-install + key voor `security-scan*` | security | Geen netwerk-facing app nog |
| Digest-feeds + week-cron | research | gedaan |

## Geparkeerd

| Item | Categorie | Wacht op |
|------|-----------|----------|
| Thesis-deliverable als toetsbaar doel | product | Lab meetbaar + runtime |
| Pi-fork | apps | Expliciete runtime-keuze = Pi |
| Productisatie: portfolio + gratis release (OS of closed) | product | Lab-kwaliteit “echt goed” + expliciete keuze |
| Prod-hosting / multi-user auth | architecture | Productisatie-ADR |
