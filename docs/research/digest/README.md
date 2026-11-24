# Digest — inbound feeds

> **Verhuisd binnen de repo** — de live digest staat in `bron/digest/` en `bron/weken/`. Zie [MOVED.md](MOVED.md). Dit lab-scaffold blijft als kit-voorbeeld.
>
> **Rol:** Periodieke *inbound* hits (changelogs, advisories, papers) ophalen en voorstellen — vóór ze op de radar of in § belanden.
> **Niet hier:** de tech-radar zelf ([radar.md](../radar.md)); wantlist ([wantlist.md](../wantlist.md)); feed-dumps als waarheid (P5).

Ruwe dumps: `data/external/digest/` (gitignored behalve README/`.gitkeep`). Voorstellen: `proposals/` (wél in git). **Cureren** blijft mens/agent: niets uit een feed is SSOT.

## Ritueel

1. Live feeds: [SOURCES.md](SOURCES.md) (arXiv + Hugging Face Daily Papers / topic-search JSON). Voorbeeld: [SOURCES.example.md](SOURCES.example.md).
2. Weekdays: `make digest-fetch` — RSS/Atom/JSON → `data/external/digest/<YYYY-MM-DD>-<slug>/`.
3. Maandag: `make digest-week` — fetch (+ HF `daily_papers?week=`) + propose + weekbrief in Agent Engineering `bron/weken/YYYY-Www.md` (wijzigt **niet** `radar.md` / `bronnen.md`).
4. Review → geaccepteerde hits handmatig naar [radar.md](../radar.md) / wantlist / AE `bron/bronnen.md` §.
5. Cron: zie [how-to/digest.md](../../how-to/digest.md). Team-CI draft-PR: kit `digest.yml` (niet in dit solo-lab).
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
make digest-week        # fetch + propose + AE bron/weken/; DIGEST_WEEK= / SKIP_FETCH=1
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
| Auto-§ in AE `bronnen.md` | P5 — weekbrief ≠ feit | Zero-touch promote vanuit cron |
