# Digest — inbound feeds

> **Role:** Fetch and propose periodic *inbound* hits (changelogs, advisories, papers) — before they land on the radar or in §.
> **Not here:** the tech radar itself ([radar.md](../radar.md)); wantlist ([wantlist.md](../wantlist.md)); feed dumps as truth (P5).

Raw dumps: `data/external/digest/` (gitignored except README/`.gitkeep`). Proposals: `proposals/` (in git). **Curation** stays human/agent: nothing from a feed is SSOT.

## Ritual

1. `SOURCES.example.md` → `SOURCES.md` and fill in real feed URLs.
2. `make digest-fetch` — RSS/Atom → `data/external/digest/<YYYY-MM-DD>-<slug>/` (`raw.xml` + `items.md`).
3. `make digest-propose` — candidate rows in `proposals/<date>-draft.md` (does **not** change `radar.md`).
4. Review → accepted rows manually to [radar.md](../radar.md) / wantlist / (Agent Engineering) `bron/bronnen.md` §.
5. Team: workflow `.github/workflows/digest.yml` opens a **draft PR** with only the proposal.
6. `make digest-check` after structural edits.

Offline/test: `DIGEST_FIXTURE=docs/research/digest/fixtures/example.rss make digest-fetch`.

## Source list

Copy [SOURCES.example.md](SOURCES.example.md) → `SOURCES.md`. No secrets in URLs with tokens. Fixture: [fixtures/example.rss](fixtures/example.rss).

## Commands

```bash
make digest-check       # scaffold structure; module research
make digest-reminder    # hint
make digest-fetch       # live or DIGEST_FIXTURE=…; DIGEST_DRY_RUN=1
make digest-propose     # proposals/*-draft.md; DIGEST_DRY_RUN=1
```

How-to: [../../how-to/digest.md](../../how-to/digest.md).

## Deliberately later

Fixed heading (P28): ask for it or file it in BACKLOG when this becomes needed.

| Extension | Why later | Ask when |
|-----------|-----------|----------|
| Auto-merge of proposal rows into `radar.md` | P5 — feeds are not SSOT | Team wants zero-touch Adopt/Trial |
| LLM summary of feed items | Extra model cost / noise (P25) | Proposals are too long to read by hand |
| Digest in **kern** (every project) | Opt-in via `research` | A project without research still wants a digest |
| Always-on in AGENTS | Harness tax (P25) | Every task must see feeds (usually not) |
| HTML scraping (not RSS/Atom) | Fragile, ToS, supply chain | A source has no feed |
