# Spec — dsh-profile-cardine

> **Role:** a plan for one work item. Temporary: delete it after the merge; the code and the tests are then the truth.
> **Not here:** the lab cage rules ([ADR 0007](../../decisions/0007-tool-approval-is-a-workspace-allowlist-and-the-shell-runs-under-bwrap.md), [ADR 0017](../../decisions/0017-the-agent-writes-in-the-cage-and-the-fs-write-tools-are-off.md)); where a profile comes from ([harness.md](../../product/harness.md)).

- **Item:** [BACKLOG.md](../BACKLOG.md) · branch `feat/dsh-profile-cardine`
- **Status:** open

## Goal

A fourth Zed server, **DeepSeek Harness (cardine)**: the normal lab agent on the
`cardine/` repo — full control of the repo, no approval needed — **plus** a system
level: read of the DSH harness (its config, its installed package, this lab), and
write there only after a permission ask. The system zone never overlaps the repo
zone, so picking this server on a Cardine window still adds access and never removes it.

## Decision in one table

| Zone | Paths | Read | Write | Ask? |
|------|-------|------|-------|------|
| **Repo** | `cardine/` (and whatever the session opens in) | yes | yes | never, same as the lab ([ADR 0017](../../decisions/0017-the-agent-writes-in-the-cage-and-the-fs-write-tools-are-off.md)) |
| **System** | `~/.dsh` except the secrets (`profiles/`, `sessions/`, `logs/`, `plugins/`, `package.json`…), `~/.local/lib/node_modules/@deepseek-ai/`, `~/.jarvis` | yes | yes | **always** |
| **Everything else** | `~/.ssh`, `~/.secrets`, `~/.aws`, `~/.config`, `~/.dsh/.env`, the rest of `~` | no | no | refused |

## Scope

