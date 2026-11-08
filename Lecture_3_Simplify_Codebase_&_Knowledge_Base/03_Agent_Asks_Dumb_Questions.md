# 3. Agent asks dumb questions

> Treat every new thread as a new hire. Let it explore **without help**, tell me what is confusing, and use that as a map of what to simplify.

Related: [1 Simplify first](01_Simplify_First_Knowledge_Guardrails.md) · [2 Dumb questions rule](02_Dumb_Questions_Rule.md) · [4 Ask why](04_Ask_Why.md) · [Lecture 2: 7 Skill shaper](../Lecture_2_Context_Agents_md_Skills_Tools/7_skill_shaper_how_to_improve_skills.md) (baseline method)

Source: lecture s01e03 transcript. Checked on the web on 2026-11-07, see [Fact-check](#fact-check).

## 1. The problem

How does the repo look to an agent that has never seen it? I can't tell from the inside, because I know too much.

## 2. Words refinement

| Term | Meaning |
|---|---|
| **Agent asks dumb questions** | The agent asks **me** what it finds confusing |
| **I ask the agent codebase questions** | I ask it how the repo works (an onboarding use). Different direction. See [fact-check](#fact-check) |
| **Cold start** | A fresh thread with no history. Only the repo and the instruction files are visible |
| **Baseline run** | A run with no special help, used to see what goes wrong. Same idea as in [7 Skill shaper](../Lecture_2_Context_Agents_md_Skills_Tools/7_skill_shaper_how_to_improve_skills.md) |

## 3. The technique

**Step 1.** Give a real task with no special setup. The lecture's first prompt for a repo with no AGENTS.md:

> I want you to work on ticket N. Explore the codebase and propose a fix. If you struggle to find anything or find something confusing, let me know. Don't be afraid to ask dumb questions.

**Step 2.** Read where it struggled: wrong files, many searches, questions to me.

**Step 3.** Answer its questions, or approve its fix and see what it does.

**Step 4.** For each struggle, pick the **lowest layer that fixes it** (see [fix order](01_Simplify_First_Knowledge_Guardrails.md#3-fix-order)): simplify code, then lint or CI, then a short line of knowledge.

## 4. The lecture's own demo failed

The lecturer deleted the README, CLAUDE.md and AGENTS.md of a big repo, and asked the agent what confused it. He says this "doesn't make a whole lot of sense to ask anymore, as I've just accidentally demonstrated", and switched to other examples. The transcript doesn't explain why. **Verify in the video before presenting.**

Two likely lessons (my reading, not stated by him):
- Modern agents explore well on their own, so a cold-start "what confuses you?" may give a thin answer.
- A **real task** shows struggle better than an abstract question.

## 5. What to look for

| Sign in the agent's run | Likely cause | Fix at |
|---|---|---|
| Searches many places for one thing | Unclear names or structure | Layer 1 |
| Runs a dev server or a heavy check at the wrong time | No simple entry point | Script, hook (layer 2) |
| Wrong PR format | A rule it could not know | One line of knowledge (layer 3) |
| Asks about a decision | Missing reason | Short note with the reason |
| Invents a new pattern | Several competing patterns in the repo | Remove the duplicates |

## Fact-check

Checked on **2026-11-07**.

| Claim | Verdict | What I found |
|---|---|---|
| Use the agent to understand a codebase and speed up onboarding | **Agrees** | Anthropic's docs recommend asking Claude codebase questions as you would a senior engineer, and say this became Anthropic's core onboarding workflow. That is **I ask the agent**, not **the agent asks me**. [Best practices](https://code.claude.com/docs/en/best-practices), [Anthropic engineering](https://www.anthropic.com/research/claude-code-best-practices) |
| Let the agent ask me questions first | **Agrees (related pattern)** | Docs describe an interview pattern: start with a minimal prompt, let Claude interview you with the `AskUserQuestion` tool, and end with a written spec. Plan mode also explores and asks clarifying questions before proposing. This is a similar idea, but for requirements, not for repo confusion. [Best practices](https://code.claude.com/docs/en/best-practices) |
| A cold-start "what confuses you?" reveals real problems | **Unverified, and his own demo undercuts it** | See section 4. A real task is a safer test |
| Use a fresh agent to judge clarity | **Agrees (my own repo)** | My note [7 Skill shaper](../Lecture_2_Context_Agents_md_Skills_Tools/7_skill_shaper_how_to_improve_skills.md) says my own session knows too much (curse of knowledge) and a fresh session is the better test |

## Cautions

- **One run proves little.** Repeat before concluding, as results vary by run and model.
- **The agent's list may be generic.** Check it against the actual transcript.
- **Don't write the list into AGENTS.md.** Fix the code first (see [1](01_Simplify_First_Knowledge_Guardrails.md)).
- **Internal source code.** Under Aras policy, check the [AI Solutions Catalog](http://aitools.aras.com/) for the approved tool before running this on company code.

## Summary

A fresh agent is a free test reader. Give it a real task, watch where it stumbles, and simplify what made it stumble.

## Open questions for discussion

- Which of my repos has no AGENTS.md, so it's a clean test?
- Which real ticket do I use as the baseline task?
- Do I repeat the run on several models?

## Sources

- Lecture s01e03 transcript
- [Claude Code: Best practices](https://code.claude.com/docs/en/best-practices)
- [Claude Code: Best practices for agentic coding (Anthropic)](https://www.anthropic.com/research/claude-code-best-practices)
- Sections 4 (my reading) and 5 (table) are my own reasoning
