# Minimale versie (prototype of hackathon)

> **Rol:** Wat je doet als je echt maar een uur hebt, zonder later te moeten verhuizen.
> **Niet hier:** het volledige stappenplan ([INDEX](INDEX.md)).

```bash
kit/new-project.sh <map> --stacks <één stack>     # na de generator; geen modules
```

Vul daarna alleen dit in:

1. `README.md`: wat en quickstart.
2. `AGENTS.md`: de commando's staan er al; voeg drie "Nooit"-regels toe die specifiek zijn voor dit project.
3. Eén test en een groene `make check`.
4. Elke keuze met een waarom: `make adr t="…"`, en schrijf alleen de samenvatting.

De rest van de kit mag leeg blijven: de bestanden met `<…>` raken de agent pas als hij ze opent, en de kaart wijst er niet naar zolang je de regel niet invult. Blijft het project bestaan, dan ga je verder met [stap 2](2-context-en-grenzen.md). Er hoeft niets te verhuizen.
