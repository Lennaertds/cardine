# Backlog

> **Rol:** **Index** van open werk: één korte regel per item + link naar de spec. Geen plan, slices of essay hier.
> **Niet hier:** het plan ([specs/](specs/)), afgewerkt werk (git en `logs/`), besluiten (`decisions/`).

Nieuw item op **Nu** (of Geparkeerd met een plan): alleen via `make spec s=<slug>` — die zet de indexregel én de spec. Handmatig een lange rij in deze tabel plakken is fout. **Straks** mag één korte regel zonder spec (tot je hem promoveert met `make spec`). Categorie is een kolom, geen map.

## Nu

| Item | Categorie | Status |
|------|-----------|--------|
| [onderzoek-a2-harnesses](specs/onderzoek-a2-harnesses.md) | research | gedaan (§76–§79); volgende A5 |
| [bootstrap-geen-stack-tot-adr](specs/bootstrap-geen-stack-tot-adr.md) | bootstrap | open |

## Straks

| Item | Categorie | Waarom later |
|------|-----------|--------------|
| A4–A3 + A6–A9 (zie [ideeen-en-vragen](../research/ideeen-en-vragen.md)); na A2/A5 | research | Programma-volgorde; A6–A9 voeden B |
| B: ADR runtime/stack/fork + meetplan | decisions | Pas na A5 + expliciete ja — niet nu |
| Runtime-keuze (Pi / TS / …) + `--starter` / generators | apps | Expliciete keuze + ADR vereist vóór code |
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
