---
name: review-loop
description: Use after finishing a code change on a branch and before it is merged. Gets an independent review from the review-second-eyes agent, fixes what matters, files the pull request, then babysits the PR until CI and the automated reviewers are green. Stops after MAX rounds in each loop. Never merges. Use whenever the user asks to review, file or finish a change, or says "review loop".
---

# Review loop

An independent reviewer checks my change, I fix what matters, I file the PR, and I follow the PR until the automated reviewers and CI are green. A human merges.

## Settings

```text
MAX = 3    rounds in the review loop, and rounds in the PR loop (each loop has its own count)
```

The reviewer's model is set in the agent file `review-second-eyes` (`model:` in its header), not here.

## Why it is built this way

- **A second reviewer finds what the author misses.** It starts from the diff and the intent only, so it cannot copy my wrong assumption.
- **Each round runs as a fresh helper.** Findings and bot comments stay out of my thread, so my context stays for decisions.
- **Reviews grow changes.** Every accepted nit is more code. So I triage, I push back on nits, and I stop at MAX.
- **I do not merge.** A human takes the last look and the merge. If the change cannot be undone, say so in the PR text.

## Before starting

1. Write the intent in two sentences. If I cannot, ask the user.
2. Find the base: `git merge-base HEAD origin/main` (or the repository's default branch).
3. Make sure tests and the build pass. Fix that first. Do not send a failing change for review.

## Loop 1: review before the PR (up to MAX rounds)

For `round` from 1 to MAX:

1. Call the `review-second-eyes` agent with the Agent tool: `mode: review`, `intent`, `base`, `round: N of MAX`, and `previous` (earlier findings with my decision on each). Do not paste my reasoning or the whole conversation.
2. Read the result. If `VERDICT: clean`, leave the loop.
3. Triage each finding (see "Triage"). Fix the ones I accept. Run the tests again.
4. At `round = MAX` with high findings still open: stop. Report them to the user and do not file the PR.

Then file the PR: look for an existing PR first (`gh pr list --head <branch>`). Follow the repository's title convention. In the description state the problem, then the solution, briefly. Add a **Review record**: rounds used, findings fixed, pushed back (with the reason), deferred, and the reviewer's `NOT CHECKED` line. Add how to undo the change.

## Loop 2: the PR until green (up to MAX rounds)

For `round` from 1 to MAX:

1. Wait for CI to finish: `gh pr checks <pr> --watch`.
2. Call `review-second-eyes` with `mode: digest`, the PR number, `intent`, `round`, `previous`. It reads CI, conversation comments (`gh pr view --comments`) and inline review comments (`gh api repos/{owner}/{repo}/pulls/<pr>/comments`) and returns the open findings.
3. If CI is green and no open findings remain: done.
4. Triage each finding. Fix the accepted ones, one commit per finding, and push.
5. At `round = MAX`: stop. List what is still open and hand it to the user.

## Triage

| Finding | Decision |
|---|---|
| Ties to the intent, or to a failing check, or is a confirmed bug | **Fix** |
| Two sources raise it (my reviewer and a bot) | **Fix**, it is the strongest signal |
| Style, naming, preference, or "could be more general" | **Push back** in one line with the reason. Do not change code |
| A real issue outside this change | **Defer**: say so in the PR and suggest an issue. Do not fix it here |
| Two findings conflict | The intent decides. Write the reason in the PR |
| Asks for a new feature, abstraction or test for a case that cannot occur | **Push back** |

Keep the change inside its intent. If a fix would grow the diff by more than a few lines beyond the finding, stop and ask.

## Rules

- Never merge, approve or resolve review threads on my own.
- Never run `git push --force`, and never skip hooks or checks.
- Keep PR comments short. If I comment on a PR, say that an agent is writing.
- No secrets, customer data or business detail in the PR text, the review record or comments.
- If the reviewer or `gh` fails twice in a row, stop and report. Do not loop on errors.

## Final report to the user

```text
Branch / PR: <name> / <url>
Loop 1: <rounds used> of MAX. Fixed <n>, pushed back <n>, deferred <n>
Loop 2: <rounds used> of MAX. CI: <green | red>. Open findings: <n>
Open items for you: <list, or none>
Way back for this change: <revert, flag, or other>
Not checked by the reviewer: <line from its last result>
```
