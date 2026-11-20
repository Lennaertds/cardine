# Agent-UI

> **Rol:** Bijhouden van de menselijke agent-oppervlakte — chat, diffs, apply/reject.
> **Niet hier:** IDE-shell ([ide-shell.md](ide-shell.md)); samenhang ([totaalproduct.md](totaalproduct.md)).

**Stand:** beslist · geen aparte ADR (volgt [ADR 0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md): ACP, geen fork)

## Wat de gebruiker kan

- Met de agent praten, streaming zien, diffs reviewen en wijzigingen accept/reject — in het Zed Agent Panel. De loop erachter is de External Agent, niet Zed Agent.

## Besluit

| Onderwerp | Keuze |
|-----------|--------|
| U1 Oppervlak | Zed Agent Panel via ACP. Geen eigen chat-UI en geen extra TUI in v1. |
| U2 Diffs | Review van Zed (multi-buffer diff, apply/reject). |
| U3 Streaming | Wat Zed en de ACP-server al doen. |
| U4 Multi-agent | Nee in v1. Eén gesprek. |

## Raakvlakken

- Host: [ide-shell.md](ide-shell.md)
- Loop: [harness.md](harness.md) (`dsh --profile acp`)
- Toont resultaten van: [tools.md](tools.md)

## Bewust niet

- Eigen Composer of chat-app.
- Marketplace van chat-themes.
- Parallel Cloud Agent dashboards.
- Zed Agent aanzetten naast de External Agent (twee loops, twee zoekpaden — zie [totaalproduct](totaalproduct.md)).
