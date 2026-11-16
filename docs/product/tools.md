# Tools

> **Rol:** Bijhouden van de exec-laag — wat de agent mag doen (read/edit/shell/MCP) en onder welke goedkeuring.
> **Niet hier:** werkplan ([onderdeel-tools](../work/specs/onderdeel-tools.md)); harness-loop ([harness.md](harness.md)); samenhang ([totaalproduct.md](totaalproduct.md)).

**Stand:** whitelist beslist in [ADR 0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md); T2 en T3 open · **Spec:** [onderdeel-tools](../work/specs/onderdeel-tools.md)

## Wat de gebruiker kan

- De agent kan bestanden lezen/wijzigen en shell gebruiken **binnen** jouw allowlist/approvals — zonder verrassingen of supply-chain risico's buiten de workspace.

## Hypothese

Geen eigen tool-runtime. De toolset is die van DeepSeek Harness ([ADR 0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md)), ingekort tot read, edit, shell, plus de indexing-tools via MCP. Complexiteit = permissions + sandbox + logging. Zoeken op het agent-pad loopt via [indexing.md](indexing.md); `rg` blijft de meet-fallback, niet het primaire pad. Zed’s built-in grep hoort bij Zed Agent en draait niet mee.

## Stand van zaken

| Onderwerp | Status | Notitie |
|-----------|--------|---------|
| Whitelist / eigendom (T1) | beslist | DSH read/edit/shell + indexing-MCP — [ADR 0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md) |
| Approval-model (T2) | open | paden in de workspace op de allowlist |
| Sandbox (T3) | open | `bwrap` tegenover de sandbox van DSH. Zed en `dsh` blijven upstream-processen. |
| MCP v1 (T4) | beslist | Aan, alleen voor de indexing-daemon. Geen open MCP-markt. |
| Indexing vs generic search (T5) | beslist | Zoeken via indexing-tools; `rg` is de meet-fallback |

## Raakvlakken

- Host: [harness.md](harness.md)
- Versheid van de boom: [fs-events.md](fs-events.md)
- Gebruikt: [indexing.md](indexing.md) (search-tools)

## Bewust niet

- Eigen tool-framework of MCP-marktplaats.
- Onbeperkte shell zonder pad-beleid.
- Docker/container-vereiste om Zed of `dsh` zelf te draaien (alleen voor untrusted agent-exec).
