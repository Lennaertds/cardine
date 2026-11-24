# Loggen

> **Rol:** Hoe een project bijhoudt wat er gedaan is en wat nog open staat, zonder dat het dubbel staat of veroudert.
> **Niet hier:** technische implementatie (zie `kit/log/`), de Makefile-targets (zie [makefile.md](makefile.md)).

## Principe

Een project houdt **één gestructureerd statusbestand** bij met alle onderwerpen, hun status, en een beknopt log van wat er gebeurd is. Het bestand wordt alleen bijgewerkt als de gebruiker erom vraagt ("vat samen en update") — niet bij elke prompt of elke commit.

Dit voorkomt:
- Dubbele informatie (dezelfde open punten in meerdere bestanden)
- Verouderde open punten (afgeronde onderwerpen blijven onterecht als "open" staan)
- Lege of half-ingevulde templates
- Conversatiedumps die meer ruis dan signaal bevatten

## Structuur

```
<project>/
├── logs/
│   ├── status-log.md       ← één overzichtstabel (actief + afgerond)
│   └── onderwerpen/
│       ├── T01-slug.md     ← detailpagina's voor open onderwerpen
│       └── T02-slug.md
```

### `logs/status-log.md`

Het centrale overzicht. Bevat:

1. **Een header** met rol en datum laatste update
2. **Een 🔴 Bezig-sectie** — onderwerpen waar actief aan gewerkt wordt
3. **Een 🟡 Open-sectie** — onderwerpen die nog moeten gebeuren
4. **Een ✅ Afgerond-sectie** — afgeronde onderwerpen, bewaard als naslag (agents kunnen ze lezen als het onderwerp relevant is, maar ze staan niet in de weg)
5. **Een Log-tabel** onderaan voor korte `make finish`-regels

Elk onderwerp heeft een uniek ID (T01, T02, …) en een detailbestand in `logs/onderwerpen/`.

### `logs/onderwerpen/T01-slug.md`

Detailpagina voor een onderwerp dat nog open is of uitgebreide notities nodig heeft:

- **Wat** — wat het onderwerp inhoudt
- **Waarom** — waarom het gedaan moet worden
- **Aanpak** — hoe het aangepakt wordt
- **Log** — wat er al aan gebeurd is (datum + actie)
- **Volgende stap** — wat de eerstvolgende actie is

Afgeronde onderwerpen blijven in `logs/onderwerpen/` staan (voor naslag), maar krijgen geen plek meer in de actieve tabel van `status-log.md`.

## Wanneer updaten

| Actie | Wat gebeurt er |
|-------|---------------|
| `make finish MSG="..."` | Schrijft één logregel onderaan `status-log.md` (in de Log-tabel) |
| "Vat samen en update" | Agent leest `status-log.md`, inventariseert huidige chat, voegt nieuwe/update bestaande onderwerpen, zet ✅ afgerond naar naslag-sectie |
| Een onderwerp is ✅ | Agent verplaatst het naar de ✅-sectie in `status-log.md`; detailbestand blijft staan |

## ID-beheer

- IDs worden toegekend bij aanmaken: T01, T02, T03, …
- Een nieuw onderwerp krijgt het volgende vrije nummer
- Verwijderde of samengevoegde IDs worden niet hergebruikt (P5: geen gaten verbergen)

## Zie ook

- [makefile.md](makefile.md) — `make finish` target
- [kit/logging/](../kit/logging/README.md) — sjablonen voor status-log en onderwerpen