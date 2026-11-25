# Inside an app: the fixed layout per stack

> **Role:** How every app looks, and the fixed folders for Next.js, NestJS, Python, SQL, Rust and C (native).
> **Not here:** the make targets ([makefile](makefile.md)), the files to copy ([kit/stacks](../kit/README.md#stacks)).

**One list of domains per project**, recorded in `GLOSSARY.md`. Use the same names everywhere: `docs/product/<domain>.md`, `apps/web/src/features/<domain>/`, `apps/api/src/<domain>/` and the Python module `<domain>.py`. That way `rg <domain>` finds everything that belongs together (P10).

## 1. Every app

```
apps/<app>/
├── README.md            ● what this app does, how to run it on its own
├── AGENTS.md            ○ what applies only here: commands, patterns, pitfalls
├── .env.example         ● every variable this app reads, with an explanation
├── app.mk               ● make targets of this app; the root Makefile picks it up automatically
├── <manifest>           ● package.json or pyproject.toml (Python lockfile here; pnpm-lock at root)
├── <configs>            ● tsconfig, eslint, next/nest/playwright, ruff: at the app root, not in subfolders
├── Dockerfile           ○ or railpack.json: deploy config of exactly this app
├── src/                 ● source code, layout per stack below
├── tests/               ● everything that checks something and does not sit next to the code
│   ├── unit/            ○ Python only; in TypeScript a unit test sits next to the file
│   ├── integration/     ○ against a real database or the running app (API tests)
│   ├── e2e/             ○ through the browser (Playwright)
│   ├── smoke/           ○ quick check against a running or deployed environment (URL as a parameter)
│   └── fixtures/        ○ small, synthetic test data; never real personal data
├── scripts/             ○ helper scripts of this app: seed, generators, probes; output to tmp/
└── experiments/         ○ notebooks and one-off scripts; never imported by src/, not in make check
```

**Test or script?** If it can fail because something is wrong, it is a test and belongs in `tests/` or next to the file. If it only makes or shows something, it is a script.

**Deep modules and seams (P16, P23).** A domain folder (`features/<domain>/`, `src/<domain>/`, `<domain>.py`) hides complexity behind a small interface. Integration tests belong on the **seams** between apps/modules (HTTP contract, writer boundaries), not spread across shallow helpers. A new `utils/`/`helpers/` folder or an extra module: ask for agreement or write an ADR first; otherwise AI speeds up software entropy.

**Commands:** every app has an `app.mk` that adds its targets (`check-web`, `dev-api`, …) to the root `Makefile`. That way `make check` covers all apps together, and the root never needs changing when an app is added. Target names and mechanism: [makefile](makefile.md).

## 2. Next.js (web)

```
apps/web/
├── next.config.ts · tsconfig.json · eslint.config.mjs · postcss.config.mjs · playwright.config.ts
├── server.mjs                     ○ only with a custom server
├── public/                        only what the browser requests directly at a fixed URL
│   ├── favicon.ico · icon-*.png · apple-touch-icon.png · og.jpg · sw.js · robots.txt · <verification>.html
│   ├── brand/                     logos in every variant the site shows
│   └── <use>/                     images per page or theme (about/, themes/); README.md with origin
└── src/
    ├── app/                       routes: page.tsx, layout.tsx, route.ts; thin, they call features/
    ├── features/<domain>/         everything of one domain together
    │   ├── components/            components only this domain uses
    │   ├── hooks/
    │   ├── api.ts                 calls to the API for this domain
    │   ├── <logic>.ts             pure functions, with <logic>.test.ts next to them
    │   └── types.ts
    ├── components/
    │   ├── ui/                    generic building blocks without domain knowledge: button, dialog, date-field
    │   └── layout/                shell, navigation, header, tabbar
    ├── hooks/                     generic hooks (viewport, scroll)
    ├── lib/                       generic helpers without React and without domain: api-client, format, i18n/
    ├── styles/                    ○ tokens and global css, if they do not fit in app/globals.css
    └── types/                     global .d.ts
```

- A feature does not import from another feature. What two features share goes to `components/ui/`, `lib/` or `packages/`.
- Create a `features/<domain>/` folder with the first component of that domain, not only at the tenth. That way there is nothing to move later.
- Tests: unit next to the file (`*.test.ts`, Vitest), browser in `tests/e2e/<flow>.spec.ts`, smoke in `tests/smoke/`.

## 3. NestJS (api)

```
apps/api/
├── nest-cli.json · tsconfig.json · tsconfig.build.json · jest.config.ts
└── src/
    ├── main.ts · app.module.ts    only start up and wire modules
    ├── common/                    what every module uses: env and config, security, guards, filters,
    │                              decorators, health check
    ├── database/                  connection, data source, shared column types
    │   └── migrations/            never modify after merge; named the way the tool generates them
    └── <domain>/
        ├── <domain>.module.ts · <domain>.controller.ts · <domain>.service.ts
        ├── <name>.entity.ts       one per table
        ├── dto/                   request and response shapes with validation
        ├── <domain>-engine.ts     pure domain logic without Nest or database; most unit tests live here
        └── <file>.spec.ts         unit test next to the file
```

Integration tests: `tests/integration/<domain>.e2e-spec.ts`, with the shared setup in `tests/setup-env.ts` and the test data in `tests/fixtures/`.

## 4. Python (data, ML, analytics)

```
apps/<name>/
├── pyproject.toml · uv.lock       also the config for pytest, ruff and mypy: no separate .ini files
├── src/<package>/                 snake_case; importable and tested
│   ├── __init__.py
│   ├── cli.py                     entry point: `uv run <package> <command>`
│   ├── config.py                  paths and settings from env, with data/<layer>/ as default
│   └── <source-or-domain>.py      one module per source or domain (hevy.py, sleep.py, insights.py)
├── tests/
│   ├── unit/test_<module>.py
│   └── fixtures/
└── experiments/
    ├── README.md                  which experiments exist, with a link to docs/research/experiments/
    └── YYYY-MM-DD-<slug>.{ipynb,py}
```

- Once a module grows past ±400 lines, it becomes a sub-package with the same name (`hevy.py` → `hevy/__init__.py`). The import name stays the same, so nothing else moves.
- An experiment that stays becomes code in `src/<package>/` with a test. The notebook stays as a record.
- Models write to `data/models/<model>/`, with a `meta.json` (data, commit, metric).

## 5. Data pipeline with SQL (ETL, warehouse)

```
apps/<pipeline>/
├── sql/
│   ├── migrations/NNNN-<slug>.sql   schema (DDL); never modify after merge
│   ├── staging/<source>__<table>.sql  one-to-one cleaned source tables
│   ├── marts/<topic>.sql            tables and views that reports or apps read
│   └── checks/<name>.sql            data quality; run in make check-full
├── src/<package>/                   Python for extract, load and orchestration ([stacks §4](stacks.md#4-python-data-ml-analytics))
├── dags/                            ○ only with an orchestrator (Airflow, Dagster)
└── tests/
```

With dbt you follow the dbt layout (`models/staging/`, `models/marts/`, `tests/`). The dbt `seeds/` are then your `data/reference/`.

## 6. Rust native (hot path, opt-in)

```
apps/native/
├── Cargo.toml · src/lib.rs        pure logic + tests (`cargo test`)
├── app.mk · AGENTS.md · .env.example
├── scripts/native-check.sh        layout checklist
├── package.json · index.js · test/     ○ --starter: napi → Nest/Node
├── pyproject.toml · native_fallback.py · tests/  ○ --starter: PyO3/maturin → Python
└── scripts/bench.sh               ○ after the first measurement
```

- Only after the polyglot decision tree + an ADR. Kit: `--stacks rust [--starter]` (both FFI scaffolds).
- `CHECK` contains `check-native`. `cargo` in `TOOLS`. JS/pytest only once `node_modules` / `.venv` is ready locally.
- Guide: [kit/stacks/rust/README.md](../kit/stacks/rust/README.md).

## 7. C native (hot path, opt-in)

```
apps/native-c/
├── src/add.c · add.h · tests/test_add.c
├── app.mk · AGENTS.md · .env.example
├── scripts/native-c-check.sh
├── package.json · index.js · test/ · src/napi_addon.c   ○ --starter: N-API → Nest/Node
├── native_c_fallback.py · tests/test_add_py.py · pyproject.toml  ○ --starter: ctypes → Python
└── build/                       gitignored; smoke + libnative_c.so
```

- Only after a polyglot ADR. Kit: `--stacks c [--starter]` (alongside `rust` if you use it).
- `CHECK` contains `check-native-c`. `cc`/`clang` in `TOOLS`.
- Guide: [kit/stacks/c/README.md](../kit/stacks/c/README.md).

## 8. Repo that is itself one package

```
project/
├── pyproject.toml · uv.lock
├── src/<package>/ · tests/ · experiments/
└── docs/ · data/ · scripts/ · tmp/      as in [skeleton](skelet.md)
```

Only if there will never be a second app: a library, a CLI, a standalone analysis or a school assignment with a single series of notebooks.

---
