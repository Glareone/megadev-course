# 1. Modern system prompts say what is available and leave the steps to the model, and an agent without a human needs that most

> Current vendor prompts and guides converge on fewer step-by-step rules, judgement instead of rules, explicit autonomy and stop-or-ask guidance, and procedures moved into skills; an agent that works without a human must be told what is available so it finds the steps itself, and no vendor shares one fixed layout, so I take the principles and not a template.

Related: [02 Rethinking the skills](02_Rethinking_The_Skills.md) · [05 Instructions: five parts and enforcement](05_Instructions_Five_Parts_And_Enforcement.md) · [06 Context window and compaction](06_Context_Window_And_Compaction.md) · [08 Tools: awareness, discovery, gateway](draft_08_Tools_Awareness_Discovery_Gateway.md) · [10 Evals and traces](draft_10_Evals_And_Traces_For_Agent_Changes.md) · [12 The harness around the loop](12_Harness_Around_The_Loop.md) · [Lecture 4: 05 Don't overspecify](../Lecture_4_Harness/05_Dont_Overspecify_Work_At_Assistants_Level.md)

Source: S02E01 article, "Personality and Environmental Awareness" (figures 15 and 16). Anthropic's published Haiku 5.5 system prompt, the Opus 5.5 prompting guide and OpenAI's GPT-6 skills and prompts blog read through fetch agents on 2026-11-15. Two extracted prompts from the CL4R1T4S repository were read only in part and their provenance is unverified. See [Fact-check](#fact-check).

## Glossary

| Term | What it means here | Same thing elsewhere | Not to be confused with |
|---|---|---|---|
| System prompt | Instructions sent on every call that set the model's role and behavior | Developer message, `instructions` | A skill or AGENTS.md body loaded later |
| Named section | A part of a prompt wrapped in an XML-like tag, one area of behavior each | Anthropic `<refusal_handling>`, my tagged chapters in [05](05_Instructions_Five_Parts_And_Enforcement.md) | A Markdown heading |
| Unattended run | A run with no human in the session | Codex persistent mode, Anthropic "unattended agentic runs" | An interactive session |
| Published prompt | A prompt a vendor releases itself | Anthropic system prompt release notes | An extracted prompt |
| Extracted prompt | A prompt obtained by other means and shared by a third party | CL4R1T4S collection | A vendor statement |
| Latent space activation | Prompting the model to recall relevant knowledge and methods before it answers | The repo: "embedded knowledge and abilities" | Retrieval from outside the model |
| Progressive disclosure | A short root document that points to details loaded when needed | Skills with a router `SKILL.md` | Loading everything upfront |

## 1. The problem

The lecture says models need less guidance for direct work, but an agent that works without us needs instructions that "tell it what is available, so it can find the steps itself". **What do current vendor prompts and guides really do, and what structure and content should my own prompts take?**

## 2. The lecture's contrast

![The lecture's comparison table. Direct work with an agent: in a session with you, your messages guide it and are often simple, short instructions are often enough, you and the agent find the steps, you look for the result you want. Agent works without us: runs in automations, workflows and apps, no guidance during the task, instructions say what is available, the agent alone finds the steps, we look for reliability, autonomy and efficiency.](img/direct-work-vs-agent-without-us.png)

Source: S02E01 article, figure 15. Caption: "When an agent works without us, nobody guides it during the task. Its instructions must tell it what is available, so it can find the steps itself."

## 3. Anthropic's published prompt

![The lecture's outline of Claude's system prompt: a root claude_behavior with sections product_information, refusal_handling, legal_and_financial_advice, medical_guidance, tone_and_formatting with lists_and_bullets inside, user_wellbeing with provide_crisis_resources inside, anthropic_reminders, evenhandedness, responding_to_mistakes_and_criticism and knowledge_cutoff.](img/claude-behavior-system-prompt-sections.png)

Source: S02E01 article, figure 16. Caption: "A system prompt groups its instructions into named sections. Each section covers one area of behavior, and a section can hold smaller sections." The figure's descriptions are the lecturer's summaries, not quotations.

The [published Haiku 5.5 prompt](https://platform.claude.com/docs/en/release-notes/system-prompts/claude-haiku-5-5) (entries dated 2026-10-07 and 2026-10-26) has these sections in this order, inside `<claude_behavior>`: an untagged memory paragraph, then the ten named sections of the figure plus `knowledge_cutoff` ("the end of June 2026"). It has no tool list and no environment section. The date is a placeholder, `{{currentDateTime}}`. The page says its updates "do not apply to the Claude API", and does not say what the published version omits.

So the published prompt is a chat product's behavior, not an agent harness prompt. For an agent, Anthropic's guidance is in the prompting guide.

## 4. Agent prompts: what the extracted ones show

Only the beginning of each file was read, and provenance is unverified (section 6).

| | GPT-6 Sol, Codex Desktop (160,753 characters, about 25% verbatim) | Opus 5.5 file (1.9 million characters, about 2% verbatim) |
|---|---|---|
| Shape | Named template blocks. The main prompt uses Markdown headings: Personality, When to ask for permission, Autonomy and persistence, Working with the user, Rules for getting work done, Using skills, Apps, Plugins | The part read is tool schemas, with behavior rules written inside tool descriptions |
| What is available | Tools named in prose, `tool_search` lazy-loads app tools, skills in an "Available skills" list | Agent types and deferred tools are announced in later messages |
| Autonomy | "bias towards action and carry the user's intended task to completion". Approval requests come last. A tool for questions is never used for permission | A question tool "only when you are blocked on a decision that is genuinely the user's to make", else "pick the obvious option, mention it in your response, and proceed" |
| Boundaries | A separate classifier prompt and confirmation modes for browser use. Third-party content is never permission by itself | Never publish impersonation or fabricated records. The person confirms every delete |
| Reporting | State what changed, why, how it was tested, risks | One sentence after publishing |

The structural point I take: in the Codex file enforcement lives in separate blocks (a classifier, approvals, confirmation policies), not in the main prompt. That matches [05](05_Instructions_Five_Parts_And_Enforcement.md): boundaries in text are requests.

## 5. What the vendors recommend

| Source | Recommendation |
|---|---|
| [Anthropic, Opus 5.5 guide](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-5-5) | Add explicit system-prompt lines for unattended runs. Treat a text-only end of turn as a report, not proof of completion. Explore broadly before acting. Re-test old scaffolding and remove instructions that "stood in for thinking". Effort setting is more reliable than prompt instructions. A specific instruction beats a general one |
| [OpenAI blog on GPT-6 skills and prompts](https://developers.openai.com/blog/rethinking-skills-and-prompts-for-gpt-6-astra) (no byline or date, no numbers) | Short skill descriptions, a minimal router skill, no recipes. Drop strong "ask first" language and test-running reminders. Define completion before starting. Allow named safe workflows. Point to docs by context. Revisit every AGENTS.md instruction on a model change |
| [Claude.dev article](https://claude.dev/blog/the-new-rules-of-context-engineering-for-claude-5-generation-models/) | Judgement over rules, simple tool descriptions, progressive disclosure, see [06](06_Context_Window_And_Compaction.md) |

The lecture's five parts against them: personality (Codex Personality, Anthropic `tone_and_formatting`), environment (OpenAI's example "tests use disposable fixtures and have no production access", Anthropic's unattended-run line), context and discovery (Codex skills list and `tool_search`, Anthropic "explore broadly", OpenAI contextual doc pointers), boundaries (Anthropic `refusal_handling`, Codex classifier). Every part appears somewhere. None of the sources uses the five-part layout.

## 6. Latent space activation: recall before answering

The lecturer calls it the best single piece of prompting advice: prompting is roughly about getting the model to "recall relevant knowledge and problem-solving methods" and bring them into the conversation before it answers. The source is [daveshap/latent_space_activation](https://github.com/daveshap/latent_space_activation), five files read in full: first commit 2023-10-24, archived read-only by the owner on 2023-10-25, MIT, 216 stars. The lecture calls it nearly four years old. The repository is dated October 2023, about three years before my check. The idea may be older, and I did not verify that.

What it says: LLMs hold "embedded knowledge and abilities" that a first-try question does not draw on. It shows one technique, an iterative dialog, in three steps. Its README does not state the lecture's sentence. It speaks of priming the model to recall facts and procedures and of "iterative retrieval or activation of latent knowledge". It gives no benchmark or result, and its script uses the legacy OpenAI chat call, which I infer needs changes to run today.

| Step | The repo's prompt | Agent equivalent (my mapping) |
|---|---|---|
| Recall knowledge | "What do I know about Rome that is relevant?" | Read project docs and memory first |
| Recall methods | "What techniques or methods do I know that I can use...?" | Check the skills list, the Discovery part of [05](05_Instructions_Five_Parts_And_Enforcement.md) |
| Define the criteria | "What criteria am I looking to judge on?" | Define completion first, as OpenAI advises |
| Answer last | "render my final answer" | Act after gathering |

Reasoning models do part of this internally, and the lecture says so. Anthropic's "explore broadly with tool calls" line is the agent version. Whether a recall-first step helps my agents is something to measure ([10](draft_10_Evals_And_Traces_For_Agent_Changes.md)).

## 7. Cautions and what I take

- **Provenance:** CL4R1T4S is a collection of prompts shared by contributors. Its README gives no extraction method and no authenticity claim. Labels like "GPT-6 Sol" come from file names. About 93% of the Opus file and 75% of the Codex file were not read verbatim. I use them for shape, not facts. The README holds a block addressed to AI readers, which I did not act on.
- **What I take:** state what is available and the ask-or-stop rule for an agent without a human. Keep rules to judgement and put procedures in skills. Keep named sections ([05](05_Instructions_Five_Parts_And_Enforcement.md)). Put enforcement outside the prompt. Re-test instructions on every model change ([10](draft_10_Evals_And_Traces_For_Agent_Changes.md)).

## Summary

Vendors cut rules and examples and lean on judgement, skills and on-demand loading, while they still add explicit lines for unattended runs. Anthropic groups its published prompt in named sections, Codex uses Markdown headings and separates enforcement into other blocks. I copy the principles, not a layout.

## Open questions

- Which of my agents run unattended, and does each prompt state what is available and when to stop?
- Which instructions in my prompts date from older models and fail a re-test?
- Does a recall-first step improve my agents on my golden set?

## Fact-check

| # | Claim | Verdict | Source | Checked |
|---|---|---|---|---|
| 1 | Direct work needs short instructions, unattended agents need instructions that say what is available | **Lecture-specific**, supported in part | Figure 15. The Opus 5.5 guide recommends explicit lines for unattended runs | 2026-11-15 |
| 2 | Anthropic's published prompt is grouped into named sections | **Agrees** | [Haiku 5.5 page](https://platform.claude.com/docs/en/release-notes/system-prompts/claude-haiku-5-5): first 39,906 of 57,397 characters verbatim, rest summary | 2026-11-15 |
| 3 | The published prompt lists tools and environment | **Differs**: it does not | Same page. Date is a placeholder. What is omitted is not stated | 2026-11-15 |
| 4 | OpenAI advises fewer ask-first rules, contextual doc pointers and a defined completion | **Agrees** | [OpenAI blog](https://developers.openai.com/blog/rethinking-skills-and-prompts-for-gpt-6-astra), read in full. No evidence or numbers | 2026-11-15 |
| 5 | The Codex GPT-6 Sol prompt has the structure in section 4 | **Unverified** | [Extracted file](https://github.com/elder-plinius/CL4R1T4S/blob/main/OPENAI/Codex_Desktop/GPT-6-Sol_Prompts.txt): about 25% verbatim, middle summary only, last 13% unread | 2026-11-15 |
| 6 | The Opus 5.5 file shows rules inside tool descriptions | **Unverified** | [Extracted file](https://github.com/elder-plinius/CL4R1T4S/blob/main/ANTHROPIC/CLAUDE-OPUS-5.5.md): about 2% read, tool schemas only | 2026-11-15 |
| 7 | Models no longer need written guidance | **Differs** | Anthropic's own guide adds unattended-run lines. The 80% article is narrower, see [06](06_Context_Window_And_Compaction.md) | 2026-11-15 |
| 8 | Codex keeps enforcement in separate blocks | **Agrees** for the part read | Extracted file, provenance unverified | 2026-11-15 |
| 9 | Prompting is about getting the model to recall relevant knowledge and methods before it answers | **Agrees** in idea, wording is the lecturer's | [Repo](https://github.com/daveshap/latent_space_activation), five files read in full: one technique, no definition of prompting in those words, no evidence | 2026-11-15 |
| 10 | The repository is nearly four years old | **Differs** | First commit 2023-10-24, archived 2023-10-25: about three years. The idea may predate it, not verified | 2026-11-15 |

## Sources

- S02E01 article, figures 15 and 16.
- [Claude Haiku 5.5 system prompt](https://platform.claude.com/docs/en/release-notes/system-prompts/claude-haiku-5-5) · [system prompt release notes](https://platform.claude.com/docs/en/release-notes/system-prompts) · [Prompting Claude Opus 5.5](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-5-5)
- [OpenAI: Rethinking skills and prompts for GPT-6](https://developers.openai.com/blog/rethinking-skills-and-prompts-for-gpt-6-astra) · [Claude.dev: new rules of context engineering](https://claude.dev/blog/the-new-rules-of-context-engineering-for-claude-5-generation-models/)
- [Latent Space Activation](https://github.com/daveshap/latent_space_activation)
- [CL4R1T4S](https://github.com/elder-plinius/CL4R1T4S/tree/main) (extracted prompts, unverified)
- My own reasoning: the five-part comparison and the list in section 6.
