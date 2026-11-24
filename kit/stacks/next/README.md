# Stack next — `apps/web`

> **Rol:** Een Next.js-app opzetten volgens [stacks §2](../../../standaard/stacks.md#2-nextjs-web). Dit bestand wordt niet gekopieerd.

## 1. Generator (eerst, in een lege `apps/web`)

```bash
pnpm create next-app@latest apps/web --ts --eslint --app --src-dir --tailwind --use-pnpm --import-alias '@/*' --skip-install
```

`create-next-app` weigert een map die niet leeg is. Draai daarom eerst de generator en kopieer daarna de kit.

## 2. Kit erover

```bash
kit/new-project.sh <project> --stacks next
```

Dit voegt `app.mk`, `AGENTS.md`, `.env.example` en de mappen `src/features/`, `src/components/{ui,layout}/` en `tests/{e2e,smoke}/` toe. Bestaande bestanden worden nooit overschreven. Heeft de generator al een `AGENTS.md` gemaakt, dan neem je de regels uit de kit-versie met de hand over.

## 3. Scripts en dev-dependencies

```bash
pnpm --dir apps/web add -D vitest @vitejs/plugin-react jsdom @testing-library/react @playwright/test prettier
```

`app.mk` roept deze scripts aan. Voeg ze toe aan `apps/web/package.json`:

```json
{
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "eslint .",
    "typecheck": "tsc --noEmit",
    "test": "vitest run",
    "test:e2e": "playwright test tests/e2e",
    "test:smoke": "playwright test tests/smoke",
    "format": "prettier --write ."
  }
}
```

## 4. Controleren

```bash
make setup && make check && make dev-web
```
