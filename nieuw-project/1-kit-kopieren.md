# Stap 1 — Kit kopiëren

> **Rol:** Het fundament neerzetten: elke vaste map, elk ingangsbestand, de Makefile en de guardrails.
> **Niet hier:** de apps zelf ([stap 3](3-apps-en-feedbacklus.md)), wat elke laag bevat ([kit](../kit/README.md#lagen)).

## Doen

1. **Kies de lagen** uit de tabel in [INDEX](INDEX.md#wat-je-kopieert). Stacks laat je nu nog weg: hun generators komen in stap 3.

   ```bash
   kit/new-project.sh ~/code/<project> --modules product,design,compose
   ```

   Het script maakt de map, kopieert kern + solo (of team) + modules, vult `{{PROJECT}}` en `{{DATE}}` in, laat de `<!-- als: … -->`-blokken staan die gelden, en doet `git init`.

2. **Controleer:**

   ```bash
   cd ~/code/<project>
   make            # toont alle targets, per groep
   make check      # faalt: "make check controleert nog geen app" (zo hoort het)
   make doctor     # welke tools ontbreken
   ```

3. **Eerste commit** met alleen de kit, zodat je later ziet wat jij toevoegde:

   ```bash
   git add -A && git commit -m "chore: projectskelet uit de kit"
   ```

## Wat je nu hebt

- `README.md`, `AGENTS.md`, `docs/INDEX.md`: de drie ingangen, met `<…>` waar jij invult.
- `Makefile` met de vaste targets ([makefile](../standaard/makefile.md)), `.gitignore`, `.editorconfig`, `.pre-commit-config.yaml`, `scripts/check-links.sh`.
- `docs/` met de kernbestanden en de sjablonen `_template.md` voor ADR, spec en log.
- `data/` met de vijf vaste lagen en een catalogus. Ruwe data komt er nooit in git.
- Lege vaste mappen met een `.gitkeep`: `apps/`, `docs/how-to/`, de datalagen.

## Valkuilen

- **Niets verplaatsen of hernoemen.** Een naam die je niet bevalt, verander je in de standaard ([standaard](../standaard/INDEX.md#de-standaard-veranderen)), niet in één project.
- **Geen extra mappen "voor later".** De plaats ligt vast, ook als de map nog niet bestaat.
- Het script weigert een doelmap in de kit zelf, en overschrijft nooit iets. Opnieuw draaien met extra modules is veilig.
