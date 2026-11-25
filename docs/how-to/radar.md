# How-to — tech radar

> **Role:** review the tech radar monthly and use `make radar-check` / `radar-reminder`.
> **Not here:** the ring content itself ([radar.md](../research/radar.md)).

## Requirement

The `research` module (`docs/research/radar.md`). Without it, `make radar-check` explains how to add the module.

## Reminder

```bash
make radar-reminder
```

Shows the `Last reviewed:` date and suggests a review when it is older than ~30 days (or missing).

## Check

```bash
make radar-check
```

Checks the fixed sections, rings/categories and `## Deliberately later` (P28). Not part of `make check`.

## Reviewing (monthly)

1. `make radar-reminder` — decide whether to review now.
2. Walk the rows: still justified in Adopt/Trial/Assess/Hold?
3. A new hit → Trial/Assess or wantlist first; Adopt/Hold with impact → `make adr`.
4. Set `Last reviewed:` to today.
5. `make radar-check`.

No scrapers: by hand, or through your own source/bridge process. A dump of feeds does not belong in this file (P5).
