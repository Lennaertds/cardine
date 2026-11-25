# data/README.md

> **Role:** The catalogue of all data: which dataset sits where, origin, licence, personal data, and how to recreate it.
> **Not here:** the rules of the layers ([data](../standard/data.md)), the pipeline (`docs/architecture/`).

**Kit file:** [kit/kern/data/README.md](../kit/kern/data/README.md) · layer kern

## When

With the first dataset, and with every new one. A dataset that sits there without a row in the catalogue may go.

## Filling in

1. Keep the **table of the layers**; it comes from the standard.
2. **One row per dataset:** path, origin, licence, personal data (yes/no and which), and how to recreate it. That last one is what a teammate or a new laptop needs.
3. `raw/` gets a date per export (`raw/hevy/2026-10-01/`). A new export is a new folder; you never overwrite.
4. `external/<source>/` gets its own `README.md` with the licence and the download link, because the data itself is not in git.

## Example (GymFreak)

```markdown
| Path | Origin | Licence | Personal data | Recreate |
|------|--------|---------|---------------|----------|
| `raw/apple-health/2026-10-01/` | export from the Health app | own data | yes: sleep, heart rate | export again on the iPhone |
| `external/evidence-pdfs/` | papers | per paper, see README | no | download links in the README |
| `interim/evidence/` | text and index from the pdfs | — | no | `make data` |
| `reference/evidence/` | by hand: sources, passages, priors | own | no | in git |
| `processed/demo/` | anonymised aggregates | own | no (checked) | `make data` |
```

## Quick check

- [ ] Every folder under `data/` has a row.
- [ ] Every row with personal data sits in a layer that never goes into git.
- [ ] "Recreate" is filled in for every row.
