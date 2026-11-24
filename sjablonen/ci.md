# .github/workflows/check.yml

> **Rol:** `make check` op elke PR en op `main`, zodat "groen" voor iedereen hetzelfde betekent.
> **Niet hier:** wat `make check` doet ([makefile](../standaard/makefile.md)), deploy (de host).

**Kitbestand:** [kit/team/.github/workflows/check.yml](../kit/team/.github/workflows/check.yml) · laag team · P13, P14

## Wanneer

Elk teamproject, vanaf de eerste PR. Solo kan ook, maar de pre-commit-hooks en `make check` lokaal volstaan meestal.

## Invullen

1. **Toolchain:** laat staan wat de stacks nodig hebben (pnpm en Node, uv), schrap de rest.
2. **Eén job, twee stappen:** `make setup` en `make check`. Geen losse lint- of teststappen: dan loopt CI uiteen met wat lokaal draait.
3. **`check-full`** (database, browser, `deps-audit`, `native-bindings-strict`) in een tweede workflow op `main` of 's nachts; bij native-stacks ook [native.yml](../kit/team/.github/workflows/native.yml).
4. Module `research`: optioneel [digest.yml](../kit/team/.github/workflows/digest.yml) (fetch→propose→draft-PR; geen auto-radar).
5. **Branch protection:** CI groen en één review vereist op `main`.

## Voorbeeld (DEP2, `check-full` met een database-service)

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

## Snelle toets

- [ ] PR-CI draait exact `make check` (soft); native STRICT zit in `native.yml` / `check-full`.
- [ ] Een PR met een falende test kan niet gemerged worden.
- [ ] Geen secrets in de workflow; die staan in de repo-instellingen.
