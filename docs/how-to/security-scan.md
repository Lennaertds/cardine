# How-to — security-scan (Strix)

> **Rol:** Strix installeren en een scan draaien tegen een target waar je toestemming voor hebt.
> **Niet hier:** dreigingen/maatregelen van dit project ([security.md](../architecture/security.md)).

## Voorwaarden

1. Docker draait.
2. `strix` in PATH (`curl -sSL https://strix.ai/install | bash` of `pipx install strix-agent`).
3. LLM-key gezet (`LLM_API_KEY` / provider volgens Strix-docs; optioneel `STRIX_LLM=…`).
4. Target = eigen repo, staging of expliciet toegestaan systeem — **nooit** andermans productie zonder mandaat.

## Commando's

```bash
make security-scan-quick          # snelle scan op .
make security-scan                # diepere scan op .
make security-scan TARGET=./apps/api
make security-scan-quick TARGET=https://localhost:3000
```

Agent-skills (optioneel): `npx skills add usestrix/strix`.

## Resultaat

Outputs onder `strix_runs/` (JSON/CSV/SARIF volgens Strix). Findings met werkende PoC serieus nemen; false positives triagen in een BACKLOG-item of issue.

Ontbreekt Docker/strix/key: het Make-target faalt met een duidelijke melding — zet dan een regel in `docs/work/BACKLOG.md` (§ Straks) i.p.v. de docs te negeren.
