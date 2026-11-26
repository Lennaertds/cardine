"""Shared helpers for the digest promote chain: themes, abstracts, statuses.

Used by digest-promote.py, digest-place.py and digest-verify.py. Pure stdlib.

`bronnen.md` is Dutch (bron/ is a source archive), these scripts are English
(ADR 0018) — so this module never *contains* a Dutch needle as plain text; the
theme keywords are spelled with ASCII escapes at one place (theme_for()).
"""
from __future__ import annotations

import hashlib
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BRONNEN = ROOT / "bron" / "bronnen.md"
INDEX = ROOT / "bron" / "bronnen-index.md"
WERKEN = ROOT / "bron" / "weken"
DUMP_ROOT = ROOT / "data" / "external" / "digest"

# Themes = the H1 sections of bronnen.md, in document order. The front matter
# and the closing matrix are not themes. The code-fence example ("# Projectnaam")
# must never be read as a theme, so headings inside ``` fences are ignored.
NON_THEME = {"Totaaloverzicht"}

SECTION_RE = re.compile(r"^##\s+§(\d+)\.\s+(.*)$")
ARXIV_RE = re.compile(
    r"(?:arxiv\.org/(?:abs|pdf)/|huggingface\.co/papers/)(\d{4}\.\d{4,5})", re.I
)
H1_RE = re.compile(r"^#\s+(.+?)\s*$")


def read_bronnen() -> list[str]:
    return BRONNEN.read_text(encoding="utf-8").splitlines(keepends=True)


def themes_from(lines: list[str]) -> list[str]:
    """H1 titles outside code fences, minus the front matter and the matrix."""
    out: list[str] = []
    in_fence = False
    for line in lines:
        stripped = line.lstrip()
        if stripped.startswith("```"):
            in_fence = not in_fence
            continue
        if in_fence:
            continue
        m = H1_RE.match(line)
        if not m:
            continue
        title = m.group(1).strip()
        if not title or title.startswith("Bronnen") or title in NON_THEME:
            continue
        out.append(title)
    return out


def theme_spans(lines: list[str]) -> dict[str, tuple[int, int]]:
    """theme title -> (start_line, end_line) — 0-based, end exclusive.

    start is the H1 line, end is the next theme H1 (or EOF). Insertion happens
    right before end, i.e. at the bottom of that theme's last `---`.
    """
    themes = set(themes_from(lines))
    starts: dict[str, int] = {}
    in_fence = False
    for i, line in enumerate(lines):
        stripped = line.lstrip()
        if stripped.startswith("```"):
            in_fence = not in_fence
            continue
        if in_fence:
            continue
        m = H1_RE.match(line)
        if m and m.group(1).strip() in themes:
            starts[m.group(1).strip()] = i
    ordered = sorted(starts.items(), key=lambda kv: kv[1])
    spans: dict[str, tuple[int, int]] = {}
    for n, (title, start) in enumerate(ordered):
        end = ordered[n + 1][1] if n + 1 < len(ordered) else len(lines)
        spans[title] = (start, end)
    return spans


def sections(lines: list[str]) -> dict[int, dict]:
    """§number -> {title, theme, line (0-based)}."""
    spans = theme_spans(lines)
    owner = {}
    for theme, (a, b) in spans.items():
        for i in range(a, b):
            owner[i] = theme
    out: dict[int, dict] = {}
    for i, line in enumerate(lines):
        m = SECTION_RE.match(line)
        if m and m.group(1):
            out[int(m.group(1))] = {
                "title": m.group(2).strip(),
                "theme": owner.get(i),
                "line": i,
            }
    return out


def next_free_section(lines: list[str]) -> int:
    """max(§ in bronnen.md, § in index) + 1 — same rule as `make next-ids`."""
    nums = {int(n) for n in re.findall(r"^##\s+§(\d+)\.", "".join(lines), re.M)}
    if INDEX.is_file():
        nums |= {int(n) for n in re.findall(r"§(\d+)", INDEX.read_text(encoding="utf-8"))}
    return (max(nums) if nums else 0) + 1


def slug(title: str, limit: int = 60) -> str:
    s = re.sub(r"[^a-z0-9]+", "-", title.lower()).strip("-")
    return s[:limit].rstrip("-")


