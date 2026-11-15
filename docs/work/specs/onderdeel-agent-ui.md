# Spec — onderdeel-agent-ui

> **Rol:** Open keuzes voor chat/diffs/apply-reject.
> **Kaart:** [totaalproduct.md](../../product/totaalproduct.md)

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** open
- **Product (bijhouden):** [../../product/agent-ui.md](../../product/agent-ui.md)
- **Hypothese:** Dun houden — paneel in IDE-shell of TUI van de harness; geen Composer-pariteit. Dit miste in je 1–6-lijst.

## Wat het is

Menselijke kant van de agent: gesprek, streaming, diffs, accept/reject, interrupt. Zonder dit werk je “blind” of alleen via terminal-logs.

## Stappenplan

Laatste onderdeel. Start als [ADR 0002](../../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md) en het H2-voorstel (ACP, apart process) vaststaan. Eén stap per sessie. Uitkomst in [agent-ui.md](../../product/agent-ui.md). Geen eigen chat-app.

### Stap A — Dun oppervlak

1. U1: Zed toont het gesprek via ACP. Een TUI komt er alleen bij als de gekozen harness die al meegeeft én Zed het gesprek niet toont.
2. U2: diffs en apply/reject zijn de review van Zed.
3. U3: streaming is wat Zed en de ACP-server al doen.
4. U4: één gesprek. Multi-agent-tabs blijven uit v1.

### Stap B — Sluiten

Volgt U1 de ACP-weg van ADR 0002, dan krijgt de productdoc dat voorstel en gaat deze spec weg zonder aparte ADR. Apply/reject zonder dataverlies wordt de acceptatie van de eerste echte sessie, later.

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