- **In:**
  - Profile `cardine` from `install-lab.sh --profile cardine --mode system`, into
    `~/.dsh/profiles/cardine/cordis.patch.yml` and the Zed server
    **DeepSeek Harness (cardine)** (0.5.3 naming, no second installer).
  - **The repo as in the lab**: `sandbox-policy: workspace-write`, shell through
    `cardine-bwrap`, `glob`/`grep` on, `tool-web`/`tool-todo`/`tool-goal` off (the
    DeepInfra `triggers` error), the slice check on. Copy the lab block; the only
    differences are the lines listed below.
  - **Write tools per zone instead of per profile.** `tool-fs` gets a path rule
    (`writePaths`, `editPaths`; name to confirm against the pinned `0.2.2-rc.1` in
    slice 1): write/edit are registered, and only allowed under the system roots.
    Inside the repo the harness sandbox already allows them; outside the system
    roots `cardine-zone-guard` refuses. The lab keeps them off, so its width does
    not grow.
  - **`approval`: ask only inside the system zone.** Upstream `never`/`ask` are
    profile-wide, so this needs a per-call policy: a small plugin (`cardine-zone-guard`
    or a `policy` field if the pinned DSH has one) that classifies a call by its
    resolved path and asks only for the system zone. Slice 1 proves which is available.
    **Measured, not claimed (2026-11-27):** this sandbox cannot observe the Zed
    ↔ DSH handshake (there is no Zed and no `dsh` on this machine view; the lab
    says a thread starts via `initialize` + `session/new`). So "ask" is proven only
    by slice 4. Until that proof, a profile that cannot ask must fail closed — a
    refusal with a named reason.
  - **System read and write for the shell**, with a measured condition from
    2026-11-27 (probe inside this sandbox's own `cardine-bwrap` cage):
    - `--ro-bind` of `~/.dsh` (except `.env`) + the dsh package, from the cage's
      argv: **works**. Same for `~/.jarvis`, already mounted ro.
    - An empty mask over `~/.dsh/.env`: **works** (a source that exists).
    - A hole where a system dir does not exist yet (a fresh `~/.dsh/profiles/cardine/`
      before its first install): **impossible**. bwrap refuses `Can't find source
      path`. The installer therefore creates the system-zone dirs (`profiles/cardine/`)
      before the first session — that is a precondition of the profile, not a licence.
    - The shell may write in the system zone: from inside the cage its name resolves
      **through the ro mount** (`read ABS` = `read RELATIVE`, measured), so a write
      fails with an EROFS that the guard must translate into an actionable message.
      `/tmp` stays a private mount of this profile, not the shared host `/tmp`.
    - `~/.ssh`, `~/.secrets` and everything else stay **absent** from the cage
      (`Can't find source path`, measured): bwrap allowlists, it never inherits.
  - **One root.** `cardine/` is the root of this profile. The BP repo keeps its own
    `bp` profile; cross-reading BP files is not part of this (a second root is
    deliberately later).
  - `cardine-status.sh` reports the profile, its mode and the system zone.
- **Out of scope:**
  - No approval-free write at system level. The write is the permission.
  - `~/.dsh/.env` and every `*.env` non-example, SSH keys and certificates:
    the existing rules of [cardine-secrets-guard](../../../packages/lab/cardine-secrets-guard/index.js)
    and `cardine-bwrap` stay in force, in both zones.
  - The `bp` and `acp` profiles: unchanged, including their width (`write`/`edit`
    off, `approval: never`).
  - Running `make`, tests or the dev server from the *system* zone.
  - **No `pacman`, no global `npm`, no `systemd`** (decided with the user, 2026-11-27).
    The system zone is DSH only. When the agent needs an install, a service or a
    binary it does not have, it asks the user, who runs it on the host. That is
    the whole reason the cage can stay a cage.
  - macOS/Windows.

## Zone rules — the part that can go wrong

| Transition | Rule |
|------------|------|
| repo → system | always asks, also when the path was reached through a symlink or `..` (resolution by `realpath` + parent walk, as the secrets guard does) |
| system → elsewhere | refused, never asked |
| `.env` in either zone | refused (existing patterns, `*.example` excepted) |
| shell into the system zone | the mount is ro, so a write fails; the guard names the tool to use |
| two harness roots at once (`Cardine/` with `cardine/` inside) | zone wins over containment: `Cardine/cardine/` is in the repo zone, so it never asks |

## Interfaces

- Modules and files: `packages/lab/install-lab.sh` (`--mode system`, the zone table),
  `packages/lab/cardine-zone-guard/` (new: `index.js`, `index.test.js`, the same shape
  as `cardine-secrets-guard/`), `packages/lab/cardine-bwrap` (a mode flag, one policy),
  `packages/lab/scripts/check-sandbox.sh` and `check-bwrap-secrets.sh` (both modes),
  `packages/lab/cardine-status.sh`.
- Interface that changes: `install-lab.sh --profile NAME [--name LABEL] [--mode lab|system]`
- Seams touched: harness → approval (the ask), harness → fs tools (the zone guard and the path rules), harness → shell (the cage).
- Example to follow: `packages/lab/cardine-secrets-guard/` (deny-only, `realpath`,
  `prepend: true`, `node --test`, mini-Cordis harness in its test).

## How to create it — in order

The N in front is the session; each step is testable on its own and ends green.

| # | Do | Prove with |
|---|----|-----------|
| 0 | **Know the knobs first.** `bash packages/lab/scripts/check-dsh-schema.sh` on the host: it reads the installed `@deepseek-ai` packages (never a copy) and answers Q1 (a root field on `sandbox-policy`), Q2 (a per-path approval), Q3 (`request_permission` in the ACP app) and Q4 (`edit` as its own `tool-fs` key). Exit 0 = all answered, 1 = a question is open, 2 = package not reachable (it cannot run in the cage). | The script's output in the log |
| 1 | **`cardine-bwrap` mode.** `CARDINE_SYSTEM_READ=1 ./cardine-bwrap …`: ro-binds `~/.dsh` (file-level `.env` mask) + the dsh package; refuses (exit 1) when a system dir is missing instead of silently dropping it. One script, one policy (no second argv parser). | `check-bwrap-secrets.sh` in both modes + the measurement above as a test (foreign ABS readable, `~/.ssh` absent) |
| 2 | **Zone guard.** `packages/lab/cardine-zone-guard/`: `realpath` classification in repo / system / deny; the `deny` set wins, then the secrets rules; `ask` for system writes. | `node --test` (mini-Cordis harness copied from `cardine-secrets-guard`) |
| 3 | **Profile.** `install-lab.sh --mode system`: the lab block + write tools on + `ask` + the guard + the bwrap mode. Creates `~/.dsh/profiles/cardine/` first. Diff against `acp` shows only the intended lines. | `diff` output in the log; `dsh --profile cardine --dump-config` |
| 4 | **The ask in Zed.** A new thread on **DeepSeek Harness (cardine)**: the dialog appears for a system write and never for a repo write. | Screenshot or the log line; if no dialog, the guard's refusal is the answer and step 2 is the ship state |
| 5 | **Report.** `cardine-status.sh` prints the profile, mode and system zone. | `make env-status` |

## Slices

1. `cardine-bwrap` ro system read (step 1).
2. Zone guard with the `ask`/`deny` classification (step 2).
3. `--mode system` profile (step 3).
4. The real thread in Zed (step 4).
5. Status + CHANGELOG (step 5).

## Acceptance

- [ ] `install-lab.sh --profile cardine --mode system` from `cardine/` writes a profile and a Zed entry; a second run changes nothing; it refuses to finish if a system-zone dir is missing.
- [ ] `bash packages/lab/scripts/check-sandbox.sh --profile cardine` is green, including both cage modes.
- [ ] In a fresh thread: a repo write is a host write with no question; a system write asks; a refused path is refused with a named reason (never a raw EACCES).
- [ ] `~/.dsh/.env` is unreadable through `read`, `grep` and the shell, with the same messages as in the lab.
- [ ] `acp` and `bp` profiles: empty diff, `make check` green.
- [ ] `make links` green; `packages/lab/CHANGELOG.md` gets a 0.6.0 entry.

## Risks / open

1. **The ask is unproven, not refused by design.** No proof yet that the pinned DSH asks in Zed (slice 4). Until then "write with permission" means "refused with a clear reason", and the spec does not widen to approval-free system writes.
2. **Zone guard vs path rules.** Two mechanisms for the same boundary is what ADRs 0003/0017 avoid. Slice 1 decides one; the guard stays deny-only and only adds the `ask` classification.
3. **Wider tool surface.** `write`/`edit` registered in one profile is a new fact in the lab; `check-sandbox.sh` must prove the lab profile still has them off.
4. **The index.** `jarvis index cardine/` also indexes `bron/`, but that is inside this repo's own zone, so it is not a leak here — it is Cardine reading its own tree.
5. **A profile is not per-agent.** Anyone who picks the server for any window gets the system zone. The server name is the warning.

## Deliberately later

| Extension | Why later | Ask when |
|-----------|-----------|----------|
| A second root (BP beside Cardine) | One root proves the shape; BP has its own profile | A task cites both trees |
| A native per-call approval policy from upstream DSH | Pinned at 0.2.2-rc.1 | The DSH changelog offers it; drop the custom classification |
| A scoped `~/.dsh` subset (e.g. read-only `logs/`) | The whole zone except secrets is the simplest rule | An agent misuses `logs/` |
