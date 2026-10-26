# Digest — inbound feeds

> **Rol:** Periodieke *inbound* hits (changelogs, advisories, papers) ophalen en voorstellen — vóór ze op de radar of in § belanden.
> **Niet hier:** de tech-radar zelf ([radar.md](../radar.md)); wantlist ([wantlist.md](../wantlist.md)); feed-dumps als waarheid (P5).

Ruwe dumps: `data/external/digest/` (gitignored behalve README/`.gitkeep`). Voorstellen: `proposals/` (wél in git). **Cureren** blijft mens/agent: niets uit een feed is SSOT.

## Ritueel

1. `SOURCES.example.md` → `SOURCES.md` en vul echte feed-URL’s in.
2. `make digest-fetch` — RSS/Atom → `data/external/digest/<YYYY-MM-DD>-<slug>/` (`raw.xml` + `items.md`).
3. `make digest-propose` — kandidaat-rijen in `proposals/<datum>-draft.md` (wijzigt **niet** `radar.md`).
4. Review → geaccepteerde rijen handmatig naar [radar.md](../radar.md) / wantlist / (Agent Engineering) `bron/bronnen.md` §.
5. Team: workflow `.github/workflows/digest.yml` opent een **draft-PR** met alleen het voorstel.
6. `make digest-check` na structurele edits.

Offline/test: `DIGEST_FIXTURE=docs/research/digest/fixtures/example.rss make digest-fetch`.

## Bronnenlijst

Kopieer [SOURCES.example.md](SOURCES.example.md) → `SOURCES.md`. Geen secrets in URLs met tokens. Fixture: [fixtures/example.rss](fixtures/example.rss).

## Commando's

```bash
make digest-check       # scaffold-structuur; module research
make digest-reminder    # tip
make digest-fetch       # live of DIGEST_FIXTURE=…; DIGEST_DRY_RUN=1
make digest-propose     # proposals/*-draft.md; DIGEST_DRY_RUN=1
```

How-to: [../../how-to/digest.md](../../how-to/digest.md).

## Bewust later

Vaste kop (P28): vraag ernaar of BACKLOG als dit nodig wordt.

| Uitbreiding | Waarom later | Vraag als |
|-------------|--------------|-----------|
| Auto-merge van voorstel-rijen in `radar.md` | P5 — feeds zijn geen SSOT | Team wil zero-touch Adopt/Trial |
| LLM-samenvatting van feed-items | Extra modelkosten / noise (P25) | Voorstel te lang om handmatig te lezen |
| Digest in **kern** (elk project) | Opt-in via `research` | Project zonder research wil toch digest |
| Always-on in AGENTS | Harness tax (P25) | Elke taak moet feeds zien (meestal niet) |
| HTML-scraping (niet RSS/Atom) | Fragiel, ToS, supply-chain | Bron heeft geen feed |
