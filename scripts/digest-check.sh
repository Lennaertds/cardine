#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
die() { echo "digest-check: $*" >&2; exit 1; }

[[ -f bron/digest/README.md ]] || die "ontbreekt bron/digest/README.md"
[[ -f bron/digest/SOURCES.md || -f bron/digest/SOURCES.example.md ]] || die "geen SOURCES(.example).md"
[[ -f bron/digest/TRIAGE.md ]] || die "ontbreekt bron/digest/TRIAGE.md"
[[ -f bron/digest/interests.md ]] || die "ontbreekt bron/digest/interests.md"
[[ -f scripts/digest-fetch.sh ]] || die "ontbreekt scripts/digest-fetch.sh"
[[ -f scripts/digest-day.sh ]] || die "ontbreekt scripts/digest-day.sh"
[[ -f scripts/digest-week.sh ]] || die "ontbreekt scripts/digest-week.sh"
[[ -f scripts/digest-rss.py ]] || die "ontbreekt scripts/digest-rss.py"
[[ -f scripts/digest-triage.py ]] || die "ontbreekt scripts/digest-triage.py"
[[ -d bron/weken ]] || die "ontbreekt bron/weken/"
grep -qF 'P5' bron/digest/README.md || grep -qi 'geen auto' bron/digest/README.md || die "README moet geen-auto-§ noemen"
grep -qi 'twijfel' bron/digest/TRIAGE.md || die "TRIAGE.md moet twijfel→keep noemen"
echo "ok    bron/digest/ (+ TRIAGE + interests)"
echo "ok    scripts/digest-*"
echo "digest-check: groen"
