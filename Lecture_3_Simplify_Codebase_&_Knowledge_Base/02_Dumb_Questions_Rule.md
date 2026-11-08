# 2. Dumb questions rule

> A human onboarding trick: every new person must ask at least one question that makes them feel dumb. It makes confusion show up early, and confusion is the signal to **simplify**.

Related: [1 Simplify first](01_Simplify_First_Knowledge_Guardrails.md) · [3 Agent asks dumb questions](03_Agent_Asks_Dumb_Questions.md) · [4 Ask why](04_Ask_Why.md)

Source: lecture s01e03 transcript. Checked on the web on 2026-11-07, see [Fact-check](#fact-check).

## 1. The problem

New people hide their confusion because nobody likes feeling dumb. The confusion stays, and the codebase never gets cleaner.

## 2. Words refinement

| Term | Meaning |
|---|---|
| **"No such thing as a dumb question"** | The usual slogan. The lecturer calls it silly: everyone has asked a dumb one |
| **Dumb questions rule** | The inversion. Each day you must ask the lead at least one question that makes you feel dumb. Your day isn't done until you do |
| **Not the same as** | [3 Agent asks dumb questions](03_Agent_Asks_Dumb_Questions.md) and [4 Ask why](04_Ask_Why.md). This note is about **humans** only |

## 3. The rule

- Lecturer used it at Amazon and Twitch for new hires.
- At least **one dumb question a day**, to a lead.
- Some people asked five in the first hours. Some saved one for the end of the day.
- The point is the **feeling**: if it felt dumb to ask, it was a real gap.

## 4. Why it matters for simplification

A dumb question is a **free confusion detector**. If a smart new person is confused, a cold-start agent will be too.

| Question type | What it usually means | Best fix |
|---|---|---|
| "Where does X live?" | Bad names or structure | Rename or move (layer 1) |
| "Why is this done twice?" | Duplicate or leftover code | Remove it |
| "Which command do I run?" | Missing one-command entry point | A single script, or one line of knowledge |
| "Why is it built like this?" | A decision nobody wrote down | A short note with the reason |

The answer should end with a **code change** first. A long wiki page is the last choice (see [fix order](01_Simplify_First_Knowledge_Guardrails.md#3-fix-order)).

## 5. My adaptation (own proposal)

1. Keep a simple **dumb question log**: question, answer, what I changed.
2. Each entry must name a **fix** (rename, script, lint rule, or a short note). "Explained it in chat" is not a fix.
3. Review the log monthly. Repeated questions are the best candidates for simplification.

## Fact-check

Checked on **2026-11-07**.

| Claim | Verdict | What I found |
|---|---|---|
| "A forced daily dumb question helps onboarding" | **Lecture-specific** | A personal management trick. I found no study of this exact rule |
| Asking questions and learning depend on whether people feel safe | **Plausibly supported, indirect** | Edmondson (1999, *Administrative Science Quarterly*, 51 teams): team psychological safety is associated with learning behavior, and learning behavior mediates team performance. A secondary source links this to help-seeking and error reporting. I did not read that detail in the paper itself. [Paper (MIT copy)](https://web.mit.edu/curhan/www/docs/Articles/15341_Readings/Group_Performance/Edmondson%20Psychological%20safety.pdf), [DOI](https://journals.sagepub.com/doi/10.2307/2666999) |
| A *quota* of dumb questions is better than the slogan | **Unverified** | The paper supports safety, not this tactic. Treat the quota as one tactic that worked for one lecturer |

## Cautions

- A quota can become theatre: invented questions nobody needs. Judge by the changes it produces.
- It works only if the lead answers kindly. Otherwise it makes people less safe, not more.
- My team is remote and mixed. Decide where the questions go (channel or one to one) so they are seen but not punishing.

## Summary

Make confusion visible on purpose. Every dumb question is a signal to simplify the code, not to write another document.

## Open questions for discussion

- Who is the "lead" who receives the questions on my team?
- Do I want a daily rule, or a lighter version for my first weeks on a repo?
- Where do I keep the log?

## Sources

- Lecture s01e03 transcript
- Edmondson, A. (1999). Psychological Safety and Learning Behavior in Work Teams. *Administrative Science Quarterly* 44(2), 350 to 383. [MIT copy](https://web.mit.edu/curhan/www/docs/Articles/15341_Readings/Group_Performance/Edmondson%20Psychological%20safety.pdf)
- Section 5 (the log) and the cautions are my own reasoning
