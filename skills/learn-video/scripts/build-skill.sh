#!/usr/bin/env bash
# build-skill.sh — package the self-contained learn-video skill as a .skill file.
# Usage: bash skills/learn-video/scripts/build-skill.sh   (run from anywhere)
#
# Produces dist/learn-video.skill, a zip with a single top-level `learn-video/` directory
# containing SKILL.md and the scripts/ runtime from skills/learn-video. Archiving the
# skills/learn-video subtree directly keeps the bundle to exactly one SKILL.md and
# well under claude.ai's 200-file cap, with no post-hoc `zip -d` stripping.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
cd "$REPO_ROOT"

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "error: working tree is dirty; commit or stash before building" >&2
  exit 1
fi

mkdir -p dist
OUT="dist/learn-video.skill"
git archive --format=zip --prefix=learn-video/ --output="$OUT" HEAD:skills/learn-video

COUNT=$(unzip -l "$OUT" | tail -1 | awk '{print $2}')
SIZE=$(du -h "$OUT" | cut -f1)

if [ "$COUNT" -gt 200 ]; then
  echo "error: $COUNT files in zip, claude.ai's cap is 200" >&2
  echo "       trim the skills/learn-video/ tree or add a .gitattributes export-ignore entry" >&2
  exit 1
fi

SKILL_MD_COUNT=$(unzip -l "$OUT" | grep -c "SKILL.md" || true)
if [ "$SKILL_MD_COUNT" -ne 1 ]; then
  echo "error: expected exactly one SKILL.md, found $SKILL_MD_COUNT" >&2
  exit 1
fi

echo "built $OUT ($COUNT files, $SIZE)"
echo "install using a host that supports local Agent Skills runtimes"
