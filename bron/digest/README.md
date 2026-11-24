# Digest — inbound feeds (Agent Engineering)

> **Rol:** Periodieke *inbound* hits (papers, feeds) ophalen en voorstellen — vóór ze een `§` in [`bronnen.md`](../bronnen.md) worden.
> **Niet hier:** duurzame feiten (`bronnen.md`); ruwe dumps (`../../data/external/digest/`).

Cureren blijft mens/agent: **niets uit een feed is SSOT** (geen auto-§).

## Ritueel

1. Feeds: [SOURCES.md](SOURCES.md) (arXiv + Hugging Face daily / **trending** / topics).
2. Dagelijks: `make digest-day` — fetch + catch-up + weekbrief in [`../weken/`](../weken/).
3. **Triage:** `make digest-triage` — [TRIAGE.md](TRIAGE.md); interesses [interests.md](interests.md) (OCR e.d.).
4. Review **keep** → `§` alleen wanneer nodig + [`bronnen-index.md`](../bronnen-index.md).
5. systemd: `make install-digest-timers`.

## Commando's

```bash
make digest-check
make digest-fetch          # alleen feeds → data/external/digest/
make digest-day            # fetch + catch-up + weekbrief (dagelijks)
make digest-week           # weekbrief; DIGEST_WEEK= / SKIP_FETCH=1
make digest-triage         # have/keep/skip; WEEK=2026-W45 FORCE=1
```

## Bewust later

| Uitbreiding | Waarom later | Vraag als |
|-------------|--------------|-----------|
| Auto-§ in `bronnen.md` | feed ≠ feit | Zero-touch promote |
| LLM-samenvatting per `keep` | kosten / noise | keep-lijst te lang om te scannen |
