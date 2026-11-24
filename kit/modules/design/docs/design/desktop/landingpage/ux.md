# Desktop — ux

> **Rol:** Hoe de showcase werkt: doel, copy, links, formulieren, feedback.  
> **Niet hier:** looks ([looks.md](looks.md)).

Mooi volgt hieruit. Een effect dat het doel niet dient, gaat eruit.

## 1. Doel per pagina

Elke showcase-route heeft één zin: wat de bezoeker hier moet kunnen (begrijpen, handelen, of doorverwijzen).

Patroon dat mensen al kennen: balk boven, claim, actie, dan de rest. Geen nieuwe navigatiemetafoor.

## 2. Copy

- De claim noemt het concrete resultaat. Geen vage belofte (“het beste platform”).
- Korte woorden. Geen stack-jargon in de claim of de featurezin. Stack mag op een technische plek.
- Eén onderwerp per zin. Fluff eruit. Plain product copy — geen AI-marketingwol (“revolutionize your journey”).
- Lange tekst breekt met een H2, een beeld of een lijst. Geen muur.
- De primaire knop zegt wat er gebeurt (“Open de demo”, “Ga naar de app”). Niet “Verstuur”, “Klik hier”, “Learn more”.
- Zelfde bestemming in de balk en in de hero.
- Eén accent-CTA in de hero (~90/10 t.o.v. secondary). Real proof in diezelfde viewport: product-UI of echte scène — geen stock-abstract, geen AI-blob als “bewijs”.

## 3. Links

- In proza: `--accent` én onderstreept. Kleur alleen is niet genoeg.
- In de balk: geen underline. De actieve route is weight 650.
- Blauw is geen linkkleur. Onderstreepte tekst die geen link is, bestaat niet.
- Externe links zeggen waar ze heen gaan.

## 4. Hiërarchie op de landing

Het oogpad, van boven naar onder:

1. Claim (grootte).
2. Primaire knop (accent, enige gevulde actie).
3. Beeld van het product.
4. Daarna de rest van de secties.

Iets benadrukken door de rest rustiger te maken, niet door een tweede accent te introduceren. Een beeld trekt hard: daarom staat het in de hero, niet nog eens als volle breedte tussen features.

## 5. Formulieren

Op de showcase zeldzaam. Als er een veld is:

- Zichtbaar label boven het veld, één verticale lijn. Placeholder is geen label.
- Verplicht-veld krijgt een woord of asterisk in het label.
- Fout onder het veld, na blur, niet per toetsaanslag. De tekst zegt wat mis is en hoe het goed komt.
- Meerdere fouten: een samenvatting bovenaan die focust, plus de fouten bij de velden.
- Type en `autocomplete` kloppen (`email`, paste toegestaan).
- Hoogte van het veld ≥ 44px.
- Onopgeslagen invoer: vragen voor het sluiten.

## 6. Feedback

- Elke actie antwoordt binnen 100ms (press, of de pending-staat).
- Korte bevestiging: de bestaande toaster, 3–5 seconden, steelt geen focus, `aria-live="polite"`.
- Fout die blijft: in de pagina, met een manier om het opnieuw te proberen.
- Destructief staat ruimtelijk weg van de primaire knop, in de danger-kleur van het product, met een woord erbij.
- Ongedaan maken als de actie inhoud wist.

## 7. Consistentie over pagina’s

- Hulp en footerlinks staan op elke showcase-route in dezelfde volgorde.
- Terug gaan herstelt scroll waar de browser dat doet. De pagina springt niet stil naar home.
- Een dialoog is geen navigatie. Inhoudelijke pagina’s zijn routes.

**Test:** de hero-knop zegt de bestemming. Een prozalink is accent en onderstreept. Er is geen tweede gevulde actie.
