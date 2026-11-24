# Stap 1 — Nulmeting en inventaris

> **Rol:** Vastleggen hoe het project er nu voor staat, vóór je iets verandert.
> **Niet hier:** wat je met elk bestand doet ([stap 2](2-classificeren.md)), hoe je meet ([meten](../meten/INDEX.md)).

## 1. Nulmeting (P21)

Kies vijf taken uit de git-geschiedenis en draai ze op de huidige stand: conditie **C1** uit [meten](../meten/2-condities.md). De minimale versie volstaat: [meten](../meten/INDEX.md#minimale-versie-een-namiddag). Kies de taken **nu**, vóór je de nieuwe structuur kent, anders meet je je taakkeuze.

## 2. Verhuistabel aanmaken

Kopieer alleen [het sjabloon](../kit/modules/herordening/docs/work/specs/herordening.md), met de hand. Het script draait pas in [stap 5](5-verhuizen.md), na het verhuizen; nu zou het lege kernbestanden naast de bestaande docs zetten.

```bash
mkdir -p <project>/docs/work/specs
cp -n kit/modules/herordening/docs/work/specs/herordening.md <project>/docs/work/specs/
sed -i 's/{{PROJECT}}/<Project>/g; s/{{DATE}}/'"$(date +%F)"'/g' <project>/docs/work/specs/herordening.md
```

## 3. Inventaris

```bash
cd <project>
fd -e md -e mdc -e txt . --exclude node_modules --exclude .venv | sort       # alle tekst
fd -H '^(\.cursorrules|AGENTS\.md|CLAUDE\.md|\.windsurfrules|copilot-instructions\.md)$'   # alle routers
fd -H -t d '^\.cursor$' ; fd -H -e mdc                                        # cursor-rules
wc -l $(fd -e md . docs) | sort -n | tail -n 20                               # de grootste docs
git ls-files | rg -n '(node_modules|\.pnpm-store|\.next|egg-info|__pycache__|^tmp/)' | head   # build-output in git
fd -H 'sync-conflict' ; fd -e md -S -1k                                       # sync-restjes, lege docs
```

Zet elk bestand als rij in de verhuistabel, kolom **Nu**. Bij grote bestanden met meerdere soorten inhoud: een rij per sectie.

## 4. Droge run van de kit

```bash
kit/new-project.sh <project> --modules <modules> --stacks <stacks> --no-git --dry-run
```

De regels met `+` ontbreken nog; die met `=` bestaan al en voeg je later met de hand samen. Kies de modules die passen bij wat je in de inventaris zag (een `research/`-achtige map → `research`; uploads → `runtime`). Elke `+` die de rol heeft van een bestaand bestand onder een andere naam, wordt een rij in de verhuistabel: dat bestand verhuist in stap 5 naar de kitnaam.

## 5. Regels buiten de repo

Noteer ook de regels die **buiten** het project op de agent inwerken: workspace-rules, user rules, `.cursor/rules/` in een bovenliggende map. Die kunnen botsen met de router van het project (context clash, §8).

## Klaar als

- De nulmeting staat in `results.csv` ([protocol](../meten/3-protocol.md)).
- Elk doc- en agentbestand staat in de verhuistabel.
- Je weet welke kit-bestanden ontbreken en welke al een tegenhanger hebben.
