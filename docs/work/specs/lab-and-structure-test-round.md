# Spec — lab-and-structure-test-round

> **Role:** Systematically test and improve `packages/lab/` and `packages/structure/` towards the next versions. No new features — only check what is there, find bugs and fix them.

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** open

## Goal

Both packages are in a "finished 0.x" state, but **not tested** on a clean machine. This spec is about:
1. Running yourself what a user would do
2. Logging and fixing bugs
3. Bumping to `lab-v0.2.0` and `structure-v0.3.0`

## Scope

- **In:** `packages/lab/` and `packages/structure/` — testing, debugging, fixing, version bump
- **Out of scope:** New features (other Linux distributions, macOS — separate specs), OS extensions

## Status per package

### `packages/lab/` — version `0.1.0`

| Part | Status | What to test |
|-----------|--------|------------|
| `install-lab.sh` | ✅ base | Does it run idempotently? Does it recognise REPO_ROOT? Clean output on non-Arch? |
| `cardine-bwrap` | ✅ base | Does the bwrap cage work? Is anything missing from the mounts? |
| `cardine-status.sh` | ✅ base | Do all checks pass (except the API key)? Does `--fix` repair paths? |
| `cardine-slice-check/` | ✅ base | Does `make check` run without errors? |
| `scripts/` | ✅ base | Which scripts still work independently of the repo structure? |
| `package.json` | ✅ base | Is the config right for npm/publish? Is `private: true` still needed? |
| `docs/cardine-lab.md` | ✅ base | Are the paths and descriptions right? |
| `systemd/` | ✅ base | Do the timers work? |

### `packages/structure/` — version `0.2.0`

| Part | Status | What to test |
|-----------|--------|------------|
| `pull_kit.sh` | ✅ base | Does it work idempotently? What happens without the Agent_Engineering sibling? |
| `new-project.sh` | ✅ base | Does it create a new project without errors? |
| `kit/` | ✅ pulled @46fb1ab | Are all files present that `kit/COMMIT` lists? |
| `package.json` | ✅ base | Does the `files` field cover everything? Does `npm pack` work? |
| `docs/cardine-structure.md` | ✅ base | Are the paths and descriptions right? |
| `CHANGELOG.md` | ✅ 0.2.0 | Complete? |

## Test plan

### Slice 1 — lab: run install-lab.sh yourself

Run on the current Arch machine (not in a sandbox/container):

```bash
bash packages/lab/install-lab.sh
```

Check that:
- [ ] No error messages about missing paths (no hardcoded `$HOME` or `Agent_Engineering` paths in errors)
- [ ] DSH is installed correctly or skipped (if already there)
- [ ] Jarvis is installed correctly or skipped
- [ ] The DSH profile is generated with correct paths
- [ ] The `cardine-bwrap` path in the profile matches `packages/lab/cardine-bwrap`
- [ ] The `cardine-slice-check` path in the profile matches `packages/lab/cardine-slice-check/index.js`
- [ ] `wrapper.sh` is created correctly with the dynamic jarvis-server binary
- [ ] On non-Arch (e.g. in Docker): skips the pacman step, gives a clear message

**Log:** note every error, warning and deviating path. After fixing: run again.

### Slice 2 — lab: check cardine-status.sh

After `install-lab.sh` (or on its own):

```bash
bash packages/lab/cardine-status.sh
bash packages/lab/cardine-status.sh --verbose
bash packages/lab/cardine-status.sh --json
bash packages/lab/cardine-status.sh --fix   # if there are wrong paths
```

Check that:
- [ ] All checks give `ok` or `warn` (no `fail` except the API key)
- [ ] `--json` gives valid JSON
- [ ] `--fix` repairs wrong paths (test by breaking a path in `cordis.patch.yml` and running `--fix`)
- [ ] Sandbox detection works (inside a DSH session)
- [ ] `make env-status` works and gives the same output

**Log:** which checks fail, which warnings are unjustified.

### Slice 3 — lab: test cardine-bwrap

