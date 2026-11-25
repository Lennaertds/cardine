# Makefile, apps/&lt;app&gt;/app.mk, local.mk

> **Role:** Adapting the project's commands without breaking the fixed names.
> **Not here:** what every target does and how the mechanism works ([standard/makefile](../standard/makefile.md)).

**Kit files:** [kit/kern/Makefile](../kit/kern/Makefile) · `app.mk` per stack: [next](../kit/stacks/next/apps/web/app.mk), [nest](../kit/stacks/nest/apps/api/app.mk), [python](../kit/stacks/python/apps/analytics/app.mk), [sql](../kit/stacks/sql/apps/pipeline/app.mk) · P13

## When

You copy the root `Makefile` and rarely change it. You work in each app's `app.mk`, and in `local.mk` for what only you use.

## Filling in

| What you want | Where | How |
|---------------|-------|-----|
| A different command for a fixed target | `apps/<app>/app.mk` | change the recipe, keep the name (`check-web` stays `check-web`) |
| A different port | at the top of the `app.mk` | `WEB_PORT ?= 3002`; override per run: `make dev-web WEB_PORT=4000` |
| A new target for one app | that app's `app.mk` | name with `-<app>`, `## explanation`, in the right list (`CHECK_FULL += e2e-web`) |
| A new target for the whole project | root `Makefile`, under the right `##@` group | `## explanation`; add it to `.PHONY` |
| Something only for you | `local.mk` (not in git) | ordinary targets with `## explanation`; `make help` shows them too |
| A second app of the same stack | `apps/<new>/app.mk` | copy it, rename the prefixes and suffixes (`ADMIN_DIR`, `check-admin`) |

Recipes are indented with a **tab**. The kit's `.editorconfig` takes care of that.

## Example (GymFreak, `local.mk`)

A target that uses your own test account does not belong in git:

```make
##@ Personal (local.mk)
boost: ## own test accounts: max coins, all themes
	@node apps/api/scripts/dev-boost.mjs test@gymfreak.be lennaert@gymfreak.be
```

And in `apps/web/app.mk`, when web may only start once the API is listening:

```make
dev-web: ## web: Next dev server; wait until the API listens on API_PORT
	@until (echo >/dev/tcp/127.0.0.1/$(API_PORT)) 2>/dev/null; do sleep 0.5; done
	pnpm --dir $(WEB_DIR) exec next dev --port $(WEB_PORT)
```

## Quick check

- [ ] `make help` shows every target someone uses, with an explanation.
- [ ] `make check` runs without network or database, and ends green.
- [ ] `security-scan*`, `obs-*`, `perf-check` and `bench` are in `make help`, not in `CHECK`.
- [ ] `deps-audit` is in `make help` and in `check-full`, not in `CHECK`.
- [ ] `native-bindings-strict` is in `make help` and in `check-full`, not in the soft `CHECK`.
- [ ] `polyglot-check` is in `make help`, not in `CHECK` / `check-full`.
- [ ] The root `AGENTS.md` mentions opt-in targets in one sentence → `make help`/INDEX, not as eight always-on command rows or a path catalogue.
- [ ] With module `research`: `radar-*` / `digest-check` / `digest-reminder` / `digest-fetch` / `digest-propose` in `make help`, not in `CHECK`.
- [ ] Every target that deletes data has a guard.
- [ ] No recipe longer than ±10 lines; otherwise a script in `scripts/`.
