#!/usr/bin/env bash
# One-shot installer / updater for the AI Commerce Agent Toolkit Hermes plugin.
#
# Clones (or pulls) ai-commerce-agent-toolkit into ~/.hermes/repos/ai-commerce-agent-toolkit
# and symlinks .hermes-plugin/ into ~/.hermes/plugins/ai-commerce-agent-toolkit/, so
# the manifest sits next to the shared skills/ folder.
#
# Re-running this command updates to the latest published version. Idempotent.
set -euo pipefail

REPO_URL="https://github.com/Desmond98-droid/ai-commerce-agent-toolkit"
REPO_DIR="$HOME/.hermes/repos/ai-commerce-agent-toolkit"
PLUGIN_LINK="$HOME/.hermes/plugins/ai-commerce-agent-toolkit"

mkdir -p "$(dirname "$REPO_DIR")" "$(dirname "$PLUGIN_LINK")"

if [ -d "$REPO_DIR/.git" ]; then
  echo "→ Updating existing checkout at $REPO_DIR"
  git -C "$REPO_DIR" pull --ff-only
else
  echo "→ Cloning $REPO_URL → $REPO_DIR"
  git clone --depth=1 "$REPO_URL" "$REPO_DIR"
fi

# Refresh the symlink. Refuse to touch a real directory the user may own.
if [ -L "$PLUGIN_LINK" ]; then
  rm "$PLUGIN_LINK"
elif [ -e "$PLUGIN_LINK" ]; then
  echo "✗ $PLUGIN_LINK exists and is not a symlink. Move or remove it, then re-run." >&2
  exit 1
fi

ln -s "$REPO_DIR/.hermes-plugin" "$PLUGIN_LINK"

echo "✓ Installed. Launch hermes and run /plugins to verify."
echo "  Expected: ✓ ai-commerce-agent-toolkit v1.6.0 (20 skills, 1 cli command)"
