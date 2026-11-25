# Digest — inbound feeds

> **Moved within the repo** — the live digest lives in `bron/digest/` and `bron/weken/`. See [MOVED.md](MOVED.md). This lab scaffold stays as a kit example.
>
> **Role:** periodically fetch *inbound* hits (changelogs, advisories, papers) and draft proposals — before they land on the radar or in a §.
> **Not here:** the tech radar itself ([radar.md](../radar.md)); the wantlist ([wantlist.md](../wantlist.md)); feed dumps as truth (P5).

Raw dumps: `data/external/digest/` (gitignored except for the README and `.gitkeep`). Proposals: `proposals/` (these *are* in git). **Curating** stays with a human or agent: nothing from a feed is an SSOT.

## Ritual

1. Live feeds: [SOURCES.md](SOURCES.md) (arXiv + Hugging Face Daily Papers / topic-search JSON). Example: [SOURCES.example.md](SOURCES.example.md).
2. Weekdays: `make digest-fetch` — RSS/Atom/JSON → `data/external/digest/<YYYY-MM-DD>-<slug>/`.
3. Monday: `make digest-week` — fetch (+ HF `daily_papers?week=`) + propose + a weekly brief in `bron/weken/YYYY-Www.md` (it does **not** touch `radar.md` or `bronnen.md`).
4. Review → accepted hits go by hand to [radar.md](../radar.md), the wantlist, or a § in `bron/bronnen.md`.
5. Cron: see [how-to/digest.md](../../how-to/digest.md). Team CI draft PR: the kit `digest.yml` (not in this solo lab).
6. `make digest-check` after structural edits.

Offline test: `DIGEST_FIXTURE=docs/research/digest/fixtures/example.rss make digest-fetch`.

## Source list

Copy [SOURCES.example.md](SOURCES.example.md) → `SOURCES.md`. No secrets in URLs with tokens. Fixture: [fixtures/example.rss](fixtures/example.rss).

## Commands

```bash
make digest-check       # scaffold structure; research module
make digest-reminder    # hint
make digest-fetch       # live, or DIGEST_FIXTURE=…; DIGEST_DRY_RUN=1
make digest-propose     # proposals/*-draft.md; DIGEST_DRY_RUN=1
make digest-week        # fetch + propose + weekly brief; DIGEST_WEEK= / SKIP_FETCH=1
```

How-to: [../../how-to/digest.md](../../how-to/digest.md).

## Deliberately later

Fixed heading (P28): ask about it or file a BACKLOG item when this becomes needed.

| Extension | Why later | Ask when |
|-----------|-----------|----------|
| Auto-merging proposal rows into `radar.md` | P5 — feeds are not an SSOT | The team wants zero-touch Adopt/Trial |
| An LLM summary of feed items | Extra model cost and noise (P25) | The proposal is too long to read by hand |
| Digest in **kern** (every project) | Opt-in through `research` | A project without research still wants a digest |
| Always-on in AGENTS | Harness tax (P25) | Every task must see the feeds (usually not) |
| HTML scraping (no RSS/Atom) | Fragile, terms of service, supply chain | The source has no feed |
| Auto-§ into `bronnen.md` | P5 — a weekly brief is not a fact | Zero-touch promotion from cron |
