#!/usr/bin/env bash
# setup-symlinks.sh — fallback install: symlink this repo's skills into ~/.claude/skills/
# Keeps the flat invocation names (/work-with-chaos, /benchmark, /decide, /input-gate, /report)
# instead of the plugin-namespaced forms. Idempotent — safe to re-run after pulling.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TARGET_DIR="$HOME/.claude/skills"
SKILLS=(work-with-chaos benchmark decide input-gate report)

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

echo "Done. Restart Claude Code (or run /reload-plugins) to pick them up."
