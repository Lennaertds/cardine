# Digest — sources (live)

> **Role:** Feeds that `make digest-fetch` fetches. **http(s) URLs**: RSS/Atom **or** the HF JSON API (`/api/…`).
> **Not here:** curation (`proposals/`, radar, Agent Engineering `bron/`).

| Source | Kind | Frequency | Note |
|--------|------|-----------|------|
| `<https://rss.arxiv.org/rss/cs.AI+cs.LG+cs.CL>` | papers | weekdays | AI + ML + NLP — RSS empty at weekends |
| `<https://rss.arxiv.org/rss/cs.SE>` | papers | weekdays | Software engineering / agentic coding |
| `<https://rss.arxiv.org/rss/cs.MA>` | papers | weekdays | Multi-agent |
| `<https://export.arxiv.org/api/query?search_query=cat:cs.AI+OR+cat:cs.LG+OR+cat:cs.CL+OR+cat:cs.SE+OR+cat:cs.MA&sortBy=submittedDate&sortOrder=descending&max_results=50>` | papers | buffer | Atom API: the latest 50 (also works at weekends); the week script dedupes |
| `<https://huggingface.co/api/daily_papers?limit=50>` | papers | weekdays | HF Daily Papers (curated) — JSON, no RSS |
| `<https://huggingface.co/api/papers/search?q=token%20consumption>` | papers | weekdays | Topic: token consumption / efficiency (UI: `/papers?q=token%20consumption`) |
| `<https://huggingface.co/api/papers/search?q=agent%20harness>` | papers | weekdays | Topic: agent harness / scaffolding |
| `<https://huggingface.co/api/papers/search?q=context%20engineering>` | papers | weekdays | Topic: context engineering |
| `<https://huggingface.co/api/papers/search?q=agentic%20coding>` | papers | weekdays | Topic: agentic coding |

**Ritual:** weekdays `digest-fetch` (systemd) → Monday `make digest-week` (extra: `daily_papers?week=YYYY-Www`) → week letter in Agent Engineering `bron/weken/` → chosen hits → `bronnen.md` § (P5, no auto-dump).

YouTube and other news: by hand via AE `bron/inbox.md` or straight into §.
