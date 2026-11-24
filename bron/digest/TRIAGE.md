# Digest-triage — vaste werkwijze

> **Rol:** Elke weekbrief (`bron/weken/YYYY-Www.md`) op **dezelfde** manier filteren.
> **Niet hier:** volledige §-teksten schrijven; dat blijft lazy (pas bij gebruik/cite).

## Principe

1. **Liever te veel dan te weinig.** Bij twijfel → `keep`.
2. **Relevant** = AE-stack **of** thema al in `bronnen.md` **of** term in [`interests.md`](interests.md) (bv. OCR).
3. **Geen auto-§.** Triage zet alleen status in de weekbrief.

## Statuswaarden

| Status | Betekenis |
|--------|-----------|
| `open` | Nog niet getrieerd (na `digest-day`) |
| `have` | arXiv/URL al in `bronnen.md` (eventueel als `§n` als bekend) |
| `§n` | Handmatig: al als die § opgenomen / gelinkt |
| `keep` | Nieuw + relevant → wachtrij (nog geen of later §) |
| `skip` | Buiten AE **én** buiten interesses/thema’s |
| `maybe` | Zeldzaam; script gebruikt dit niet (jij mag het zetten) |

## Commando

```bash
make digest-triage                 # huidige ISO-week (+ vorige op maandag)
make digest-triage WEEK=2026-W45   # één weekbrief
DIGEST_TRIAGE_FORCE=1 make digest-triage   # herbereken ook bestaande keep/skip (niet §n)
```

Script: `scripts/digest-triage.py`.

## Beslisboom (script)

1. Rij met status `§…` → **onaangeroerd**.
2. arXiv-id / URL komt voor in `bronnen.md` → `have` of `§n`.
3. Bronlabel hoog signaal (`HF trending`, `HF q:*`, `HF week`, `HF day`) → `keep`.
4. Titel matcht keyword uit:
   - vaste AE-lijst (agent, harness, context, prompt, token, …)
   - H1-thema’s uit `bronnen.md` (Prompt Engineering, Inference, …)
   - [`interests.md`](interests.md)
   → `keep`.
5. Anders → `skip` (alleen dit is “niet relevant”).

## Mens-ritueel (na het script)

1. `make digest-triage`
2. Scan **alleen** `keep` (niet 300 abstracts). Groepeer mentaal per thema.
3. Wat je nú nodig hebt → § + index; status → `§n`.
4. Rest mag `keep` blijven tot je het oppakt.
5. `interests.md` bijwerken als je een nieuwe hobby-as start (OCR-achtig).

## W45 / W46

- Vorige week: één keer triëren + afronden.
- Lopende week: na `digest-day` opnieuw `digest-triage` (alleen `open` wordt gezet, tenzij `FORCE=1`).
