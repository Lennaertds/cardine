# Backlog

> **Rol:** **Index** van open werk: één korte regel per item + link naar de spec. Geen plan, slices of essay hier.
> **Niet hier:** het plan ([specs/](specs/)), afgewerkt werk (git en `logs/`), besluiten (`decisions/`).

Nieuw item op **Nu** (of Geparkeerd met een plan): alleen via `make spec s=<slug>` — die zet de indexregel én de spec. Handmatig een lange rij in deze tabel plakken is fout. **Straks** mag één korte regel zonder spec (tot je hem promoveert met `make spec`). Categorie is een kolom, geen map.

## Volgorde (totaalproduct)

Werk **één stap tegelijk**. Samenhang en groepen: [totaalproduct.md](../product/totaalproduct.md).

| Stap | Spec | Waarom deze plek |
|------|------|------------------|
| 0 | [totaalproduct-onderdelen](specs/totaalproduct-onderdelen.md) | Kader — heringedeeld (groepen + volgorde) |
| 1 | [ide-shell](../product/ide-shell.md) | gedaan — upstream Zed, geen fork ([ADR 0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md)) |
| 2 | [fs-events](../product/fs-events.md) | gedaan — Zed-watch, geen eigen watcher |
| 3 | [onderdeel-agent-ui](specs/onderdeel-agent-ui.md) | gedaan — Zed Agent Panel via ACP; geen eigen UI |
| 4 | [onderdeel-harness](specs/onderdeel-harness.md) | Import, geen onderzoekstraject. Voorstel: DSH `acp`, geen fork. ADR na ja |
| 5 | [onderdeel-llm](specs/onderdeel-llm.md) + [onderdeel-tools](specs/onderdeel-tools.md) | Gevolg van stap 4. LLM hoort bij DSH, niet bij Zed |
| 6 | [onderdeel-indexing](specs/onderdeel-indexing.md) | Enige onderzoekswedge. MCP die DSH mount |
| 7 | [onderdeel-structure](specs/onderdeel-structure.md) | Ontwerp op de harness, na het ja van stap 4 |
| 8 | [onderdeel-session-spine](specs/onderdeel-session-spine.md) | Ontwerp op de harness, na stap 7 |
| — | [bootstrap-geen-stack-tot-adr](specs/bootstrap-geen-stack-tot-adr.md) | Doorlopend: geen `apps`/generators tot ADR |

Geen code/`--starter` tot de relevante ADR’s. Research-ankers (gedaan): A2; A4-shell is [ADR 0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md).

## Nu

| Volg | Item | Categorie | Status |
|------|------|-----------|--------|
| 0 | [totaalproduct-onderdelen](specs/totaalproduct-onderdelen.md) | product | kader + herindeling gedaan |
| ✓ | IDE-shell ([ide-shell](../product/ide-shell.md)) | product | gedaan — [ADR 0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md) |
| ✓ | FS/events ([fs-events](../product/fs-events.md)) | product | gedaan — Zed-watch |
| ✓ | [onderdeel-agent-ui](specs/onderdeel-agent-ui.md) | product | gedaan — Zed-panel via ACP |
| **4** | [onderdeel-harness](specs/onderdeel-harness.md) | product | **volgende ja** — voorstel DSH-import; nog geen ADR |
| 5 | [onderdeel-tools](specs/onderdeel-tools.md) | product | volgt 4 |
| 5 | [onderdeel-llm](specs/onderdeel-llm.md) | product | volgt 4 — niet Zed |
| 6 | [onderdeel-indexing](specs/onderdeel-indexing.md) | product | onderzoek loopt — X1/X2; consument = DSH-MCP |
| 7 | [onderdeel-structure](specs/onderdeel-structure.md) | product | na ja op 4 |
| 8 | [onderdeel-session-spine](specs/onderdeel-session-spine.md) | product | na 7 |
| — | [bootstrap-geen-stack-tot-adr](specs/bootstrap-geen-stack-tot-adr.md) | bootstrap | open (guardrail) |
| ✓ | [cursor-vervang-lagen](specs/cursor-vervang-lagen.md) | research | gedaan — A4-shortlist; shell-keuze in [ADR 0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md) |
| ✓ | [onderzoek-a2-harnesses](specs/onderzoek-a2-harnesses.md) | research | gedaan (§76–§79); voedt stap 4 |

## Straks

| Item | Categorie | Waarom later |
|------|-----------|--------------|
| A5-matrix H×M (na genoeg harness/LLM-richting) | research | Voedt ADR stap 4/6 |
| B: ADR’s na ja — eerst harness-import (stap 4), dan indexing | decisions | Pas na expliciete ja |
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
