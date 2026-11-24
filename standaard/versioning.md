# Kit-versioning

> **Rol:** Hoe de kit (`kit/`) versies krijgt en hoe `cardine-structure` die overneemt.
> **Niet hier:** SemVer voor projecten (staat in `kern/`), CHANGELOG-formaat.

## Waarom

`cardine-structure` (publiek npm-package) bevat een kopie van `kit/`. Elke
`cardine-structure`-release legt één kit-versie vast, zodat gebruikers weten welke
structuur ze krijgen. De bron (`kit/`) en de distributiekopie
(`packages/structure/kit/`) staan in dezelfde repo en worden gelijkgehouden met
`make sync-kit`.

## Tags

Kit-tags volgen het patroon `kit-v<semver>`:

```
kit-v0.1.0       → eerste kit-release
kit-v0.2.0       → kit met nieuwe module of stack
kit-v0.2.1       → bugfix in kit zonder nieuwe features
```

SemVer voor de kit:

| Deel | Wanneer ophogen |
|------|----------------|
| **major** | Breaking change: laag hernoemd, generator werkt anders, bestaande projecten breken |
| **minor** | Nieuwe module, nieuwe stack, nieuwe optie in `new-project.sh` |
| **patch** | Bugfix, documentatie-update in kit, kleine aanpassing aan `new-project.sh` |

## Een nieuwe kit-versie vrijgeven

```bash
# 1. Zorg dat alles gecommit is en make check groen
make check

# 2. Zorg dat de distributiekopie gelijk is aan de bron
make sync-kit

# 3. Tag de huidige HEAD als kit-v0.2.0
make tag-kit TAG=v0.2.0

# 4. Het tag-script controleert of de werkdirectory schoon is
#    en of de tag nog niet bestaat op een andere commit.
```

De nieuwe versie gaat mee in de volgende `cardine-structure`-release:

```bash
bash packages/structure/sync_kit.sh
```

## Koppeling met cardine-structure

| cardine-structure versie | kit-tag | Bijzonderheden |
|--------------------------|---------|----------------|
| 0.5.0 | — | `kit/` wordt de bron; geen pin meer |
| 0.4.0 | — | `jarvis-check`/`env-status`/`index` in `kern/Makefile` |
| 0.1.0 | `kit-v0.1.0` | eerste release |

Deze tabel wordt bijgewerkt in `packages/structure/docs/cardine-structure.md`.

## Wanneer taggen

- **Altijd** vóór een `cardine-structure`-release
- **Optioneel** na een significante kit-wijziging (nieuwe module, stack, of generator-optie)
- **Niet** bij kleine doorlopende wijzigingen — die bundel je in de volgende tag

## Bewust later

| Uitbreiding | Waarom later | Vraag als |
|-------------|-------------|-----------|
| Automatische tag bij `make check` | Niet elke check is een release | Tags worden handmatig gezet |
| Kit-CHANGELOG als apart bestand | Nu volstaat de koppelingstabel hierboven | Kit wijzigt wekelijks |
