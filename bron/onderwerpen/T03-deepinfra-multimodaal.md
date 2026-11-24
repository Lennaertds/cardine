# T03: DeepInfra multimodale modellen check

**Gemaakt:** 2026-11-19
**Status:** 🟡 Open
**Prioriteit:** Middel

## Wat
Controleren of DeepInfra multimodale modellen ondersteunt (voor image-input in prompts).

## Waarom
Als DeepInfra wél multimodale modellen heeft, kunnen we image-input gebruiken. Eerder aanname: DeepSeek-V4-Flash is text-only, maar misschien zijn er andere modellen beschikbaar via DeepInfra.

## Aanpak
- `curl` API call naar DeepInfra om beschikbare modellen te lijsten
- Check of er vision/multimodale modellen tussen zitten

## Log
| Datum | Wat gedaan |
|-------|------------|
| 2026-11-19 | Notitie gemaakt, nog niet uitgevoerd |

## Volgende stap
`curl` request naar DeepInfra API voor modellenlijst.