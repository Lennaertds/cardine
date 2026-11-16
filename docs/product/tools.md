# Tools

> **Rol:** Bijhouden van de exec-laag — wat de agent mag doen (read/edit/shell/MCP) en onder welke goedkeuring.
> **Niet hier:** werkplan ([onderdeel-tools](../work/specs/onderdeel-tools.md)); harness-loop ([harness.md](harness.md)); samenhang ([totaalproduct.md](totaalproduct.md)).

**Stand:** volgt harness-voorstel · **Spec:** [onderdeel-tools](../work/specs/onderdeel-tools.md)

## Wat de gebruiker kan

- De agent kan bestanden lezen/wijzigen en shell gebruiken **binnen** jouw allowlist/approvals — zonder verrassingen of supply-chain risico's buiten de workspace.

## Hypothese

Geen eigen tool-runtime. De toolset is die van DeepSeek Harness (het [harness-voorstel](harness.md)), ingekort tot read, edit, shell, plus de indexing-tools via MCP. Complexiteit = permissions + sandbox + logging. Zoeken op het agent-pad loopt via [indexing.md](indexing.md); `rg` blijft de meet-fallback, niet het primaire pad. Zed’s built-in grep hoort bij Zed Agent en draait niet mee.

## Stand van zaken

| Onderwerp | Status | Notitie |
|-----------|--------|---------|
| Whitelist / eigendom (T1) | voorstel | DSH-basis; sluit mee met harness-ja |
| Approval-model (T2) | open | paden in de workspace op de allowlist |
| Sandbox (T3) | open | Zed en `dsh` blijven upstream-processen. Shell en package-install (`npm`/`pip`) onder `bwrap` met alleen de workspace. |
| MCP v1 (T4) | voorstel | Aan, alleen voor de indexing-daemon. Geen open MCP-markt. |
| Indexing vs generic search (T5) | voorstel | Zoeken via indexing-tools |

## Raakvlakken

- Host: [harness.md](harness.md)
- Versheid van de boom: [fs-events.md](fs-events.md)
- Gebruikt: [indexing.md](indexing.md) (search-tools)

## Bewust niet

- Eigen tool-framework of MCP-marktplaats.
- Onbeperkte shell zonder pad-beleid.
- Docker/container-vereiste om Zed of `dsh` zelf te draaien (alleen voor untrusted agent-exec).
