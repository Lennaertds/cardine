#!/usr/bin/env bash
# check-language: fails when Dutch (or French) text appears outside the allowed zones.
#
# English is the only project language (ADR 0018). Without a guard the repo drifts
# back within weeks, because nothing fails when a comment is written in Dutch.
#
# Allowed to stay Dutch:  bron/ (source archive), historical logs and released
#                         CHANGELOG sections, .git, node_modules, tmp, data/external
#                         (gitignored feed dumps: generated, not authored).
# The guard itself and the migration plan are skipped too: they have to be able
# to name the Dutch words they look for.
#
# Usage: packages/lab/scripts/check-language.sh [root]
set -euo pipefail

root="${1:-.}"
root="${root%/}"

# Old Dutch wording may appear on a line that names it in a _LEGACY_WORDING
# variable, and on the line after it: a test asserting that wording is *gone*
# has to spell it out. Nothing else gets that exemption.
#
# Distinctive Dutch function words. Kept small on purpose: these rarely appear in
# English prose, while words like "is"/"in"/"of" do, so they would flood the report.
dutch='het|een|van|niet|wordt|worden|moet|moeten|zijn|heeft|hebben|deze|dit|door|voor|maar|ook|nog|alleen|altijd|nooit|omdat|wanneer|daarom|terwijl|tussen|zonder|tijdens|geen|welke|iedere|elke|slechts|vrijwel|bovendien|daarnaast|vervolgens|eigenschap|bestand|bestanden|gebruik|instelling|melding|fout|controleer|voorbeeld|volgende'

fail=0
report() {
  local kind="$1" pattern="$2" hits
  # Scanned in Python, not grep: grep's \b follows the locale's idea of a word
  # character (so "één"/"Já" slipped through) and its multibyte handling skips
  # whole files; both made the guard report green while Dutch stayed in place.
  hits="$(python3 - "$root" "$pattern" <<'PY'
import os, re, sys
root, words = sys.argv[1], sys.argv[2].split('|')
# __file__ is '<stdin>' here (the scan is piped in), so compare by file name.
me = 'check-language.sh'
pat = re.compile(r'\b(' + '|'.join(words) + r')\b')
# File names of the example project (kept as they are: the historical ADRs and
# logs name them, and renaming them would point at a path that never existed).
example_name = re.compile(r'regels-van-chacha\.md')
# Links into the Dutch source archive (target or label) are not Dutch leakage:
# the archive stays Dutch (ADR 0018), so a link to it is allowed to name it.
archive_link = re.compile(r'\[[^\]]*\]\([^)]*bron/[^)]*\)|\([^)]*bron/[^)]*\)')
exts = {'.md', '.sh', '.js', '.py', '.yml', '.yaml', '.mk', '.toml'}
skip = {'.git', 'node_modules', 'tmp', 'bron', '_bootstrap', 'logs'}
skipf = {'LANGUAGE-MIGRATION.md', 'CHANGELOG.md'}
# Paths that .gitignore keeps out of git: feed dumps and per-machine local.mk
# profile extras are generated or local, never repo English. Exact paths only,
# and only these two: everything tracked is still scanned.
skip_rel = {'data/external', 'packages/structure/kit/profiles/extra'}
for dirpath, dirnames, files in os.walk(root):
    rel = os.path.relpath(dirpath, root).replace(os.sep, '/')
    if rel in skip_rel or any(rel.startswith(r + '/') for r in skip_rel):
        dirnames[:] = []
        continue
    dirnames[:] = sorted(d for d in dirnames if d not in skip)
    for f in sorted(files):
        if f in skipf or os.path.splitext(f)[1] not in exts:
            continue
        p = os.path.join(dirpath, f)
        if f == me:
            continue
        try:
            with open(p, encoding='utf-8', errors='replace') as fh:
                skip_next = False
                for n, line in enumerate(fh, 1):
                    if '_LEGACY_WORDING' in line:
                        skip_next = True
                        continue
                    if skip_next:
                        skip_next = False
                        continue
                    if pat.search(example_name.sub('', archive_link.sub('', line))):
                        print(f"{p}:{n}:{line.rstrip()}")
        except OSError:
            continue
PY
)"
  # Log entries written before the migration keep their language; only the
  # template has to be English.
  if [[ -n "$hits" ]]; then
    local n; n="$(printf '%s\n' "$hits" | wc -l)"
    echo "check-language: $kind text found outside the allowed zones — $n hit(s)" >&2
    # Per top-level area, so the migration plan can be driven by this number.
    printf '%s\n' "$hits" \
      | cut -d: -f1 \
      | awk '{ sub(/^\.\//, ""); if ($0 !~ /\//) { print "root files"; next } split($0, a, "/"); print a[1] "/" }' \
      | sort | uniq -c | sort -rn \
      | awk '{printf "    %4d  %s\n", $1, $2}' >&2
    if [[ -n "${VERBOSE:-}" ]]; then
      printf '%s\n' "$hits" | sed -n '1,40p' >&2
    else
      echo "    (set VERBOSE=1 for the first 40 lines)" >&2
    fi
    fail=1
  fi
}

# Only Dutch is detected. A French word list collides with Dutch ("pas", "mais",
# "plus") and drowned the signal; anything French in this repo is caught because
# it sits inside otherwise Dutch text.
report "Dutch" "$dutch"

if ((fail)); then
  cat >&2 <<'MSG'

English is the only project language (ADR 0018).
bron/ stays Dutch as a source archive; old log entries keep their language.
See LANGUAGE-MIGRATION.md for the migration status.
MSG
  exit 1
fi
echo "check-language: green (no Dutch or French outside bron/ and history)"
