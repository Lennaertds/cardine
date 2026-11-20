# apps/web — Next.js

Geldt naast de [root-AGENTS.md](../../AGENTS.md). Alleen wat specifiek is voor deze app.

<!-- als: design
UI / scherm / layout / PWA in deze app: eerst [DESIGN.md](../../docs/design/DESIGN.md), dan één craft-bestand. Zelfde regel als in de root.
-->

## Indeling

- Routes in `src/app/` blijven dun: ze roepen `src/features/<domein>/` aan.
- Een feature importeert nooit uit een andere feature. Gedeeld gaat naar `src/components/ui/`, `src/lib/` of `packages/`.
- Nieuw domein → nieuwe map `src/features/<domein>/`, ook bij de eerste component. Naam uit [GLOSSARY.md](../../docs/context/GLOSSARY.md).
- API-calls alleen in `features/<domein>/api.ts`, via de client in `src/lib/`.

## Tests

- Unit naast het bestand: `<naam>.test.ts` (Vitest). Eén test: `pnpm --dir apps/web exec vitest run <pad>`.
- Browser: `tests/e2e/<flow>.spec.ts`. Smoke: `tests/smoke/`.

## Valkuilen

- Fout `Cannot find module './NNN.js'` na `make build-web`: eerst `make clean-web`, dan `make dev-web`.
- Alles wat `NEXT_PUBLIC_` heet, belandt in de browser. Nooit een secret.
- Nieuwe env-variabele: ook in `.env.example`, met een veilige voorbeeldwaarde.
