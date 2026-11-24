# HRM en TRM — hiërarchisch / recursief redeneren met tiny nets

> **Rol:** Plaats van Hierarchical Reasoning Model (HRM) en Tiny Recursive Model (TRM) in de hefbomen; pointers naar dichte naslag.
> **Niet hier:** volledige video-dictaat (dat staat in §46); HybridLink ([hybrid-agents.md](hybrid-agents.md)); transformer-basics ([../modellen](../modellen/INDEX.md)).

**Bron:** [§46](../../bronnen.md) (bycloud-explainer, verdicht okt 2026). Papers nog niet regel-voor-regel hier.

## Plaats in het vakgebied

| | HRM | TRM |
|---|-----|-----|
| Idee | Twee kleine nets op **verschillende frequenties** (fast scratchpad / slow sturing + halt) | **Recursie** over tiny net: scratchpad + answer-canvas; train op echte unrolled loop |
| Schaal (video-claims) | ~27M params | ~7M params |
| Typische benches (video-claims) | ARC-AGI ~32% / ~2% (v1/v2), Sudoku | ARC-AGI ~40% / ~6.2%; Sudoku vaak MLP-only |
| Tegenover | LLM + text CoT; één forward pass | Zelfde + kritiek op HRM-heuristiek/equilibrium |

Hefboom: vooral **reasoning-mode / architectuur** (niet AGENTS.md-omgeving). Zie [drie-hefbomen](../efficientie/drie-hefbomen.md) en [kenniskaart](../kenniskaart.md).

## Mechanismen (samenvatting; detail in §46)

- HRM: fast microsteps op latent scratchpad → slow strategic update + halting head; training “alsof” fast loop equilibrium.
- TRM: functionele twee memories (geen bio-story); vaste # recursiestappen; backprop door echte laatste pass; 2 layers + meer recursie > meer layers (overfit op little data).
- Attention vs MLP hangt van grid/contextgrootte (Sudoku vs Maze/ARC).

## Papers / video

- **HRM:** Hierarchical Reasoning Model — Guan Wang e.a. (Sapient Intelligence)
- **TRM:** Less is More: Recursive Reasoning with Tiny Networks — Alexia Jolicoeur-Martineau (Samsung SAIT Montréal)
- Explainer: bycloud *How did a 27M Model even beat ChatGPT?* → **§46**

## Wat kan naar de standaard

**Geen actie.** Bachelor/theorie (reasoning-hefboom); geen kit-default, geen nieuwe P zonder meting. Brug: [brug.md](../brug.md).
