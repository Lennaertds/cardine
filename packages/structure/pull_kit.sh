#!/usr/bin/env bash
# =============================================================================
# pull_kit.sh — Pull Agent_Engineering/kit/ naar packages/structure/kit/
#
# Kopieert een pinned commit of tag uit Agent_Engineering/kit/ naar
# packages/structure/kit/. Is idempotent: als de gepinde commit al
# in kit/COMMIT staat, gebeurt er niets.
#
# Tags volgen het patroon kit-v<semver> in Agent_Engineering.
# Zie Agent_Engineering/standaard/versioning.md.
#
# Gebruik:
#   bash packages/structure/pull_kit.sh                  # pullt HEAD
#   bash packages/structure/pull_kit.sh <commit>         # pullt specifieke commit
#   bash packages/structure/pull_kit.sh --tag v0.1.0     # pullt kit-v0.1.0 tag
# =============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KIT_DIR="$SCRIPT_DIR/kit"
COMMIT_FILE="$KIT_DIR/COMMIT"

# Relatief naar Agent_Engineering — vanuit packages/structure/ is dat ../../../
# cardine/packages/structure/ → cardine/ → Cardine/ → Cardine/Agent_Engineering
AGENT_ENGINEERING_DIR="$(cd "$SCRIPT_DIR/../../../Agent_Engineering" && pwd)"

# =============================================================================
# Helper
# =============================================================================
red()   { printf '\033[31m%s\033[0m\n' "$*"; }
green() { printf '\033[32m%s\033[0m\n' "$*"; }
blue()  { printf '\033[34m%s\033[0m\n' "$*"; }

die() { red "❌ $*"; exit 1; }

# =============================================================================
# 1. Valideer dat Agent_Engineering bestaat en een git repo is
# =============================================================================
if [ ! -d "$AGENT_ENGINEERING_DIR" ]; then
    die "Agent_Engineering niet gevonden op: $AGENT_ENGINEERING_DIR"
fi

if [ ! -d "$AGENT_ENGINEERING_DIR/.git" ]; then
    die "Agent_Engineering is geen git-repository: $AGENT_ENGINEERING_DIR"
fi

# =============================================================================
# 2. Parse argumenten — ondersteun zowel <commit> als --tag <versie>
# =============================================================================
PINNED_COMMIT=""
KIT_TAG=""

if [ $# -ge 2 ] && [ "$1" = "--tag" ]; then
    # --tag v0.1.0  →  kit-v0.1.0 in Agent_Engineering
    KIT_TAG="kit-$2"
    blue "🔖 Kit-tag: $KIT_TAG"

    # Resolve tag naar commit
    if ! PINNED_COMMIT="$(git -C "$AGENT_ENGINEERING_DIR" rev-parse "$KIT_TAG^{commit}" 2>/dev/null)"; then
        die "Tag $KIT_TAG bestaat niet in Agent_Engineering. Beschikbare kit-tags:"
        git -C "$AGENT_ENGINEERING_DIR" tag -l "kit-*" | sort -V >&2
        exit 1
    fi
elif [ $# -ge 1 ]; then
    # <commit> — directe commit hash
    PINNED_COMMIT="$1"
else
    # Geen argument — HEAD van Agent_Engineering
    PINNED_COMMIT="$(git -C "$AGENT_ENGINEERING_DIR" rev-parse HEAD)"
    blue "ℹ️  Geen commit of tag opgegeven — gebruik HEAD van Agent_Engineering"
fi

blue "🔗 Pinned commit: $PINNED_COMMIT"

# Valideer dat de commit bestaat
if ! git -C "$AGENT_ENGINEERING_DIR" cat-file -e "$PINNED_COMMIT^{commit}" 2>/dev/null; then
    die "Commit bestaat niet in Agent_Engineering: $PINNED_COMMIT"
fi

# =============================================================================
# 3. Idempotentie-check
# =============================================================================
if [ -f "$COMMIT_FILE" ]; then
    # COMMIT bevat "kit-v0.1.0 = hash" of alleen "hash" — extraheer de hash
    CURRENT_COMMIT="$(tail -1 "$COMMIT_FILE" | grep -oE '[0-9a-f]{40}')"
    if [ "$CURRENT_COMMIT" = "$PINNED_COMMIT" ]; then
        LABEL="${KIT_TAG:-$(head -1 "$COMMIT_FILE" | grep -oE 'kit-v[0-9]+\.[0-9]+\.[0-9]+' || echo "$PINNED_COMMIT")}"
        green "✅ kit is al op $LABEL ($PINNED_COMMIT) — niets te doen."
        exit 0
    fi
    blue "🔄 Nieuwe commit ($PINNED_COMMIT) verschilt van huidige ($CURRENT_COMMIT) — updaten..."
fi

# =============================================================================
# 4. Kit uit Agent_Engineering kopiëren
# =============================================================================
KIT_SOURCE="$AGENT_ENGINEERING_DIR/kit"

if [ ! -d "$KIT_SOURCE" ]; then
    die "kit/ bestaat niet in Agent_Engineering: $KIT_SOURCE"
fi

blue "📦 Kit-bron: $KIT_SOURCE"
blue "📦 Kit-doel:  $KIT_DIR"

# Zet de repo in de juiste staat voor deze commit
git -C "$AGENT_ENGINEERING_DIR" checkout --detach "$PINNED_COMMIT" 2>/dev/null || true

# Maak doel leeg
rm -rf "$KIT_DIR"
mkdir -p "$KIT_DIR"

# Kopieer de inhoud van Agent_Engineering/kit/ naar packages/structure/kit/
if command -v rsync &>/dev/null; then
    rsync -a --delete "$KIT_SOURCE/" "$KIT_DIR/"
else
    cp -a "$KIT_SOURCE"/. "$KIT_DIR/"
fi

# =============================================================================
# 5. Commit hash + tag opslaan in COMMIT
# =============================================================================
if [ -n "$KIT_TAG" ]; then
    echo "$KIT_TAG = $PINNED_COMMIT" > "$COMMIT_FILE"
else
    echo "$PINNED_COMMIT" > "$COMMIT_FILE"
fi

# Zet Agent_Engineering terug naar de oorspronkelijke branch (indien van toepassing)
git -C "$AGENT_ENGINEERING_DIR" checkout - 2>/dev/null || true

green "✅ Pull voltooid — commit $PINNED_COMMIT"
if [ -n "$KIT_TAG" ]; then
    green "   Tag: $KIT_TAG"
fi
echo ""
blue "📋 Inhoud kit/:"
ls -la "$KIT_DIR"
echo ""
blue "📋 Verwachte verplichte onderdelen:"
for item in kern solo logging new-project.sh; do
    if [ -e "$KIT_DIR/$item" ]; then
        green "   ✅ $item"
    else
        red "   ❌ $item ontbreekt!"
    fi
done