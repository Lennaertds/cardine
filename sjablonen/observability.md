# docs/architecture/observability.md

> **Rol:** Signalen, kit-default LGTM-stack en hoe je observability lokaal start.
> **Niet hier:** security-dreigingen ([security](security.md)), containers ([architecture](architecture.md)).

**Kitbestand:** [kit/kern/docs/architecture/observability.md](../kit/kern/docs/architecture/observability.md) · laag kern · runtime: module `observability` · P13 · bron §48 (alleen in Agent Engineering `bron/`, niet herhalen in projectdocs)

## Wanneer

Dag 0 met de stack-tabel uit de kit. Bij elke nieuwe service: signalen + correlatievelden bijwerken. OTel in de apps mag later (BACKLOG) zolang dit doc zegt *wat* verplicht is. AGENTS laadt dit **niet** always-on — alleen via INDEX als de opdracht het noemt.

## Invullen

1. **Stack:** kit-default laten (OTel → Alloy → Prometheus/Loki/Tempo → Grafana), of ADR + dit bestand aanpassen. Schrijf “kit-default”, niet “default voor alle projecten alsof alles al live is”.
2. **Productie:** waar Grafana/OTel-ingest draait.
3. **SLO’s:** minstens één user-facing doel per productieve service.
4. **Module:** `kit/new-project.sh … --modules …,observability` voor compose + `make obs-up`. Zonder module: compose ontbreekt → Bewust later / BACKLOG.
5. **`## Bewust later`:** kitrijen laten staan of aanvullen (P28). Geen paden naar Agent Engineering `bron/` in het projectbestand.

## Snelle toets

- [ ] Geen hoog-kardinaliteit-labels op metrics (`user_id`, raw URL, …).
- [ ] `make help` toont `obs-up` / `security-scan`; die zitten niet in `make check`.
- [ ] Zonder module faalt `obs-up` met “kit: --modules observability”.
- [ ] `## Bewust later` heeft minstens één uitbreidingsrij (P28).
- [ ] Geen “Agent Engineering bron §…” in de projectdoc.
