# Stap 5 — Validiteit

> **Rol:** Waar een meting misleidend kan zijn, en wat je ertegen doet.
> **Niet hier:** de methode zelf ([INDEX](INDEX.md)).

| Risico | Gevolg | Maatregel |
|--------|--------|-----------|
| **Eigen bias** als beoordelaar | Je ziet wat je hoopt | Blind beoordelen, een tweede beoordelaar |
| **Lekken van de oplossing** | De agent kent het antwoord uit de docs, logs of git | Docs, logs en ADR's van ná de base commit verwijderen; git-geschiedenis afkappen (`git clone --depth 1` op de base) |
| **Modeldrift** | Het model verandert tijdens je meting | Modelversie vastleggen, alles in een korte periode draaien, volgorde randomiseren |
| **Te weinig taken** | Toeval domineert | Herhalingen; resultaten per taak tonen; voorzichtig formuleren |
| **Taken passen bij één variant** | Je meet de taakkeuze in plaats van de structuur | Taken kiezen vóór je de nieuwe structuur bouwt |
| **Eigen projecten** | Moeilijk te veralgemenen | Twee verschillende projecten (solo en team); eventueel een open-source repo als derde case |
