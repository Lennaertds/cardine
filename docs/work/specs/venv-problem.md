# Spec — venv breaks inside the cage

> **Role:** why a repo's `.venv` looked broken in a DSH session and how that is fixed. Keep while the fix is rolling out; the code and `make sandbox-check` are the truth after that.

- **Status:** fixed in cardine-lab 0.5.4 — the user still needs a new DSH session (the cage is read at session start).
- **Decision:** [ADR 0017](../../decisions/0017-the-agent-writes-in-the-cage-and-the-fs-write-tools-are-off.md) (amended: no mask inside a dependency tree).
- **How-to:** [sandbox-troubleshoot § 1d](../../how-to/sandbox-troubleshoot.md#1d-a-venv-breaks-delete-fails-device-or-resource-busy).

## Goal

A venv in the workspace behaves inside a DSH shell exactly as it does on the
host: create it, `pip install`, `rm -rf` it, recreate it — and the agent stops
"repairing" it.

## What was wrong

The venv itself was never broken. `cardine-bwrap` masked **every** `*.pem` in
the workspace as a secret, and every venv ships
`…/site-packages/pip/_vendor/certifi/cacert.pem`. pip and `venv` unlink a file
before writing it, so:

| Step | Effect |
|------|--------|
| `python3 -m venv .venv` | the `cacert.pem` comes back as an empty **mount** |
| later `pip` write to it | the unlink is a no-op, the write goes into the mask |
| `rm -rf .venv` | `cannot remove …: Device or resource busy`; the shell only warned |
| rebuild over the remnant | `ensurepip returned non-zero exit status 1` |
| agent's conclusion | "the venv is broken" → rename tricks, yet another venv |

Measured 2026-11-27 on the lab machine against the installed cage.

## Scope

- **In:** `cardine-bwrap` (mask selection, caller cwd), the proof in
  `check-bwrap-secrets.sh`, ADR 0017, the troubleshoot how-to, CHANGELOG/version.
- **Out of scope:** the cage's network, the approval policy and the fs write
  tools — none of them was the cause; nothing about them is relaxed.

## Open for the user

- **The part that is a bug, not a decision:** `cd .venv` with no bound
  workspace used to fall back to `$HOME` and create `~/.venv`. Fixed: the cage
  now starts in the caller's directory when it is bound (`--chdir`). If you
  still want more of `~` visible, that is a separate ADR — nothing in this fix
  takes `~/.ssh`, `~/.secrets` or `~/.dsh/.env` out of ADR 0016/0017.
- **Clearing the residue:** folders `_ksp-*` in the repo root come from the
  diagnosis. They hold stuck mask mounts; the host command is in
  `_VENV-PROBE-CLEANUP.txt`.
