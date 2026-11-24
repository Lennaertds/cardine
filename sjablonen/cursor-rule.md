# .cursor/rules/&lt;app&gt;.mdc

> **Rol:** Regels die Cursor automatisch laadt op basis van een glob of een beschrijving.
> **Niet hier:** regels voor elke tool ([agents-app](agents-app.md)), subagents per rol ([cursor-agents](cursor-agents.md)).

**Kitbestand:** [kit/modules/cursor/.cursor/rules/_template.mdc](../kit/modules/cursor/.cursor/rules/_template.mdc) · module `cursor` · P15

## Wanneer

Alleen als je iets wil dat `AGENTS.md` niet kan: laden op een glob (`apps/web/**/*.tsx`), laden op een beschrijving, of handmatig met `@`. In een teamproject liefst niet: niet iedereen gebruikt Cursor. De standaard per app is een geneste `AGENTS.md`; een `.mdc` alleen voor wat die niet kan, zoals een regel per bestandstype over apps heen.

**Meer `.mdc` i.p.v. mensdocs is meestal slechter** (P15, P25, §8): always-on of dubbele inhoud = harness tax en context clash. Migreer geen `docs/` naar `.mdc`. Agent-gerichte taal = dichte imperatieven, domeintermen en pointers — geen aparte kunsttaal en geen paper-jargon in always-on rules.

## Audit vóór je een `.mdc` toevoegt

1. Staat dit al in root- of geneste `AGENTS.md`? → **niet** kopiëren; schrap of verwijs (P7).
2. Geldt het bij élke taak? → hoort in `AGENTS.md`, niet in `.mdc` met `alwaysApply: true`.
3. Is het alleen voor mensen (waarom, onboarding)? → `docs/`, niet `.mdc`.
4. Heb je alleen Cursor-glob/description nodig? → `.mdc` oké; inhoud zo kort als de geneste AGENTS-regels.
5. Deletion test: verdwijnt het bestand, verandert agentgedrag nog? Zo nee → weg (P20).

## Invullen

1. **`description`:** wanneer de regel geldt, in één zin. De agent beslist hierop of hij hem laadt.
2. **`globs`:** zo smal als kan. `apps/web/**` voor een app, `**/*.sql` voor een taal.
3. **`alwaysApply: false`**, tenzij het echt bij elke taak geldt (dan hoort het in `AGENTS.md`).
4. **Inhoud:** patronen met een echt voorbeeldbestand, valkuilen, het één-test-commando. Dezelfde regels als bij [agents-app](agents-app.md).
5. Kopieer het sjabloon naar `<app>.mdc` en verwijder `_template.mdc` als elke app er een heeft.

## Voorbeeld (GymFreak, `.cursor/rules/api.mdc`)

```markdown
---
description: Werk in de NestJS-API van GymFreak (endpoints, services, migraties).
globs: apps/api/**
alwaysApply: false
---

- Nieuw endpoint volgt `apps/api/src/sleep/`: module, controller, service, `dto/`, engine met tests.
- Migraties in `src/database/migrations/` nooit wijzigen na merge; vraag eerst.
- Eén test: `pnpm --filter @gymfreak/api exec jest src/diet/diet-engine.spec.ts`.
```

## Snelle toets

- [ ] Audit hierboven doorlopen (geen duplicaat van AGENTS, geen docs→mdc-migratie).
- [ ] De glob raakt alleen de bestanden waarvoor de regel geldt.
- [ ] Geen regel die ook in `AGENTS.md` of `apps/<app>/AGENTS.md` staat (context clash, §8).
- [ ] `alwaysApply: false` tenzij het echt in AGENTS hoort.
- [ ] Een workspace-rule buiten de repo die naar dit project verwijst, wijst naar een bestaand pad.
