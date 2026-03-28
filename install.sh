#!/usr/bin/env bash
# prompt-library/install.sh
# Add this prompt library to a project or globally.
#
# Usage:
#   ./install.sh              # link into current project (.claude/commands/)
#   ./install.sh --global     # link into ~/.claude/commands/ (all projects)
#   ./install.sh --remove     # remove links from current project
#   ./install.sh --remove --global  # remove links from global

set -e

LIBRARY_DIR="$(cd "$(dirname "$0")" && pwd)"
MODE="project"
REMOVE=false

for arg in "$@"; do
  case "$arg" in
    --global) MODE="global" ;;
    --remove) REMOVE=true ;;
  esac
done

if [[ "$MODE" == "global" ]]; then
  TARGET="$HOME/.claude/commands"
else
  TARGET="$(pwd)/.claude/commands"
fi

if $REMOVE; then
  if [[ ! -d "$TARGET" ]]; then
    echo "Nothing to remove — $TARGET does not exist."
    exit 0
  fi
  for f in "$LIBRARY_DIR"/*.md; do
    name=$(basename "$f")
    link="$TARGET/$name"
    if [[ -L "$link" && "$(readlink "$link")" == "$f" ]]; then
      rm "$link"
      echo "removed $name"
    fi
  done
  # Clean up empty dir (project mode only)
  if [[ "$MODE" == "project" ]] && [[ -z "$(ls -A "$TARGET")" ]]; then
    rmdir "$TARGET"
    echo "removed $TARGET"
  fi
  echo "Done."
  exit 0
fi

mkdir -p "$TARGET"

for f in "$LIBRARY_DIR"/*.md; do
  name=$(basename "$f")
  link="$TARGET/$name"
  if [[ -e "$link" && ! -L "$link" ]]; then
    echo "skipping $name (non-symlink file already exists at $link)"
    continue
  fi
  ln -sf "$f" "$link"
  echo "linked $name"
done

echo ""
echo "Prompt library linked to: $TARGET"
if [[ "$MODE" == "project" ]]; then
  echo "Prompts are available as /p1, /p2, /p3, /p4, /p5 in this project."
else
  echo "Prompts are available as /p1, /p2, /p3, /p4, /p5 in all projects."
fi
echo ""
echo "Pipeline usage:"
echo "  claude -p '/p1 <your ticket here>'"
echo "  claude -p '/p4 <solution to analyze>'"
