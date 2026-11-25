# Step 3 — Feedback loop

> **Role:** Before you start on docs: make sure `make check` exists, covers everything and is green. This pays off most and changes no documentation (P13).
> **Not here:** the targets and the mechanism ([makefile](../standard/makefile.md)).

## Do

1. **Kit Makefile as the base.** In this step you copy by hand; the script only runs in [step 5](5-move.md), after the move. If a Makefile already exists, rename it temporarily and take the kit version:

   ```bash
   git mv Makefile Makefile.old
   cp kit/kern/Makefile <project>/Makefile && sed -i 's/{{PROJECT}}/<Project>/' <project>/Makefile
   cp -n kit/kern/scripts/check-links.sh <project>/scripts/
   ```

2. **An `app.mk` per app** from `kit/stacks/<stack>/apps/<app>/app.mk`. Adapt the commands to the scripts the app already has, but keep the target names. If a tool is missing (no unit tests, no linter), leave that line out and file a backlog item; a command that does not exist makes `check` red:

   ```make
   check-web: ## web: lint, types and unit tests
   	pnpm --filter @gymfreak/web lint
   	pnpm --filter @gymfreak/web typecheck
   ```

3. **Carry over old targets** to the fixed names. One table in the commit message or the move table:

   | Old | New | Where |
   |-----|-----|-------|
   | `make start` | `make dev` | root (`DEV` from the `app.mk` files) |
   | `make web`, `make api` | `make dev-web`, `make dev-api` | `app.mk` |
   | `make clean` (only `.next`) | `make clean-web`; `make clean` does everything | `app.mk` |
   | a personal target only you use | the same name | `local.mk` |

   A target that fits no list keeps existing, in the `app.mk` of the app it belongs to, with `## explanation`.

4. **Separate fast and full.** `check` = lint, types, unit tests of **every** app, without network or database. What needs Postgres, a browser or an external service goes to `check-full`.

5. **Get it green.** If `make check` fails on existing problems, fix them or add a temporary exception with a backlog item. A check that is always red teaches the agent to ignore it.

6. Delete `Makefile.old` once every target has a place.

## Done when

- `make check` ends with `make check: green` and covers every app.
- `make help` shows every target someone uses.
- `AGENTS.md` (or the old router) names `make check` as the first finishing step. The rewrite follows in [step 6](6-router-and-map.md).

Worked out for GymFreak: [G-1](examples/gymfreak.md#step-g-1-make-check-and-the-fixed-targets-g1).
