# Spec — fix-environment (agent only in the sandbox)

> **Role:** Plan to cage the agent inside one project for good: read and write in the workspace without asking, and nothing outside it — by making the **unbreakable cage** the only write right. Temporary: delete when finished (the code and the tests are the truth then).
>
> **Not here:** the history of earlier sessions ([daily log 2026-11-22](../logs/2026-11-22.md)); decision texts (`docs/decisions/`).

- **Item:** [BACKLOG.md](../BACKLOG.md) · branch `feat/fix-environment`
- **Status:** code landed (2026-11-23) — a restart of Zed and DSH is still needed before the profile is live. Decided with the advice from § Open decisions: **bind**, shared `/tmp`, network open, `approval: never`. See [ADR 0017](../../decisions/0017-the-agent-writes-in-the-cage-and-the-fs-write-tools-are-off.md).

## Goal

The agent works in Zed / DSH / `bwrap` inside the project without a single approval question: read, modify, shell, `make`. Everything outside the workspace (`~`, `~/.ssh`, `~/.secrets`, `~/.dsh`, other repos, `/etc`) is invisible and unchangeable on **every** route. What is written in the cage lands on disk **immediately** — and what the agent did can be recognised afterwards as its change.

## Where we stand now (measured 2026-11-22, this session)

| Fact | Evidence | Consequence |
|------|--------|--------|
| The shell runs in the cage | `PID 1 = bwrap`, `~/.dsh/.env` invisible, `/etc` is tmpfs, the workspace is `overlay` | Shell reads and shell writes are shielded |
| The cage starts with the **install-lab config** | `~/.dsh/profiles/acp/cordis.patch.yml` has `approval: ask` and `sandbox-policy: workspace-write` | The agent still asks on every edit |
| `cardine-strict.patch.yml` is **not** installed | the file does not exist as a profile; ADR 0017 does not exist | The strict profile is a loose sketch |
| Shell writes in the cage disappear | `check-bwrap-secrets.sh` literally requires "host copies unchanged (overlay)"; daily log 2026-11-22 § Went wrong: appends "disappear" | **Writing through the shell is unreliable** — the cause of "vanished work" in FIXES.md |
| `read`/`write`/`edit` run outside the cage | security.md, ADR 0016 | That route is the only one that touches the host, and the weakest link |

So the current "boundary" is a mix of two half-finished arrangements: the weak, human-driven way touches the disk, the strong, mechanical way does not. That is exactly the problem to invert.

## Starting point (the core plan)

> **The unbreakable cage is the only write right; the weak route never intervenes.**

- The weak route (the in-process fs tools `read`/`write`/`edit`) can by definition do everything DSH may do. Shielding it with a guard is "a denylist on a keyring". **Disabling** it in the profile is robust (the same principle as disabling `tool-web`/`tool-todo`/`tool-goal`).
- The strong route (the cage) is what remains and must therefore be *usable*: writing must work directly and reliably. That needs a `/tmp` that the host does share, and an overlay that gets cleaned up.
- This corrects one mistake from ADR 0007/0016 ("shell writes do not land on the host") and makes the choice explicit: **the agent writes through the shell, in the cage.**

What stays: the **workspace guard** stays, but as *defence in depth* for the read tools we do not want to disable (`read`, `read_image`, `glob`, `grep`) and as a safety net if a future profile turns writes back on. It is no longer the only wall; `make check` proves it never was the only wall.

## Scope

- **In:**
  - profile (`install-lab.sh` + `cordis.patch.yml`): writes off, `approval: never`, workspace from the **repo**, not from `process.cwd()`;
  - `cardine-bwrap`: shared `/tmp`, clean up the overlay, no host mutation;
  - trust (`git trust`): what the agent writes is recognisable as such and never committed silently;
  - `make check` as the gate: proves every route and every direction, with an umbrella `make sandbox-check`;
  - docs, ADR, version.
- **Out of scope:**
  - Closing off the shell's network. It stays open (ADR 0017).
  - Other OSes (`docs/work/specs/lab-macos.md`, `lab-other-linux.md`).
  - Caging Zed itself: Zed and `dsh` stay native processes (ADR 0007).
  - A clean per-path trust model ("propose outside, apply outside"): dropped, because "never ask" is the requirement and the guard cannot be trusted as the only wall.

