# Step 1 — Baseline and inventory

> **Role:** Record how the project stands now, before you change anything.
> **Not here:** what you do with each file ([step 2](2-classificeren.md)), how you measure ([meten](../measurement/INDEX.md)).

## 1. Baseline (P21)

Pick five tasks from the git history and run them on the current state: condition **C1** from [meten](../measurement/2-condities.md). The minimal version is enough: [meten](../measurement/INDEX.md#minimal-version-one-afternoon). Pick the tasks **now**, before you know the new structure, otherwise you are measuring your task selection.

## 2. Create the move table

Copy only [the template](../kit/modules/reorganise/docs/work/specs/reorganise.md), by hand. The script only runs in [step 5](5-move.md), after the move; now it would put empty kern files next to the existing docs.

```bash
mkdir -p <project>/docs/work/specs
cp -n kit/modules/reorganise/docs/work/specs/reorganise.md <project>/docs/work/specs/
sed -i 's/{{PROJECT}}/<Project>/g; s/{{DATE}}/'"$(date +%F)"'/g' <project>/docs/work/specs/reorganise.md
```

## 3. Inventory

```bash
cd <project>
fd -e md -e mdc -e txt . --exclude node_modules --exclude .venv | sort       # all text
fd -H '^(\.cursorrules|AGENTS\.md|CLAUDE\.md|\.windsurfrules|copilot-instructions\.md)$'   # all routers
fd -H -t d '^\.cursor$' ; fd -H -e mdc                                        # cursor rules
wc -l $(fd -e md . docs) | sort -n | tail -n 20                               # the largest docs
git ls-files | rg -n '(node_modules|\.pnpm-store|\.next|egg-info|__pycache__|^tmp/)' | head   # build output in git
fd -H 'sync-conflict' ; fd -e md -S -1k                                       # sync leftovers, empty docs
```

Put every file as a row in the move table, column **Now**. For large files with several kinds of content: one row per section.

## 4. Dry run of the kit

```bash
kit/new-project.sh <project> --modules <modules> --stacks <stacks> --no-git --dry-run
```

Lines with `+` are still missing; those with `=` already exist and you merge them by hand later. Pick the modules that fit what you saw in the inventory (a `research/`-like folder → `research`; uploads → `runtime`). Every `+` that has the role of an existing file under another name becomes a row in the move table: that file moves to the kit name in step 5.

## 5. Rules outside the repo

Also note the rules that act on the agent **outside** the project: workspace rules, user rules, `.cursor/rules/` in a parent folder. Those can clash with the project's router (context clash, §8).

## Done when

- The baseline is in `results.csv` ([protocol](../measurement/3-protocol.md)).
- Every doc and agent file is in the move table.
- You know which kit files are missing and which already have a counterpart.
