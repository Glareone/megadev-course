# fleet-lab: a small agent fleet for Pi and Claude Code

Three skills that plan, run and do work items in parallel, each item in its own git worktree and branch, plus a Claude Code launcher and an installer. The design, the four levels and the fact-check are in [Lecture 5: 09 A local fleet lab](../../Lecture_5_Workflows_not_tool_sets/09_Local_Fleet_Lab_Sandboxes_And_Worktrees.md). Review of the finished branches uses [review-loop](../../.claude/review-loop/README.md).

| File | What it is |
|---|---|
| [skills/fleet-plan/SKILL.md](skills/fleet-plan/SKILL.md) | Planner: survey with counts, at most 5 items, no shared paths, a command as done-check, stops for my approval |
| [skills/fleet-run/SKILL.md](skills/fleet-run/SKILL.md) | Runner: one worker per approved item, `MAX = 3` at once, collects `FLEET-STATUS` into `.fleet/report.md`. Only writer of `.fleet/` |
| [skills/fleet-run/scripts/run-pi-workers.sh](skills/fleet-run/scripts/run-pi-workers.sh) | Pi runner: a worktree per item, `pi -p` with the worker skill, `xargs -P` for the cap, `after:` order, logs per item |
| [skills/fleet-worker/SKILL.md](skills/fleet-worker/SKILL.md) | Worker: one item, own branch `fleet/<id>`, scope only, done-check, one commit, `FLEET-STATUS` block. No push, no merge |
| [claude/agents/fleet-worker.md](claude/agents/fleet-worker.md) | Claude Code launcher: `isolation: worktree`, preloads the worker skill |
| [install.sh](install.sh) | Copies the skills to `<repo>/.agents/skills/`, symlinks `<repo>/.claude/skills/`, copies the agent, excludes `.fleet/` from git |

This folder is not loaded by any harness as it stands (it is not under `.agents/skills/` or `.claude/skills/`). `install.sh` puts it where each harness looks.

## Portability in one table

| | Pi | Claude Code |
|---|---|---|
| Finds the skills in | `.agents/skills/` | `.claude/skills/` (symlinks) |
| Frontmatter it uses | Portable fields only | Same. The Claude-only settings live in the agent file |
| Runs workers with | `run-pi-workers.sh` (separate `pi -p` processes) | `fleet-worker` subagent, `isolation: worktree` |
| Worker model | `FLEET_MODEL` env var | `model:` in the agent file |

## Run it, level by level

Install into the target repository on a branch and commit, so a sandbox clone sees the skills:

```bash
cd ~/src/Azure-Solution-and-Enterprise-Architecture-in-Depth
git switch -c fleet/setup
"<megadev-course>/.agents/fleet-lab/install.sh" .
git add .agents .claude && git commit -m "Add fleet-lab skills"
```

**Level 0, Claude Code only, nothing installed.** In the target repo: `/fleet-plan rewrite links and remove build output`, approve items in `.fleet/items/`, then `/fleet-run`. Changes are isolated, execution is not.

**Level 1, one Pi agent in a sandbox.** I type the secret myself, never the agent:

```bash
brew install docker/tap/sbx && sbx login
sbx policy init balanced
sbx secret set openrouter                      # prompts, stored in the macOS Keychain
sbx run --clone --name fleet-azure --kit docker.io/sbx/pi-kit:latest pi
```

Inside Pi: `/model` to pick DeepSeek V4.1 Flash, then hand it one item by hand. On my Mac afterwards:

```bash
git fetch sandbox-fleet-azure
git diff fleet/setup..sandbox-fleet-azure/fleet/01-old-repo-links
```

**Level 2, planner and three workers in one sandbox.**

```bash
sbx exec fleet-azure -- pi -p --model openrouter/deepseek/deepseek-v4.1-flash "Use the fleet-plan skill. Goal: reduce structural debt of this repository."
sbx exec fleet-azure -- cat .fleet/plan.md
# approve items: sbx exec fleet-azure -- sed -i 's/^status: proposed/status: approved/' .fleet/items/01-*.md
sbx exec fleet-azure -- .agents/skills/fleet-run/scripts/run-pi-workers.sh 3
sbx exec fleet-azure -- pi -p "Use the fleet-run skill, Collect step only."
git fetch sandbox-fleet-azure
```

Then on my Mac, for each `done` branch: check it out, run `review-loop` in Claude Code, and open the PR myself.

**Direct DeepSeek instead of OpenRouter** (comparison run):

```bash
sbx secret set-custom --host api.deepseek.com --env DEEPSEEK_API_KEY   # prompts for the value
```

## Before trusting it

- **Only the shell logic is tested.** On 2026-11-11 `install.sh` and `run-pi-workers.sh` ran against a throwaway repo with a stub `pi`: two items in parallel, one worktree and branch each, an `after:` item held back, an unapproved item ignored, started items skipped on a rerun. No model, no `sbx` and no real Pi have run these skills yet.
- **Level 1 must prove three things first:** `--clone` works together with `--kit`, Pi inside `pi-kit` uses the proxy's placeholder key for OpenRouter, and the model id `deepseek/deepseek-v4.1-flash` exists (check with `/model`).
- **`sbx exec` working directory.** The commands above assume `sbx exec` starts in the clone's root. If not, add `cd` to the clone path first.
- **Claude Code worktrees branch from the default branch**, not from the branch I am on. If the skills live only on `fleet/setup`, merge them first or run Level 0 from the default branch.
- **The reviewer is a different model family on purpose** (Claude reviewing DeepSeek), as [Lecture 5: 02](../../Lecture_5_Workflows_not_tool_sets/02_Merge_Review_Second_Pair_Of_Eyes.md) argues.
- **Data:** item text and code go to OpenRouter and DeepSeek. Use it on my own public repositories. For Aras code check the [AI Solutions Catalog](http://aitools.aras.com/) first.
