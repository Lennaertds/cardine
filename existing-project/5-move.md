# Step 5 — Move

> **Role:** Every file to its fixed place, following the move table, without losing history or links. Only after that does the kit fill in what is missing.
> **Not here:** where every file belongs ([skelet](../standard/skelet.md), [where does this belong](../standard/where-does-this-belong.md)).

## Why move first, then the kit

The script overwrites nothing, but it only looks at the **target name**. If you run it before the move, it puts an empty template next to an existing file with the same role: `RULES.md` next to `REGELS.md`, `INDEX.md` next to `INDEX_DOCS.md`. After that `git mv` fails because the target already exists. So: first every existing file gets its fixed name, then the kit fills the gaps.

## Order

1. **Docs**, one commit per folder: `context/`, `rules/`, `product/`, `design/`, `architecture/`, `research/`, `decisions/`, `work/`.

   ```bash
   git mv docs/INDEX_DOCS.md docs/INDEX.md
   git mv docs/architecture/SECURITY.md docs/architecture/security.md
   rg -n 'INDEX_DOCS|SECURITY\.md' . --glob '!node_modules'      # leftover references
   ```

   - Keep existing names if they are already clear: churn costs too. A file that has the role of a kit file but is called differently (`REGELS.md`) does get the kit name: that way every project has the same thing in the same place.
   - A rename that only differs in case works on Linux in one `git mv`. On macOS or Windows in two: `git mv SECURITY.md tmp.md && git mv tmp.md security.md`.
   - Large files with several kinds of content: split them following the move table (P11).
   - Folder trees and file lists: delete them (P5). A per-module description becomes the docstring of that module.
   - A big decision log you split into separate ADRs only if the measurement asks for it; then a script is faster than by hand.

2. **Data** into the layers ([data](../standard/data.md)). Change the paths in the code along the way, preferably behind one env variable per layer, and fill in `data/README.md` per dataset. Then remove the old data rules at the bottom of `.gitignore` ([step 4](4-opruimen.md)), and check:

   ```bash
   git status --short data/                              # nothing vanished or suddenly tracked
   git ls-files -ci --exclude-standard                   # empty
   ```

3. **Apps**: tests to their fixed place (`tests/integration/`, `tests/e2e/`, `tests/smoke/`) and configs to the app root. The rest **on touch**: when you work on a file anyway, it moves to `features/<domain>/` or `src/<domain>/`. No big move of code at once: that breaks every open branch.

4. **The kit for what is missing**, dry first:

   ```bash
   kit/new-project.sh <project> --modules <modules> --stacks <stacks> --no-git --dry-run
   kit/new-project.sh <project> --modules <modules> --stacks <stacks> --no-git
   ```

   - Never `--starter`: that starter code belongs to a new app and clashes with an existing package.
   - Read the list with `+`. If it shows a template whose content the project already has under another name, a row is missing from the move table: add it, move, and run again.
   - The list with `=` is what already exists; that file stays as it is. Compare it with the kit file and take over what is missing by hand. For `app.mk`, `.env.example` and `docker-compose.yml`: the kit version is an example, the project's values (ports, service names, versions) win.
   - A new template you do not fill in during this reorganisation goes back out. An empty file in the map is a distraction.

5. **After every commit:** `make check`. The link check catches references to old paths.

## Done when

- Every row in the move table is ticked off, or has "on touch" as its status.
- A second dry run of the kit shows only templates you deliberately do not use.
- `make check` is green, so no dead links.
- `rg` on every old name only finds hits in the move table.
- Rules outside the repo (workspace rules, user rules) no longer point at old paths.
