# docs/context/GLOSSARY.md

> **Rol:** Eén term per begrip, met de naam in de code. Ook de lijst van domeinen en de projectcodes.
> **Niet hier:** uitleg van algemene begrippen (REST, ETL, JWT).

**Kitbestand:** [kit/kern/docs/context/GLOSSARY.md](../kit/kern/docs/context/GLOSSARY.md) · laag kern · P10

## Wanneer

Dag 0 met de eerste vijf termen. Daarna elke keer dat een term in een gesprek, issue of prompt opduikt die een frisse lezer niet kent, en elke keer dat een code of afkorting in een bestandsnaam komt.

## Invullen

1. **Domeinen:** de namen die ook de mappen worden (`features/<domein>/`, `src/<domein>/`, `product/<domein>.md`). Eén woord, Engels als de code Engels is.
2. **Termen:** term, betekenis, naam in de code, en waarmee je hem niet verwart. De laatste kolom vangt de meeste fouten.
3. **Codes en afkortingen:** elke code die in een bestandsnaam, een doc-kop of een commit voorkomt.
4. Gemengd Nederlands en Engels: de Nederlandse term in de eerste kolom, de code-naam in de derde.

## Voorbeeld (GymFreak en DEP2)

```markdown
## Domeinen

| Domein | Eén zin | Code |
|--------|---------|------|
| gym | Schema's, sessies en sets | H |
| sleep | Slaapdata importeren en trends tonen | S |
| diet | Macro's en budget per dag | D |

## Termen

| Term | Betekenis | In de code | Niet verwarren met |
|------|-----------|------------|--------------------|
| Split | De verdeling van spiergroepen over de week | `Split`, `proposeSplit()` | slot (één dag in de split) |
| Plot | Proefveldje met één ras en één behandeling | `DimPlot`, `plot_id` | object (de hele proefopzet) |
| Vlucht | Eén dronevlucht met zijn orthomosaic | `flight_id` | campagne (alle vluchten van één datum) |
```

## Snelle toets

- [ ] Elke code uit een bestandsnaam staat erin (`H-gym.md` → H).
- [ ] Elke domeinnaam is ook een map in de code, met dezelfde spelling.
- [ ] Geen term heeft twee namen in de code.
