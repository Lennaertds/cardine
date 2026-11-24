# How-to — digest (inbound)

> **Rol:** Feeds ophalen, voorstel maken, cureren naar radar — zonder dump als SSOT.
> **Niet hier:** ring-keuzes ([radar.md](../research/radar.md)); inhoud van feeds.

## Vereiste

Module `research` (`docs/research/digest/`). Zonder: Make zegt hoe je de module toevoegt.

## Check / reminder

```bash
make digest-check
make digest-reminder
```

## Fetch

```bash
# 1. Bronnen
cp docs/research/digest/SOURCES.example.md docs/research/digest/SOURCES.md
# vul echte https://… feeds in

make digest-fetch                          # live HTTP (curl/wget)
DIGEST_DRY_RUN=1 make digest-fetch         # alleen URL’s tonen
DIGEST_FIXTURE=docs/research/digest/fixtures/example.rss make digest-fetch   # offline
```

Output: `data/external/digest/<datum>-<slug>/{source.txt,raw.xml,items.md}`.

## Voorstel (geen auto-radar)

```bash
make digest-propose
DIGEST_DRY_RUN=1 make digest-propose
```

Schrijft `docs/research/digest/proposals/<datum>-draft.md`. Kopieer geaccepteerde rijen **handmatig** naar `radar.md` (P5).

Team-CI: `.github/workflows/digest.yml` (dispatch/cron) → draft-PR met alleen `proposals/`.

## Cureren

1. Review voorstel of raw `items.md`.
2. Relevant → Trial/Assess op `radar.md` of ADR.
3. Nog te lezen → `wantlist.md`.
4. Agent Engineering-repo: eerst `bron/bronnen.md` (§), dan brug.
