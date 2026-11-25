# 0017 — The agent writes inside the cage and the fs write tools are off

- **Status:** accepted
- **Date:** 2026-11-23
- **Touches:** [security.md](../architecture/security.md), [tools.md](../product/tools.md), [0007](0007-tool-approval-is-a-workspace-allowlist-and-the-shell-runs-under-bwrap.md), [0016](0016-secrets-live-outside-the-repos-and-the-filesystem-tools-are-closed.md), `packages/lab/cardine-bwrap`, `packages/lab/install-lab.sh`, `packages/lab/scripts/check-sandbox.sh`.

## Summary

In the context of a lab agent that must be able to work in one project without an approval prompt, faced with a shell cage whose writes vanished into an overlay and with filesystem tools that touched the host outside that cage, we chose bind mounts plus turning off `write`/`edit`/`apply_patch`, over a clean-up overlay or a guard as the only wall, in order to make a write land on the host immediately and be impossible outside the repo, and we accept that the lab environment uses `approval: never` until upstream can do `auto` without a fork.

## Context

Measured on 2026-11-22 ([day log](../work/logs/2026-11-22.md), [FIX-OMGEVING](../work/specs/FIX-ENVIRONMENT.md)):

- The shell runs in `bwrap` (PID 1). `~/.dsh/.env`, `~/.ssh` and `~/.secrets` are not visible there.
- The workspace sat on a tmp overlay. An append inside the cage was sometimes gone for a later read in the same turn, while the shell could still see it. `git status` on the host did not show the work. That is what caused the lost work.
- `read`/`write`/`edit` run in the DSH host process. That route asked on every edit (`approval: ask`) and was the only one that reliably touched the host.
- `dsh-tool-fs` registers `write` and `edit` unless the profile sets them to `false`. `applyPatch` is off by default. Reading the installed package README (`@deepseek-ai/dsh-tool-fs`): `write: false` and `edit: false` drop the tool. No extra unregister plugin is needed.

Three write models were open:

| Model | What the host sees | Cost |
|-------|------------------|--------|
| bind | every write, immediately | a buggy write is on disk immediately too |
| overlay | nothing, until a sync | a vanishing window; the sync can crash halfway |
| snapshot sync | a copy afterwards | every call copies, including `node_modules` |

## Decision

- **Bind, no overlay.** `cardine-bwrap` mounts the workspace with `--bind`. There is no `--overlay-src` and no sync back. `git status` on the host is the truth.
- **Secrets stay masked.** `.env`/`.env.*` (except `*.example`), SSH keys and certificates in the workspace get a read-only empty file laid over them. That is a mount inside the cage; the host inode stays. A `.env` does not belong in the repo ([0016](0016-secrets-live-outside-the-repos-and-the-filesystem-tools-are-closed.md)).
- **`/tmp` is a shared host directory** (mode 700, per call, cleaned up at the end and stale after an hour). No tmpfs: `make` and `node` must be able to hand a temporary file to the host.
- **An own user namespace.** `--unshare-user`. The cage does not run as the host uid in the kernel map; a write on the bind still carries that uid on the host (measured).
- **The shell's network stays open.** No network isolation in the cage. `npm`, `pip` and other fetches from the shell must work, as must anything the agent does on the internet through a process. This is a fixed lab choice (2026-11-23): an earlier isolation was reverted. `make sandbox-check` requires a successful TCP connect from inside the cage and turns red if the cage cuts the network off after all.
- **Fs write tools off.** In the lab profile: `read` and `readImage` on, `write`, `edit` and `applyPatch` off. `glob`/`grep` stay on and go through the workspace guard.
- **The open session is the guard's workspace.** `read`, `glob` and `grep` follow the thread's cwd. A path set in the Zed server at install time does not override that cwd: the same server opens other projects too (measured on Caddie, 2026-11-23). `CARDINE_WORKSPACE` remains only the fallback when the session has no cwd. The `workspaceRoot` profile field is DSH's fallback for a call without a session.
- **No dialogue.** `approval: never` is the safety net of this lab environment. The PR route upstream gets `auto` later, because Zed demands "never ask" there without a fork. Until then `never` is the lab choice, not a general product rule.
- **Provenance.** The agent does not commit or push. What the cage wrote sits uncommitted in `git status`. `make finish` writes `written via the cage` into the day log and fails if that line cannot be read back.
- **A new party, the same cage.** A subagent or hook that must change files starts inside this cage. No second path with host fs writes.
- **The user namespace is measured.** `make sandbox-check` requires a uid map that is not the host identity `0 0 4294967295`. A cage that does not get the namespace is red. The same check requires a TCP connect to `1.1.1.1:443` from the shell to succeed.

`install-lab.sh` is the only source of the profile. `cardine-strict.patch.yml` is no longer a second truth.

## Alternatives

| Option | Why not |
|-------|-------------|
| An overlay with sync back at the end of every shell | Every call copies; a crash mid-sync loses bytes; the vanishing window of 2026-11-22 returns |
| Only tighten the workspace guard | The in-process tools cannot be caged; a denylist on a keyring |
| Keep `approval: ask` | The requirement is that a session does not ask |
| `danger-full-access` | No boundary; the shell cage becomes decoration |
| Docker around the agent | [0007](0007-tool-approval-is-a-workspace-allowlist-and-the-shell-runs-under-bwrap.md): too heavy; Zed and `dsh` stay native |
| Isolate the shell's network | `npm`, `pip` and fetches from the agent break. The lab choice is that the shell keeps the network |

## Consequences

- **Easier:** a write in the cage lands on the host immediately. `make check` proves both directions, with a counter-test.
- **Harder or risky:** a mistaken shell write is immediately a real file change. The masks and `git status` (no silent commit) are the brake. The shell can reach the internet; that is accepted. A profile change only applies after a new DSH session.
- **To do:** after this code lands, close Zed, run `pkill -f "bin/dsh"`, open one new window, start a new thread, and run `make sandbox-check` on the host.
