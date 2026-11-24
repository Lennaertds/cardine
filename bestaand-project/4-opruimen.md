# Stap 4 — Opruimen

> **Rol:** Eerst wegnemen, dan pas verhuizen of herschrijven. Een kleinere repo is makkelijker te herordenen.
> **Niet hier:** wat weg mag ([stap 2](2-classificeren.md), regels 1 tot 4).

## Doen, elk in een eigen commit

1. **`.gitignore` uit de kit.** Het kit-blok bovenaan, de regels die alleen voor dit project gelden onderaan onder `# --- Specifiek voor dit project`. Regels voor de huidige datamappen (bv. `data/user/`, uitzonderingen als `!data/evidence/**`) blijven daar staan tot de data in [stap 5](5-verhuizen.md) naar de lagen verhuisd is; pas dan gaan ze weg. Daarna wat al gecommit was maar genegeerd moet worden:

   ```bash
   git ls-files -ci --exclude-standard            # wat in git staat maar genegeerd hoort
   git rm -r --cached .pnpm-store tmp apps/analytics/src/*.egg-info
   ```

2. **`.editorconfig` en `.pre-commit-config.yaml`** uit de kit, dan `pre-commit install` en `pre-commit run --all-files`. Wat de hooks vinden (grote bestanden, ruwe data, een private key) is meteen een rij in de verhuistabel.

3. **Afleiders weg.** Oude varianten, `_v3`-bestanden, docs over verwijderde code, sync-conflicten, lege bestanden, boilerplate van generators. Git bewaart ze; wie ze nodig heeft, vindt ze met `git log --all -- <pad>`. Twijfel je, dan `docs/archive/` met uitsluiting in de kaart.

4. **Parallelle lijnen benoemen.** Twee manieren om hetzelfde te doen (twee pipelines, twee schema's, een oude en een nieuwe dashboardlijn): kies er één met een ADR. De andere gaat naar `legacy/` met een `legacy/AGENTS.md` van twee regels ("niet uitbreiden; alleen lezen voor vergelijking"), of weg.

5. **Seams vóór AI-volume (P23).** Voordat je agents grote refactors laat doen: noteer de naden (wie praat met wie) in `ARCHITECTURE.md` § Seams en zet of herstel integratietests daarop. Zonder die harness rond de code versnelt AI entropie (§32).

6. **Status weg uit de stabiele docs.** "Laatste wijzigingen", TODO's, sprintstand: naar `docs/work/` (solo) of issues (team), daarna weg (P8, P27).

## Klaar als

- `git ls-files -ci --exclude-standard` geeft niets.
- `pre-commit run --all-files` is groen.
- Geen bestandsnaam bevat nog `_v2`, `_final`, `_new`, `copy` of `sync-conflict`.
- Seams voor de kernflows staan (of staan gepland) vóór grote agent-refactors.
- `make check` is nog steeds groen.
