# 0006 — The agent searches through jarvis as MCP; Zed search and LSP stay with the editor

- **Status:** accepted
- **Date:** 2026-11-16
- **Touches:** [indexing.md](../product/indexing.md), [totaalproduct.md](../product/totaalproduct.md), [PRODUCT.md](../product/PRODUCT.md), [BACKLOG.md](../work/BACKLOG.md). The `onderdeel-indexing` spec was removed — the product doc suffices. [0001](0001-runtime-stack-deliberately-deferred-until-an-explicit-pi-or-ts-choice.md) and [0003](0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md) still apply.

## Summary

In the context of an agent that must find files, faced with Zed search and a language server that belong to the editor, we chose jarvis (Zoekt + SCIP) as MCP on the agent path over replacing the editor's search, in order to have one index for DeepSeek Harness, and we accept that the code stays in the Zed binary and that a dirty file still needs a git overlay.

## Context

- The Arch smoke test (2026-11-16) carried jarvis 0.10.0: `searchCode`, `goToDefinition` and `findReferences` were correct. A gitignored path returned 0 hits. A just-changed file was missing while `getIndexStatus` said `fresh`.
- Zed Agent has its own grep in the same binary. It does not run while only the external agent is on. That has not yet been verified in a running Zed.
- Project search and the LSP while you type belong to the editor. Replacing them was not part of the proposal.

## Decision

Indexing applies to the agent path only.

- The composition is jarvis: Zoekt for text, SCIP for symbols, as an MCP that `dsh --profile acp` mounts. No own engine, no fork, no embeddings in v1.
- Zed Agent stays off. Its grep is not this contract.
- Project search and the LSP in Zed stay on for the human. We do not turn them off and we do not remove them from the binary.

Contract, names taken from the smoke test:

| Tool | Input | Output | Error |
|------|-------|--------|------|
| `searchCode` | query, optional repo | paths | 0 hits, also when the index is empty or the path is in `.gitignore` |
| `goToDefinition` | symbol | path and line | no location |
| `findReferences` | symbol | locations | no location |
| `getIndexStatus` | — | status | do not trust it for freshness |

Freshness of a dirty file comes from `git status` ([fs-events](../product/fs-events.md)), not from `getIndexStatus`.

The repo map (X3) and doc weighting (X4) stay open. Two roots worked in the smoke test; that is an observation, not an extra requirement.

## Alternatives

| Option | Why not |
|-------|-------------|
| Also replace Zed search and the LSP | That is the editor. The proposal covered the agent path only |
| Zed Agent grep as the search path | That gives two indexes, and the grep is not your contract |
| An own Instant Grep or embeddings | The smoke test already carried composition; embeddings are not v1 |
| Fork jarvis | No Arch blocker |

## Consequences

- **Easier:** one MCP for the agent. The editor stays upstream Zed.
- **Harder or risky:** turning Zed Agent on by accident gives a second search path. `getIndexStatus` claims "fresh" on a dirty file until the git overlay is added.
- **To do:** the baseline against `rg` stays step 4, not part of this ADR. No `apps/`. [0001](0001-runtime-stack-deliberately-deferred-until-an-explicit-pi-or-ts-choice.md) stays.
