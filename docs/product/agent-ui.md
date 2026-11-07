# Agent-UI

> **Rol:** Bijhouden van de menselijke agent-oppervlakte — chat, diffs, apply/reject.
> **Niet hier:** werkplan ([onderdeel-agent-ui](../work/specs/onderdeel-agent-ui.md)); IDE-fork ([ide-shell.md](ide-shell.md)); samenhang ([totaalproduct.md](totaalproduct.md)).

**Stand:** vorm · **Spec:** [onderdeel-agent-ui](../work/specs/onderdeel-agent-ui.md)

## Wat de gebruiker kan

- Met de agent praten, streaming zien, diffs reviewen en wijzigingen accept/reject — zonder blind op terminal-logs te vertrouwen.

## Hypothese

Dun houden: paneel in IDE-shell **of** harness TUI/web, eventueel beide later. Geen Composer/Cloud-pariteit. Multi-agent tabs niet v1.

## Stand van zaken

| Onderwerp | Status | Notitie |
|-----------|--------|---------|
| In-IDE vs TUI/web U1 | open | hangt van IDE + harness |
| Diff-vorm U2 | open | |
| Streaming U3 | open | |
| Multi-agent U4 | open | neiging: nee v1 |

## Raakvlakken

- Host: [ide-shell.md](ide-shell.md) en/of [harness.md](harness.md)
- Toont resultaten van: [tools.md](tools.md)
- Mag “index stale” tonen via: [fs-events.md](fs-events.md)

## Bewust niet

- Marketplace van chat-themes.
- Parallel Cloud Agent dashboards.
