# Tools

> **Rol:** Bijhouden van de exec-laag — wat de agent mag doen (read/edit/shell/MCP) en onder welke goedkeuring.
> **Niet hier:** harness-loop ([harness.md](harness.md)); samenhang ([totaalproduct.md](totaalproduct.md)).

**Stand:** beslist · **ADR:** [0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md) (whitelist) en [0007](../decisions/0007-tool-goedkeuring-is-een-workspace-allowlist-en-de-shell-draait-onder-bwrap.md) (allowlist + `bwrap`) · **Spec weg** — besluit in ADR's, vorm in product-doc

## Wat de gebruiker kan

- De agent kan bestanden lezen/wijzigen en shell gebruiken **binnen** jouw allowlist/approvals — zonder verrassingen of supply-chain risico's buiten de workspace.

## Besluit

Geen eigen tool-runtime. De toolset is die van DeepSeek Harness ([ADR 0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md)), ingekort tot read, edit, shell, plus de indexing-tools via MCP. Paden in de workspace gaan door. Daarbuiten vraagt de agent. Shell en `npm`/`pip` draaien onder `bwrap` met alleen de workspace ([ADR 0007](../decisions/0007-tool-goedkeuring-is-een-workspace-allowlist-en-de-shell-draait-onder-bwrap.md)). Zoeken op het agent-pad loopt via [indexing.md](indexing.md); `rg` blijft de meet-fallback. Zed’s built-in grep hoort bij Zed Agent en draait niet mee.

## Stand van zaken

| Onderwerp | Status | Notitie |
|-----------|--------|---------|
| Whitelist / eigendom (T1) | beslist | DSH read/edit/shell + indexing-MCP — [ADR 0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md) |
| Approval-model (T2) | staat | `workspace-write` + `ask`, vast in het ACP-profiel. How-to: [zed-dsh](../how-to/zed-dsh.md) |
| Sandbox (T3) | staat | `packages/lab/cardine-bwrap`. `~/.ssh` niet zichtbaar. Zed en `dsh` blijven native |
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
