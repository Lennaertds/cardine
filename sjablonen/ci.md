# .github/workflows/check.yml

> **Role:** `make check` on every PR and on `main`, so "green" means the same for everyone.
> **Not here:** what `make check` does ([makefile](../standard/makefile.md)), deploy (the host).

**Kit file:** [kit/team/.github/workflows/check.yml](../kit/team/.github/workflows/check.yml) · layer team · P13, P14

## When

Every team project, from the first PR. Solo works too, but the pre-commit hooks and a local `make check` are usually enough.

## Filling in

1. **Toolchain:** keep what the stacks need (pnpm and Node, uv), remove the rest.
2. **One job, two steps:** `make setup` and `make check`. No separate lint or test steps: then CI drifts apart from what runs locally.
3. **`check-full`** (database, browser, `deps-audit`, `native-bindings-strict`) in a second workflow on `main` or at night; with native stacks also [native.yml](../kit/team/.github/workflows/native.yml).
4. Module `research`: optionally [digest.yml](../kit/team/.github/workflows/digest.yml) (fetch→propose→draft PR; no auto-radar).
5. **Branch protection:** CI green and one review required on `main`.

## Example (DEP2, `check-full` with a database service)

```yaml
name: check-full
on:
  push:
    branches: [main]
jobs:
  check-full:
    runs-on: ubuntu-latest
    services:
      db:
        image: postgres:17
        env: { POSTGRES_USER: app, POSTGRES_PASSWORD: app, POSTGRES_DB: app }
        ports: ["5432:5432"]
        options: --health-cmd "pg_isready -U app" --health-interval 2s --health-retries 15
    steps:
      - uses: actions/checkout@v4
      - uses: astral-sh/setup-uv@v6
      - run: make setup && make check-full
```

## Quick check

- [ ] PR CI runs exactly `make check` (soft); native STRICT lives in `native.yml` / `check-full`.
- [ ] A PR with a failing test cannot be merged.
- [ ] No secrets in the workflow; they live in the repo settings.
