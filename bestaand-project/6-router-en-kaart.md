# Stap 6 — Router en kaart

> **Rol:** Eén `AGENTS.md` en één `docs/INDEX.md`, opgebouwd uit wat het oude routerbestand waardevol maakte.
> **Niet hier:** wat er in een router hoort ([agents-root](../sjablonen/agents-root.md)), de kaart ([docs-index](../sjablonen/docs-index.md)).

## Doen

1. **`AGENTS.md` uit de kit als vorm, de oude router als bron.** Neem uit het oude bestand alleen over wat de toets van P5 en P6 doorstaat:

   | In de oude router | Gaat naar |
   |-------------------|-----------|
   | "nooit", "mag niet", security, data | `AGENTS.md` § Nooit (kort) en `RULES.md` of `security.md` (uitleg) |
   | commando's, scripts | `AGENTS.md` § Commando's, met de make-targets uit stap 3 |
   | werkwijze: plan eerst, volg patronen | `AGENTS.md` § Werken |
   | Strix / obs / perf / deps / polyglot / radar | Keyword-tabel in § Werken + INDEX — **niet** als always-on genummerde stappen of acht commandorijen |
   | wat je doet vóór je afrondt | `AGENTS.md` § Afronden |
   | schrijfrechten per pad | `docs/agent/write-rules.md` (module `agent`), één regel in `AGENTS.md` |
   | "bij UI lees X" / leesroutes per soort opdracht | `AGENTS.md` § Werken (één regel); detail in `DESIGN.md` / `PRODUCT.md` — **niet** in `write-rules.md` (die opent de agent alleen bij schrijfvragen) |
   | lessen na mislukkingen | wat bij elke taak geldt: `AGENTS.md`; de rest: `docs/agent/lessons.md` |
   | mappenboom, lijst van docs | weg (de kaart en `ls`) |
   | status, "nu bezig met" | `docs/work/` of de tracker |

2. **Geen tweede router.** Een losse `CLAUDE.md` of `copilot-instructions.md` met eigen inhoud: verwijderen, of een symlink naar `AGENTS.md` (module `claude`). Twee routers met verschillende inhoud geven een context clash (§8).

   **Solo: `.cursorrules` blijft, maar wordt dun.** Leeg hem eerst volgens de tabel hierboven, en vervang hem dan door [kit/solo/.cursorrules](../kit/solo/.cursorrules): de verwijzing naar `AGENTS.md` plus je persoonlijke voorkeuren, ≤ 15 regels, niets dubbel ([gids](../sjablonen/cursorrules.md)). In een teamproject gaat hij weg.

3. **Per app een geneste `apps/<app>/AGENTS.md`** uit de stack: elke tool leest hem, en Cursor laadt hem zodra je in die map werkt. Bestaan er `.cursor/rules/<app>.mdc`'s met dezelfde rol, voeg hun inhoud samen in de geneste `AGENTS.md` en verwijder ze. Een `.mdc` houd je alleen voor wat `AGENTS.md` niet kan, zoals laden op een bestandstype (`**/*.sql`) over apps heen.

4. **`docs/INDEX.md` uit de kit**, met per bestand de vraag die het beantwoordt en wanneer niet. Alleen links naar bestanden die bestaan.

5. **Regels buiten de repo gelijktrekken.** Een workspace-rule die iets anders zegt dan de router, maakt de agent onzeker. Laat de workspace-rule naar de router verwijzen ("binnen een project wint de router van dat project").

## Klaar als

- Er is precies één routerbestand met inhoud (`AGENTS.md`); de andere zijn symlinks of weg. Solo staat er daarnaast een `.cursorrules` van ≤ 15 regels die niets uit `AGENTS.md` herhaalt.
- `make docs-health`: root-`AGENTS.md` onder 70 regels (streef ~50), elke geneste onder 40.
- De toets met een frisse agent uit [nieuw-project stap 4](../nieuw-project/4-agent.md#toets-met-een-frisse-agent) slaagt.
