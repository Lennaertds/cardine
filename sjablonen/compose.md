# docker-compose.yml and .env.example (root)

> **Role:** The local services (Postgres, Redis, …) the apps run on.
> **Not here:** production hosting ([architecture](architecture.md)), an app's env variables (`apps/<app>/.env.example`).

**Kit files:** [docker-compose.yml](../kit/modules/compose/docker-compose.yml), [.env.example](../kit/modules/compose/.env.example) · module `compose`

## When

As soon as an app needs a database or another service. `make up` starts everything and waits for the health checks; `make dev-api` runs `make up` first.

## Filling in

1. **One service per service**, with a **health check**: without one, `docker compose up --wait` does not wait, and the API starts against a database that is not ready yet.
2. **Ports and passwords via variables** with a default (`${POSTGRES_PORT:-5432}`), so two projects can run side by side.
3. **One volume per service** with data, so `make down` deletes nothing. Deleting is done with `make db-reset`.
4. Root `.env.example` only for compose. Every app has its own `.env.example` with `DATABASE_URL`, pointing at the same port.

## Example (GymFreak)

```yaml
services:
  db:
    image: postgres:17
    environment:
      POSTGRES_USER: ${POSTGRES_USER:-gymfreak}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD:-gymfreak}
      POSTGRES_DB: ${POSTGRES_DB:-gymfreak}
    ports:
      - "${POSTGRES_PORT:-5433}:5432"
```

with in `apps/api/.env.example`: `DATABASE_URL=postgres://gymfreak:gymfreak@localhost:5433/gymfreak`.

## Quick check

- [ ] `make up` only finishes once every service is healthy.
- [ ] No real password in a `.env.example`.
- [ ] The port in `docker-compose.yml`, the app's `.env.example` and `ARCHITECTURE.md` is the same.
