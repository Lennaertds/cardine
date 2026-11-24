# README.md

> **Rol:** De voorpagina voor mensen: wat het is, waarom, en hoe je het in twee minuten draait.
> **Niet hier:** werkwijze voor de agent ([agents-root](agents-root.md)), architectuur ([architecture](architecture.md)).

**Kitbestand:** [kit/kern/README.md](../kit/kern/README.md) · laag kern

## Wanneer

Altijd. Dag 0 met de quickstart uit de kit; aanvullen zodra er een demo of een eerste gebruiker is.

## Invullen

1. **Titel en één zin:** wat het is en voor wie. Geen marketing.
2. **Waarom:** het probleem in twee à drie zinnen. De volledige context staat in `CONTEXT.md`; verwijs ernaar.
3. **Demo:** link en, als het mag, een testaccount zonder echte data.
4. **Snel starten:** de drie make-commando's uit de kit. Wat je extra nodig hebt (Docker, uv), staat in `make doctor`.
5. **Meer:** links naar `docs/INDEX.md` en `AGENTS.md`. Niet de inhoud ervan herhalen.

## Voorbeeld (GymFreak)

```markdown
# GymFreak

Trainingsplanner als PWA voor wie zelf zijn schema's maakt: plannen, loggen, en trends in kracht, slaap en voeding.

Demo: https://gymfreak.be · testaccount `test@gymfreak.be` (alleen demo-data)

## Snel starten

    make setup   # .env, dependencies, git-hooks
    make up      # Postgres op :5433
    make dev     # web :3002, api :3003

## Meer

Docs: [docs/INDEX.md](docs/INDEX.md) · Werkwijze met een agent: [AGENTS.md](AGENTS.md)
```

## Snelle toets

- [ ] Iemand zonder voorkennis draait het project met alleen dit bestand en `make doctor`.
- [ ] Geen mappenboom, geen lijst van features die in `PRODUCT.md` hoort, geen status.
- [ ] Code privé? Dan staat de publieke uitleg in een aparte repo, niet hier.
