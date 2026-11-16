# Spec — onderdeel-agent-ui

> **Rol:** Besluitnotitie voor chat/diffs/apply-reject. Geen open keuze meer.
> **Kaart:** [totaalproduct.md](../../product/totaalproduct.md)

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** afgerond (geen aparte ADR)
- **Product (bijhouden):** [../../product/agent-ui.md](../../product/agent-ui.md)

## Besluit

De menselijke oppervlakte is het Zed Agent Panel. Zed start de harness als External Agent over ACP ([ADR 0002](../../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md)). Geen eigen chat-UI in v1.

| # | Vraag | Keuze |
|---|-------|--------|
| U1 | In-IDE paneel vs harness TUI/web vs beide? | Zed-paneel via ACP. Geen TUI erbij. |
| U2 | Diff-vorm? | Review van Zed. |
| U3 | Streaming in v1? | Wat ACP + Zed al leveren. |
| U4 | Multi-agent tabs? | Nee. |

Apply/reject zonder dataverlies hoort bij de eerste echte sessie, niet bij een aparte UI-ADR.
