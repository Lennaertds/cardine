# Weken — inbound weekbrieven

> **Rol:** Wekelijkse selectie van inbound hits (arXiv + Hugging Face daily/trending/topics). Geen SSOT.
> **Niet hier:** duurzame feiten (`../bronnen.md` §); ruwe dumps (`../../data/external/digest/`); inbox (`../inbox.md`).

## Ritueel (altijd zo)

1. **Dagelijks** (systemd 07:00): `make digest-day` — catch-up + fetch + weekbrief.
2. **Triage:** `make digest-triage` — zie [`../digest/TRIAGE.md`](../digest/TRIAGE.md).  
   - al in `bronnen.md` → `have` / `§n`  
   - AE **of** bestaande thema’s **of** [`interests.md`](../digest/interests.md) (OCR, …) → `keep`  
   - anders → `skip` · **bij twijfel keep**
3. Scan alleen **`keep`** → § + index wanneer je de bron gebruikt; rest mag `keep` blijven.
4. Feeds: [`../digest/SOURCES.md`](../digest/SOURCES.md).

## Bestandsnaam

`YYYY-Www.md` — bv. `2026-W46.md` (`date +%G-W%V`).

## Bewust later

| Uitbreiding | Waarom later | Vraag als |
|-------------|--------------|-----------|
| Auto-§ in `bronnen.md` | feed ≠ feit | Zero-touch promote |
| LLM-abstract per `keep` | kosten / noise | keep-lijst te lang om te scannen |
