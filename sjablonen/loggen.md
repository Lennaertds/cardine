# Sjabloon: Status-log bijhouden

> **Gids bij:** `logs/status-log.md` (uit `kit/logs/`) en `logs/onderwerpen/T*.md`

## `logs/status-log.md` invullen

### Wanneer
Het bestand wordt aangemaakt bij de bootstrap van een project. Het wordt bijgewerkt op verzoek van de gebruiker ("vat samen en update") of via `make finish MSG="..."`.

### Invullen

1. **Header** — vervang `{{DATE}}` door de datum van aanmaken
2. **🔴 Bezig** — onderwerpen waar nu actief aan gewerkt wordt, met korte notitie
3. **🟡 Open** — onderwerpen die nog moeten gebeuren
4. **✅ Afgerond (naslag)** — afgeronde onderwerpen, verplaatst uit de actieve tabellen
5. **Log** — `make finish` schrijft hier regels onder (| datum | wat |)

### Voorbeeld

```markdown
# Status-log

> **Rol:** Één bron van waarheid over wat er gedaan is en wat nog open staat.
> **Bijgewerkt:** 2025-11-19
> **Zie ook:** `logs/onderwerpen/` voor details per onderwerp

## 🔴 Bezig

| ID | Onderwerp | Laatste update | Notities |
|----|-----------|---------------|----------|
| T01 | Token-logger bouwen | 2025-11-19 | DSH hooks onderzoeken |

## 🟡 Open

| ID | Onderwerp | Laatste update | Notities |
|----|-----------|---------------|----------|
| T02 | Structuurplan in kit gieten | 2025-11-19 | Drieplaats-regel |

## ✅ Afgerond (naslag)

| ID | Onderwerp | Laatste update | Notities |
|----|-----------|---------------|----------|
| T04 | Make finish opgezet | 2025-11-19 | Status-log werkt |

---

## Log

| Datum | Wat |
|-------|-----|
| 2025-11-19 | Project gestart, status-log aangemaakt |
```

### Snelle toets

- [ ] Staan alle open onderwerpen erin (geen gaten)?
- [ ] Zijn afgeronde onderwerpen verplaatst naar ✅ (niet dubbel)?
- [ ] Klopt de datum in de header?

## `logs/onderwerpen/TX-naam.md` invullen

### Wanneer
Een detailpagina wordt aangemaakt bij een nieuw onderwerp dat uitgebreide notities nodig heeft. Lichte onderwerpen kunnen volstaan met de notitie-kolom in `status-log.md`.

### Invullen

1. **ID** — gebruik het volgende vrije nummer (T01, T02, …); gaten niet hergebruiken
2. **Status** — 🔴 Bezig / 🟡 Open / ✅ Afgerond
3. **Wat** — concrete beschrijving van wat er moet gebeuren
4. **Waarom** — het doel of de aanleiding
5. **Aanpak** — hoe het aangepakt wordt (bijv. welke sporen, stappen, methodes)
6. **Log** — datum + actie, groeit met elke update
7. **Volgende stap** — wat de eerstvolgende actie is

### Voorbeeld

```markdown
# T01: Token-logger voor DeepSeekHarness

**Gemaakt:** 2025-11-19
**Status:** 🔴 Bezig
**Prioriteit:** Hoog

## Wat
Een post-request hook in DeepSeekHarness die elke API-response parsed
(prompt_tokens, completion_tokens, model, timestamp) en wegschrijft naar
een lokaal bestand (CSV/JSONL).

## Waarom
Dieper inzicht dan DeepInfra dashboard; eigen metingen + aggregatie.

## Aanpak
- Spoor A: DSH plugins/hooks checken
- Spoor B: Zed assistent logs doorzoeken
- Spoor C: Proxy logger bouwen

## Log
| Datum | Wat gedaan |
|-------|------------|
| 2025-11-19 | Omgevingsvariabelen uitgelezen, sandbox-beperking ontdekt |

## Volgende stap
Spoor A verder onderzoeken (plugins directory)
```

### Snelle toets

- [ ] Staat het ID in de tabel van `status-log.md`?
- [ ] Is de status hetzelfde als in de tabel?
- [ ] Staat de volgende stap erin (zodat een agent door kan)?

## Een onderwerp afronden

1. Zet status op ✅ in het detailbestand
2. Verplaats de rij in `status-log.md` van 🔴/🟡 naar ✅
3. Het detailbestand blijft staan (naslag voor agents die ernaar vragen)

## Een onderwerp toevoegen

1. Kies volgend vrij ID (check de bestaande IDs in `logs/onderwerpen/`)
2. Maak `logs/onderwerpen/T<ID>-<slug>.md` van het sjabloon
3. Voeg een rij toe in de juiste sectie van `status-log.md`

Zie [standaard/loggen.md](../standaard/loggen.md) voor de volledige regels.