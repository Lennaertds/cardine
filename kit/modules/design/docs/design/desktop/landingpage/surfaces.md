# Desktop — surfaces

> **Rol:** Wanneer een vlak solid is, en wanneer het het ene glas-paneel is.  
> **Niet hier:** het materiaal ([liquid-glass.md](liquid-glass.md)); kaarten in de app ([surfaces-cards](../../iphone/application/surfaces-cards.md)).

De contentlaag is rustig en dekkend. Glas is de uitzondering, en er is er één.

## 1. Solid

Deze blijven `--card` of gewoon `--background`, met `--r-group` als ze een rand hebben:

- feature-kolommen;
- proza-blokken;
- bewijslijst en chart;
- formulieren;
- footer;
- rijen in een menu (de menu-schaal is glas; de rij is een fill).

Rij-padding ruimer dan op de telefoon: minstens 12px verticaal, 16px horizontaal. Sectiekoppen in titelkast, niet in hoofdletters.

Een haarlijn of een shift van `--background` naar `--card` scheidt secties. Geen kaarten-soep om de pagina “af” te maken.

## 2. Het ene glazen paneel

Toegestaan als functionele laag:

- de site-balk;
- een menu;
- een dialoog;
- hoogstens één detailpaneel over media.

Niet twee van de laatste drie tegelijk. De balk mag blijven staan terwijl een menu open is, omdat het menu uit de balk groeit en dezelfde laag is — de items erin zijn geen tweede `backdrop-filter`.

## 3. Detailpaneel over foto

De foto is de content. Het paneel is het ene glasvlak.

- Als de tekst op Regular-glas niet genoeg contrast haalt: een solid leesvlak ín het paneel (`--card` ≥ 96% dekking), geen tweede blur.
- Geen glazen kaarten rond tekstblokken.
- Hotspots zijn controls ([controls.md](controls.md)), geen glazen stickers.

## 4. Leeg, laden, fout

Op de showcase zeldzaam. Als een demo-blok faalt:

- één zin in body-type, `--foreground`;
- geen illustratie-bibliotheek, geen glazen empty-card;
- de rest van de secties blijft staan.

Product empty/loading blijft [surfaces-states](../../iphone/application/surfaces-states.md).

## 5. Beeld

- Device-mock: `--r-device`, schaduwrol panel, geen glas-op-glas op het scherm van de mock.
- Foto’s: echte product- of scènebeelden. Geen stock, geen neon-overlay.
- Een full-bleed foto mag Clear-glas dragen alleen als [liquid-glass.md](liquid-glass.md) §1 slaagt.
- Tekst op een foto: één methode uit [images.md](images.md) §2.

**Test:** op de landing heeft geen feature-kolom `backdrop-filter`. Het enige glas is de balk (en een menu als dat open is).
