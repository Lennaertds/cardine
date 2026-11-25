# apps/api — NestJS

Applies on top of the [root AGENTS.md](../../AGENTS.md). Only what is specific to this app.

## Layout

- One folder per domain in `src/<domain>/`: module, controller, service, entities, `dto/`. Name from [GLOSSARY.md](../../docs/context/GLOSSARY.md).
- Domain logic in `<domain>-engine.ts`: pure functions, without Nest or a database. Most unit tests live there.
- What every module uses (config, guards, filters, health): `src/common/`.
- Controllers stay thin: validate with DTOs, call the service, nothing more.

## Database

- Migrations in `src/database/migrations/`: never change after merge, always add a new one. Ask permission first.
- Changing the schema = migration + entity + `docs/architecture/data-model.md` if it exists.
- Start over locally: `make db-reset-api` (refuses outside localhost).

## Tests

- Unit next to the file: `<name>.spec.ts`. One test: `pnpm --dir apps/api exec jest <path>`.
- Integration: `tests/integration/<domain>.e2e-spec.ts`, test data in `tests/fixtures/`.

## Pitfalls

- New env variable: validate it in `src/common/` and add it to `.env.example`.
- Every route requires auth, except what is explicitly public (`/health`, login).