## Touchpoints

| Place | What changes |
|------|---------------|
| `packages/lab/install-lab.sh` § 6 | profile generation: `danger-full-access`/`auto` → writes off, `never`, workspace from `REPO_ROOT` |
| `~/.dsh/profiles/acp/cordis.patch.yml` (host) | the same; `cardine-strict.patch.yml` goes or becomes the real profile |
| `packages/lab/cardine-bwrap` | `--tmpfs /tmp` → bind of a host folder; `--overlay-src`/`--tmp-overlay` → `--bind` **or** a cleaning overlay; fail-closed |
| `packages/lab/cardine-workspace-guard/` (now `cardine-secrets-guard`) | stays the path policy for read tools; the name and scope are explained |
| `packages/lab/scripts/check-bwrap-secrets.sh` | invert: "host unchanged" → "host **does** change", "normal file writable" really on the host |
| new `packages/lab/scripts/check-sandbox.sh` | umbrella proof matrix (route × direction), the gate in `make check` |
| `Makefile` | `CHECK := sandbox-secrets secrets-check` → `CHECK := sandbox-check` |
| `docs/architecture/security.md` | "two boundaries, one truth" → one write route + one read boundary |
| `docs/decisions/` | record **ADR 0017** (claimed in code, does not exist yet) |
| `AGENTS.md` | a `git trust` rule, no "never ask" exception needed any more |

Patterns to follow: inverting a requirement in a test (`check-bwrap-secrets.sh` already does that for "probe did not run → red"), the deny-only plugin in `cardine-secrets-guard/index.test.js`, and the rollback daily log in `AGENTS.md` § Finishing.

## Steps

Every step is separately testable and ends in a **negative control** (the test must be able to go red) and in the host terminal — not from the agent, because the agent cannot reliably touch the host config (see FIXES.md).

### Step 0 — Record it in an ADR (before any code)

- **Why:** the code already points at "ADR 0017", which does not exist; without an ADR every next session is surprised by the overlay behaviour again.
- **What:** `docs/decisions/0017-the-agent-writes-in-the-cage-and-the-fs-write-tools-are-off.md`:
  - the agent **never** asks for an approval in the lab environment (an equivalent "sandboxed auto mode");
  - only the cage may write; the in-process write tools are off;
  - `/tmp` is shared with the host (needed for `make`, `node_modules`, what the cage has to deliver);
  - a new party (subagent, hook) starts only in the cage, never with host fs;
  - `approval: never` is the *safety-net setting* for this environment; the PR route to upstream gets `auto` later (approvals granted automatically) so that "never ask" can work there without a fork — that is not a loose agreement but a Zed requirement.
- **Done when:** the ADR names the trade-offs of the three write models (bind / overlay / snapshot sync) and picks one (advice: **bind + `git trust`**; see Step 3).
- **Rollback:** set the ADR status back to *proposed*.

### Step 1 — Profile: writes off, `never`, repo fixed

- **Files:** `packages/lab/install-lab.sh` § 6, `~/.dsh/profiles/acp/cordis.patch.yml`, `packages/lab/cardine-strict.patch.yml`.
- **What:**
  1. `sandbox-policy`: `workspace-write` with `workspaceRoot` = `${REPO_ROOT}` (no `!!js process.cwd()`, no `danger-full-access`).
  2. `approval`: `policy: never` — no dialog, deterministic.
  3. `tool-fs`: only `read`; `write`/`edit`/`apply_patch` off.
     **Open:** whether `tool-fs config.applyPatch: false` also disables `write`/`edit` differs per DSH version. Measure it: after a restart `read` must work and `write`/`edit` must not be in the tool list. If not, that is a separate setting or a small out-of-tree plugin that *unregisters* the tools (not a guard that blocks afterwards).
  4. `tool-fs-search`: stays **on** (`glob`/`grep`) and goes through the workspace guard.
  5. `cardine-strict.patch.yml` does not become a second truth: either gone, or a pointer to `install-lab.sh` as the only source.
- **Done when:** in a new thread the agent does not ask on an edit; an edit outside the repo is not possible (*the tool does not exist*); `read` of a file in the repo works; `read` of `../Agent_Engineering` is refused.
- **Rollback:** restore `~/.dsh/profiles/acp/cordis.patch.yml.bak-*` and `pkill -f "bin/dsh"`.

