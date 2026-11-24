# T01: Token-logger voor DeepSeekHarness

**Gemaakt:** 2026-11-19
**Status:** 🔴 Bezig
**Prioriteit:** Hoog

## Wat
Een post-request hook in DeepSeekHarness die elke API-response parsed (prompt_tokens, completion_tokens, model, timestamp) en wegschrijft naar een lokaal bestand (CSV/JSONL).

## Waarom
Dieper inzicht dan DeepInfra dashboard; eigen metingen + aggregatie over tijd.

## Sporen
- **Spoor A:** DSH plugins/hooks — check `~/.dsh/plugins/` voor hook-mogelijkheden
- **Spoor B:** Zed assistent logs — `find ~ -name '*.json' -path '*zed*'`
- **Spoor C:** Proxy logger — mitmproxy tussen Zed en DeepInfra om requests/responses op te vangen

## Bevindingen tot nu toe
- Omgevingsvariabelen uitgelezen: `DSH_HOME=/home/ventje/.dsh`, `DSH_SESSION_ID=4be08289-...`
- Sandbox (bubblewrap) blokkeert directe toegang tot `~/.dsh/`
- DeepSeek-V4-Flash is text-only, geen multimodale input

## Bronnen
§30 (harness tax), §74 (keep-rate/tool-error taxonomy), §5 (deterministische harness-laag)

## Log
| Datum | Wat gedaan |
|-------|------------|
| 2026-11-19 | Onderzoek gestart: omgevingsvariabelen uitgelezen, sandbox-beperking ontdekt, 3 sporen geïdentificeerd |

## Volgende stap
Onderzoek `~/.dsh/` directory buiten de sandbox (terminale commando's) of begin met spoor B (Zed logs).