```bash
# Test whether bwrap itself works
bwrap --version

# Test whether cardine-bwrap can start a shell
bash packages/lab/cardine-bwrap -- echo "hello from bwrap"

# Test whether ~/.dsh is reachable
bash packages/lab/cardine-bwrap -- ls -la ~/.dsh/

# Test whether ~/.ssh is hidden (ADR 0007)
bash packages/lab/cardine-bwrap -- ls ~/.ssh/ 2>&1 || echo "~/.ssh not reachable (correct)"
```

Check that:
- [ ] `bwrap` works (needs: `sudo pacman -S bubblewrap` / kernel namespaces)
- [ ] `cardine-bwrap` starts a shell
- [ ] `~/.dsh` is writable (DSH profile persistent)
- [ ] `~/.ssh` is **not** visible
- [ ] `~/.local` and `~/.jarvis` are readable (tools work)
- [ ] An error message for `--` without a command
- [ ] An error message for unknown flags

**Log:** which mounts are missing, which permissions are wrong.

### Slice 4 — lab: test cardine-slice-check

```bash
# Test whether the Node module works
node packages/lab/cardine-slice-check/index.js

# Test in the context of DSH: echo '{"jsonrpc":"2.0","id":1,"method":"initialize"}' | dsh --profile acp
```

Check that:
- [ ] The module runs without Node errors
- [ ] `make check` at the root works
- [ ] The slice check is called on a DSH turn (if DSH runs)

**Log:** Node version issues, module resolution problems.

### Slice 5 — structure: test pull_kit.sh

```bash
# Test without Agent_Engineering
bash packages/structure/pull_kit.sh

# Test with Agent_Engineering (if it sits as a sibling)
bash packages/structure/pull_kit.sh
```

Check that:
- [ ] Without Agent_Engineering: a clear error message, no half-finished work
- [ ] With Agent_Engineering: pulls the kit from the pinned commit
- [ ] Idempotent: a second run changes nothing
- [ ] `kit/COMMIT` exists and matches the pulled content
- [ ] All expected files are present in `kit/`

**Log:** what is missing from the kit? Which files are not pulled?

### Slice 6 — structure: test new-project.sh

```bash
# Test in a temporary directory
cd /tmp
bash /path/to/packages/structure/kit/new-project.sh
```

Check that:
- [ ] The script starts without errors
- [ ] `npx cardine-structure` works (via the npm bin link)
- [ ] The created project has the right structure (kern + chosen modules/stacks)
- [ ] `make check` in the new project is green
- [ ] `readlink -f` resolution works (0.2.0 fix)

**Log:** which errors appear with `npx`? Does the fallback work?

### Slice 7 — structure: test npm pack

```bash
# Simulate what npm publish does
cd packages/structure
npm pack --dry-run
```

Check that:
- [ ] `files` in `package.json` covers all needed files
- [ ] No superfluous files in the pack (node_modules, .git, etc.)
- [ ] If `npm pack` works: make a tarball and install it locally

**Log:** missing files, too many files.

### Slice 8 — Bump to the next version

After all fixes:

**lab:**
- [ ] CHANGELOG.md: a `0.2.0` entry with all fixes
- [ ] `package.json`: version `0.2.0`
- [ ] Prepare the git tag: `lab-v0.2.0`

**structure:**
- [ ] CHANGELOG.md: a `0.3.0` entry with all fixes
- [ ] `package.json`: version `0.3.0`
- [ ] Prepare the git tag: `structure-v0.3.0`

## Acceptance

- [ ] `bash packages/lab/install-lab.sh` runs without errors on Arch
- [ ] `bash packages/lab/cardine-status.sh` — all checks (except the API key) are green
- [ ] `cardine-bwrap` hides `~/.ssh`, shows `~/.dsh` and the tools
- [ ] `bash packages/structure/pull_kit.sh` works idempotently
- [ ] `npx cardine-structure` creates a new project
- [ ] `npm pack --dry-run` in both packages shows the right files
- [ ] `make check` is green
- [ ] Both packages have a bumped version + CHANGELOG entry