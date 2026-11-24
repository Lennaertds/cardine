#!/usr/bin/env python3
"""Parse RSS/Atom XML of HF/JSON API → items.md (title + link). Stdlib only."""
from __future__ import annotations

import argparse
import html
import json
import os
import re
import sys
import xml.etree.ElementTree as ET
from datetime import datetime, timedelta, timezone
from pathlib import Path
from typing import Any
from urllib.parse import urlparse


def _local(tag: str) -> str:
    return tag.rsplit("}", 1)[-1] if "}" in tag else tag


def _text(el: ET.Element | None) -> str:
    if el is None or el.text is None:
        return ""
    return html.unescape(" ".join(el.text.split()))


def _link_from(el: ET.Element) -> str:
    for child in el:
        if _local(child.tag) == "link":
            href = child.attrib.get("href") or child.attrib.get("url")
            if href:
                return href.strip()
            if child.text and child.text.strip().startswith("http"):
                return child.text.strip()
    return ""


def parse_items_xml(xml_bytes: bytes) -> list[tuple[str, str]]:
    root = ET.fromstring(xml_bytes)
    items: list[tuple[str, str]] = []
    # RSS 2.0
    for channel in root.iter():
        if _local(channel.tag) != "channel":
            continue
        for item in channel:
            if _local(item.tag) != "item":
                continue
            title = ""
            link = ""
            for child in item:
                name = _local(child.tag)
                if name == "title":
                    title = _text(child)
                elif name == "link":
                    link = (child.text or "").strip() or child.attrib.get("href", "")
            if title or link:
                items.append((title or "(geen titel)", link))
        break
    if items:
        return items
    # Atom
    for entry in root.iter():
        if _local(entry.tag) != "entry":
            continue
        title = ""
        link = _link_from(entry)
        for child in entry:
            if _local(child.tag) == "title":
                title = _text(child)
        if title or link:
            items.append((title or "(geen titel)", link))
    return items


def _parse_iso(ts: str | None) -> datetime | None:
    if not ts or not isinstance(ts, str):
        return None
    try:
        return datetime.fromisoformat(ts.replace("Z", "+00:00"))
    except ValueError:
        return None


def _hf_paper_link(pid: str) -> str:
    pid = pid.strip()
    if re.fullmatch(r"\d{4}\.\d{4,5}(v\d+)?", pid):
        return f"https://arxiv.org/abs/{pid}"
    return f"https://huggingface.co/papers/{pid}"


def _iter_json_records(data: Any) -> list[dict[str, Any]]:
    if isinstance(data, list):
        return [x for x in data if isinstance(x, dict)]
    if isinstance(data, dict):
        for key in ("results", "papers", "data", "items"):
            val = data.get(key)
            if isinstance(val, list):
                return [x for x in val if isinstance(x, dict)]
        return [data]
    return []


def parse_items_json(
    raw: bytes,
    *,
    since: datetime | None = None,
) -> list[tuple[str, str]]:
    data = json.loads(raw)
    items: list[tuple[str, str]] = []
    seen: set[str] = set()
    for rec in _iter_json_records(data):
        paper = rec.get("paper") if isinstance(rec.get("paper"), dict) else rec
        if not isinstance(paper, dict):
            continue
        title = (paper.get("title") or rec.get("title") or "").strip()
        pid = str(paper.get("id") or rec.get("id") or "").strip()
        link = ""
        if pid:
            link = _hf_paper_link(pid)
        elif isinstance(paper.get("url"), str):
            link = paper["url"].strip()
        if since is not None:
            ts = (
                _parse_iso(paper.get("publishedAt"))
                or _parse_iso(rec.get("publishedAt"))
                or _parse_iso(paper.get("submittedOnDailyAt"))
                or _parse_iso(rec.get("submittedOnDailyAt"))
            )
            # Zoek-API's mixen oud; zonder datum laten we door (daily_papers heeft meestal wel ts).
            if ts is not None and ts < since:
                continue
        if not title and not link:
            continue
        key = (link or title).lower()
        if key in seen:
            continue
        seen.add(key)
        items.append((title or "(geen titel)", link))
    return items


def looks_like_json(raw: bytes) -> bool:
    s = raw.lstrip()
    return bool(s) and s[0:1] in (b"{", b"[")


def write_items_md(items: list[tuple[str, str]], out: Path, source: str, limit: int) -> int:
    lines = [
        f"# Items — {source}",
        "",
        "> Gegenereerd door digest-fetch. Geen SSOT — cureren via digest-propose → radar (P5).",
        "",
        "| Titel | Link |",
        "|-------|------|",
    ]
    n = 0
    for title, link in items[:limit]:
        t = title.replace("|", "\\|")
        lines.append(f"| {t} | {link or '—'} |")
        n += 1
    out.write_text("\n".join(lines) + "\n", encoding="utf-8")
    return n


def _since_from_env() -> datetime | None:
    raw = os.environ.get("DIGEST_JSON_SINCE", "").strip()
    if raw:
        try:
            d = datetime.fromisoformat(raw)
            if d.tzinfo is None:
                d = d.replace(tzinfo=timezone.utc)
            return d
        except ValueError:
            print(f"digest-rss: ongeldige DIGEST_JSON_SINCE={raw!r}", file=sys.stderr)
            return None
    # Default: laatste 14 dagen voor HF/JSON (houdt topic-search fris).
    days = os.environ.get("DIGEST_JSON_DAYS", "14").strip()
    try:
        n = int(days)
    except ValueError:
        n = 14
    if n <= 0:
        return None
    return datetime.now(timezone.utc) - timedelta(days=n)


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("-i", "--input", required=True, help="pad naar feed XML of JSON")
    ap.add_argument("-o", "--output", required=True, help="pad naar items.md")
    ap.add_argument("-s", "--source", default="", help="bron-URL of slug")
    ap.add_argument("-n", "--limit", type=int, default=30)
    args = ap.parse_args()
    path = Path(args.input)
    if not path.is_file():
        print(f"digest-rss: bestand ontbreekt: {path}", file=sys.stderr)
        return 1
    raw = path.read_bytes()
    source = args.source or str(path)
    host = urlparse(source).netloc.lower() if source.startswith("http") else ""
    try:
        if looks_like_json(raw):
            since = _since_from_env() if "huggingface.co" in host or path.suffix == ".json" else None
            items = parse_items_json(raw, since=since)
            kind = "json"
        else:
            m = re.search(rb"<[\s\S]+", raw)
            if not m:
                print("digest-rss: geen XML/JSON gevonden", file=sys.stderr)
                return 1
            items = parse_items_xml(m.group(0))
            kind = "xml"
    except (ET.ParseError, json.JSONDecodeError, TypeError, ValueError) as e:
        print(f"digest-rss: parse-fout: {e}", file=sys.stderr)
        return 1
    n = write_items_md(items, Path(args.output), source, args.limit)
    print(f"digest-rss: {n} items ({kind}) → {args.output}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
