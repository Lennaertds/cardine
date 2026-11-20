# Implementatieplan — Cardine packages

> Fasen en planning voor het opzetten van de publieke packages.
> **Status:** nog niet gestart — wacht op ontwerp-goedkeuring.

## Fase 1 — Package-structuur

| Taak | Duur |
|------|------|
| Mapstructuur aanmaken `packages/lab/`, `packages/structure/` | 1 dag |
| `install-lab.sh` verhuizen naar `packages/lab/` en publiek maken | 1 dag |
| Alle scripts verhuizen naar `packages/lab/scripts/` | 1 dag |
| CHANGELOG.md per package aanmaken | 1 dag |

## Fase 2 — Structure-pull

| Taak | Duur |
|------|------|
| Script maken: `pull_kit.sh` dat kit uit Agent_Engineering kopieert | 1 dag |
| Eerste pinned pull uit Agent_Engineering | 1 dag |
| README.md voor structure-package | 1 dag |

## Fase 3 — Meta opschonen

| Taak | Duur |
|------|------|
| Root README herschrijven als uithangbord | 1 dag |
| `package.json` updaten met verwijzingen | 1 dag |
| Overbodige root-bestanden opkuisen | 1 dag |

## Tijdlijn

```mermaid
gantt
    title Implementatie packages
    dateFormat  YYYY-MM-DD
    
    section Fase 1 — Package-structuur
    Mapstructuur aanmaken packages/lab/ packages/structure/                         :p1a, 2026-11-21, 1d
    install-lab.sh verhuizen naar packages/lab/ en publiek maken                    :p1b, after p1a, 1d
    Alle scripts verhuizen naar packages/lab/scripts/                               :p1c, after p1b, 1d
    CHANGELOG.md per package aanmaken                                               :p1d, after p1c, 1d
    
    section Fase 2 — Structure-pull
    Script maken: pull_kit.sh dat kit uit Agent_Engineering kopieert                 :p2a, after p1d, 1d
    Eerste pinned pull uit Agent_Engineering                                        :p2b, after p2a, 1d
    README.md voor structure-package                                                :p2c, after p2b, 1d
    
    section Fase 3 — Meta opschonen
    Root README herschrijven als uithangbord                                         :p3a, after p2c, 1d
    package.json updaten met verwijzingen                                           :p3b, after p3a, 1d
    Overbodige root-bestanden opkuisen                                              :p3c, after p3b, 1d
```