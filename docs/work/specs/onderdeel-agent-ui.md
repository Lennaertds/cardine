# Spec — onderdeel-agent-ui

> **Rol:** Open keuzes voor chat/diffs/apply-reject.
> **Kaart:** [totaalproduct.md](../../product/totaalproduct.md)

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** open
- **Product (bijhouden):** [../../product/agent-ui.md](../../product/agent-ui.md)
- **Hypothese:** Dun houden — paneel in IDE-shell of TUI van de harness; geen Composer-pariteit. Dit miste in je 1–6-lijst.

## Wat het is

Menselijke kant van de agent: gesprek, streaming, diffs, accept/reject, interrupt. Zonder dit werk je “blind” of alleen via terminal-logs.

## Open beslissingen

| # | Vraag | Opties | Blokkeert |
|---|-------|--------|-----------|
| U1 | In-IDE paneel vs harness TUI/web vs beide? | hangt van I2/H2 | UX |
| U2 | Diff: inline vs side-by-side vs external `git difftool`? | | edit-flow |
| U3 | Streaming tokens in UI v1? | ja/nee | H1 |
| U4 | Multi-agent tabs? | nee v1 | scope |

## Acceptatie (later)

- [ ] U1 gekozen met IDE+harness-ADR
- [ ] Apply/reject zonder dataverlies
