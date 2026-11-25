# How-to — digest (inbound)

> **Role:** Fetch feeds, make a proposal, curate into the radar — without a dump becoming SSOT.
> **Not here:** ring choices ([radar.md](../research/radar.md)); the content of feeds.

## Requirement

Module `research` (`docs/research/digest/`). Without it: Make tells you how to add the module.

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
DIGEST_DRY_RUN=1 make digest-fetch         # show URLs only
DIGEST_FIXTURE=docs/research/digest/fixtures/example.rss make digest-fetch   # offline
```

Output: `data/external/digest/<date>-<slug>/{source.txt,raw.xml,items.md}`.

## Proposal (no auto-radar)

```bash
make digest-propose
DIGEST_DRY_RUN=1 make digest-propose
```

Writes `docs/research/digest/proposals/<date>-draft.md`. Copy accepted rows **by hand** into `radar.md` (P5).

Team CI: `.github/workflows/digest.yml` (dispatch/cron) → a draft PR containing only `proposals/`.

## Curating

1. Review the proposal or the raw `items.md`.
2. Relevant → Trial/Assess on `radar.md` or an ADR.
3. Still to read → `wantlist.md`.
4. Agent Engineering repo: `bron/bronnen.md` (§) first, then the bridge.
