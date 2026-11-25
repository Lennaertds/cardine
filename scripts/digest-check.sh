#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
die() { echo "digest-check: $*" >&2; exit 1; }

[[ -f bron/digest/README.md ]] || die "missing bron/digest/README.md"
[[ -f bron/digest/SOURCES.md || -f bron/digest/SOURCES.example.md ]] || die "no SOURCES(.example).md"
[[ -f bron/digest/TRIAGE.md ]] || die "ontbreekt bron/digest/TRIAGE.md"
[[ -f bron/digest/interests.md ]] || die "ontbreekt bron/digest/interests.md"
[[ -f scripts/digest-fetch.sh ]] || die "ontbreekt scripts/digest-fetch.sh"
[[ -f scripts/digest-day.sh ]] || die "ontbreekt scripts/digest-day.sh"
[[ -f scripts/digest-week.sh ]] || die "ontbreekt scripts/digest-week.sh"
[[ -f scripts/digest-rss.py ]] || die "ontbreekt scripts/digest-rss.py"
[[ -f scripts/digest-triage.py ]] || die "ontbreekt scripts/digest-triage.py"
[[ -d bron/weken ]] || die "ontbreekt bron/weken/"
"README must mention the no-auto-line rule"
grep -qi 'twijfel\|doubt' bron/digest/TRIAGE.md || die "TRIAGE.md must mention doubt→keep"
echo "ok    bron/digest/ (+ TRIAGE + interests)"
echo "ok    scripts/digest-*"
echo "digest-check: groen"
