# Skills-veiligheid — SkillSpector

> **Rol:** Scannen van agent-skills vóór installatie (prompt injection, exfil, tool poisoning, …).
> **Niet hier:** skill-*ontwerp* (§3); Microsoft APM als geheel product.

## Plaatsing

- **SkillSpector** = NVIDIA-scanner voor AI agent skills (static + optioneel LLM); deel van NVIDIA skills trust pipeline / SkillEvaluator tier 1.
- **Microsoft APM** (`apm audit`) kan SkillSpector als *external scanner* aanroepen — vandaar de associatie met Microsoft, maar de scanner zelf is NVIDIA.

## Te schrijven

- Threat model: skills als supply chain
- Wat de scanner wel/niet doet (geen sandbox van runtime)
- Wanneer offline (`--no-llm`) vs LLM-analyse
- Link naar P14/P6: liever checks dan “vertrouw de skill-tekst”

## Wat kan naar de standaard

Optioneel later: “scan skills vóór merge” in team-how-to — niet always-on. Nu: **geen actie**.
