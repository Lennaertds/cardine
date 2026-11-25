# 0014 — Index repositories separately and run `install-lab.sh` on every new machine

- **Status:** accepted
- **Date:** 2026-11-22
- **Touches:** `packages/lab/install-lab.sh`, `packages/lab/cardine-status.sh`, `docs/work/logs/`, Jarvis-index workflow

## Summary

In the context of a fresh Arch Linux / Hyprland machine where `install-lab.sh` had not been run, faced with (1) a `400: Invalid structured outputs: 'triggers'` API error caused by cached session state and (2) a stalled Jarvis indexing run inside `bwrap` leaving stale `.lock` files, we decided to (a) always run `install-lab.sh` as the first step on a new machine, (b) index each git repository separately (not the parent directory that collects them), (c) run new index runs by hand in the terminal first (outside `bwrap`), and (d) add a lockfile health check to `cardine-status.sh`, in order to guarantee reproducible project starts and prevent errors from outdated sessions or sandbox limits. We accept that this stays a manual startup step (not fully automatable) and that each new repo needs two terminal commands.

## Context

While working on a school project with a shared repo (through the Cardine stack) we discovered that `install-lab.sh` had not been run on the new machine. That led to two errors:

1. **400 API error:** an existing Zed thread sent stale session state with an invalid tool and schema structure to the DeepInfra endpoint. Because the DSH profile in Zed had not been initialised correctly (through the missing `install-lab.sh`), the thread did not notice the configuration change and kept sending an incorrect tool structure. DeepInfra refused the request with `400 invalid_request_error: Invalid structured outputs: 'triggers'`.

2. **Jarvis index blockage:** the agent tried to index the repository through `mcp__jarvis__indexRepo`. Because indexing ran inside the `bwrap` sandbox the process was cut off and stale PID files were left in `~/.jarvis/`. Later index attempts failed with `another index is already running`. The optional `scip expt-convert` step failed as well.

3. **Parent directory problem:** there was a tendency to put one Jarvis index on a parent directory that is not itself a git repo but contains two nested git repositories. Zoekt (through `zoekt-git-index`) is git-oriented and does not handle such directories correctly — branch tracking and incremental updates stop working.

## Decision

**We keep and document the following way of working for setting up a new machine or a new project in the Cardine stack:**

### A. `install-lab.sh` as the mandatory first step

On every new Arch Linux / Hyprland machine (or a fresh fork) `install-lab.sh` must be run before Zed + DSH starts:

```bash
cd <repo-root>/packages/lab
bash install-lab.sh
```

The script idempotently prepares the DSH ACP profile, the sandbox (bwrap), jarvis-server and the right Node version. Without this step the profile and sandbox settings the agent needs to work correctly are missing.

### B. Index each git repository separately, not the parent directory

- **Correct:** `cd project-a && jarvis index "$(pwd)" --no-semantic --no-scip`
- **Correct:** `cd project-b && jarvis index "$(pwd)" --no-semantic --no-scip`
- **Wrong:** `cd ~/Documents/projects && jarvis index "$(pwd)" --no-semantic --no-scip`

**Why:** Zoekt is git-oriented and uses `zoekt-git-index` per git repository. A parent directory without its own `.git` (or with two nested `.git` directories) breaks branch tracking, incremental updates and `.gitignore` resolution. Jarvis searches all registered repos at once by default when no `r:` filter is given, so there is no functional need for one index at the top. SCIP and language detection also stay clean per repo (a Python pipeline versus a TypeScript backend).

### C. Always index new projects in the terminal first, not from the agent

Run once in the project directory for every new project:

```bash
jarvis index "$(pwd)" --no-semantic --no-scip
```

**Why:** the agent itself runs under `bwrap`. The sandbox limits cut the indexing process off, or it fails in subtle ways (stale lockfiles, unclosed subprocesses). Indexing in the terminal first (without the sandbox) builds the Zoekt index directly and cleanly.

### D. Lockfile health check in `cardine-status.sh`

We add a check to `packages/lab/cardine-status.sh` that:

- Checks whether `~/.jarvis/index-*.lock` files exist
- For each lockfile, checks whether its PID is still alive (`kill -0 <pid>`)
- If not, cleans up the stale lockfile with a message

## Alternatives

| Option | Why not |
|-------|-------------|
| Allow indexing through the agent | The bwrap sandbox breaks subprocesses; it leads to stale locks and unreliable indexes |
| One index on the parent directory | Zoekt works per git repo; branch tracking, `.gitignore` and incremental updates break |
| Automate it fully in `install-lab.sh` | The paths to index are project-specific; `install-lab.sh` does not know the user's project layout |
| Simply ignore lockfiles and rebuild | Lockfiles block every index attempt — no recovery without cleaning up |

## Consequences

- **Easier:** a reproducible setup; no more mysterious 400 errors or stalled indexing runs.
- **Easier:** two separate repo indexes give cleaner Zoekt results per project.
- **Harder or risky:** every new machine and every new project needs two manual terminal steps (`install-lab.sh` + `jarvis index ...`). That cannot be fully automated without knowing the project layout.
- **To do:** add the lockfile check to `cardine-status.sh` (optional, for extra robustness).