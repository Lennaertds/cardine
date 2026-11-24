# .cursorrules (solo)

> **Rol:** Jouw persoonlijke laag voor Cursor bovenop `AGENTS.md`: voorkeuren en Cursor-afspraken.
> **Niet hier:** alles over het project zelf ([agents-root](agents-root.md)), regels voor één app ([agents-app](agents-app.md)).

**Kitbestand:** [kit/solo/.cursorrules](../kit/solo/.cursorrules) · laag solo · steunt op P2, P7

## Wanneer

Elk soloproject. In een teamproject niet: daar horen persoonlijke voorkeuren in je eigen user rules, niet in de repo.

## Waarom niet alles in `.cursorrules`

Cursor leest `AGENTS.md` en `.cursorrules` allebei. Staat dezelfde regel in beide, dan betaal je hem twee keer (harness tax, P25), en zodra één versie wijzigt, spreken ze elkaar tegen (P7). Daarom:

| Hoort in `AGENTS.md` | Hoort in `.cursorrules` |
|----------------------|-------------------------|
| grenzen, commando's, werkwijze, afronden, de kaart | de verwijzing naar `AGENTS.md` |
| harde leesroutes (UI → `DESIGN.md`, feature → `PRODUCT.md`) | taal van de antwoorden (Nederlands, …) |
| uitvoeren wint van praten (*implementeer* → code deze beurt) | persoonlijke werkwijze (plan eerst **tenzij** al uitvoer-woord; browser-check **na** de fix) |
| rapportagestijl (extreem beknopt; geldt voor elke tool) | wat alleen in Cursor bestaat (welke `.mdc`-rules, `@`-gebruik) |
| alles wat ook een andere tool of een frisse agent moet weten | (niets dat al links staat) |

Zo is `AGENTS.md` in elk project dezelfde standaard, en is `.cursorrules` het enige bestand dat per persoon verschilt. Wissel je van project, dan staan de regels op dezelfde plaats.

## Invullen

1. De eerste alinea uit de kit laten staan.
2. Twee à vier persoonlijke regels. Gelden ze in al je projecten, dan staan ze in elk project hetzelfde.
3. Een bestaande `.cursorrules` die als router diende: de inhoud gaat naar `AGENTS.md`, `docs/agent/write-rules.md` en de geneste `AGENTS.md`'s ([stap 6](../bestaand-project/6-router-en-kaart.md)). Wat overblijft is deze dunne laag.

## Voorbeeld (GymFreak)

```markdown
# GymFreak — Cursor, persoonlijk

Volg [AGENTS.md](AGENTS.md): daar staan de grenzen, de commando's, de werkwijze en de kaart. Dit bestand bevat
alleen mijn persoonlijke voorkeuren en wat enkel voor Cursor geldt. Het herhaalt niets uit AGENTS.md.

- Antwoord in het Nederlands. Volledig in de code.
- Bij een wijziging aan de UI: na de fix in de browser controleren op iPhone- en desktopbreedte, dan afronden. (Lezen van DESIGN hoort in AGENTS.md.)
- Bij meer dan drie bestanden: kort plan alleen als nog geen *implementeer* / *bouw* / *ja*; daarna meteen code.
- Kwaliteit boven tokenzuinigheid: liever een bestand meer lezen dan gokken.
```

## Snelle toets

- [ ] ≤ 15 regels.
- [ ] Geen regel die ook in `AGENTS.md` staat (`rg` op een kernwoord).
- [ ] De eerste regel verwijst naar `AGENTS.md`.
