# Stack next — `apps/web`

> **Role:** Set up a Next.js app following [stacks §2](../../../standard/stacks.md#2-nextjs-web). This file is not copied.

## 1. Generator (first, in an empty `apps/web`)

```bash
pnpm create next-app@latest apps/web --ts --eslint --app --src-dir --tailwind --use-pnpm --import-alias '@/*' --skip-install
```

`create-next-app` refuses a folder that is not empty. So run the generator first and copy the kit afterwards.

## 2. Kit on top

```bash
kit/new-project.sh <project> --stacks next
```

This adds `app.mk`, `AGENTS.md`, `.env.example` and the folders `src/features/`, `src/components/{ui,layout}/` and `tests/{e2e,smoke}/`. Existing files are never overwritten. If the generator already created an `AGENTS.md`, take the rules from the kit version over by hand.

## 3. Scripts and dev dependencies

```bash
pnpm --dir apps/web add -D vitest @vitejs/plugin-react jsdom @testing-library/react @playwright/test prettier
```

`app.mk` calls these scripts. Add them to `apps/web/package.json`:

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

## 4. Check

```bash
make setup && make check && make dev-web
```
