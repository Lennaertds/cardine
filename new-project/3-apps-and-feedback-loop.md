# Step 3 — Apps and feedback loop

> **Role:** Generate every app, put the kit on top, and get `make check` green with a real test. This pays off most of all steps (P13).
> **Not here:** the layout inside an app ([stacks](../standard/stacks.md)), what each target does ([makefile](../standard/makefile.md)).

## Do

1. **Generator per app, in this order: generator first, kit after.** The generators refuse a folder that is not empty. The commands are in the guide per stack:

   | Stack | Guide |
   |-------|-------|
   | Next.js → `apps/web` | [kit/stacks/next](../kit/stacks/next/README.md) |
   | NestJS → `apps/api` | [kit/stacks/nest](../kit/stacks/nest/README.md) |
   | Python → `apps/analytics` | [kit/stacks/python](../kit/stacks/python/README.md) |
   | SQL pipeline → `apps/pipeline` | [kit/stacks/sql](../kit/stacks/sql/README.md) |

2. **Kit on top of the apps:**

   ```bash
   kit/new-project.sh . --stacks next,nest --starter
   ```

   This installs `app.mk`, `AGENTS.md`, `.env.example` and the fixed folders per app. The root `Makefile` finds each `app.mk` by itself.

3. **Add the scripts** that `app.mk` calls (`lint`, `typecheck`, `test`, …): see step 3 in each stack guide.

4. **Install and check:**

   ```bash
   make setup        # .env from .env.example, dependencies per app, pre-commit
   make up           # only with the compose module
   make check        # lint, types, unit tests of every app + links
   make dev          # all apps at once
   ```

5. **One real test per app** that passes, even if it tests almost nothing. With `--starter` the Python stacks bring one along (`test_config.py`).

6. **Team:** CI runs `make check` on every PR (`.github/workflows/check.yml` from the team layer). Set branch protection on `main`.

## Done when

- `make check` ends with `make check: green`.
- `make help` shows one group per app.
- `make doctor` shows no `MISSING`.
- In `ARCHITECTURE.md` the ports from the `app.mk` files are listed (`WEB_PORT`, `API_PORT`).

## Extra apps and targets

- **A second app of the same stack:** copy `kit/stacks/<stack>/apps/<app>/` by hand to `apps/<new-app>/` and rename the prefix in `app.mk`.
- **Your own project target** (e.g. `boost`): in the `app.mk` of the app it belongs to, with `## explanation`.
- **Personal target** (e.g. with your own test account): in `local.mk`; not in git.

## Pitfalls

- `make check` touches the network or the database: that belongs in `check-full`. `check` must run in seconds to a minute, otherwise the agent will not run it.
- A generator creates its own `README.md` or `AGENTS.md`: the kit skips those (output with `=`). Copy the rules from the kit `AGENTS.md` over by hand.
- Delete generator boilerplate (sample logos, demo routes) straight away: they are distractions.
