# Stap 4 — Agent

> **Rol:** `AGENTS.md` en de kaart invullen met alleen wat nu waar is, en toetsen met een frisse agent.
> **Niet hier:** wat er in een `AGENTS.md` hoort ([agents-root](../sjablonen/agents-root.md)), waarom het kort moet ([bron P1–P3, P20](../bron/principes.md)).

## Doen

1. **`AGENTS.md` invullen** ([gids](../sjablonen/agents-root.md)):
   - **Nooit:** de grenzen voor secrets, data en git zijn er al. Voeg toe wat specifiek is voor dit project (bv. "nooit `apps/api/src/database/migrations/` wijzigen na merge"). Obs/perf/deps niet als always-on-links.
   - **Commando's:** dagelijkse tabel staat er al; vul "één test" in per stack. Opt-in-targets blijven onder `make help` + INDEX (geen pad-catalogus in AGENTS).
   - **Werken:** harde leesroutes; opt-in via opdracht → INDEX; echt voorbeeldbestand (`apps/api/src/sleep/sleep.service.ts`). Laat **intent**, **seams** en **één slice** kort staan (P22–P24); knip essays weg, niet de kern.
2. **Geneste `apps/<app>/AGENTS.md`** nakijken: de kit zette ze neer met stackregels. Schrap wat niet geldt, vul de valkuilen aan ([gids](../sjablonen/agents-app.md)).
3. **`docs/INDEX.md`**: alleen links naar bestanden die bestaan. Vervang de regels met `<…>` of schrap ze ([gids](../sjablonen/docs-index.md)).
4. **Solo: `.cursorrules`** uit de kit invullen met je persoonlijke voorkeuren, ≤ 15 regels, niets uit `AGENTS.md` herhalen — dubbel = harness tax (P25) ([gids](../sjablonen/cursorrules.md)). Gebruik in elk project dezelfde regels, dan voelt elk project hetzelfde aan.
5. **Andere tools:** module `claude` voor `CLAUDE.md` → `AGENTS.md`; module `cursor` voor path-rules én subagents in `.cursor/agents/` ([cursor-rule](../sjablonen/cursor-rule.md), [cursor-agents](../sjablonen/cursor-agents.md), [agent-rollen](../standaard/agent-rollen.md)). Modules `design` / `product` / `research` zetten hun rol-agent mee.
6. **Guardrails:** de pre-commit-hooks uit de kit draaien al na `make setup`. Een agent-hook (bv. linten na elke edit) voeg je pas toe als de agent die fout echt maakt (P14, P20).

## Toets met een frisse agent

Open een nieuwe sessie zonder voorgeschiedenis en geef:

> Voeg een kleine feature toe: <iets van tien minuten>. Rond af zoals het hoort.

| Kijk of de agent | Zo niet |
|------------------|---------|
| uit zichzelf `make check` draait en de output toont | commando bovenaan in `AGENTS.md`, als stap 1 van Afronden |
| de kaart opent en één doc kiest, geen hele map | link naar de kaart bovenaan; INDEX per vraag |
| bij een UI-fix (module `design`) eerst `DESIGN.md` opent, dan één craft-bestand — niet alleen code/screenshots | harde leesroute in `AGENTS.md` § Werken; kaart in `DESIGN.md` aangescherpt |
| bij "gebruik subagents" (module `cursor`) passende `.cursor/agents/` kiest i.p.v. alles in één venster | regel in `AGENTS.md`; `description` in de agentbestanden; [agent-rollen](../standaard/agent-rollen.md) |
| na “implementeer” / “bouw” / “ja” in dezelfde beurt code schrijft, niet opnieuw plant of vraagt | regel “uitvoeren wint van praten” in `AGENTS.md`; plan-eerst in `.cursorrules` heeft carve-out |
| het patroon van het voorbeeldbestand volgt | concreter voorbeeld in Werken |
| geen "Nooit"-regel breekt | regel scherper, of beter: een hook of test (P14) |
| productintentie niet afzwakt om groen te worden | intent-regel in Werken; productregel + test aangescherpt (P22) |
| geen nieuwe `utils/` of module zonder te vragen | seam-regel + ARCHITECTURE § Seams (P23) |
| één slice afrondt i.p.v. drie tegelijk | slices in de spec; "één slice per sessie" (P24) |
| een log of PR-samenvatting schrijft | stap 4 van Afronden (spine, P27) |

## Klaar als

- `make docs-health` toont de root-`AGENTS.md` onder de 70 regels (streef ~50), elke geneste onder 40.
- De toets slaagt. Wat misliep, is een regel of een test geworden.
