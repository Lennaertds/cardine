#!/usr/bin/env bash
# Add an entry to bron/sessies/INDEX.md and create the session file
# Usage: sessie-log.sh <datum> <tijd> <msg> <slug>
set -euo pipefail

datum="$1"
tijd="$2"
msg="$3"
slug="$4"
index="bron/sessies/INDEX.md"
sessiebestand="bron/sessies/${datum}-${slug}.md"

# Maak sessiebestand aan
cat > "$sessiebestand" <<EOF
# Sessie: ${msg}

**Datum:** ${datum} ${tijd}

(fill in: what was done, open points, next step)

---

EOF

echo "Sessiebestand: ${sessiebestand}"

# Add the entry to INDEX.md (python3 for reliability with pipes)
python3 <<PYEOF
import sys
path = "${index}"
newrow = "| ${datum} | ${msg} | [${slug}.md](${datum}-${slug}.md) |"
placeholder = "| — | — | — |"

with open(path) as f:
    content = f.read()

if placeholder in content:
    content = content.replace(placeholder, newrow, 1)
    with open(path, 'w') as f:
        f.write(content)
    print("INDEX.md: entry toegevoegd (placeholder vervangen)")
else:
    with open(path, 'a') as f:
        f.write("\n" + newrow)
    print("INDEX.md: entry toegevoegd (onderaan)")
PYEOF