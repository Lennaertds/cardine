# Stack nest — `apps/api`

> **Rol:** Een NestJS-API opzetten volgens [stacks §3](../../../standaard/stacks.md#3-nestjs-api). Dit bestand wordt niet gekopieerd.

## 1. Generator

```bash
pnpm dlx @nestjs/cli new api --directory apps/api --package-manager pnpm --skip-git --strict
```

Nest zet zijn tests in `test/`. Verhuis ze meteen naar de vaste plek, zodat er later niets te verhuizen valt:

```bash
mkdir -p apps/api/tests/integration
mv apps/api/test/app.e2e-spec.ts apps/api/tests/integration/app.e2e-spec.ts
mv apps/api/test/jest-e2e.json apps/api/tests/jest-integration.json && rmdir apps/api/test
```

In `tests/jest-integration.json`: `"rootDir": "."` en `"testRegex": "integration/.*\\.e2e-spec\\.ts$"`.

## 2. Kit erover

```bash
kit/new-project.sh <project> --stacks nest --modules compose
```

Dit voegt `app.mk`, `AGENTS.md`, `.env.example` en de mappen `src/common/`, `src/database/migrations/` en `tests/{integration,smoke,fixtures}/` toe. Met de module `compose` start `make dev-api` eerst Postgres.

## 3. Scripts

`app.mk` roept deze scripts aan. Voeg ze toe aan `apps/api/package.json` (de generator heeft `start:dev`, `build` en `test` al):

```json
{
  "scripts": {
    "lint:check": "eslint \"{src,tests}/**/*.ts\"",
    "typecheck": "tsc --noEmit",
    "test:integration": "jest --config ./tests/jest-integration.json --runInBand",
    "seed": "ts-node scripts/seed.ts",
    "db:reset": "<schema leegmaken en alle migraties draaien, met je ORM>"
  }
}
```

Voorbeeld voor `db:reset` met TypeORM: `typeorm-ts-node-commonjs schema:drop -d src/database/data-source.ts && typeorm-ts-node-commonjs migration:run -d src/database/data-source.ts`.

## 4. Health check

`make smoke-api` vraagt `GET /health` op. Zet die route in `src/common/health/`, zonder auth.

## 5. Controleren

```bash
make setup && make up && make check && make dev-api
```
