# Backlog

> **Rol:** Open werk: één regel per item, met een link naar de spec als die er is.
> **Niet hier:** afgewerkt werk (git en `logs/`), besluiten (`decisions/`).

Nieuw item met spec: `make spec s=<slug>` zet de regel bovenaan bij **Nu**. De categorie is een kolom, geen map.

## Nu

| Item | Categorie | Status |
|------|-----------|--------|
| BOOTSTRAP stap 2: context/grenzen (lab→mogelijk gratis product) — wacht op runtime-keuze (stap 3) | bootstrap | open |

## Straks

| Item | Categorie | Waarom later |
|------|-----------|--------------|
| Runtime-keuze (Pi / TS / …) + stack-ADR + `--starter` / generators | apps | Expliciete keuze vereist vóór code |
| LLM-providerconfig (DeepSeek-default-richting + andere keys via `.env`) | harness | Na stack; keys nooit in git |
| Domeinbestanden `product/harness.md`, `structure.md`, `indexing.md` | product | Gedrag nog niet concreet |
| Seam-tests (harness↔structure/indexing, structure↔AE, harness↔LLM) | architecture | Pas na stack |
| OTel in apps + `make obs-*` zinvol vullen | observability | Geen app; kit-docs beloven LGTM |
| Performance-budgets + `bench.sh` per app | performance | Geen meetpad zonder runtime |
| Strix-install + key voor `security-scan*` | security | Geen netwerk-facing app nog |
| Digest-feeds invullen (`SOURCES`) | research | Optioneel tot inbound nieuws nodig is |

## Geparkeerd

| Item | Categorie | Wacht op |
|------|-----------|----------|
| Thesis-deliverable als toetsbaar doel | product | Lab meetbaar + runtime |
| Pi-fork | apps | Expliciete runtime-keuze = Pi |
| Productisatie: portfolio + gratis release (OS of closed) | product | Lab-kwaliteit “echt goed” + expliciete keuze |
| Prod-hosting / multi-user auth | architecture | Productisatie-ADR |
