# Stap 5 — Per feature

> **Rol:** De vaste lus voor elk stuk werk: plannen, bouwen in slices, controleren, docs bij.
> **Niet hier:** het sjabloon van een spec ([spec](../sjablonen/spec.md)), hoe je een agent reviewt ([bron P19](../bron/principes.md)).

## Voor

| Taak | Doe |
|------|-----|
| Klein: de diff past in één zin | Meteen doen, geen spec |
| Groot of onzeker | `make spec s=<slug>` (solo) of een issue (team): doel, **buiten scope**, raakvlakken, slices, acceptatie |
| Raakt een keuze met een waarom | Eerst `make adr t="…"`, dan bouwen |

Deel op in **verticale slices** die elk in één schone sessie passen en elk apart testbaar zijn (P1, P18, P24). Een slice gaat door de hele stack: tabel, endpoint, scherm. Noem in de spec welke **seams** je raakt (P23).

## Tijdens

- **Eén taak per sessie.** Na twee mislukte correcties: nieuwe sessie met een betere prompt (§12). Grote taken: sub-agents of parallelle smalle contexten i.p.v. één vervuild window (P24).
- **Test eerst:** laat de agent een falende test schrijven, dan de code (§2, §7). De test moet de **intentie** bewaren, niet afzwakken (P22).
- **Verwijs naar een voorbeeld:** "volg het patroon van `apps/api/src/sleep/`".
- **Modelkeuze (P26):** routinetaken (hernoemen, formatteren) met een klein/snel model als de tool dat toelaat; open ontwerp en lastige bugs met frontier.
- Branch `feat/<slug>`, dezelfde slug als de spec. Status van de taak staat in BACKLOG/issue, niet alleen in de chat (P27).

## Na

1. `make check` groen, met de output als bewijs. Voor een release: `make check-full`.
2. Review van de diff: zelf, of door een agent in een **nieuwe** sessie (P19). Check expliciet: intent intact, geen nieuwe modulegrenzen zonder ADR (P22, P23).
3. Docs die de wijziging raakt: alleen die. Nieuw besluit → ADR. Nieuw doc → regel in `docs/INDEX.md`. Seams gewijzigd → `ARCHITECTURE.md` bij.
4. Solo: `make log`, item afvinken in `BACKLOG.md`, spec weg. Team: PR-template invullen (Review + Docs).
5. **Maakte de agent een fout die hij al eerder maakte?** Eén regel in `AGENTS.md` of de geneste versie, of beter een test of hook (P20). Geen regel erbij "voor de zekerheid" (P25).

## Voorbeeld (GymFreak, solo)

```bash
make spec s=diet-budget                 # docs/work/specs/diet-budget.md + regel in BACKLOG § Nu
git switch -c feat/diet-budget
# sessie 1: slice 1 — kolom + migratie + endpoint, met test
# sessie 2: slice 2 — scherm in features/diet/, met test
make check
make log                                # docs/work/logs/2026-10-19.md
git rm docs/work/specs/diet-budget.md   # na merge; de code en tests zijn nu de waarheid
```
