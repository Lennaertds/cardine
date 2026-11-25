# docs/context/GLOSSARY.md

> **Role:** One term per concept, with the name in the code. Also the list of domains and the project codes.
> **Not here:** explanations of general concepts (REST, ETL, JWT).

**Kit file:** [kit/kern/docs/context/GLOSSARY.md](../kit/kern/docs/context/GLOSSARY.md) · layer kern · P10

## When

Day 0 with the first five terms. After that, every time a term shows up in a conversation, issue or prompt that a fresh reader does not know, and every time a code or abbreviation ends up in a filename.

## Filling in

1. **Domains:** the names that also become the folders (`features/<domain>/`, `src/<domain>/`, `product/<domain>.md`). One word, English if the code is English.
2. **Terms:** term, meaning, name in the code, and what not to confuse it with. The last column catches most mistakes.
3. **Codes and abbreviations:** every code that appears in a filename, a doc header or a commit.
4. Mixed Dutch and English: the local-language term in the first column, the code name in the third.

## Example (GymFreak and DEP2)

```markdown
## Domains

| Domain | One sentence | Code |
|--------|--------------|------|
| gym | Programmes, sessions and sets | H |
| sleep | Import sleep data and show trends | S |
| diet | Macros and budget per day | D |

## Terms

| Term | Meaning | In the code | Do not confuse with |
|------|---------|-------------|---------------------|
| Split | The distribution of muscle groups across the week | `Split`, `proposeSplit()` | slot (one day in the split) |
| Plot | A trial field with one variety and one treatment | `DimPlot`, `plot_id` | object (the whole trial design) |
| Flight | One drone flight with its orthomosaic | `flight_id` | campaign (all flights of one date) |
```

## Quick check

- [ ] Every code from a filename is in there (`H-gym.md` → H).
- [ ] Every domain name is also a folder in the code, spelled the same way.
- [ ] No term has two names in the code.
