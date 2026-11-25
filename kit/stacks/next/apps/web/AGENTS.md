# apps/web — Next.js

Applies on top of the [root AGENTS.md](../../AGENTS.md). Only what is specific to this app.

<!-- als: design
UI / screen / layout / PWA in this app: [DESIGN.md](../../docs/design/DESIGN.md) first, then one craft file. Same rule as in the root.
-->

## Layout

- Routes in `src/app/` stay thin: they call `src/features/<domain>/`.
- A feature never imports from another feature. Shared code goes to `src/components/ui/`, `src/lib/` or `packages/`.
- New domain → new folder `src/features/<domain>/`, even for the first component. Name from [GLOSSARY.md](../../docs/context/GLOSSARY.md).
- API calls only in `features/<domain>/api.ts`, through the client in `src/lib/`.

## Tests

- Unit next to the file: `<name>.test.ts` (Vitest). One test: `pnpm --dir apps/web exec vitest run <path>`.
- Browser: `tests/e2e/<flow>.spec.ts`. Smoke: `tests/smoke/`.

## Pitfalls

- Error `Cannot find module './NNN.js'` after `make build-web`: `make clean-web` first, then `make dev-web`.
- Anything named `NEXT_PUBLIC_` ends up in the browser. Never a secret.
- New env variable: also in `.env.example`, with a safe example value.
