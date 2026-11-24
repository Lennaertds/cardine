# Binnen een app: vaste indeling per stack

> **Rol:** Hoe elke app eruitziet, en de vaste mappen voor Next.js, NestJS, Python, SQL, Rust en C (native).
> **Niet hier:** de make-targets ([makefile](makefile.md)), de bestanden om te kopiëren ([kit/stacks](../kit/README.md#stacks)).

**Eén lijst domeinen per project**, vastgelegd in `GLOSSARY.md`. Gebruik overal dezelfde namen: `docs/product/<domein>.md`, `apps/web/src/features/<domein>/`, `apps/api/src/<domein>/` en de Python-module `<domein>.py`. Zo vindt `rg <domein>` alles wat erbij hoort (P10).

## 1. Elke app

```
apps/<app>/
├── README.md            ● wat deze app doet, hoe je ze los draait
├── AGENTS.md            ○ wat alleen hier geldt: commando's, patronen, valkuilen
├── .env.example         ● elke variabele die deze app leest, met uitleg
├── app.mk               ● make-targets van deze app; de root-Makefile neemt het automatisch op
├── <manifest>           ● package.json of pyproject.toml (Python-lockfile hier; pnpm-lock op root)
├── <configs>            ● tsconfig, eslint, next/nest/playwright, ruff: op app-root, niet in submappen
├── Dockerfile           ○ of railpack.json: deploy-config van precies deze app
├── src/                 ● broncode, indeling per stack hieronder
├── tests/               ● alles wat iets controleert en niet naast de code staat
│   ├── unit/            ○ alleen Python; in TypeScript staat een unit-test naast het bestand
│   ├── integration/     ○ tegen een echte database of de draaiende app (API-tests)
│   ├── e2e/             ○ door de browser (Playwright)
│   ├── smoke/           ○ korte check tegen een draaiende of gedeployde omgeving (URL als parameter)
│   └── fixtures/        ○ kleine, synthetische testdata; nooit echte persoonsgegevens
├── scripts/             ○ hulpscripts van deze app: seed, generators, probes; uitvoer naar tmp/
└── experiments/         ○ notebooks en eenmalige scripts; nooit geïmporteerd door src/, niet in make check
```

**Test of script?** Kan het falen omdat iets fout is, dan is het een test en hoort het in `tests/` of naast het bestand. Maakt of toont het alleen iets, dan is het een script.

**Deep modules en seams (P16, P23).** Een domeinmap (`features/<domein>/`, `src/<domein>/`, `<domein>.py`) verbergt complexiteit achter een kleine interface. Integratietests horen op de **naden** tussen apps/modules (HTTP-contract, writer-grenzen), niet verspreid over ondiepe helpers. Nieuwe `utils/`/`helpers/` of een extra module: eerst akkoord of ADR; anders versnelt AI software-entropie.

**Commando's:** elke app heeft een `app.mk` dat zijn targets (`check-web`, `dev-api`, …) aan de root-`Makefile` toevoegt. Zo werkt `make check` voor alle apps samen, en hoef je de root nooit aan te passen als er een app bijkomt. Targetnamen en mechanisme: [makefile](makefile.md).

## 2. Next.js (web)

```
apps/web/
├── next.config.ts · tsconfig.json · eslint.config.mjs · postcss.config.mjs · playwright.config.ts
├── server.mjs                     ○ alleen bij een custom server
├── public/                        alleen wat de browser rechtstreeks op een vaste URL opvraagt
│   ├── favicon.ico · icon-*.png · apple-touch-icon.png · og.jpg · sw.js · robots.txt · <verificatie>.html
│   ├── brand/                     logo's in alle varianten die de site toont
│   └── <gebruik>/                 afbeeldingen per pagina of thema (about/, themes/); README.md met herkomst
└── src/
    ├── app/                       routes: page.tsx, layout.tsx, route.ts; dun, ze roepen features/ aan
    ├── features/<domein>/         alles van één domein samen
    │   ├── components/            componenten die alleen dit domein gebruikt
    │   ├── hooks/
    │   ├── api.ts                 calls naar de API voor dit domein
    │   ├── <logica>.ts            pure functies, met <logica>.test.ts ernaast
    │   └── types.ts
    ├── components/
    │   ├── ui/                    generieke bouwstenen zonder domeinkennis: button, dialog, date-field
    │   └── layout/                shell, navigatie, header, tabbar
    ├── hooks/                     generieke hooks (viewport, scroll)
    ├── lib/                       generieke helpers zonder React en zonder domein: api-client, format, i18n/
    ├── styles/                    ○ tokens en globale css, als ze niet in app/globals.css passen
    └── types/                     globale .d.ts
```

- Een feature importeert niet uit een andere feature. Wat twee features delen, gaat naar `components/ui/`, `lib/` of `packages/`.
- Een map `features/<domein>/` maak je bij de eerste component van dat domein, niet pas bij de tiende. Zo is er later niets te verhuizen.
- Tests: unit naast het bestand (`*.test.ts`, Vitest), browser in `tests/e2e/<flow>.spec.ts`, smoke in `tests/smoke/`.

## 3. NestJS (api)

```
apps/api/
├── nest-cli.json · tsconfig.json · tsconfig.build.json · jest.config.ts
└── src/
    ├── main.ts · app.module.ts    alleen opstarten en modules koppelen
    ├── common/                    wat elke module gebruikt: env en config, security, guards, filters,
    │                              decorators, health check
    ├── database/                  verbinding, data source, gedeelde kolomtypes
    │   └── migrations/            nooit wijzigen na merge; naam zoals de tool hem genereert
    └── <domein>/
        ├── <domein>.module.ts · <domein>.controller.ts · <domein>.service.ts
        ├── <naam>.entity.ts       één per tabel
        ├── dto/                   request- en response-vormen met validatie
        ├── <domein>-engine.ts     pure domeinlogica zonder Nest of database; hier zitten de meeste unit-tests
        └── <bestand>.spec.ts      unit-test naast het bestand
```

Integratietests: `tests/integration/<domein>.e2e-spec.ts`, met de gedeelde setup in `tests/setup-env.ts` en de testdata in `tests/fixtures/`.

## 4. Python (data, ML, analytics)

```
apps/<naam>/
├── pyproject.toml · uv.lock       ook de config van pytest, ruff en mypy: geen aparte .ini-bestanden
├── src/<pakket>/                  snake_case; importeerbaar en getest
│   ├── __init__.py
│   ├── cli.py                     ingang: `uv run <pakket> <commando>`
│   ├── config.py                  paden en instellingen uit env, met data/<laag>/ als default
│   └── <bron-of-domein>.py        één module per bron of domein (hevy.py, sleep.py, insights.py)
├── tests/
│   ├── unit/test_<module>.py
│   └── fixtures/
└── experiments/
    ├── README.md                  welke experimenten er zijn, met een link naar docs/research/experiments/
    └── YYYY-MM-DD-<slug>.{ipynb,py}
```

- Groeit een module boven ±400 regels, dan wordt ze een subpakket met dezelfde naam (`hevy.py` → `hevy/__init__.py`). De importnaam blijft gelijk, dus er verhuist verder niets.
- Een experiment dat blijft, wordt code in `src/<pakket>/` met een test. Het notebook blijft staan als verslag.
- Modellen schrijven naar `data/models/<model>/`, met een `meta.json` (data, commit, metriek).

## 5. Datapipeline met SQL (ETL, warehouse)

```
apps/<pipeline>/
├── sql/
│   ├── migrations/NNNN-<slug>.sql   schema (DDL); nooit wijzigen na merge
│   ├── staging/<bron>__<tabel>.sql  één-op-één opgekuiste brontabellen
│   ├── marts/<onderwerp>.sql        tabellen en views die rapporten of apps lezen
│   └── checks/<naam>.sql            datakwaliteit; draaien in make check-full
├── src/<pakket>/                    Python voor extract, load en orkestratie ([stacks §4](stacks.md#4-python-data-ml-analytics))
├── dags/                            ○ alleen met een orchestrator (Airflow, Dagster)
└── tests/
```

Met dbt volg je de dbt-indeling (`models/staging/`, `models/marts/`, `tests/`). De `seeds/` van dbt zijn dan je `data/reference/`.

## 6. Rust native (hot path, opt-in)

```
apps/native/
├── Cargo.toml · src/lib.rs        pure logica + tests (`cargo test`)
├── app.mk · AGENTS.md · .env.example
├── scripts/native-check.sh        layout-checklist
├── package.json · index.js · test/     ○ --starter: napi → Nest/Node
├── pyproject.toml · native_fallback.py · tests/  ○ --starter: PyO3/maturin → Python
└── scripts/bench.sh               ○ na eerste meting
```

- Alleen na polyglot-beslisboom + ADR. Kit: `--stacks rust [--starter]` (beide FFI-scaffolds).
- `CHECK` bevat `check-native`. `cargo` in `TOOLS`. JS/pytest alleen als `node_modules` / `.venv` lokaal klaar is.
- Gids: [kit/stacks/rust/README.md](../kit/stacks/rust/README.md).

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

- Alleen na polyglot-ADR. Kit: `--stacks c [--starter]` (naast eventueel `rust`).
- `CHECK` bevat `check-native-c`. `cc`/`clang` in `TOOLS`.
- Gids: [kit/stacks/c/README.md](../kit/stacks/c/README.md).

## 8. Repo dat zelf één pakket is

```
project/
├── pyproject.toml · uv.lock
├── src/<pakket>/ · tests/ · experiments/
└── docs/ · data/ · scripts/ · tmp/      zoals in [skelet](skelet.md)
```

Alleen als er nooit een tweede app komt: een library, een CLI, een losstaande analyse of een schoolopdracht met één reeks notebooks.

---
