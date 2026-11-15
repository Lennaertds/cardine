# Tools

> **Rol:** Bijhouden van de exec-laag — wat de agent mag doen (read/edit/shell/MCP) en onder welke goedkeuring.
> **Niet hier:** werkplan ([onderdeel-tools](../work/specs/onderdeel-tools.md)); harness-loop ([harness.md](harness.md)); samenhang ([totaalproduct.md](totaalproduct.md)).

**Stand:** vorm · **Spec:** [onderdeel-tools](../work/specs/onderdeel-tools.md)

## Wat de gebruiker kan

- De agent kan bestanden lezen/wijzigen en shell gebruiken **binnen** jouw allowlist/approvals — zonder verrassingen of supply-chain risico's buiten de workspace.

## Hypothese

Tool-runtime komt mee met de gekozen harness (gebundeld in `agentic-core`); v1 is basic. Complexiteit = permissions + sandbox-isolatie + logging, niet een nieuw framework. Indexing-zoeken liever via [indexing.md](indexing.md)-tools dan alleen ruwe `rg`.

## Stand van zaken

| Onderwerp | Status | Notitie |
|-----------|--------|---------|
| Whitelist / eigendom (T1) | open | |
| Approval-model (T2) | open | |
| Sandbox (T3) | open | Host (`agentic-core`/Zed) draait native; agent-shell & package-installs (`npm`/`pip`/etc.) in lichte isolatie (Arch: `bwrap`/bubblewrap, optioneel rootless Podman) met alleen workspace-mount. |
| MCP v1 (T4) | open | neiging: uit tot nodig |
| Indexing vs generic search (T5) | open | |

## Raakvlakken

- Host: [harness.md](harness.md)
- Emits: [fs-events.md](fs-events.md)
- Gebruikt: [indexing.md](indexing.md) (search-tools)

## Bewust niet

- Eigen MCP-marktplaats.
- Onbeperkte shell zonder pad-beleid.
- Docker/container-vereiste om de IDE of `agentic-core` zelf te draaien (alleen voor untrusted agent-exec).
