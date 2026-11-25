# How-to — tech radar

> **Role:** Revise the tech radar monthly and use `make radar-check` / `radar-reminder`.
> **Not here:** the ring content itself ([radar.md](../research/radar.md)).

## Requirement

Module `research` (`docs/research/radar.md`). Without it: `make radar-check` tells you how to add the module.

## Reminder

```bash
make radar-reminder
```

Shows the `Last reviewed:` date and a hint to revise when it is older than ~30 days (or missing).

## Check

```bash
make radar-check
```

Checks the fixed sections, rings/categories and `## Deliberately later` (P28). Not in `make check`.

## Revise (monthly)

1. `make radar-reminder` — decide whether to revise now.
2. Walk the rows: still justified in Adopt/Trial/Assess/Hold?
3. New hit → Trial/Assess or the wantlist first; Adopt/Hold with impact → `make adr`.
4. Set `Last reviewed:` to today.
5. `make radar-check`.

No scrapers: by hand or via your own §/bridge process (Agent Engineering). A feed dump does not belong in this file (P5).