### Step 2 — `cardine-bwrap`: usable, deterministic, cleaned up

- **Files:** `packages/lab/cardine-bwrap`.
- **What:**
  1. **Overlay decision.** Before choosing between bind and overlay: measure whether the cage's `/tmp` misses the host (see Step 4, negative test). If the cage has to run `make`, `node` or `npm`, `/tmp` must be able to hand what the cage creates over to the host.
  2. **Advice: `--bind`** (one write right, no vanishing window, `git status` is the truth). The masks (`.env`, keys) stay; they are acceptable: an `.env` should never exist *in* the repo (ADR 0016), so the masking find normally finds nothing. The find runs before the cage, on the host's guest-current tree.
  3. **If overlay stays:** then `--overlay-src` + `--overlay` with a **host** workdir and an explicit *sync back* in the `trap` (at the end of every shell call), plus a `git trust` entry per changed path. Effectively "apply the autonomous workspace". Document the cost: every call copies; `find` over `node_modules` joins in; a crash mid-sync loses bytes.
  4. **`/tmp`:** `--tmpfs /tmp` → `--bind <host-tmp> <host-tmp>` (a fixed folder, `700`, cleaned at cage start), otherwise half of `make` fails.
  5. **Fail-closed:** a command that does not reach the host must be **red**, not silently green as now (`.probe-tool.txt` could not be removed while the shell did not report it).
  6. **`--unshare-user`:** consider it; without a user namespace the cage runs as the real uid and sees more than intended through `/proc/<pid>/root` of other processes. Test: `PROC-ZIET-DSH-ENV` and `ls /proc/*/root/home`.
- **Done when:** `echo x > file` in the cage, then `cat file` **on the host** → `x`; `git status` shows the file; `make check` in the cage passes; a write attempt that fails is reported as an error.
- **Rollback:** restore the previous `cardine-bwrap` (mount flags only, no data).

### Step 3 — Trust: what the agent writes is recognisable as such

- **Why:** "the agent can write without asking" is only justified if you can recognise a change **by the agent** in `git status`/`git log`, and if it is never committed silently.
- **Files:** `AGENTS.md`, `Makefile` (`make sandbox-check`), `.git/info/exclude` if needed, `docs/architecture/security.md`.
- **What:**
  1. The agent does **not** run `git commit`/`git push` (already in `AGENTS.md` § Never); the cage may run `git` (status/diff/read-only), commits are the user's.
  2. `git config` in the cage: the host's `user.name`/`user.email` stay, but a pre-commit scheme (`core.hooksPath`) that blocks a commit carrying an agent marker — or simpler: because the agent does not commit, `git status` is the boundary; a session-start snapshot (`git stash list`/tag `agent-start`) makes the difference visible.
  3. The daily log (`make finish`) gets "written via the cage" in the line by default — that is now the provenance axis.
- **Done when:** after an agent edit `git status` shows the file on the host, and `git log` contains no agent commit.
- **Rollback:** restore hooksPath; it is not a data change.

### Step 4 — `make check` as the gate: the proof matrix

- **Files:** new `packages/lab/scripts/check-sandbox.sh`; adapt `check-bwrap-secrets.sh`, `check-secrets.sh` (guard unit tests); `Makefile`; `packages/lab/cardine-status.sh`.
- **What:** one script that prints the matrix. Every cell is an assert **and** a counter-check (a command that *should* be possible must also really run; otherwise "found nothing" is no proof — that lesson is already in `check-bwrap-secrets.sh`).

| Route | Inside the workspace | Outside the workspace |
|-------|-----------------|---------------------|
| shell read (`cat`, `rg`) | **must** | **may not** (`~/.ssh`, `~/.secrets`, `~/.dsh/.env`, `/etc/shadow`, `../Agent_Engineering`) |
| shell write | **must**, and **visible on the host** | **may not**, host unchanged |
| `read`/`read_image` | **must** | **may not** (guard) |
| `write`/`edit`/`apply_patch` | **tool does not exist** | **tool does not exist** |
| `glob`/`grep` | **must** | **may not** (guard) |
| `make check` in the cage | **must pass** | n.a. |
| approval dialog | **never appears** | **never appears** |

  - `Makefile`: `CHECK := sandbox-check` (one entry point; `sandbox-secrets` and `secrets-check` may stay as aliases).
  - `cardine-status.sh`: shows the cage status (PID 1, overlay or bind, profile version) so that after a restart you see at once whether you are in the right environment.
