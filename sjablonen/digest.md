# docs/research/digest/

> **Rol:** Inbound feeds ophalen en voorstellen; cureren vóór radar/wantlist.
> **Niet hier:** ring-inhoud ([radar](radar.md)).

**Kit:** [digest/README.md](../kit/modules/research/docs/research/digest/README.md) · how-to [digest.md](../kit/modules/research/docs/how-to/digest.md) · module `research` · P5, P8, P28

## Wanneer

Met module `research`. Bij periodieke tooling-/security-/release-hits.

## Invullen

1. Kopieer `SOURCES.example.md` → `SOURCES.md` (echte feed-URL’s).
2. `make digest-fetch` → `data/external/digest/` (raw; niet in docs plakken).
3. `make digest-propose` → `proposals/*-draft.md`; geaccepteerd → handmatig `radar.md`.
4. Team: `digest.yml` draft-PR met alleen voorstel.
5. **`## Bewust later`:** kitrijen laten of aanvullen (P28).

## Snelle toets

- [ ] `make digest-check` groen.
- [ ] `digest-check` / `reminder` / `fetch` / `propose` in `make help`; niet in `CHECK`.
- [ ] Zonder `SOURCES.md` faalt `digest-fetch`; `DIGEST_DRY_RUN=1` / `DIGEST_FIXTURE=` werken.
- [ ] Voorstel wijzigt `radar.md` niet automatisch (P5).
