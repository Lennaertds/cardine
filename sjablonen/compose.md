# docker-compose.yml en .env.example (root)

> **Rol:** De lokale diensten (Postgres, Redis, …) waar de apps op draaien.
> **Niet hier:** productie-hosting ([architecture](architecture.md)), de env-variabelen van een app (`apps/<app>/.env.example`).

**Kitbestanden:** [docker-compose.yml](../kit/modules/compose/docker-compose.yml), [.env.example](../kit/modules/compose/.env.example) · module `compose`

## Wanneer

Zodra een app een database of andere dienst nodig heeft. `make up` start alles en wacht op de healthchecks; `make dev-api` doet `make up` eerst.

## Invullen

1. **Eén service per dienst**, met een **healthcheck**: zonder healthcheck wacht `docker compose up --wait` niet, en start de API tegen een database die nog niet klaar is.
2. **Poorten en wachtwoorden via variabelen** met een default (`${POSTGRES_PORT:-5432}`), zodat twee projecten naast elkaar kunnen draaien.
3. **Een volume per dienst** met data, zodat `make down` niets wist. Wissen doe je met `make db-reset`.
4. Root-`.env.example` alleen voor compose. Elke app heeft zijn eigen `.env.example` met `DATABASE_URL`, die naar dezelfde poort wijst.

## Voorbeeld (GymFreak)

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

met in `apps/api/.env.example`: `DATABASE_URL=postgres://gymfreak:gymfreak@localhost:5433/gymfreak`.

## Snelle toets

- [ ] `make up` eindigt pas als elke dienst gezond is.
- [ ] Geen echt wachtwoord in een `.env.example`.
- [ ] De poort in `docker-compose.yml`, de `.env.example` van de app en `ARCHITECTURE.md` is dezelfde.
