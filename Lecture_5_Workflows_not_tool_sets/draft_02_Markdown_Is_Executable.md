# 2. Markdown is executable: a prompt as the whole workflow

> A Markdown file piped into an agent runs almost like a program. It is not deterministic, but it lets me build flows that I used to write as code, such as a nightly PR triage, with no code at all.

Related: [01 Workflows live in prompts and skills](draft_01_Workflows_Live_In_Prompts_And_Skills.md) · [02 Before the merge](02_Merge_Review_Second_Pair_Of_Eyes.md) · [05 Seek tedium](draft_05_Seek_Tedium_Delegate_The_Boring.md) · [08 Compose skills](draft_08_Compose_Skills_Building_Blocks_To_Workflows.md) · [Lecture 4: 10 Automation](../Lecture_4_Harness/10_Automation_Repository_Agents.md) · [Lecture 4: 08 Model routing and cost](../Lecture_4_Harness/08_Settings_Model_Routing_Cost.md) · [Lecture 4: 17 Cost per task](../Lecture_4_Harness/17_Cost_Per_Task.md)

Source: S01E05 transcript, the nightly PR triage story. Claude Code scheduling docs checked on 2026-11-09 as a search summary, see [Fact-check](#fact-check).

## 1. The problem

Many of my small tools and side projects are just a fixed procedure with a few judgment calls. Writing them as code means building parsing, retries and special cases. Can I write the procedure as text and let the agent run it, and what do I give up?

## 2. Words

| Term | Means here | Not to be confused with |
|---|---|---|
| **Executable Markdown** | A `.md` prompt or skill the agent follows step by step | A script. Same input can give a different path |
| **Delegate** | A helper agent started by the main agent for one job, with its own model | A person, or a long-lived worker ([Lecture 2: 12](../Lecture_2_Context_Agents_md_Skills_Tools/12_subagents_vs_workers.md)) |
| **Scheduled prompt** | A saved prompt the harness reruns on a timer | A cron job that runs code |

## 3. The lecturer's picture of it

"Back in my day, the idea that you could have something.js and pipe this into Node.js ... was just mind-blowing ... But now, you can take something.markdown and pipe that into Claude, and it will execute it, almost like it's code. Is it deterministic? No. But JavaScript barely feels deterministic nowadays."

| | Script | Markdown workflow |
|---|---|---|
| Same input, same steps | Yes | No, the path can differ |
| Handles an odd case | Only if I coded it | The model adapts |
| Cost to change | Edit, test, deploy | Edit a sentence |
| Where it breaks | A clear error | A quiet wrong turn |
| Portability | Tied to the runtime | Any harness that reads Markdown |

## 4. Worked case: the nightly PR triage

The lecturer's open source project gets "800 to 1,000" pull requests a day at times. He cannot read them all, so a scheduled prompt runs every day at 9:00 p.m.

```mermaid
sequenceDiagram
    participant T as Timer 9 p.m.
    participant M as Main agent
    participant H as Cheap delegates (Haiku)
    participant O as Strong delegates (Opus + second model family)
    participant Me as Me
    T->>M: Run the saved prompt
    M->>H: One delegate per PR active in the last 24 h
    H-->>M: Brief audit: mergeability, value, novelty, insights
    M->>O: Only PRs that look mergeable
    O-->>M: Verify each one
    M-->>Me: Short list, 8 PRs or fewer, worth merging or taking over
    style H fill:#2a7,stroke:#2a7,color:#fff
    style O fill:#d44,stroke:#d44,color:#fff
```

**The whole program, as the lecturer wrote it** (his words, shortened):

```text
Every day at 9:00 p.m. do the following.
Spin up a set of Haiku delegates to look at pull requests with activity
in the last 24 hours. Do a brief audit for mergeability, value, novelty,
and other insights I might want to know.
If any look mergeable, have Opus and a second-family delegate verify.
Come back with a short list of eight or fewer PRs worth merging
or taking over to get landed.
Any confusion about what I'm looking for? Ask. Otherwise do a test run
before we set up the scheduled task.
```

**What happened:** the agent asked no questions, ran a test with the Haiku delegates, had Opus and the second model review 12 PRs, and showed the list. He approved, and the agent wrote the saved prompt it reruns each night. That prompt grew code-like parts: specific commands, and steps to stay under GitHub rate limits.

**Important:**
- **No code was written.** The prompt, then the agent's own rewrite of it, is the workflow.
- **Cost is a design input.** A strong model on every PR "would put us out of business". Cheap model filters, strong model confirms. See [Lecture 4: 08](../Lecture_4_Harness/08_Settings_Model_Routing_Cost.md) and [17](../Lecture_4_Harness/17_Cost_Per_Task.md).
- **Test run before the schedule.** The agent proves the flow once, then saves it.
- **The agent refines the prompt.** He wrote the first version, the model adjusted it after seeing what worked.

**Not important:**
- The model names and the 9 p.m. time. They are his choices.

## 5. What I give up, and how to cover it

| Risk of Markdown as a program | Cover |
|---|---|
| Quiet wrong turn, no error | The output is a short list I read, so a wrong turn costs me one review, not a merge |
| Different result each night | Fix the output format in the prompt (a list of at most eight, with a reason each) |
| A step that must be exact | Put it in a command the prompt names, not in prose |
| Hits a rate limit | Name the limit in the prompt and tell the agent how to stay under it |

## My take

This is the "Markdown as a program" idea at the center of the lecture, and it fits an agentic platform: a saved prompt is a small, readable job definition. For my own platform the open point is **who reviews the saved prompt**. The model rewrote it, so a change history and a human read of each rewrite are the audit trail. Output that goes to a human list is a safe first use. Output that acts, such as merging, needs the limits from [01](draft_01_Workflows_Live_In_Prompts_And_Skills.md).

## Cautions

- Non-determinism is real. Do not use this where one wrong step cannot be undone.
- A scheduled prompt can drift as the model changes. Re-read it ([01](01_Skill_Or_Agent_For_Explore_Loops.md#7-a-skill-audit-i-can-run)).
- Data: a triage prompt reads repository content. For Aras work, check the [AI Solutions Catalog](http://aitools.aras.com/) first.

## Summary

A Markdown prompt can be the whole workflow: written once, tested once, scheduled. Use cheap models to filter and strong models to confirm. Keep exact steps in commands, and keep a human on anything that acts.

## Open questions

- Which of my small scripts would be shorter and clearer as a saved prompt?
- Where do I keep the saved prompt so its rewrites are reviewed?

## Fact-check

| # | Claim | Verdict | Source | Checked |
|---|---|---|---|---|
| 1 | A harness can rerun a saved prompt on a schedule | **Agrees** | [Claude Code scheduled tasks](https://code.claude.com/docs/en/scheduled-tasks): `/loop` (session only), desktop tasks, and cloud routines created with `/schedule`. Search summary, page not read in full | 2026-11-09 |
| 2 | A harness can start delegates on chosen models | **Agrees** | [Claude Code subagents](https://code.claude.com/docs/en/subagents): `model` field takes `sonnet`, `opus`, `haiku` or `inherit`. Search summary. Sources disagree on precedence with the `CLAUDE_CODE_SUBAGENT_MODEL` variable, so check the page | 2026-11-09 |
| 3 | The lecturer's harness (T3 Code) runs this flow | **Unverified** | The lecturer's setup. [T3 Code](https://github.com/pingdotgg/t3code) exists, MIT, supports Codex, Claude and OpenCode per its README summary. Whether it has scheduling is not checked | 2026-11-09 |
| 4 | The delegate models "Haiku 5.5" and "Opus 5.5", and the second-family reviewer "6.1 Soul" | **Unverified** | Names as spoken in the transcript. The reviewer is most likely `gpt-5.6-sol` (see [02](02_Merge_Review_Second_Pair_Of_Eyes.md#how-the-sol-loop-got-here-seven-edits)), but the "6.1" is not confirmed. Verify before presenting | 2026-11-09 |
| 6 | "800 to 1,000 PRs a day" at his project | **Unverified** | Spoken once in the transcript. Verify before presenting | 2026-11-09 |
| 5 | The result is not deterministic but useful | **Lecture-specific** | The lecturer's experience | 2026-11-09 |

## Sources

- S01E05 transcript (the prompt is quoted and shortened)
- [Claude Code scheduled tasks](https://code.claude.com/docs/en/scheduled-tasks) and [subagents](https://code.claude.com/docs/en/subagents)
- Sections 5 and "My take" are my own reasoning
