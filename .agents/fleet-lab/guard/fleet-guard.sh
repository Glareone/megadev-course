#!/usr/bin/env bash
# fleet-guard: check a fetched agent branch BEFORE it is checked out on the host.
# It only reads git objects. It never checks out, merges or runs anything from the branch.
# Run it from this kit (megadev-course), never from a copy inside the target repository:
# an agent branch could change a guard that lives in the repository it is checked against.
#
# Usage:  fleet-guard.sh <ref> [--base <ref>] [--scope <glob>]... [--max-files <n>]
#   <ref>          the fetched branch, e.g. sandbox-fleet-azure/fleet/01-old-repo-links
#   --base         what the branch started from (default: main). The diff is <base>...<ref>
#   --scope        allowed paths (shell glob, * also matches /). Repeat. If given, every changed path must match one
#   --max-files    fail when more files changed (default 50)
# Exit: 0 PASS, 1 FAIL (violations listed), 2 usage or git error.
set -euo pipefail

ref=""; base="main"; max=50; scopes=()
while [ $# -gt 0 ]; do
  case "$1" in
    --base) base="$2"; shift 2 ;;
    --scope) scopes+=("$2"); shift 2 ;;
    --max-files) max="$2"; shift 2 ;;
    -h|--help) sed -n '2,14p' "$0"; exit 0 ;;
    -*) echo "unknown option $1" >&2; exit 2 ;;
    *) ref="$1"; shift ;;
  esac
done
[ -n "$ref" ] || { echo "usage: fleet-guard.sh <ref> [--base <ref>] [--scope <glob>]... [--max-files <n>]" >&2; exit 2; }
git rev-parse --verify -q "$ref^{commit}" >/dev/null || { echo "unknown ref: $ref" >&2; exit 2; }
git rev-parse --verify -q "$base^{commit}" >/dev/null || { echo "unknown base: $base" >&2; exit 2; }

# Paths that can run code or steer an agent on my machine once checked out, opened or built.
protected() {
  case "$1" in
    .claude/*|*/.claude/*|CLAUDE.md|*/CLAUDE.md|AGENTS.md|*/AGENTS.md|.mcp.json|*/.mcp.json) return 0 ;;   # agent hooks, MCP servers, instructions
    .agents/*|*/.agents/*) return 0 ;;                                                                     # skills
    .github/*|.gitlab-ci.yml|azure-pipelines.yml|.circleci/*) return 0 ;;                                  # CI
    .vscode/*|*/.vscode/*|.idea/*|.devcontainer/*|*/.devcontainer/*) return 0 ;;                           # editor tasks, dev containers
    .git*|*/.git*|.husky/*|.pre-commit-config.yaml|.envrc|*/.envrc) return 0 ;;                            # git config, hooks, direnv
    *.sh|*.bash|*.zsh|*.ps1|*.psm1|*.cmd|*.bat|Makefile|*/Makefile) return 0 ;;                           # scripts
    package.json|*/package.json|.npmrc|*/.npmrc) return 0 ;;                                                # npm lifecycle scripts
    Directory.Build.props|Directory.Build.targets|*/Directory.Build.props|*/Directory.Build.targets|*.csproj|*.targets) return 0 ;;  # MSBuild runs these on build
  esac
  return 1
}

in_scope() {
  [ "${#scopes[@]}" -eq 0 ] && return 0
  local g
  for g in "${scopes[@]}"; do
    # shellcheck disable=SC2254
    case "$1" in $g) return 0 ;; esac
  done
  return 1
}

fail=0; n=0
echo "fleet-guard: $base...$ref"
# --raw gives modes: 120000 symlink, 160000 submodule, 100755 executable. -z keeps odd file names intact.
while IFS= read -r -d '' meta && IFS= read -r -d '' path; do
  n=$((n+1))
  status="${meta##* }"; newmode="$(echo "$meta" | awk '{print $2}')"
  case "$status" in R*|C*) IFS= read -r -d '' path ;; esac   # renames carry two paths: keep the new one
  if protected "$path"; then echo "FAIL protected path: $path"; fail=1; fi
  if ! in_scope "$path"; then echo "FAIL outside scope: $path"; fail=1; fi
  case "$newmode" in
    120000) echo "FAIL symbolic link: $path"; fail=1 ;;
    160000) echo "FAIL submodule: $path"; fail=1 ;;
    100755) echo "FAIL executable file: $path"; fail=1 ;;
  esac
done < <(git diff --raw -z --no-abbrev -M "$base...$ref")

if [ "$n" -gt "$max" ]; then echo "FAIL $n files changed, limit $max"; fail=1; fi
commits="$(git rev-list --count "$base..$ref")"
echo "files: $n  commits: $commits"
if [ "$fail" -eq 0 ]; then echo "PASS"; else echo "Do not check out this branch. Read the diff with: git diff $base...$ref"; fi
exit "$fail"