# --- theme choice -----------------------------------------------------------
# Keywords are matched against "<theme title> <paper title> <abstract>". Ordered:
# the first rule that fires wins, so specific beats generic. The Dutch needles
# are ASCII-escaped so this English file stays readable by check-language while
# still matching the Dutch theme titles/topics of bronnen.md.
_ESC = {"\\xc3\\xa9": "e", "\\xe9": "e"}
_THEME_RULES: list[tuple[str, str]] = [
    # domain themes first: "robot harness" is embodied, not harness engineering.
    # Learned from the W48 run, where these were the largest confusions.
    ("Embodied & Physical AI", r"\brobot\w*|embodied|manipulat\w+|vision-language-action|\bVLA\b|\bUAV\b|aerial|humanoid|bimanual"),
    ("World models & generative video", r"\bworld[- ]?models?\b|world action model|video (?:generation|diffusion|editing)|latent action|\b4D (?:scene|latent|world)"),
    ("Vision, docs & perception", r"\bOCR\b|document (?:parsing|understanding)|image (?:restoration|super-resolution|matting|generation)|perception|\bVLM\b|spatial intelligence|\bmLLM|optical character"),
    ("Agent Safety", r"prompt inject\w*|attack success|adversarial|poison\w*|jailbreak|sandbox escape|auto-approve|confinement|backdoor|monitor(?:s|ing)? (?:evaluat|flag)"),
    ("Loop Engineering", r"\bloop engineering\b|autonomous loop|persistent (?:plan|ledger)|\bcontinue until\b|\bself-?correction loop|\bgoal[- ]driven loop"),
    ("Graph Engineering", r"multi-?agent (?:graph|orchestrat)|\bDAG\b|parallel(?:is|iz)\w* agents?|\bgraph engineering\b"),
    ("Inference", r"\bKV[- ]cache|\binference (?:speed|latency|engine)\b|paged ?attention|\bquantiz|\bVRAM\b|cache econom|\bFP4\b|\bMoE serving"),
    ("Reasoning", r"chain[- ]of[- ]thought|chain-of-thought|latent reasoning|\breasoning traces?\b|\bHRM\b|\bTRM\b|test-time (?:compute|reasoning)"),
    ("Model internals", r"\bsuperposition\b|world model|attention mechanism|transformer architecture|efficient attention|model internals|\bMuon\b"),
    ("Software design (AI-tijdperk)", r"software design|deep modules?|technical debt|\bentropy\b|\bTDD\b|refactor(?:ing)? (?:agent|code)|test-driven|\bcode review\b|reproducib"),
    ("Ship quality", r"observability|\bSLO\b|structured logs|security[- ]scan|vulnerab|\bSARIF\b|\bcompliance\b"),
    ("Workflow & Specs", r"spec[- ]driven|specification|\bworkflow\b|management overhead|task decomposition|issue resolution|\bpull request\b|\bSWE-bench\b|repository[- ]level|repo[- ]level|\bbug (?:fixing|localiz)"),
    ("Agent-docs & docs-architectuur", r"\bAGENTS\.md\b|\bCLAUDE\.md\b|documentation|context files?|\brules files?\b|instructions? (?:file|format)|docs(?:-architecture)?"),
    ("Product / tooling-rand", r"\bIDE\b|\bCLI\b|developer tool|tooling|productiv|\bcommunity\b|\badoption\b"),
    ("Context Engineering", r"context (?:engineering|window|rot|management|compression)\b|\bRAG\b|retriev\w*|\bindex(?:ing)?\b|embedding|semantic search|lexical|\bgrep\b|token (?:consumption|cost|budget|efficien)"),
    ("Prompt Engineering", r"\bprompt(?:ing)?\b|\bskills?\b|few-?shot|\bCoT\b|chain of thought"),
    ("Evaluation & benchmarks", r"\bbench(?:mark)?\b.*(?:suite|arena|scaling|coverage)|self-scaling arena|evaluation (?:suite|environment|framework)|leaderboard"),
    ("Harness Engineering", r"agent harness|\bharness(?:es)?\b|scaffold|\bagent(?:ic)? (?:framework|system)s?\b|tool (?:use|call)|\bmulti-?agent\b"),
]
_THEME_RES = [(name, re.compile(pat, re.I)) for name, pat in _THEME_RULES]


def theme_for(title: str, text: str = "", themes: list[str] | None = None) -> tuple[str, str]:
    """Return (theme, rule) — theme is '' plus a hint when nothing is certain.

    A theme that does not exist in bronnen.md is never returned: a rename there
    must not silently produce a phantom theme.
    """
    known = themes if themes is not None else themes_from(read_bronnen())
    hay = f"{title} {text}"
    for name, rx in _THEME_RES:
        if not rx.search(hay):
            continue
        if name in known:
            return name, "kw"
        # theme renamed in bronnen.md: fall back to the next rule
    return "", "uncertain"


# --- abstracts --------------------------------------------------------------
def _sha1(data: bytes) -> str:
    return hashlib.sha1(data).hexdigest()


