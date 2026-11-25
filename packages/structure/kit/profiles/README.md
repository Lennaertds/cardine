# Profiles — predefined kit combinations

> **Role:** Per profile a `.profile` file with variables that `new-project.sh` reads.
> **Not here:** the profile definitions themselves ([standard/profielen.md](../../standard/profielen.md)), how to create a profile ([sjablonen/profielen.md](../../sjablonen/profielen.md)).

## Existing profiles

| Profile | Use | Modules | Stacks | Extra folders |
|---------|-----|---------|--------|---------------|
| `app` | Building an application | vision, assignment, product, design, research, business, agent, deliverables, meetings, compose, observability | user chooses | — |
| `research` | Research with software | assignment, research, agent, deliverables, meetings | python | — |
| `studie` | Study planning | assignment | — | werk/kalender.md, werk/deadlines.md, werk/studielog.md, local.mk |
| `schoolwerk` | Exercises (DL/DB/Python/algorithms) | assignment, compose | python | containers/, local.mk |

## How it works

```bash
kit/new-project.sh ~/code/nieuw --profile app --stacks next,python
```

The script reads `kit/profiles/<name>.profile`, fills in the variables and behaves as if you had passed `--modules ... --stacks ...` by hand.

## Structure

```
kit/profiles/
├── README.md
├── app.profile
├── research.profile
├── studie.profile
├── schoolwerk.profile
└── extra/
    ├── app/          # extra files for the app profile (if any)
    ├── research/
    ├── studie/
    │   ├── werk/
    │   │   ├── kalender.md
    │   │   ├── deadlines.md
    │   │   └── studielog.md
    │   └── local.mk
    └── schoolwerk/
        ├── containers/
        │   └── docker-compose.yml
        └── local.mk
```
