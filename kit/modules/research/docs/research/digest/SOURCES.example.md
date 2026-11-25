# Digest — sources (example)

> Copy to `SOURCES.md` and adapt. This example is **illustrative**, not a project fact.
> Only **http(s) URLs** are read by `make digest-fetch` (RSS/Atom). Offline: `DIGEST_FIXTURE=…`.

| Source | Kind | Frequency | Note |
|--------|------|-----------|------|
| `<https://example.com/changelog.rss>` | changelog | weekly | example — replace with a real feed |
| `<https://example.com/security.atom>` | CVE/advisory | weekly | example — link to the deps ritual |
| `<https://example.com/papers.rss>` | research | monthly | example — curate first, then § |

After the fetch: `make digest-propose` → review `proposals/` → by hand into `radar.md` / wantlist (P5 — no dump as SSOT).
