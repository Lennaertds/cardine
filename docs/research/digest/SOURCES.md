# Digest — bronnen (live)

> **Rol:** Feeds die `make digest-fetch` ophaalt. **http(s)-URL’s**: RSS/Atom **of** HF JSON-API (`/api/…`).
> **Niet hier:** curatie (`proposals/`, radar, Agent Engineering `bron/`).

| Bron | Soort | Frequentie | Notitie |
|------|-------|------------|---------|
| `<https://rss.arxiv.org/rss/cs.AI+cs.LG+cs.CL>` | papers | weekdays | AI + ML + NLP — RSS leeg in weekend |
| `<https://rss.arxiv.org/rss/cs.SE>` | papers | weekdays | Software engineering / agentic coding |
| `<https://rss.arxiv.org/rss/cs.MA>` | papers | weekdays | Multi-agent |
| `<https://export.arxiv.org/api/query?search_query=cat:cs.AI+OR+cat:cs.LG+OR+cat:cs.CL+OR+cat:cs.SE+OR+cat:cs.MA&sortBy=submittedDate&sortOrder=descending&max_results=50>` | papers | buffer | Atom-API: recente 50 (werkt ook in weekend); weekscript dedupe’t |
| `<https://huggingface.co/api/daily_papers?limit=50>` | papers | weekdays | HF Daily Papers (curated) — JSON, geen RSS |
| `<https://huggingface.co/api/papers/search?q=token%20consumption>` | papers | weekdays | Topic: token consumption / efficiency (UI: `/papers?q=token%20consumption`) |
| `<https://huggingface.co/api/papers/search?q=agent%20harness>` | papers | weekdays | Topic: agent harness / scaffolding |
| `<https://huggingface.co/api/papers/search?q=context%20engineering>` | papers | weekdays | Topic: context engineering |
| `<https://huggingface.co/api/papers/search?q=agentic%20coding>` | papers | weekdays | Topic: agentic coding |

**Ritueel:** weekdays `digest-fetch` (systemd) → maandag `make digest-week` (extra: `daily_papers?week=YYYY-Www`) → weekbrief in Agent Engineering `bron/weken/` → gekozen hits → `bronnen.md` § (P5, geen auto-dump).

YouTube en overig nieuws: handmatig via AE `bron/inbox.md` of meteen §.
