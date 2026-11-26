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
| Auto-accept zonder beoordeling | feed ≠ feit (P5); de router haalt 45% op de handmatige selectie | de router boven ~85% komt met bewezen precisie |
| Nieuwe thema's automatisch aanmaken | een thema vergt nu een `# Titel`-shell + een `### [Titel]`-tabel in `bronnen-index.md` | vaker dan ~1× per maand een nieuw thema |

~~LLM-abstract per `keep`~~ — gebouwd in W48: `make digest-promote` zet abstract +
HF-`ai_summary` bij elke kandidaat (zie [docs/how-to/digest.md](../../docs/how-to/digest.md)).
