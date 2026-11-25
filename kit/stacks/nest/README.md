# Stack nest — `apps/api`

> **Role:** Set up a NestJS API following [stacks §3](../../../standard/stacks.md#3-nestjs-api). This file is not copied.

## 1. Generator

```bash
pnpm dlx @nestjs/cli new api --directory apps/api --package-manager pnpm --skip-git --strict
```

Nest puts its tests in `test/`. Move them to their fixed place straight away, so nothing has to be moved later:

```bash
mkdir -p apps/api/tests/integration
mv apps/api/test/app.e2e-spec.ts apps/api/tests/integration/app.e2e-spec.ts
mv apps/api/test/jest-e2e.json apps/api/tests/jest-integration.json && rmdir apps/api/test
```

In `tests/jest-integration.json`: `"rootDir": "."` en `"testRegex": "integration/.*\\.e2e-spec\\.ts$"`.

## 2. Kit on top

```bash
kit/new-project.sh <project> --stacks nest --modules compose
```

This adds `app.mk`, `AGENTS.md`, `.env.example` and the folders `src/common/`, `src/database/migrations/` and `tests/{integration,smoke,fixtures}/`. With module `compose`, `make dev-api` starts Postgres first.

## 3. Scripts

`app.mk` calls these scripts. Add them to `apps/api/package.json` (the generator already has `start:dev`, `build` and `test`):

```json
{
  "scripts": {
    "lint:check": "eslint \"{src,tests}/**/*.ts\"",
    "typecheck": "tsc --noEmit",
    "test:integration": "jest --config ./tests/jest-integration.json --runInBand",
    "seed": "ts-node scripts/seed.ts",
    "db:reset": "<empty the schema and run all migrations, with your ORM>"
  }
}
```

Example for `db:reset` with TypeORM: `typeorm-ts-node-commonjs schema:drop -d src/database/data-source.ts && typeorm-ts-node-commonjs migration:run -d src/database/data-source.ts`.

## 4. Health check

`make smoke-api` requests `GET /health`. Put that route in `src/common/health/`, without auth.

## 5. Check

```bash
make setup && make up && make check && make dev-api
```
