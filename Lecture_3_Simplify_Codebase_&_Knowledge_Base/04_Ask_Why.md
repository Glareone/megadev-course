# 4. Ask why

> After a mistake, ask the agent **why**. Its answer shows where it struggled. Treat it as a **hypothesis to verify**, not as proof, and fix the cause at the lowest layer.

Related: [1 Simplify first](01_Simplify_First_Knowledge_Guardrails.md) · [2 Dumb questions rule](02_Dumb_Questions_Rule.md) · [3 Agent asks dumb questions](03_Agent_Asks_Dumb_Questions.md)

Source: lecture s01e03 transcript. Checked on the web on 2026-11-07, see [Fact-check](#fact-check).

## 1. The problem

The agent did something wrong or odd: wrong tool, wrong file, huge PR, ugly output. How do we find the cause fast?

## 2. Words refinement

| Term | Meaning |
|---|---|
| **Ask why** | We ask the agent to explain a past mistake and suggest a fix |
| **Explore vs change** | To *explore* ("why did this happen?") ask a question. To *change* something, give an instruction |
| **Customer rule** | The lecturer: trust customers with their **problems**, not their **solutions**. Here the agent is the customer |
| **Faithful explanation** | An explanation that matches what really drove the behavior. Agents' explanations are not always faithful (see fact-check) |

## 3. The technique

1. **Notice** a repeated mistake.
2. **Ask why**, in plain words. You don't need to explain what you expect. The lecturer didn't even write the cause into the prompt.
3. **Read** what it says it struggled with, and **what it changed** if you let it try a fix.
4. **Verify** the diagnosis (see section 5).
5. **Fix properly yourself** at the lowest layer that works (see [fix order](01_Simplify_First_Knowledge_Guardrails.md#3-fix-order)).

The agent can look through **other threads' history**, so we can describe what happened in another thread instead of pasting it.

## 4. The lecture's examples

| Case | Question | What it found | Lecturer's follow-up |
|---|---|---|---|
| Ugly black background in inline HTML | "Why do you always add awful black backgrounds? Fix it here and push to the fleet" | A global "true black" rule was too broad | The agent's fix was weak. He found the skill it changed and edited it properly |
| Wrong tool used | "The thread used the wrong tool. Figure out why and update the skills" | A skill told the agent to use a command that created new threads instead of sub-agents | Fixed the skill |
| Scope creep: PR grew from about 15 needed lines to 271 added | "Audit the causes of the scope creep" | The agent's own review brief asked for more scope ("other paths?", "missed cases"), and each review round added more | Added a rule: keep changes simple, watch for unneeded tests, unneeded edge cases and extra compatibility |

**Important:** in all three, the lesson came from **what the agent changed**, not from the fix being good.

## 5. How to verify the answer

An agent's "why" can sound right and still be wrong. Before acting:

| Check | How |
|---|---|
| **Read the evidence** | Open the transcript and the tool calls. Does the story match? |
| **Reproduce** | Re-run the task in a fresh thread. Does the mistake come back? |
| **Test the fix** | Change the cause, run the same task again. Did the behavior change? |
| **Ask a second time** | Different phrasing, or a fresh thread. Is the answer stable? |

This is the same idea as the with and without comparison in [7 Skill shaper](../Lecture_2_Context_Agents_md_Skills_Tools/7_skill_shaper_how_to_improve_skills.md).

## 6. Self audit prompts (from the lecture)

- "What are the most common issues my agents run into in this repo over the last week? Go through my real history to find repeated hiccups and wrong tool calls."
- "Read my past code review comments, find repeated feedback, and propose lint rules or code cleanups that prevent it."

**Restricted Data warning.** These read chat or history that may contain PII or customer data. Under Aras policy, remove identifiers first and check the [AI Solutions Catalog](http://aitools.aras.com/).

## Fact-check

Checked on **2026-11-07**.

| Claim | Verdict | What we found |
|---|---|---|
| Agents can tell you why they did something | **Partly, risky** | Research shows model explanations can be plausible but unfaithful. Turpin et al. (NeurIPS 2023): biasing features strongly changed answers, but models rarely mentioned them in their explanations, with accuracy dropping up to 36% on some tasks (GPT-3.5, Claude 1.0). Anthropic (2025): Claude 3.7 Sonnet and DeepSeek R1 mentioned planted hints only about 25 to 39% of the time when they used them. Both are about **reasoning text** on **older models**, not exactly "why did you do that" after an agent run, so this is **not a direct test**. Still, verify. [Turpin et al.](https://arxiv.org/abs/2305.04388), [Anthropic](https://www.anthropic.com/research/reasoning-models-dont-say-think) |
| The agent's diagnosis is good but its fix is poor | **Lecture-specific** | One author's observation at filming time. No study found. Models change fast, so re-test |
| Explicit instructions to change, questions to explore | **Lecture-specific, sensible** | No source found. It is a working rule, not a result |
| The 271-line PR story | **Anecdote** | One case from one person |
| Agents over-engineer | **Weak evidence** | See [fact-check row 7 in note 1](01_Simplify_First_Knowledge_Guardrails.md#fact-check-of-the-lecturer) |

## Cautions

- **Don't trust the agent's fix.** Use it as a pointer to where the problem is.
- **Don't act on one answer.** Verify (section 5).
- **Don't turn every answer into a rule.** A rule that can't be reviewed rots (see [1, section 4](01_Simplify_First_Knowledge_Guardrails.md#4-knowledge-guardrails-and-principles-by-type-and-reviewability)).
- **Models change quickly.** Re-check before presenting.

## Summary

Ask why, treat the answer as a hypothesis, verify it, then fix the cause in the code before adding any prose.

## Open questions for discussion

- Which repeated mistake do we start with?
- Do we keep a record of "why" answers and what we verified?
- Who decides the layer for a fix: the author of the prompt, or a reviewer?

## Sources

- Lecture s01e03 transcript
- [Turpin et al., Language Models Don't Always Say What They Think (arXiv 2305.04388)](https://arxiv.org/abs/2305.04388)
- [Anthropic, Reasoning models don't always say what they think](https://www.anthropic.com/research/reasoning-models-dont-say-think)
- Section 5 (how to verify) is our own reasoning, not from the lecture
