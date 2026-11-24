# data/README.md

> **Rol:** De catalogus van alle data: welke dataset waar staat, herkomst, licentie, persoonsgegevens, en hoe je hem opnieuw maakt.
> **Niet hier:** de regels van de lagen ([data](../standaard/data.md)), de pipeline (`docs/architecture/`).

**Kitbestand:** [kit/kern/data/README.md](../kit/kern/data/README.md) · laag kern

## Wanneer

Bij de eerste dataset, en bij elke nieuwe. Een dataset die er staat zonder rij in de catalogus, mag weg.

## Invullen

1. De **tabel van de lagen** laat je staan; ze komt uit de standaard.
2. **Per dataset een rij:** pad, herkomst, licentie, persoonsgegevens (ja/nee en welke), en hoe je hem opnieuw maakt. Dat laatste is wat een teamgenoot of een nieuwe laptop nodig heeft.
3. `raw/` krijgt een datum per export (`raw/hevy/2026-10-01/`). Een nieuwe export is een nieuwe map; je overschrijft nooit.
4. `external/<bron>/` krijgt een eigen `README.md` met de licentie en de downloadlink, want de data zelf staat niet in git.

## Voorbeeld (GymFreak)

```markdown
| Pad | Herkomst | Licentie | Persoonsgegevens | Opnieuw maken |
|-----|----------|----------|------------------|---------------|
| `raw/apple-health/2026-10-01/` | export uit de Health-app | eigen data | ja: slaap, hartslag | opnieuw exporteren op de iPhone |
| `external/evidence-pdfs/` | papers | per paper, zie README | nee | downloadlinks in de README |
| `interim/evidence/` | tekst en index uit de pdf's | — | nee | `make data` |
| `reference/evidence/` | met de hand: bronnen, passages, priors | eigen | nee | in git |
| `processed/demo/` | geanonimiseerde aggregaten | eigen | nee (gecontroleerd) | `make data` |
```

## Snelle toets

- [ ] Elke map onder `data/` heeft een rij.
- [ ] Elke rij met persoonsgegevens staat in een laag die nooit in git komt.
- [ ] "Opnieuw maken" is voor elke rij ingevuld.
