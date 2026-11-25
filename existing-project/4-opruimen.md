# Step 4 — Clean up

> **Role:** Remove first, only then move or rewrite. A smaller repo is easier to reorganise.
> **Not here:** what may go ([step 2](2-classificeren.md), rules 1 to 4).

## Do, each in its own commit

1. **`.gitignore` from the kit.** The kit block on top, the rules only for this project at the bottom under `# --- Specific to this project`. Rules for the current data folders (e.g. `data/user/`, exceptions like `!data/evidence/**`) stay there until the data has moved to the layers in [step 5](5-move.md); only then do they go. Then what is already committed but should be ignored:

   ```bash
   git ls-files -ci --exclude-standard            # what is in git but should be ignored
   git rm -r --cached .pnpm-store tmp apps/analytics/src/*.egg-info
   ```

2. **`.editorconfig` and `.pre-commit-config.yaml`** from the kit, then `pre-commit install` and `pre-commit run --all-files`. Whatever the hooks find (large files, raw data, a private key) is immediately a row in the move table.

3. **Remove distractions.** Old variants, `_v3` files, docs about deleted code, sync conflicts, empty files, generator boilerplate. Git keeps them; whoever needs them finds them with `git log --all -- <path>`. In doubt: `docs/archive/` with an exclusion in the map.

4. **Name parallel tracks.** Two ways of doing the same thing (two pipelines, two schemas, an old and a new dashboard track): pick one with an ADR. The other goes to `legacy/` with a two-line `legacy/AGENTS.md` ("do not extend; read only for comparison"), or goes away.

5. **Seams before AI volume (P23).** Before you let agents do big refactors: note the seams (who talks to whom) in `ARCHITECTURE.md` § Seams and put or restore integration tests on them. Without that harness around the code, AI speeds up entropy (§32).

6. **Status out of the stable docs.** "Latest changes", TODOs, sprint state: to `docs/work/` (solo) or issues (team), then removed (P8, P27).

## Done when

- `git ls-files -ci --exclude-standard` returns nothing.
- `pre-commit run --all-files` is green.
- No file name contains `_v2`, `_final`, `_new`, `copy` or `sync-conflict` any more.
- Seams for the core flows are in place (or planned) before big agent refactors.
- `make check` is still green.
