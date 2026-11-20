# 0007 — Tool-goedkeuring is een workspace-allowlist en de shell draait onder bwrap

- **Status:** aanvaard
- **Datum:** 2026-11-16
- **Raakt:** [tools.md](../product/tools.md), [totaalproduct.md](../product/totaalproduct.md), [structure.md](../product/structure.md), [PRODUCT.md](../product/PRODUCT.md), [BACKLOG.md](../work/BACKLOG.md). Spec `onderdeel-tools` verwijderd — product-doc volstaat. Sluit T2 en T3 uit [0003](0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md).

## Samenvatting

In de context van een agent die bestanden en shell gebruikt, geconfronteerd met een home-directory die niet mee mag en een harness-sandbox waarvan de default niet gemeten is, kozen we voor een workspace-allowlist en `bwrap` om de shell en tegen de sandbox van DeepSeek Harness, om de kooi zelf te begrenzen tot de workspace, en we aanvaarden dat een install die netwerk of een cache buiten de map nodig heeft daar bewust een gat voor vraagt.

## Context

- T1, T4 en T5 staan in [0003](0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md): read, edit, shell, plus de index-MCP. Schrijven buiten de workspace is al dicht ([0004](0004-de-projectstandaard-is-dual-een-dunne-agents-md-en-een-harde-make-check.md)).
- Drie goedkeuringen lagen open: altijd vragen, allowlist, of auto in het lab. Drie kooien: geen, `bwrap`, of de sandbox van DSH.
- `bwrap` is een dunne Linux-naamruimte, lichter dan Docker. Of hij sneller is dan de sandbox van DSH is niet gemeten. De reden is de grens: alleen de workspace is gemount. Zed en `dsh` blijven gewone processen.

## Besluit

- **T2.** Paden in de workspace gaan door. Een pad daarbuiten stopt en vraagt. Binnen de map vraagt de agent niet bij elke edit.
- **T3.** Shell en package-install (`npm`, `pip`) draaien onder `bwrap`, met alleen de workspace gemount. Geen Docker om Zed of `dsh` zelf te draaien. De sandbox van DeepSeek Harness is niet de kooi.

Logs blijven zonder secrets en zonder `.env`.

## Alternatieven

| Optie | Waarom niet |
|-------|-------------|
| Altijd vragen | Elke edit wacht. De allowlist dekt het gewone werk al |
| Auto in het lab, ook buiten de map | Geen rem op de home |
| Geen sandbox | Een goedgekeurde shell is nog steeds de hele account |
| Sandbox van DeepSeek Harness | Default niet gemeten; een preview-update kan die grens verleggen |

## Gevolgen

- **Makkelijker:** gewone edits lopen. Een shell ziet `~/.ssh` niet.
- **Moeilijker of risico:** `npm` of `pip` dat het netwerk of een cache buiten de workspace nodig heeft, faalt tot die mount bewust open gaat. `bwrap` is Linux; andere OS’en zijn een latere port.
- **Te doen:** de kooi pas met de applicatie. Geen `apps/` door deze ADR. [0001](0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md) blijft.
