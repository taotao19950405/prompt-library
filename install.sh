#!/usr/bin/env bash
# prompt-library/install.sh
# Link this prompt library into a project or globally for Claude Code.
#
# Usage:
#   ./install.sh              # link into current project (.claude/commands)
#   ./install.sh --global     # link ~/.claude/commands to this library
#   ./install.sh --remove     # remove link from current project
#   ./install.sh --remove --global  # remove global link

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
  PARENT="$HOME/.claude"
else
  TARGET="$(pwd)/.claude/commands"
  PARENT="$(pwd)/.claude"
fi

if $REMOVE; then
  if [[ -L "$TARGET" && "$(readlink "$TARGET")" == "$LIBRARY_DIR" ]]; then
    rm "$TARGET"
    echo "Removed link: $TARGET"
  else
    echo "No matching link found at $TARGET"
  fi
  exit 0
fi

if [[ -e "$TARGET" && ! -L "$TARGET" ]]; then
  echo "Error: $TARGET exists and is not a symlink. Remove it manually first."
  exit 1
fi

mkdir -p "$PARENT"
ln -sf "$LIBRARY_DIR" "$TARGET"
echo "Linked: $TARGET -> $LIBRARY_DIR"
echo ""
echo "Prompts available in Claude Code: /p1  /p2  /p3  /p4  /p5  /promptls"
