# How-to — digest (inbound)

> **Live digest:** `make digest-day`, feeds in `bron/digest/`, weekbrieven in `bron/weken/`. Alles in deze repo.
>
> **Rol (legacy lab):** Feeds ophalen, voorstel maken, cureren naar radar — zonder dump als SSOT.
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

Output: `data/external/digest/<datum>-<slug>/{source.txt,raw.xml|raw.json,items.md}`.

## Voorstel (geen auto-radar)

```bash
make digest-propose
DIGEST_DRY_RUN=1 make digest-propose
```

Schrijft `docs/research/digest/proposals/<datum>-draft.md`. Kopieer geaccepteerde rijen **handmatig** naar `radar.md` (P5).

Team-CI: `.github/workflows/digest.yml` (dispatch/cron) → draft-PR met alleen `proposals/`.

## Wekelijks + systemd (papers → AE)

arXiv-RSS vernieuwt **dagelijks** (geen weekend). HF Daily Papers via JSON-API (`/api/daily_papers`, topic `/api/papers/search`). Daarom:

| Wanneer | Commando | Effect |
|---------|----------|--------|
| Ma–vr ~07:00 | `make digest-fetch` | Dumps in `data/external/digest/` |
| Ma ~07:30 | `make digest-week` | Fetch + propose + weekbrief in `bron/weken/YYYY-Www.md` |

Handmatig:

```bash
make digest-week                         # vandaag: huidige week (op ma: vorige week)
DIGEST_WEEK=2026-W44 make digest-week    # specifieke ISO-week
DIGEST_WEEK_SKIP_FETCH=1 make digest-week
```

Scheduling: **systemd user-timers** (geen `cronie` op deze machine). Eenmalig:

```bash
bash packages/lab/scripts/install-digest-timers.sh
systemctl --user list-timers 'digest-*'
```

Units staan in `packages/lab/systemd/`; log: `data/external/digest/cron.log`.  
Timers draaien als je user-sessie actief is (`Persistent=true` haalt gemiste runs in). Zonder login: `loginctl enable-linger "$USER"`.

Weekbrief is **geen** auto-§. Cureren blijft hieronder.

## Cureren

1. Review voorstel (`proposals/`) of weekbrief (`bron/weken/`).
2. Relevant lab → Trial/Assess op `radar.md` of ADR / `wantlist.md`.
3. Agent Engineering: gekozen hits → `bron/bronnen.md` (§) + index; status in weekbrief bijwerken.
4. YouTube e.d.: inbox of meteen § + kort in de weekbrief.
