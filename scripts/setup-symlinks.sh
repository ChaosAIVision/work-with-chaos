#!/usr/bin/env bash
# setup-symlinks.sh — fallback install: symlink this repo's skills into ~/.claude/skills/
# Keeps the flat invocation names (/work-with-chaos, /diagnose-linux-disk)
# instead of the plugin-namespaced forms. Idempotent — safe to re-run after pulling.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TARGET_DIR="${CHAOS_SKILLS_TARGET_DIR:-$HOME/.claude/skills}"
SKILLS=(work-with-chaos diagnose-linux-disk)

mkdir -p "$TARGET_DIR"

for skill in "${SKILLS[@]}"; do
  src="$REPO_ROOT/skills/$skill"
  dst="$TARGET_DIR/$skill"

  if [ ! -f "$src/SKILL.md" ]; then
    echo "✗ $skill: no SKILL.md at $src — skipped" >&2
    continue
  fi

  if [ -L "$dst" ]; then
    if [ "$(readlink "$dst")" = "$src" ]; then
      echo "· $skill: already linked"
      continue
    fi
    echo "! $skill: symlink exists but points elsewhere — replacing" >&2
    rm "$dst"
  elif [ -e "$dst" ]; then
    echo "✗ $skill: $dst exists and is not a symlink — NOT touching it. Remove it manually if you want the link." >&2
    continue
  fi

  ln -s "$src" "$dst"
  echo "✓ $skill: linked → $src"
done

# Retire only helper links managed by this checkout after their files moved.
# Real directories and links to other checkouts remain untouched.
for helper in benchmark decide input-gate report; do
  old_src="$REPO_ROOT/skills/$helper"
  old_dst="$TARGET_DIR/$helper"
  if [ -L "$old_dst" ] && [ "$(readlink "$old_dst")" = "$old_src" ] && [ ! -e "$old_src/SKILL.md" ]; then
    rm -- "$old_dst"
    echo "Removed obsolete helper link: $helper"
  fi
done

echo "Done."
