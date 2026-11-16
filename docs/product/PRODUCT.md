# Product

> **Rol:** Wat het product doet, per onderdeel/domein, gezien vanuit de gebruiker.
> **Niet hier:** hoe het gebouwd is ([ARCHITECTURE.md](../architecture/ARCHITECTURE.md)), hoe het eruitziet (`design/`).

## Fasen

| Fase | Wat | Status |
|------|-----|--------|
| Lab | Solo, lokaal, meetbaar; eigen LLM-keys (DeepSeek of andere) | nu |
| Thesis | Zelfde lab, leesbaar/toetsbaar voor beoordelaar | later |
| Product | Portfolio + gratis app voor anderen (OS of closed nader) | alleen als kwaliteit het waard is |

## Persoonlijk totaalproduct

**Samenhang:** [totaalproduct.md](totaalproduct.md) — hoe de 9 onderdelen samen één lokaal solo-product vormen.  
**Per onderdeel bijhouden:** één bestand hieronder (niet alleen in specs).

| # | Onderdeel | Productdoc | Spec |
|---|-----------|------------|------|
| 1 | IDE-shell | [ide-shell.md](ide-shell.md) | afgerond — [ADR 0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md) |
| 2 | FS/events | [fs-events.md](fs-events.md) | afgerond — Zed-boom, geen eigen watcher (geen ADR) |
| 8 | Agent-UI | [agent-ui.md](agent-ui.md) | afgerond — Zed Agent Panel via ACP (geen ADR) |
| 5 | Harness | [harness.md](harness.md) | beslist — [ADR 0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md) |
| 4 | Tools | [tools.md](tools.md) | beslist — [ADR 0007](../decisions/0007-tool-goedkeuring-is-een-workspace-allowlist-en-de-shell-draait-onder-bwrap.md) |
| 6 | LLM | [llm.md](llm.md) | beslist — [ADR 0008](../decisions/0008-het-coding-model-is-deepseek-flash-en-claude-is-de-tweede-provider.md) |
| 3 | Indexing | [indexing.md](indexing.md) | beslist, agent-pad — [ADR 0006](../decisions/0006-de-agent-zoekt-via-jarvis-als-mcp-zed-zoeken-en-lsp-blijven-van-de-editor.md) |
| 7 | Structure | [structure.md](structure.md) | beslist — [ADR 0004](../decisions/0004-de-projectstandaard-is-dual-een-dunne-agents-md-en-een-harde-make-check.md) |
| 9 | Session/spine | [session-spine.md](session-spine.md) | overgeslagen — [ADR 0005](../decisions/0005-het-gesprek-blijft-de-zed-en-dsh-sessie-zonder-repo-spine.md) |

Kern-domeinen (GLOSSARY-waarde): `indexing`, `structure`. Harness = geïmporteerde DSH ([ADR 0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md)). Shell, FS en Agent-UI = Zed-host. LLM hoort bij die harness, niet bij Zed Agent. Overige = seams.

## Bewust niet

- Geen productrelease of prod-hosting in de labfase (wel later mogelijk, gratis, OS of closed).
- Geen betalende SaaS als uitgangspunt; gebruiker brengt eigen API-keys mee.
- Geen feature-bloat “voor anderen”; IDE-shell is dunne host.
- Geen IDE-fork: Zed blijft upstream ([ADR 0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md)). Geen Pi-/DSH-fork als vastgelegde stack tot een eigen ADR.
- Geen overname of duplicatie van data, secrets of broninhoud uit andere projecten / Agent_Engineering.
- Geen keuze “open vs closed” vastleggen tot productisatie.
- Geen eigen inference-serving.
