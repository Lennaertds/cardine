# How-to — Sandbox / bwrap troubleshoot

> **Role:** what to do when the sandbox (bwrap) does not work, or when DSH complains about `ENOENT` / a missing runner.
>
> **Not here:** installing DSH or jarvis ([zed-dsh.md](zed-dsh.md)), the approval policy ([security.md](../architecture/security.md)).

## Symptoms

| Error | Cause |
|-------------|---------|
| `spawn …/cardine-bwrap ENOENT` | The path to `cardine-bwrap` in the DSH profile is wrong. |
| `Error: sandbox mode "…" is requested but no sandbox backend is usable` | bwrap is missing, or the runner cannot start. |
| `make: *** No rule to make target 'check'` | The slice check runs `make check` in a directory without a Makefile. |

## 1. cardine-bwrap not found (ENOENT)

This is the most common cause. The DSH profile (`~/.dsh/profiles/acp/cordis.patch.yml`) points to an **absolute path** for the bwrap runner. If that path is wrong, DSH cannot start the sandbox.

### Check

```bash
grep 'cardine-bwrap' ~/.dsh/profiles/acp/cordis.patch.yml
```

**Expected:** a line like:

```yaml
- /path/to/cardine/packages/lab/cardine-bwrap
```

**If the path is wrong** (for example a renamed directory):

```bash
# Fix: replace the wrong path with the right one
INSTALL_LAB_DIR="$(dirname "$(readlink -f "$0")")"
echo "Use: $INSTALL_LAB_DIR/cardine-bwrap"
# Update the DSH profile with the right path

### Why does this happen?

`install-lab.sh` determines `REPO_ROOT` via:

```bash
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && git rev-parse --show-toplevel 2>/dev/null || pwd)"
```

This only works if:
1. The script is called from inside a git repo (not a subdirectory outside it).
2. Git is available and knows the repo.

If you run the script from a context where git cannot find the root (a symlink, the wrong CWD, or a partial clone), it falls back to `pwd` — which can give a wrong path.

**Remedy:** always run `install-lab.sh` from inside the project directory:

```bash
cd /path/to/your/project
bash packages/lab/install-lab.sh
```

Or use the Makefile:

```bash
make install-lab
```

## 1b. You moved or renamed the repo

The profile stores **absolute paths** in five places: `workspaceRoot`,
`mcp-jarvis.cwd`, the `runnerCommand`, and the `name:` of both plugins. After a
move every `bash` call fails with `spawn …/packages/lab/cardine-bwrap ENOENT`,
and `grep`/`glob`/`read` keep working — they do not use the runner, so the error
looks like a broken tool instead of a stale path.

Run this from inside the project (on the host, not in a DSH shell — the cage
cannot write `~/.dsh`):

```bash
make move          # dry run: which paths and tools are stale
make move-fix      # rewrite the profile (paths only), rebuild the jarvis wrapper, re-index
```

What `make move-fix` does:

1. Copies the profile to `cordis.patch.yml.bak` and replaces the old root in
   **every** line of the profile. The model list, the approval policy and the
   plugins stay as they are.
2. Rebuilds `~/.local/bin/jarvis-server-wrapper.sh` when it is missing. `mcp-jarvis`
   has `failOnStartupError: true`, so a missing wrapper takes jarvis down with it.
3. Runs `jarvis index <new root> --no-semantic`. The index is labelled by folder
   name, so an orphan entry of the old name can stay behind in `jarvis list`.
4. **Does not restart DSH.** You do that: `dsh kill`, then start Zed / a thread
   from inside the new root. The profile and the plugins load at server start.

A thread started from a folder that is **not** the profile root gets no sandbox
at all. Start every DSH session from inside the project the profile points at.

## 1c. Two projects side by side (one profile each)

DSH resolves `workspaceRoot`, `mcp-jarvis.cwd` and the slice check from **one
profile per session**, and Zed knows one server per project. So a second project
gets its own profile, generated from the lab in the first:

```bash
cd ~/Documents/Student_Zelfstandige/Cardine/Bachelorproef_2027_Codebase_Indexing
bash ../cardine/packages/lab/install-lab.sh --profile bp --name "Bachelorproef 2027"
cd ~/.dsh/profiles/bp && pnpm install        # links the slice check and the guard
```

What comes out:

| Piece | Where |
|-------|-------|
| Probe profile | `~/.dsh/profiles/bp/cordis.patch.yml` — workspaceRoot and jarvis cwd: the BP repo |
| Plugin paths | the lab in `cardine/packages/lab` — a profile of another repo still runs *this* slice check against *that* repo's `make check` |
| Zed server | `DeepSeek Harness (bp)`, `args: ["--profile","bp"]`, next to `DeepSeek Harness` |
| Jarvis backend | shared (`~/.jarvis`); the index is per repo — `jarvis index <root> --no-semantic` |
| Credentials | shared `~/.dsh/.env` (never overwritten) |

In Zed: open the project, pick **DeepSeek Harness (bp)** for the BP repo and
**DeepSeek Harness** for cardine. A thread started in a folder none of the
profiles names gets no sandbox. `make move` in either repo reports every profile,
so a move that broke the other project shows up too.

## 2. bwrap not installed at all

```bash
which bwrap
```

If bwrap is missing on Arch Linux:

```bash
sudo pacman -S bubblewrap
```

Or via `install-lab.sh` (it installs automatically when sudo is available):

```bash
make install-lab
```

## 3. Sandbox policy of the lab profile

Since [ADR 0017](../decisions/0017-the-agent-writes-in-the-cage-and-the-fs-write-tools-are-off.md)
the profile runs `workspace-write` with `approval: never`, and the shell goes
through `cardine-bwrap`. That means:

- **The workspace is writable through the cage**; the write lands on the host.
- **The fs write tools are off** — `write`, `edit` and `apply_patch` do nothing; writing happens through the shell.
- **No permission dialogue** — inside the workspace the agent acts on its own; a path outside it is not mounted at all.
- **`make check`** runs at the end of every turn (via the slice check).

`DSH_PERMISSION_MODE=danger-full-access` bypasses that boundary. The lab profile
does not set it, and should not.

The settings live in `~/.dsh/profiles/acp/cordis.patch.yml`:

```yaml
- id: sandbox-policy
  config:
    mode: workspace-write
    workspaceRoot: !!js process.cwd()

