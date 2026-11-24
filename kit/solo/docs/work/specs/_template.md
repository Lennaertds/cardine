# Spec — <slug>

> **Rol:** Plan voor één werkitem. Tijdelijk: na merge verwijderen; de code en de tests zijn dan de waarheid.

- **Item:** [BACKLOG.md](../BACKLOG.md) · branch `feat/<slug>`
- **Status:** open | in uitvoering | klaar (→ weg)

## Doel

<Wat de gebruiker straks kan, en waarom. Eén of twee zinnen.>

## Scope

- **In:** <…>
- **Buiten scope:** <expliciet wat niet, ook wat voor de hand ligt>

## Raakvlakken

- Modules en bestanden: `<pad>`, `<pad>`
- Interface die verandert: <signatuur, endpoint, schema>
- Seams die raken: <web→api, api→db, … — zie ARCHITECTURE.md § Seams>
- Voorbeeld om te volgen: `<pad/naar/vergelijkbare/feature>`

## Slices (elk apart testbaar, één sessie, door de hele stack)

1. <Dunste werkende versie>
2. <Uitbreiding>
3. <Randgevallen>

## Acceptatie

- [ ] <Test of commando dat bewijst dat het werkt — intent, niet alleen “groen”>
- [ ] Productregels / RULES die dit raakt, blijven gelden (niet afgezwakt)
- [ ] `make check` groen
