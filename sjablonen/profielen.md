# Profiel aanmaken — gids

> **Rol:** Hoe je een nieuw kit-profiel maakt en aan de bestaande toevoegt.
> **Niet hier:** de bestaande profielen ([kit/profiles/](../kit/profiles/README.md)), wat een profiel is ([standaard/profielen.md](../standaard/profielen.md)).

## Stappen

1. **Bepaal het profiel** — welke modules? Welke stacks? Extra mappen?
2. **Maak `kit/profiles/<naam>.profile`** — zie voorbeeld hieronder.
3. **Voeg een rij toe** in `standaard/profielen.md` (de tabel) en in `kit/README.md` (de profielentabel).
4. **Pas eventueel `new-project.sh` aan** als het profiel extra logica nodig heeft (bv. een aparte Makefile).
5. **Test:** `make test-kit` en probeer: `bash kit/new-project.sh tmp/test-profiel --profile <naam> --dry-run`.

## Voorbeeld `.profile`-bestand

```bash
# kit/profiles/studie.profile
PROFILE_NAME="studie"
PROFILE_DESCRIPTION="Studieplanning: kalender, deadlines, studielog"
MODULES="assignment"
STACKS=""
STARTER=false
EXTRA_DIRS="werk/kalender.md werk/deadlines.md werk/studielog.md"
```

## Extra mappen bij een profiel

De map `kit/profiles/extra/<naam>/` kan bestanden bevatten die in een project met dat profiel worden neergezet. Bijvoorbeeld:

```
kit/profiles/extra/studie/
├── werk/
│   ├── kalender.md            # sjabloon voor jaarkalender
│   ├── deadlines.md           # tabel met deadlines
│   └── studielog.md           # dagelijks logboek
└── Makefile                   # aparte Makefile met log/deadline-targets
```

## Must-check na aanmaak

- [ ] Profiel werkt met `--dry-run`: toont de juiste modules en mappen
- [ ] Profiel werkt zonder `--dry-run`: map bestaat en `make check` wordt groen
- [ ] Geen overbodige modules (bv. `compose` bij `studie`)
- [ ] `kit/README.md` heeft een rij
- [ ] `standaard/profielen.md` heeft een rij
- [ ] `make test-kit` groen

## Profiel verwijderen

1. Verwijder `kit/profiles/<naam>.profile`
2. Verwijder de rij uit `standaard/profielen.md` en `kit/README.md`
3. Verwijder `kit/profiles/extra/<naam>/` als die bestaat
4. `make test-kit`