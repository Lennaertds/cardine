# 0007 — Tool approval is a workspace allowlist and the shell runs under bwrap

- **Status:** accepted
- **Date:** 2026-11-16
- **Touches:** [tools.md](../product/tools.md), [totaalproduct.md](../product/totaalproduct.md), [structure.md](../product/structure.md), [PRODUCT.md](../product/PRODUCT.md), [BACKLOG.md](../work/BACKLOG.md). The `onderdeel-tools` spec was removed — the product doc suffices. Closes T2 and T3 from [0003](0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md).

## Summary

In the context of an agent that uses files and a shell, faced with a home directory that must not come along and a harness sandbox whose default is unmeasured, we chose a workspace allowlist and `bwrap` around the shell over the DeepSeek Harness sandbox, in order to bound the cage ourselves to the workspace, and we accept that an install needing the network or a cache outside the directory must deliberately ask for a hole there.

## Context

- T1, T4 and T5 are in [0003](0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md): read, edit, shell, plus the index MCP. Writing outside the workspace is already closed ([0004](0004-the-project-standard-is-dual-a-thin-agents-md-and-a-hard-make-check.md)).
- Three approval models were open: always ask, an allowlist, or auto in the lab. Three cages: none, `bwrap`, or the DSH sandbox.
- `bwrap` is a thin Linux namespace, lighter than Docker. Whether it is faster than the DSH sandbox is unmeasured. The reason is the boundary: only the workspace is mounted. Zed and `dsh` stay ordinary processes.

## Decision

- **T2.** Paths inside the workspace go through. A path outside it stops and asks. Inside the directory the agent does not ask on every edit.
- **T3.** Shell and package install (`npm`, `pip`) run under `bwrap`, with only the workspace mounted. No Docker to run Zed or `dsh` itself. The DeepSeek Harness sandbox is not the cage.

Logs stay free of secrets and of `.env`.

**Affected by [0017](0017-the-agent-writes-in-the-cage-and-the-fs-write-tools-are-off.md).** The overlay described below has been replaced: the workspace is a bind, shell writes land on the host, and `write`/`edit` are off. The secrets masking stays. The shell's network stays open; 0017 fixes that.

**`.env` inside the workspace is closed off.** The workspace is writable, so a `--bind` alone lets the agent both read and overwrite the `.env`. `cardine-bwrap` therefore masks per file `*.env`/`*.env.*` (except `*.example`), SSH keys, `*.pem`, `*.p12` and `*.pfx` with a read-only empty file inside the cage. The host inode stays. Proven by `make sandbox-check`.

## Alternatives

| Option | Why not |
|-------|-------------|
| Always ask | Every edit waits. The allowlist already covers ordinary work |
| Auto in the lab, also outside the directory | No brake on the home directory |
| No sandbox | An approved shell is still the whole account |
| The DeepSeek Harness sandbox | Default unmeasured; a preview update can shift that boundary |

## Consequences

- **Easier:** ordinary edits go through. A shell does not see `~/.ssh`.
- **Harder or risky:** an `npm` or `pip` that needs a cache outside the workspace fails until that directory is deliberately mounted. The network itself stays open ([0017](0017-the-agent-writes-in-the-cage-and-the-fs-write-tools-are-off.md)). `bwrap` is Linux; other operating systems are a later port.
- **To do:** the cage only with the application. No `apps/` through this ADR. [0001](0001-runtime-stack-deliberately-deferred-until-an-explicit-pi-or-ts-choice.md) stays.
