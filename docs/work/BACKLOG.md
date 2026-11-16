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
| 4 | [onderdeel-harness](specs/onderdeel-harness.md) | gedaan — upstream DSH, `acp`, geen fork ([ADR 0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md)). Smoke pas bij een volledige applicatie |
| 5 | [onderdeel-llm](specs/onderdeel-llm.md) + [onderdeel-tools](specs/onderdeel-tools.md) | gedaan — tools [0007](../decisions/0007-tool-goedkeuring-is-een-workspace-allowlist-en-de-shell-draait-onder-bwrap.md), LLM [0008](../decisions/0008-het-coding-model-is-deepseek-flash-en-claude-is-de-tweede-provider.md) |
| 6 | [onderdeel-indexing](specs/onderdeel-indexing.md) | gedaan voor X1/X2 — jarvis op het agent-pad ([ADR 0006](../decisions/0006-de-agent-zoekt-via-jarvis-als-mcp-zed-zoeken-en-lsp-blijven-van-de-editor.md)). Baseline vs `rg` open |
| 7 | [onderdeel-structure](specs/onderdeel-structure.md) | gedaan — dual, rode `make check` sluit de slice niet ([ADR 0004](../decisions/0004-de-projectstandaard-is-dual-een-dunne-agents-md-en-een-harde-make-check.md)). Hook-code pas met een applicatie |
| 8 | [onderdeel-session-spine](specs/onderdeel-session-spine.md) | overgeslagen — gesprek = Zed-paneel + DSH-sessie ([ADR 0005](../decisions/0005-het-gesprek-blijft-de-zed-en-dsh-sessie-zonder-repo-spine.md)) |
| — | [bootstrap-geen-stack-tot-adr](specs/bootstrap-geen-stack-tot-adr.md) | Doorlopend: geen `apps`/generators tot ADR |

Geen code/`--starter` tot een runtime-ADR. [0001](../decisions/0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md) blijft; [0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md) is de harness-import, geen app-stack. Research-ankers (gedaan): A2; A4-shell is [ADR 0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md).

## Nu

| Volg | Item | Categorie | Status |
|------|------|-----------|--------|
| 0 | [totaalproduct-onderdelen](specs/totaalproduct-onderdelen.md) | product | kader + herindeling gedaan |
| ✓ | IDE-shell ([ide-shell](../product/ide-shell.md)) | product | gedaan — [ADR 0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md) |
| ✓ | FS/events ([fs-events](../product/fs-events.md)) | product | gedaan — Zed-watch |
| ✓ | [onderdeel-agent-ui](specs/onderdeel-agent-ui.md) | product | gedaan — Zed-panel via ACP |
| ✓ | [onderdeel-harness](specs/onderdeel-harness.md) | product | gedaan — [ADR 0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md) |
| ✓ | [onderdeel-tools](specs/onderdeel-tools.md) | product | gedaan — [ADR 0007](../decisions/0007-tool-goedkeuring-is-een-workspace-allowlist-en-de-shell-draait-onder-bwrap.md) |
| ✓ | [onderdeel-llm](specs/onderdeel-llm.md) | product | gedaan — [ADR 0008](../decisions/0008-het-coding-model-is-deepseek-flash-en-claude-is-de-tweede-provider.md) |
| ✓ | [onderdeel-indexing](specs/onderdeel-indexing.md) | product | X1/X2 gedaan — [ADR 0006](../decisions/0006-de-agent-zoekt-via-jarvis-als-mcp-zed-zoeken-en-lsp-blijven-van-de-editor.md); baseline vs `rg` open |
| ✓ | [onderdeel-structure](specs/onderdeel-structure.md) | product | gedaan — [ADR 0004](../decisions/0004-de-projectstandaard-is-dual-een-dunne-agents-md-en-een-harde-make-check.md) |
| ✓ | [onderdeel-session-spine](specs/onderdeel-session-spine.md) | product | overgeslagen — [ADR 0005](../decisions/0005-het-gesprek-blijft-de-zed-en-dsh-sessie-zonder-repo-spine.md) |
| — | [bootstrap-geen-stack-tot-adr](specs/bootstrap-geen-stack-tot-adr.md) | bootstrap | open (guardrail) |
| ✓ | [cursor-vervang-lagen](specs/cursor-vervang-lagen.md) | research | gedaan — A4-shortlist; shell-keuze in [ADR 0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md) |
| ✓ | [onderzoek-a2-harnesses](specs/onderzoek-a2-harnesses.md) | research | gedaan (§76–§79); voedt stap 4 |

## Straks

| Item | Categorie | Waarom later |
|------|-----------|--------------|
| Zed zelf proberen, als de gepinde upstream | product | Vóór indexing. Klachten staan in [ide-shell](../product/ide-shell.md) |
| ACP-smoke: Zed start `dsh` en ziet één MCP-tool | harness | Pas als er een volledige applicatie is |
| A5-matrix H×M (na genoeg harness/LLM-richting) | research | Voedt ADR stap 4/6 |
| Baseline indexing vs `rg` | product | Stap 4 van [onderdeel-indexing](specs/onderdeel-indexing.md). X1/X2 is [0006](../decisions/0006-de-agent-zoekt-via-jarvis-als-mcp-zed-zoeken-en-lsp-blijven-van-de-editor.md) |
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
| Repo-spine (`.agent/`) | product | Een koppeling die de pad-binding van de chat wél oplost |
