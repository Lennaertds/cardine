# Digest — bronnen (voorbeeld)

> Kopieer naar `SOURCES.md` en pas aan. Dit voorbeeld is **illustratief**, geen projectfeit.
> Alleen **http(s)-URL’s** worden door `make digest-fetch` gelezen (RSS/Atom). Offline: `DIGEST_FIXTURE=…`.

| Bron | Soort | Frequentie | Notitie |
|------|-------|------------|---------|
| `<https://example.com/changelog.rss>` | changelog | wekelijks | voorbeeld — vervang door echte feed |
| `<https://example.com/security.atom>` | CVE/advisory | wekelijks | voorbeeld — koppel aan deps-ritueel |
| `<https://example.com/papers.rss>` | research | maandelijks | voorbeeld — eerst cureren, dan § |

Na fetch: `make digest-propose` → review `proposals/` → handmatig naar `radar.md` / wantlist (P5 — geen dump als SSOT).
