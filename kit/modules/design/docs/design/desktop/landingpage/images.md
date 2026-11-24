# Desktop — images

> **Rol:** Welke beelden, hoe tekst erop staat, en de technische maten.  
> **Niet hier:** merkpersoonlijkheid (project).

Beelden ondersteunen het verhaal. Een beeld dat alleen “vult”, gaat eruit.

## 1. Soorten die mogen

| Soort | Waar |
|-------|------|
| Product-UI (device-mock, echt scherm) | Hero, productsectie |
| Scènefoto uit de productfamilie | Full-bleed, eventueel onder Clear-glas |
| Portret / team | Detailpaneel indien nodig |

Geen stock van generieke “happy users”, geen illustratiepakket, geen patronen, geen 3D-objecten als sfeer.

Naast elkaar: dezelfde aspect-ratio en dezelfde korte zijde. Niet een vierkant naast een banner.

## 2. Tekst op een foto

Eén methode per beeld.

| Volgorde | Methode | Wanneer |
|----------|---------|---------|
| 1 | Dim of een gradient over het beeld | Default zodra er tekst op de foto staat |
| 2 | Tekst in een rustig deel van de foto | Alleen als dat deel echt leeg is en het contrast haalt |
| 3 | Solid leesvlak | Alleen in een detailpaneel, als glas de tekst niet draagt ([surfaces.md](surfaces.md)) |

De drie methoden niet stapelen op hetzelfde beeld.

## 3. Technisch

- Bron minstens 2× de vertoonde CSS-pixels. `srcset` met 1× en 2×.
- Formaat: AVIF of WebP. PNG alleen als er echte transparantie nodig is.
- `width` en `height`, of `aspect-ratio`, zodat de layout niet springt.
- Hero-beeld: eager, hoge fetch-priority. Alles onder de eerste viewport: `loading="lazy"`.
- Gecomprimeerd. Een hero onder ongeveer 200KB na compressie is het doel; erboven eerst opnieuw comprimeren.
- `max-width: 100%` en `height: auto` binnen de kolom. De full-bleed foto mag de kolom uit, de tekst niet.
- Alt: beschrijvend als het beeld informatie draagt. `alt=""` als het decor is en de tekst ernaast hetzelfde zegt.

## 4. Crop

Snijd bij op het onderwerp. Geen tweede crop in CSS die dat alsnog doet: `object-fit: cover` alleen als de veilige zone in het bestand zit.

**Test:** de landing toont het product, niet een stockfoto. Elk beeld heeft een gereserveerde verhouding. Tekst op een foto gebruikt één van de drie methoden.
