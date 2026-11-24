# docs/decisions/NNNN-&lt;slug&gt;.md (ADR)

> **Rol:** Eén besluit met zijn waarom, zo dat niemand het later opnieuw moet uitvechten.
> **Niet hier:** hoe het systeem nu werkt ([architecture](architecture.md)), wat er nog moet gebeuren ([backlog](backlog.md)).

**Kitbestand:** [kit/kern/docs/decisions/_template.md](../kit/kern/docs/decisions/_template.md) · laag kern · P9 (naar Nygard en de Y-statement, §16, §17)

## Wanneer

Elke keuze met een waarom die iemand later in vraag zou stellen: stack, database, hosting, een patroon, een grens. Ook als je iets bewust **niet** doet. Een kleine keuze die alleen in één bestand speelt: een comment in dat bestand volstaat.

Native / extra taal (Rust, C, …) na budget-breuk: eerst [polyglot.md](../kit/kern/docs/architecture/polyglot.md); vorm zie kit-voorbeeld [`0000-voorbeeld-native-module-na-budget-breuk.md`](../kit/kern/docs/decisions/0000-voorbeeld-native-module-na-budget-breuk.md) — status *voorbeeld*, niet als geldend besluit laten staan.

```bash
make adr t="Postgres is de enige writer van user-data"   # → docs/decisions/0007-postgres-is-de-enige-writer-van-user-data.md
```

## Invullen

1. **Titel = het besluit als zin.** Niet "Database", wel "Postgres is de enige writer van user-data".
2. **Status:** `voorgesteld` tot het gemerged of afgesproken is, dan `aanvaard`.
3. **Samenvatting** als Y-statement: één zin met situatie, probleem, keuze, alternatief, doel en nadeel.
4. **Context:** de krachten, als feiten.
5. **Alternatieven:** elk met waarom niet. Dit is wat een agent later het meest helpt.
6. **Gevolgen:** wat makkelijker en moeilijker wordt, en welke docs of code moeten volgen.

Een ADR herschrijf je nooit. Verandert het besluit, dan maak je een nieuwe ADR, en zet je de oude op `vervangen door NNNN`.

## Voorbeeld (DEP2)

```markdown
# 0002 — De pipeline is de bron van waarheid voor alle cases

- **Status:** aanvaard
- **Datum:** 2026-10-14
- **Raakt:** `sql/`, `src/etl/`, `dronebeelden/`, `docs/architecture/`

## Samenvatting

In de context van twee parallelle lijnen voor dronedata, geconfronteerd met agents en teamleden die in de
verkeerde lijn werken, kozen we voor het sterschema van de pipeline en tegen schema `plantcount`, om één
plek voor elke meting te hebben, en we aanvaarden dat de groepsscripts van case 2 herschreven moeten worden.

## Alternatieven

| Optie | Waarom niet |
|-------|-------------|
| Beide lijnen houden | elke vraag heeft twee antwoorden; geen test dekt de tweede lijn |
| `plantcount` als bron | geen koppeling met `DimPlot`; niet vergelijkbaar met case 1 |
```

## Snelle toets

- [ ] De titel is een besluit, geen onderwerp.
- [ ] Er staat minstens één alternatief met waarom niet.
- [ ] Een vervangen ADR verwijst naar zijn opvolger.
- [ ] Bij meer dan ±15 ADR's: `decisions/DECISIONS.md` met de geldende, en de kaart verwijst ernaar.
