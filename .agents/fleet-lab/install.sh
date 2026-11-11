#!/usr/bin/env bash
# Install the fleet-lab skills into a target repository, for Pi and Claude Code at once.
# Usage: install.sh /path/to/target-repo
#   .agents/skills/<name>        real files (Pi reads this, Agent Skills spec)
#   .claude/skills/<name>        symlink to the above (Claude Code reads this)
#   .claude/agents/fleet-worker.md   Claude Code worker launcher (Claude only)
set -euo pipefail

kit="$(cd "$(dirname "$0")" && pwd)"
target="${1:?usage: install.sh /path/to/target-repo}"
git -C "$target" rev-parse --show-toplevel >/dev/null
target="$(git -C "$target" rev-parse --show-toplevel)"

mkdir -p "$target/.agents/skills" "$target/.claude/skills" "$target/.claude/agents"
for s in fleet-plan fleet-run fleet-worker; do
  rm -rf "$target/.agents/skills/$s"
  cp -R "$kit/skills/$s" "$target/.agents/skills/$s"
  ln -sfn "../../.agents/skills/$s" "$target/.claude/skills/$s"
  echo "skill $s"
done
chmod +x "$target/.agents/skills/fleet-run/scripts/run-pi-workers.sh"
cp "$kit/claude/agents/fleet-worker.md" "$target/.claude/agents/fleet-worker.md"
echo "agent fleet-worker (Claude Code)"
grep -qx '.fleet/' "$target/.git/info/exclude" 2>/dev/null || echo '.fleet/' >> "$target/.git/info/exclude"
echo "done. Commit these files on a branch before 'sbx run --clone': the clone sees only committed files."