- id: approval
  config:
    policy: never
```

The template is generated by `packages/lab/install-lab.sh`.

## 4. Slice check runs in the wrong directory

`cardine-slice-check` (in `packages/lab/cardine-slice-check/index.js`) checks whether `make check` is green after every turn. If the agent works in a directory without a Makefile (`~` or `/tmp`), you got:

```
make: *** No rule to make target 'check'.  Stop.
```

The slice check now looks for a Makefile itself:
1. First in the agent's CWD.
2. Then in parent directories up to `/`.
3. Falling back to the project root (derived from the script path).

This is fixed in the current version.

## 5. ~/.dsh/ not persistent in the sandbox

### Symptom

`install-lab.sh` runs without errors, but after a restart `~/.dsh/` is empty or gone. The DSH profile is not loaded.

### Cause

`cardine-bwrap` (the bwrap runner DSH uses for shell commands) did not mount `~/.dsh/`. Every bash command got a fresh tmpfs for `~/.dsh/` — writes were gone after the call.

### Fix

`cardine-bwrap` now mounts `~/.dsh/` as a writable `--bind` instead of leaving it out. The DSH profile therefore survives between calls.

```bash
# In packages/lab/cardine-bwrap:
args=(
  ...
  --bind "${HOME_DIR}/.dsh" "${HOME_DIR}/.dsh"
  ...
)
```

In addition, `cardine-bwrap` makes sure `~/.dsh/` exists before bwrap starts (otherwise `--bind` fails):

```bash
mkdir -p "${HOME_DIR}/.dsh" "${HOME_DIR}/.dsh/profiles" "${HOME_DIR}/.dsh/profiles/acp"
```

### Verify

```bash
# Check whether ~/.dsh is persistent inside the sandbox
bash packages/lab/cardine-status.sh
```

The status script reports under "Sandbox / bwrap" whether `~/.dsh/` is persistent.

## 6. A new DSH session is needed after a profile change

The DSH profile is **loaded once, when an agent session starts** (in Zed). Changes to `cordis.patch.yml` only take effect after a **new thread** in the Agent panel.

### Check whether the profile is loaded

```bash
# Dump the current DSH config
dsh --profile acp --dump-config 2>&1 | grep -A5 'sandbox-policy\|approval\|bwrap'
```

If the output does not match what is in `cordis.patch.yml`: start a new DeepSeek Harness thread in Zed.

## See also

- [zed-dsh.md](zed-dsh.md) — the full install guide
- [security.md](../architecture/security.md) — approval policy and secrets
- [status-jarvis-dsh.md](status-jarvis-dsh.md) — status check for the whole environment