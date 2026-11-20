# apps/api — NestJS

Geldt naast de [root-AGENTS.md](../../AGENTS.md). Alleen wat specifiek is voor deze app.

## Indeling

- Eén map per domein in `src/<domein>/`: module, controller, service, entities, `dto/`. Naam uit [GLOSSARY.md](../../docs/context/GLOSSARY.md).
- Domeinlogica in `<domein>-engine.ts`: pure functies, zonder Nest of database. Daar zitten de meeste unit-tests.
- Wat elke module gebruikt (config, guards, filters, health): `src/common/`.
- Controllers blijven dun: valideren met DTO's, de service aanroepen, niets meer.

## Database

- Migraties in `src/database/migrations/`: nooit wijzigen na merge, altijd een nieuwe. Vraag eerst toestemming.
- Schema veranderen = migratie + entity + `docs/architecture/data-model.md` als dat bestaat.
- Lokaal opnieuw beginnen: `make db-reset-api` (weigert buiten localhost).

## Tests

- Unit naast het bestand: `<naam>.spec.ts`. Eén test: `pnpm --dir apps/api exec jest <pad>`.
- Integratie: `tests/integration/<domein>.e2e-spec.ts`, testdata in `tests/fixtures/`.

## Valkuilen

- Nieuwe env-variabele: valideren in `src/common/` en toevoegen aan `.env.example`.
- Elke route vereist auth, behalve wat expliciet publiek is (`/health`, login).
