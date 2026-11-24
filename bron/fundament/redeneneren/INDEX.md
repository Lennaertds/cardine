# Redeneren — hoe het model “denkt”

> **Rol:** Interne en zichtbare redeneerprocessen: CoT, test-time compute, latent vs text, hybrid, HRM/TRM.
> **Niet hier:** modelarchitectuur-basics ([../modellen](../modellen/INDEX.md)); tool-protocollen ([../agents](../agents/INDEX.md)).

## Scope

Denken *tijdens* generatie — niet de gewichten zelf, niet RAG. Inclusief **recurrent / hiërarchische** tiny nets die reasoning buiten text-CoT zoeken.

## Bestanden

| Bestand | Status | Over |
|---------|--------|------|
| [hybrid-agents.md](hybrid-agents.md) | diep | HybridLink, HybridSFT/RL, lessen voor omgeving (§35) |
| [cot-en-test-time.md](cot-en-test-time.md) | stub | Chain-of-thought, search, compute at test time |
| [hrm-trm.md](hrm-trm.md) | outline | HRM + TRM: hiërarchisch/recursief; dichte video in **§46** |

## Leesvolgorde

cot-en-test-time → hybrid-agents → hrm-trm → hefbomen in [../efficientie/drie-hefbomen.md](../efficientie/drie-hefbomen.md).
