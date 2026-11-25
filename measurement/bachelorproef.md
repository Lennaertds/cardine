# From this set to a bachelor thesis

> **Role:** How the evaluation set becomes the design of a bachelor thesis straight away.
> **Not here:** the execution ([INDEX](INDEX.md)).

This evaluation set is immediately the design of a bachelor thesis. Examples of a sharp research question, each time with one variable you manipulate:

- *"Which parts of repository documentation (context file, docs map, check command, folder overview) influence the pass rate and cost of AI coding agents on maintenance tasks in small full-stack and data projects?"* → ablation C2 against C3 to C5.
- *"To what extent does an executable check command improve the correctness of AI coding agents, compared to instructions in natural language?"* → C2 against C4.
- *"Does the effect of agent context files differ between a solo project and a team project?"* → C0, C1 and C2 on GymFreak and DEP2.

The lasting contribution is the **method and the repeatable set**, not the score of one model. That is out of date within six months. Compare your results with the ETH study (§20): do you confirm them for smaller projects, or do you find a context in which well-structured docs *do* help?

**Theory vs empirics:** the narrative "why the environment counts next to model and reasoning mode" lives in [bron/fundament/efficientie/drie-hefbomen.md](../bron/fundament/efficientie/drie-hefbomen.md) and the [knowledge map](../bron/fundament/kenniskaart.md). This folder stays the **empirical** axis (ablating the environment). Hybrid/latent (§35) belongs in the theory-chapter bridge, not as a kit default.
