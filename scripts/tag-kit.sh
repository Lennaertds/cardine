#!/usr/bin/env bash
# =============================================================================
# tag-kit.sh — Tag de huidige kit/ commit in Agent_Engineering
#
# Maakt een git-tag aan op de huidige HEAD die aangeeft welke versie van
# de kit klaar is voor pull door cardine-structure.
#
# Gebruik:
#   bash scripts/tag-kit.sh <tag>     # tag huidige HEAD als kit-<tag>
#
# Voorbeelden:
#   bash scripts/tag-kit.sh v0.1.0    # tag als kit-v0.1.0
#   bash scripts/tag-kit.sh v0.2.0    # tag als kit-v0.2.0
#
# Tags volgen het patroon kit-v<semver> zodat cardine-structure ze kan
# gebruiken als pinned target voor pull_kit.sh.
# =============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

red()   { printf '\033[31m%s\033[0m\n' "$*"; }
green() { printf '\033[32m%s\033[0m\n' "$*"; }
blue()  { printf '\033[34m%s\033[0m\n' "$*"; }

die() { red "❌ $*"; exit 1; }

# =============================================================================
# 1. Valideer argumenten
# =============================================================================
if [ $# -lt 1 ]; then
    echo "Gebruik: bash scripts/tag-kit.sh <tag>"
    echo ""
    echo "  <tag>    semver-tag (bv. v0.1.0, v0.2.0)"
    echo ""
    echo "Het script maakt een tag kit-<tag> op de huidige HEAD."
    exit 1
fi

TAG_VERSION="$1"
TAG_NAME="kit-${TAG_VERSION}"

# Valideer tag-formaat (eenvoudig: begint met v)
if [[ ! "$TAG_VERSION" =~ ^v[0-9]+\.[0-9]+\.[0-9]+ ]]; then
    die "Tag moet semver zijn (bv. v0.1.0, v0.2.0). Kreeg: $TAG_VERSION"
fi

cd "$REPO_DIR"

# =============================================================================
# 2. Check of de tag al bestaat
# =============================================================================
if git tag -l "$TAG_NAME" | grep -q "$TAG_NAME"; then
    CURRENT_COMMIT="$(git rev-parse HEAD)"
    TAG_COMMIT="$(git rev-parse "$TAG_NAME^{commit}")"
    if [ "$CURRENT_COMMIT" = "$TAG_COMMIT" ]; then
        green "✅ Tag $TAG_NAME bestaat al op huidige commit ($CURRENT_COMMIT) — niets te doen."
        exit 0
    else
        die "Tag $TAG_NAME bestaat al op een andere commit ($TAG_COMMIT). Verwijder hem eerst met: git tag -d $TAG_NAME"
    fi
fi

# =============================================================================
# 3. Check of de werkdirectory schoon is
# =============================================================================
if ! git diff --quiet HEAD; then
    die "Werkdirectory is niet schoon. Commit of stash eerst wijzigingen."
fi

# =============================================================================
# 4. Tag aanmaken
# =============================================================================
COMMIT_HASH="$(git rev-parse HEAD)"

git tag -a "$TAG_NAME" -m "kit release $TAG_VERSION: $COMMIT_HASH"

green "✅ Tag aangemaakt: $TAG_NAME → $COMMIT_HASH"
echo ""
blue "📋 Gebruik in cardine-structure:"
echo "   bash packages/structure/pull_kit.sh --tag $TAG_VERSION"
echo ""
blue "📋 Huidige tags:"
git tag -l "kit-*" | sort -V