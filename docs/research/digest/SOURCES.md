# Digest — bronnen (live)

> **Rol:** Feeds die `make digest-fetch` ophaalt. Alleen **http(s)-URL’s** (RSS/Atom).
> **Niet hier:** curatie (`proposals/`, radar, Agent Engineering `bron/`).

| Bron | Soort | Frequentie | Notitie |
|------|-------|------------|---------|
| `<https://rss.arxiv.org/rss/cs.AI+cs.LG+cs.CL>` | papers | weekdays | AI + ML + NLP — RSS leeg in weekend |
| `<https://rss.arxiv.org/rss/cs.SE>` | papers | weekdays | Software engineering / agentic coding |
| `<https://rss.arxiv.org/rss/cs.MA>` | papers | weekdays | Multi-agent |
| `<https://export.arxiv.org/api/query?search_query=cat:cs.AI+OR+cat:cs.LG+OR+cat:cs.CL+OR+cat:cs.SE+OR+cat:cs.MA&sortBy=submittedDate&sortOrder=descending&max_results=50>` | papers | buffer | Atom-API: recente 50 (werkt ook in weekend); weekscript dedupe’t |

**Ritueel:** weekdays `digest-fetch` (cron) → maandag `make digest-week` → weekbrief in Agent Engineering `bron/weken/` → gekozen hits → `bronnen.md` § (P5, geen auto-dump).

YouTube en overig nieuws: handmatig via AE `bron/inbox.md` of meteen §.
