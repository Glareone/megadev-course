# review-loop (my own example, not enabled)

An example skill and agent for an independent review before and after a pull request. It follows my notes [Lecture 5: 02 Before the merge](../../Lecture_5_Workflows_not_tool_sets/02_Merge_Review_Second_Pair_Of_Eyes.md) and [01 Skill or agent for exploring](../../Lecture_5_Workflows_not_tool_sets/01_Skill_Or_Agent_For_Explore_Loops.md), and the lecturer's `sol-loop` ([02, the seven edits](../../Lecture_5_Workflows_not_tool_sets/02_Merge_Review_Second_Pair_Of_Eyes.md#how-the-sol-loop-got-here-seven-edits)).

| File | What it is |
|---|---|
| [SKILL.md](SKILL.md) | The procedure, run in the author's thread: two loops, `MAX = 3` rounds each, triage rules, no merge |
| [agents/review-second-eyes.md](agents/review-second-eyes.md) | The reviewer: read-only, `model: claude-sonnet-5-5` in its header, gets git history and the PR with its comments through `git` and `gh` |

## The reviewer is the agent

The lecturer calls his version the "sol agent" and keeps it as an agent, and I agree: the reviewer is agent-level work. The agent file carries the model, the read-only limits, the way to get its own context (git history, the PR and its comments through `gh`) and the output shape. It runs in its own thread and returns findings only.

The loop is not inside the agent: fixing needs write access and the reviewer is read-only, and a subagent cannot start another subagent. So the skill stays as a thin driver in the author's thread. It counts rounds (`MAX = 3`), triages and fixes. The agent can be used on its own too: ask for an independent review of a branch or a PR without the skill.

## Split of work

| Part | Where | Why |
|---|---|---|
| Procedure, `MAX`, triage | Skill | Portable text, changes often, needs the author's context |
| Model, tools, read-only limits | Agent file header | Settings a skill cannot enforce, and a separate thread keeps findings out of the author's context |

## How to enable it

Claude Code loads project skills from `.claude/skills/` and project agents from `.claude/agents/`, so this folder is not loaded as it stands. To use it in a repository:

1. Copy `SKILL.md` to `.claude/skills/review-loop/SKILL.md`.
2. Copy `agents/review-second-eyes.md` to `.claude/agents/review-second-eyes.md`.
3. Check that `gh` is installed and signed in (`gh auth status`).
4. Allow the read-only commands in the project's permission settings, so the reviewer is not asked each time: `git log`, `git show`, `git diff`, `git blame`, `gh pr view`, `gh pr diff`, `gh pr checks`, `gh api` (GET). Keep `gh pr merge`, `gh pr comment`, `git push` and `git commit` out of the reviewer's allowance.

## What to know before trusting it

- **Not run yet.** I wrote it from my notes and the lecturer's slides. Nothing was executed.
- **Model name:** the header uses the full ID `claude-sonnet-5-5`. Claude Code documents the alias `sonnet` and accepts full IDs per third-party guides. Check the current subagent docs.
- **Same family as the author.** If the author is also a Claude model, this reviewer shares its family's blind spots. For risky areas (auth, data, money, migrations) change `model:` to a model from another family, or add a second reviewer.
- **The `tools` list does not limit Bash commands.** The read-only rule is in the agent's text and in the permission allowlist. Test that a forbidden command is refused before relying on it.
- **`MAX = 3`** is the lecturer's number for his agreement loop. Applying it to the PR loop is my choice.
- **Test it before use:** take five past PRs with known problems, run `mode: review`, and count what it finds and what it invents ([02](../../Lecture_5_Workflows_not_tool_sets/02_Merge_Review_Second_Pair_Of_Eyes.md), open questions).
- **Data:** the diff and the PR comments go to a model. For Aras code check the [AI Solutions Catalog](http://aitools.aras.com/) first.