- **Done when:** every cell is green on the host **and** in the cage, and with one deliberately broken wall (e.g. `--bind /` temporarily) the matrix goes red.
- **Rollback:** restore `CHECK`; the check scripts are read-only.

### Step 5 — Rollout, restart and measurement

- **From the host** (FIXES.md problem 3 — this is not optional):
  ```
  pkill -f "bin/dsh" || true
  # close all Zed windows, one new window, new thread (+)
  git pull            # or: commit the changes in cardine first
  make check          # of: bash packages/lab/scripts/check-sandbox.sh
  ```
- **Then, measure in a new thread:** "am I in the cage?" → PID 1, profile, overlay/bind; and "write a file and cat it on the host."
- **Clean up afterwards:** remove `.probe-tool.txt` and other leftovers of the previous session **from the host** (the agent cannot get rid of them).
- **Done when:** one session converts the project (edits + `make check`) without a single approval dialog, and the user sees everything on disk.

### Step 6 — Docs and release

- `docs/architecture/security.md`: rewrite "two boundaries" to "one write route (the cage), one read boundary (guard for the tools that stay)".
- `docs/product/tools.md` § State of play: update T2/T3 (approval = never; sandbox = the cage writes).
- `docs/decisions/0016`: add a note "touched by 0017" (do not rewrite).
- `AGENTS.md`: `git trust`/commit ban (if Step 3 asks for it), no "the guard is the wall" wording any more.
- `CHANGELOG.md` + version `@lennaertds/cardine-lab` (patch/minor), and `install-lab.sh` is the only source of the profile.
- **Done when:** `git diff` after Step 5 shows only docs + the code discussed, and a fresh `install-lab.sh` run produces an identical profile.

## Acceptance (final proof)

1. **No dialog:** in a session with 5+ edits and `make check` no approval question appears.
2. **Writing works:** `echo`/`make` in the cage lands on the host; `git status` shows it; nothing "vanishes".
3. **No leak:** `~/.ssh`, `~/.secrets`, `~/.dsh/.env`, `/etc/shadow`, `../Agent_Engineering` are invisible via the shell **and** via the tools.
4. **No host mutation:** a probe that writes outside the workspace leaves the guest host byte-for-byte equal (`md5`).
5. **Not silent:** a missed write or a failed mount is red in `make check`, never "ok".
6. **Recognisable:** `git log` has no agent commit; the daily log names the cage as the write route.

## Risks and alternatives

| Risk | Mitigation |
|--------|-----------|
| `write`/`edit` cannot be disabled through the profile | Measure (Step 1.3); if needed a small plugin that unregisters the tools, or an upstream PR for a `tool-fs` switch |
| The cage breaks `make`/`npm` (missing `/tmp`, cache) | Step 2.4: shared `/tmp`; then show the fail-closed behaviour: failed → red, never silently green |
| Bind instead of overlay is riskier with a buggy agent | The masks for `.env`/keys stay (defence in depth), and `git trust` from Step 3 |
| Overlay stays and there is a "vanishing effect" again | Then only with an explicit sync back + trust, never "half" |
| "Never ask" is a policy choice, not a technical one | This is the lab environment with an auto sandbox; ADR 0017 records it and limits it to this environment |

**Alternatives considered:** (a) only sharpen the guard — rejected: in-process tools cannot be caged by definition; (b) everything in Docker — rejected: ADR 0007, too heavy; (c) keep "ask" and refine domains — rejected: you precisely want to never ask; (d) use the DSH sandbox — rejected: the default is unmeasured, ADR 0007.

## Decisions (2026-11-23)

1. **Bind** for the workspace. Recorded in ADR 0017.
2. **`/tmp` shared** with the host (mode 700, per call).
3. **Network open.** Fixed in ADR 0017. A closure on 2026-11-23 was reverted.
4. **`approval: never`** in this lab, until upstream `auto` can be done without a fork.

## Session reference

Generated from the measurements in [docs/work/logs/2026-11-22.md](../logs/2026-11-22.md). Earlier session code points at ADR 0016 and at "ADR 0017"; that last one is in Step 0.
