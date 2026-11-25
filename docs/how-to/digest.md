# How-to — digest (inbound)

> **Live digest:** `make digest-day`, feeds in `bron/digest/`, weekly briefs in `bron/weken/`. All of it in this repo.
>
> **Role (legacy lab):** fetch feeds, draft proposals, curate into the radar — without a dump as the SSOT.
> **Not here:** ring choices ([radar.md](../research/radar.md)); the content of feeds.

## Requirement

The `research` module (`docs/research/digest/`). Without it, Make explains how to add the module.

## Check / reminder

```bash
make digest-check
make digest-reminder
```

## Fetch

```bash
# 1. Sources
cp docs/research/digest/SOURCES.example.md docs/research/digest/SOURCES.md
# fill in real https://… feeds

make digest-fetch                          # live HTTP (curl/wget)
DIGEST_DRY_RUN=1 make digest-fetch         # only show URLs
DIGEST_FIXTURE=docs/research/digest/fixtures/example.rss make digest-fetch   # offline
```

Output: `data/external/digest/<date>-<slug>/{source.txt,raw.xml|raw.json,items.md}`.

## Proposal (no auto radar)

```bash
make digest-propose
DIGEST_DRY_RUN=1 make digest-propose
```

Writes `docs/research/digest/proposals/<date>-draft.md`. Copy accepted rows **by hand** into `radar.md` (P5).

Team CI: `.github/workflows/digest.yml` (dispatch/cron) → a draft PR containing only `proposals/`.

## Weekly + systemd (papers)

The arXiv RSS feed refreshes **daily** (no weekend). HF Daily Papers go through a JSON API (`/api/daily_papers`, topic `/api/papers/search`). Hence:

| When | Command | Effect |
|------|---------|--------|
| Mon–Fri ~07:00 | `make digest-fetch` | Dumps in `data/external/digest/` |
| Mon ~07:30 | `make digest-week` | Fetch + propose + weekly brief in `bron/weken/YYYY-Www.md` |

By hand:

```bash
make digest-week                         # today: current week (on Mon: previous week)
DIGEST_WEEK=2026-W44 make digest-week    # a specific ISO week
DIGEST_WEEK_SKIP_FETCH=1 make digest-week
```

Scheduling: **systemd user timers** (no `cronie` on this machine). Once:

```bash
bash packages/lab/scripts/install-digest-timers.sh
systemctl --user list-timers 'digest-*'
```

Units live in `packages/lab/systemd/`; log: `data/external/digest/cron.log`.
The timers run while your user session is active (`Persistent=true` catches up missed runs). Without a login session: `loginctl enable-linger "$USER"`.

A weekly brief is **not** an automatic source entry. Curating stays below.

## Curating

1. Review the proposal (`proposals/`) or the weekly brief (`bron/weken/`).
2. Relevant to the lab → Trial/Assess on `radar.md`, or an ADR / `wantlist.md`.
3. Chosen hits → `bron/bronnen.md` (a new §) plus the index; update the status in the weekly brief.
4. YouTube etc.: to the inbox, or straight to a § with a short note in the weekly brief.
