# docs/research/digest/

> **Role:** Fetch inbound feeds and propose items; curate before the radar/wantlist.
> **Not here:** ring content ([radar](radar.md)).

**Kit:** [digest/README.md](../kit/modules/research/docs/research/digest/README.md) · how-to [digest.md](../kit/modules/research/docs/how-to/digest.md) · module `research` · P5, P8, P28

## When

With module `research`. For periodic tooling/security/release hits.

## Filling in

1. Copy `SOURCES.example.md` → `SOURCES.md` (real feed URLs).
2. `make digest-fetch` → `data/external/digest/` (raw; do not paste into docs).
3. `make digest-propose` → `proposals/*-draft.md`; accepted → manually into `radar.md`.
4. Team: `digest.yml` opens a draft PR containing only the proposal.
5. **`## Deliberately incomplete` (P28):** keep the kit rows or extend them (P28).

## Quick check

- [ ] `make digest-check` is green.
- [ ] `digest-check` / `reminder` / `fetch` / `propose` in `make help`; not in `CHECK`.
- [ ] Without `SOURCES.md`, `digest-fetch` fails; `DIGEST_DRY_RUN=1` / `DIGEST_FIXTURE=` work.
- [ ] A proposal never changes `radar.md` on its own (P5).