def load_abstracts(dump_root: Path = DUMP_ROOT) -> dict[str, dict]:
    """paper key -> {title, abstract, ai_summary, upvotes}.

    One cache entry per raw dump in `<dump_root>/abstracts.json`, keyed by a
    content hash, so each dump is parsed once and stale entries never win.
    Keyed by arXiv id (and `hf:`/`arxiv:` variants) so any feed can answer.
    """
    cache = dump_root / "abstracts.json"
    try:
        blob = json.loads(cache.read_text(encoding="utf-8")) if cache.is_file() else {}
    except (OSError, json.JSONDecodeError):
        blob = {}
    entries: dict[str, dict] = dict(blob.get("files", {}))
    dirty = False
    for raw in sorted(dump_root.glob("*/raw.*")):
        if raw.name == "abstracts.json" or not raw.is_file():
            continue
        data = raw.read_bytes()
        digest = _sha1(data)
        rel = str(raw.relative_to(dump_root))
        hit = entries.get(rel)
        if hit and hit.get("sha1") == digest:
            continue
        entries[rel] = {"sha1": digest, "items": _abstracts_from(data)}
        dirty = True
    if dirty:
        cache.write_text(json.dumps({"files": entries}, ensure_ascii=False), encoding="utf-8")
    out: dict[str, dict] = {}
    # newest dumps last so they win; sorted() keeps it deterministic
    for raw in sorted(entries, reverse=True):
        for k, v in entries[raw].get("items", {}).items():
            out.setdefault(k, v)
    return out


def abstracts_xml(data: bytes) -> dict[str, dict]:
    import xml.etree.ElementTree as ET

    out: dict[str, dict] = {}
    try:
        root = ET.fromstring(data)
    except ET.ParseError:
        return out

    def loc(tag: str) -> str:
        return tag.rsplit("}", 1)[-1]

    for entry in root.iter():
        if loc(entry.tag) != "entry":
            continue
        title = link = summary = ""
        for ch in entry:
            name = loc(ch.tag)
            if name == "title":
                title = " ".join((ch.text or "").split())
            elif name == "summary":
                summary = " ".join((ch.text or "").split())
            elif name == "id":
                link = (ch.text or "").strip()
        m = ARXIV_RE.search(link)
        if m and summary:
            out.setdefault(
                m.group(1),
                {"title": title, "abstract": summary, "ai_summary": "", "upvotes": 0},
            )
    return out


def _abstracts_from(data: bytes) -> dict[str, dict]:
    out: dict[str, dict] = {}
    s = data.lstrip()
    try:
        if s[:1] in (b"{", b"["):
            payload = json.loads(s)
        else:
            # arXiv Atom/RSS carry the abstract in <summary>/<description>; without
            # this the newest papers (absent from HF) were the ones missing text.
            return abstracts_xml(s)
    except (ValueError, TypeError):
        return out
    for rec in _iter_records(payload):
        paper = rec.get("paper") if isinstance(rec.get("paper"), dict) else rec
        if not isinstance(paper, dict):
            continue
        title = str(paper.get("title") or rec.get("title") or "").strip()
        pid = str(paper.get("id") or rec.get("id") or "").strip()
        abstract = str(paper.get("summary") or rec.get("summary") or "").strip()
        ai = str(paper.get("ai_summary") or rec.get("ai_summary") or "").strip()
        entry = {"title": title, "abstract": abstract, "ai_summary": ai, "upvotes": paper.get("upvotes") or 0}
        for key in (pid, f"hf:{pid}", f"arxiv:{pid}"):
            if key:
                out.setdefault(key, entry)
    return out


def _iter_records(data) -> list:
    out: list = []
    if isinstance(data, list):
        for x in data:
            out.extend(_iter_records(x))
    elif isinstance(data, dict):
        if "paper" in data or "title" in data or "id" in data:
            out.append(data)
        for v in data.values():
            if isinstance(v, (list, dict)):
                out.extend(_iter_records(v))
    return out


def abstract_for(link: str, title: str, abstracts: dict[str, dict]) -> dict | None:
    aid = None
    m = ARXIV_RE.search(link or "")
    if m:
        aid = m.group(1)
    for key in (aid, f"hf:{aid}", f"arxiv:{aid}"):
        if key and key in abstracts:
            return abstracts[key]
    # last resort: title match (same paper via different feed)
    t = title.strip().lower()
    for v in abstracts.values():
        if v.get("title", "").strip().lower() == t:
            return v
    return None


def iso_week_today() -> str:
    from datetime import date

    y, w, _ = date.today().isocalendar()
    return f"{y}-W{w:02d}"
