# Kit-versioning

> **Rol:** Hoe Agent_Engineering kit-versies beheert, en hoe cardine-structure die pulled.
> **Niet hier:** SemVer voor projecten (staat in `kern/`), CHANGELOG-formaat.

## Waarom

`cardine-structure` (publiek npm-package) pullt de kit uit Agent_Engineering op een **pinned commit**. Elke `cardine-structure`-release verwijst naar één specifieke kit-versie. Daarom heeft de kit eigen tags in Agent_Engineering.

## Tags

Kit-tags volgen het patroon `kit-v<semver>`:

```
kit-v0.1.0       → eerste gepinde kit-release
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

# 2. Tag de huidige HEAD als kit-v0.2.0
make tag-kit TAG=v0.2.0

# 3. Het tag-script controleert of de werkdirectory schoon is
#    en of de tag nog niet bestaat op een andere commit.
```

Na het taggen kan `cardine-structure` de nieuwe versie pullen met:

```bash
bash packages/structure/pull_kit.sh --tag v0.2.0
```

## Koppeling met cardine-structure

| cardine-structure versie | Agent_Engineering kit-tag | Commit |
|--------------------------|---------------------------|--------|
| 0.1.0 | `kit-v0.1.0` | c841cb9 |
| ... | ... | ... |

Deze tabel wordt bijgewerkt in `packages/structure/docs/cardine-structure.md`.

## Wanneer taggen

- **Altijd** vóór een `cardine-structure`-release
- **Optioneel** na een significante kit-wijziging (nieuwe module, stack, of generator-optie)
- **Niet** bij kleine doorlopende wijzigingen — die bundel je in de volgende tag

## Bewust later

| Uitbreiding | Waarom later | Vraag als |
|-------------|-------------|-----------|
| Automatische tag bij `make check` | Niet elke check is een release | Tags worden handmatig gezet |
| Kit-CHANGELOG in Agent_Engineering zelf | Nu volstaat de koppelingstabel in cardine-structure | Kit wijzigt wekelijks |