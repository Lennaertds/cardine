#!/usr/bin/env bash
# =============================================================================
# tag-kit.sh — Tag the current kit/ in this repo
#
# Creates a git tag on the current HEAD that says which version of
# the kit is ready to be pulled by cardine-structure.
#
# Usage:
#   bash scripts/tag-kit.sh <tag>     # tag the current HEAD as kit-<tag>
#
# Examples:
#   bash scripts/tag-kit.sh v0.1.0    # tags as kit-v0.1.0
#   bash scripts/tag-kit.sh v0.2.0    # tags as kit-v0.2.0
#
# Tags follow the pattern kit-v<semver> so cardine-structure can use them
# as a pinned target for its kit pull.
# =============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

red()   { printf '\033[31m%s\033[0m\n' "$*"; }
green() { printf '\033[32m%s\033[0m\n' "$*"; }
blue()  { printf '\033[34m%s\033[0m\n' "$*"; }

die() { red "❌ $*"; exit 1; }

# =============================================================================
# 1. Validate the arguments
# =============================================================================
if [ $# -lt 1 ]; then
    echo "Usage: bash scripts/tag-kit.sh <tag>"
    echo ""
    echo "  <tag>    semver tag (e.g. v0.1.0, v0.2.0)"
    echo ""
    echo "The script creates a tag kit-<tag> on the current HEAD."
    exit 1
fi

TAG_VERSION="$1"
TAG_NAME="kit-${TAG_VERSION}"

# Valideer tag-formaat (eenvoudig: begint met v)
if [[ ! "$TAG_VERSION" =~ ^v[0-9]+\.[0-9]+\.[0-9]+ ]]; then
    die "The tag must be semver (e.g. v0.1.0, v0.2.0). Got: $TAG_VERSION"
fi

cd "$REPO_DIR"

# =============================================================================
# 2. Check whether the tag already exists
# =============================================================================
if git tag -l "$TAG_NAME" | grep -q "$TAG_NAME"; then
    CURRENT_COMMIT="$(git rev-parse HEAD)"
    TAG_COMMIT="$(git rev-parse "$TAG_NAME^{commit}")"
    if [ "$CURRENT_COMMIT" = "$TAG_COMMIT" ]; then
        green "✅ Tag $TAG_NAME already exists on the current commit ($CURRENT_COMMIT) — nothing to do."
        exit 0
    else
        die "Tag $TAG_NAME already exists on another commit ($TAG_COMMIT). Remove it first with: git tag -d $TAG_NAME"
    fi
fi

# =============================================================================
# 3. Check that the working directory is clean
# =============================================================================
if ! git diff --quiet HEAD; then
    die "The working directory is not clean. Commit or stash your changes first."
fi

# =============================================================================
# 4. Create the tag
# =============================================================================
COMMIT_HASH="$(git rev-parse HEAD)"

git tag -a "$TAG_NAME" -m "kit release $TAG_VERSION: $COMMIT_HASH"

green "✅ Tag created: $TAG_NAME → $COMMIT_HASH"
echo ""
blue "📋 Gebruik in cardine-structure:"
echo "   bash packages/structure/pull_kit.sh --tag $TAG_VERSION"
echo ""
blue "📋 Huidige tags:"
git tag -l "kit-*" | sort -V