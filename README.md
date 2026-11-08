# megadev-course

A personal knowledge base. It follows the order of the **MEGA.dev course** on building with AI agents, but it is not only the course. It also holds my own knowledge and experience.

**How it is organized.**
- **By lecture,** the way the course goes: one folder per lecture.
- **By topic inside each lecture:** one file per topic. A file does not retell the lecture. It follows how I get the things the lecture touches. I dive into the problem, add my own understanding and clarifications, and check the result against industry standards.
- **What it holds:** lecture notes, refined insights, challenge work and my experiments.

It is **not a codebase**. The output is Markdown with Mermaid diagrams that I re-read and present. This file is the table of contents, the list of references I check against, and the rules every note follows.

**Three voices, kept apart.** In each note, what the lecture says, what I add, and what industry sources say are marked separately, so you can always tell which is which.

## The principle: every claim is checked

A lecture is one author's view at one moment. It can be outdated, stale, or wrong. So nothing is copied into a note unchecked.

- **I check each key claim against industry standards and current sources.** Vendor docs, specifications, papers and official repositories come first. Blogs and social posts come last.
- **The checks are current for Q4 2026 to Q1 2027.** Most are dated November 2026. Models, harnesses, prices and vendor docs change within weeks, so a "fact" here is only valid inside that window. Re-check before you present.
- **Every note ends with a fact-check table.** Each claim gets a verdict, the source and the date:

| Verdict | Meaning |
|---|---|
| **Agrees** | A primary source supports it |
| **Differs** | A source says something different. The note says so plainly |
| **Outdated** | It was true once. I fix the sentence in the note body at once, in every note that repeats it, and mark it `Corrected YYYY-MM-DD` |
| **Lecture-specific** | The lecturer's opinion or method. No outside source |
| **Unverified** | I could not check it. It stays marked "verify before presenting" |

- **I keep my own reasoning apart.** Each note's Sources section says which parts are mine and not from the lecture or the sources.
- **I check examples by running them or by reading their results,** and the note says which one I did. A search summary is not a primary source, and the note says when that is all we had.

**Status of the checks.** The Lecture 3 notes carry the full fact-check tables. The Lecture 1 and 2 notes mark their sources and my own reasoning, but were written before this rule. A systematic re-check of their time-sensitive claims (models, tool behavior, limits, versions) is still to do.

```mermaid
flowchart LR
    L["Lecture, video or picture"] --> R["Refine: problem, words, simplest version"]
    R --> V["Check against industry standards and current sources"]
    V --> N["Note: with verdicts, dates and sources"]
    N -->|"fact outdated or wrong"| F["Fix the note body and every note that repeats it"]
    F --> N
```

## How a note is built

Every note has the same shape, so it is quick to scan:

1. `# N. Title` and a one-line summary starting with `>`.
2. A `Related:` line that links both ways. No broken relative links.
3. The sections: the problem, the words I pin down, the picture (its story, what is important, what is not), my view, the fact-check, cautions, summary, open questions, sources.
4. Diagrams are **Mermaid only**. No ASCII art.

## What to read first

- **Starting the course:** [how-to-start-mega-dev-challenge.md](how-to-start-mega-dev-challenge.md), then [mega-mcp-auth-issues.md](mega-mcp-auth-issues.md) if sign-in fails.
- **The core idea of Lecture 3:** [1 Simplify first](Lecture_3_Simplify_Codebase_&_Knowledge_Base/01_Simplify_First_Knowledge_Guardrails.md). Fix the codebase first, and keep knowledge as a last resort with a type and a way to review it.
- **The context model behind everything:** [Lecture 2: 4 Context window](Lecture_2_Context_Agents_md_Skills_Tools/4_context_window.md).

## Table of contents

### Course setup

| File | What it is |
|---|---|
| [how-to-start-mega-dev-challenge.md](how-to-start-mega-dev-challenge.md) | How to connect your agent to the course and start a Challenge |
| [mega-mcp-auth-issues.md](mega-mcp-auth-issues.md) | Known sign-in issues with the course MCP server |

### Lecture 1: Mechanics behind generative AI

Folder: [Lecture_1_Mechanics_Behind_Generative_AI](Lecture_1_Mechanics_Behind_Generative_AI/)

| Note | Topic |
|---|---|
| [01](Lecture_1_Mechanics_Behind_Generative_AI/01_tokenizer_encoder_decoder.md) | Tokenizer: encoder and decoder |
| [02](Lecture_1_Mechanics_Behind_Generative_AI/02_next_token_prediction.md) | Predicting the next token |
| [03](Lecture_1_Mechanics_Behind_Generative_AI/03_video_chatml_tools_agent_loop.md) | The video: ChatML, tools and the agent loop |
| [04](Lecture_1_Mechanics_Behind_Generative_AI/04_lesson_model_mechanics_and_tools.md) | Lesson page: model mechanics and tools |
| [05](Lecture_1_Mechanics_Behind_Generative_AI/05_lesson_harnesses_providers_steering.md) | Lesson page: harnesses, providers and steering |
| [06](Lecture_1_Mechanics_Behind_Generative_AI/06_reasoning_visible_and_silent.md) | Reasoning: visible and silent |
| [07](Lecture_1_Mechanics_Behind_Generative_AI/07_responses_api_request_example.md) | Example: Responses API request |
| [08](Lecture_1_Mechanics_Behind_Generative_AI/08_chatml.md) | ChatML |
| [09](Lecture_1_Mechanics_Behind_Generative_AI/09_multimodality.md) | Multimodality |
| [10](Lecture_1_Mechanics_Behind_Generative_AI/10_code_mode.md) | Code mode |
| [11](Lecture_1_Mechanics_Behind_Generative_AI/11_cli_and_mcp.md) | CLI and MCP tools |
| [12](Lecture_1_Mechanics_Behind_Generative_AI/12_mcp_resources_and_skills.md) | MCP: resources and skills |
| [13](Lecture_1_Mechanics_Behind_Generative_AI/13_skills_and_context.md) | Skills: loading, context and unloading |
| [14](Lecture_1_Mechanics_Behind_Generative_AI/14_attachments_and_what_the_model_sees.md) | Attachments: what the model actually sees |
| [15](Lecture_1_Mechanics_Behind_Generative_AI/15_self_querying.md) | Self-querying |
| [16](Lecture_1_Mechanics_Behind_Generative_AI/16_self_management.md) | Self-management |
| [17](Lecture_1_Mechanics_Behind_Generative_AI/17_ambient_durable_agents.md) | Ambient, durable agents |

### Lecture 2: Context, AGENTS.md, skills and tools

Folder: [Lecture_2_Context_Agents_md_Skills_Tools](Lecture_2_Context_Agents_md_Skills_Tools/)

| Note | Topic |
|---|---|
| [Insight 1](Lecture_2_Context_Agents_md_Skills_Tools/Insight_1_Context_Agents.md) | Context: AGENTS.md and CLAUDE.md. The main source of token waste |
| [1](Lecture_2_Context_Agents_md_Skills_Tools/1_Harness.md) | Harness: everything around the model |
| [2](Lecture_2_Context_Agents_md_Skills_Tools/2_agent_context_self_report.md) | Agent context self-report |
| [3](Lecture_2_Context_Agents_md_Skills_Tools/3_lifecycle_hooks.md) | Lifecycle hooks: deterministic logic around the loop |
| [4](Lecture_2_Context_Agents_md_Skills_Tools/4_context_window.md) | Context window |
| [5](Lecture_2_Context_Agents_md_Skills_Tools/5_skills.md) | Skills: design, generation and security |
| [6](Lecture_2_Context_Agents_md_Skills_Tools/6_router_skills.md) | Router skills |
| [7](Lecture_2_Context_Agents_md_Skills_Tools/7_skill_shaper_how_to_improve_skills.md) | Skill shaper: how to improve skills |
| [8](Lecture_2_Context_Agents_md_Skills_Tools/8_tools_native_and_external.md) | Tools: native and external |
| [9](Lecture_2_Context_Agents_md_Skills_Tools/9_tools_prompt_injection.md) | Tools and prompt injection |
| [10](Lecture_2_Context_Agents_md_Skills_Tools/10_tool_results_context_to_file_and_back.md) | Tool results: context to file and back |
| [11](Lecture_2_Context_Agents_md_Skills_Tools/11_tool_upfront_vs_tool_discovery.md) | Tools: upfront schemas versus discovery |
| [12](Lecture_2_Context_Agents_md_Skills_Tools/12_subagents_vs_workers.md) | Subagents versus workers |

### Lecture 3: Simplify the codebase and the knowledge base

Folder: [Lecture_3_Simplify_Codebase_&_Knowledge_Base](Lecture_3_Simplify_Codebase_&_Knowledge_Base/). Pictures are in its `img/` folder.

| Note | Topic |
|---|---|
| [1](Lecture_3_Simplify_Codebase_&_Knowledge_Base/01_Simplify_First_Knowledge_Guardrails.md) | Simplify first: fix the codebase before adding knowledge. Knowledge needs a type and a way to review it |
| [2](Lecture_3_Simplify_Codebase_&_Knowledge_Base/02_Dumb_Questions_Rule.md) | Dumb questions rule: a human onboarding trick that makes confusion visible |
| [3](Lecture_3_Simplify_Codebase_&_Knowledge_Base/03_Agent_Asks_Dumb_Questions.md) | Agent asks dumb questions: a fresh agent as a test reader |
| [4](Lecture_3_Simplify_Codebase_&_Knowledge_Base/04_Ask_Why.md) | Ask why: treat the answer as a hypothesis and verify it |
| [5](Lecture_3_Simplify_Codebase_&_Knowledge_Base/05_Knowledge_As_Files_For_Agents.md) | Knowledge as files, built for agents: raw sources, an agent-written wiki, thinking rounds |
| [6](Lecture_3_Simplify_Codebase_&_Knowledge_Base/06_Beyond_Markdown_mdx_svx.md) | Beyond Markdown: mdx and svx |
| [7](Lecture_3_Simplify_Codebase_&_Knowledge_Base/07_Explainer_Skill.md) | The explainer skill: a skill as an example, and an idea for ADRs |
| [8](Lecture_3_Simplify_Codebase_&_Knowledge_Base/08_Decision_Models_Search_And_Memory.md) | Decision models: pointing the agent where to look, and near and far memory |
| [9](Lecture_3_Simplify_Codebase_&_Knowledge_Base/09_Jevgrep.md) | Jevgrep: the numbers read closely, and a test plan |
| [10](Lecture_3_Simplify_Codebase_&_Knowledge_Base/10_Demos_Reaching_The_Right_Files.md) | Demos: reaching the right files and notes (a map, links and a picker) |
| [11](Lecture_3_Simplify_Codebase_&_Knowledge_Base/11_Knowledge_Base_Problems_And_Known_Techniques.md) | Knowledge base problems and known techniques, filtered for agents |
| [12](Lecture_3_Simplify_Codebase_&_Knowledge_Base/12_Knowledge_Event_&_Triggers.md) | Update triggers: schedules and events, and how to keep them safe |
| [13](Lecture_3_Simplify_Codebase_&_Knowledge_Base/13_Knowledge_Skill_Anatomy.md) | How the knowledge skill is built, and what to copy |
| [14](Lecture_3_Simplify_Codebase_&_Knowledge_Base/14_Broader_Context_Task_Board.md) | Broader context: a task board next to `AGENTS.md` |

### Lecture 4: Working with AI harnesses

Folder: [Lecture_4_Harness](Lecture_4_Harness/)

| Note | Topic |
|---|---|
| [1](Lecture_4_Harness/01_Harness_Lock-in_Keep_Doors_Open.md) | Harness lock-in: treat the harness as a replaceable middle layer, keep substance in the repo |
| [2](Lecture_4_Harness/02_Agent_Runner_Portability.md) | Agent runner portability: plugin architecture, adapter boundaries, runner contracts, six evaluation questions |
| [3](Lecture_4_Harness/03_Skill_And_Folder_Orchestration.md) | Skill and folder orchestration: organizing skills by harness, scope and origin (fleet + limen patterns) |
| [4](Lecture_4_Harness/04_Computers_md_Fleet_Infrastructure.md) | COMPUTERS.md: machine registry, provisioning runbook, fleet infrastructure as data. Path to A2A service discovery |
| [5](Lecture_4_Harness/05_Dont_Overspecify_Work_At_Assistants_Level.md) | Don't overspecify: the stack is Code → LLMs → Harnesses → Assistants. Work at the top, keep lower layers thin |
| [6](Lecture_4_Harness/06_Self_Management_Pi_Herdr.md) | Self-management: Pi and Herdr, self-configuring agents, spawning workers that survive a closed terminal (draft) |
| [7](Lecture_4_Harness/07_Multi_Agent_Coordination.md) | Multi-agent coordination: coordinator, workers, supervisor, files as messages, worktrees, vision and styleguide, the job lifecycle as a state machine, where the lifecycle hooks attach (draft) |
| [8](Lecture_4_Harness/08_Settings_Model_Routing_Cost.md) | Settings: model routing, reasoning effort, cost per task, deterministic privacy boundary (draft) |
| [9](Lecture_4_Harness/09_Teamwork_Knowledge_Base_Tool_Stack.md) | Teamwork: internal knowledge base, AI-friendly tool stack, sharing skills (draft) |
| [10](Lecture_4_Harness/10_Automation_Repository_Agents.md) | Automation: repository agents, PR review, issue to PR, doc updates, trigger → agent → human loop (draft) |
| [11](Lecture_4_Harness/11_Cloud_Coding_Agents.md) | Cloud coding agents vs agent hosting platforms: comparison table, vendor docs, self-hosted options, Aras caveat, open questions to return to |
| [12](Lecture_4_Harness/12_Context_Language_Models.md) | Context language models: the model edits its own context file. What the paper shows, wins and non-wins, what it does not test, how it differs from Mixture-of-Experts and other model types, weights, license and serving (checked against the PDF) |
| [13](Lecture_4_Harness/13_Herdr_vs_Orca_Agent_Orchestration.md) | Herdr vs Orca: terminal multiplexer vs worktree orchestrator, real Herdr commands checked, comparison table, where each fits (first pass) |
| [14](Lecture_4_Harness/14_What_Agent_Fleets_Need_Beyond_Spawning.md) | What an agent fleet needs beyond spawning workers: the lecture's 11 requirements as a checklist, coverage in my notes, gaps, test questions for my platform (first pass) |
| [15](Lecture_4_Harness/15_Pi_Limen_Behind_The_Scenes.md) | Behind the scenes of the limen setup: what Pi's hooks do, what limen's files, supervisor and Herdr do, the real job-record layout, a sequence diagram, and corrections to my earlier notes (first pass) |

### Example skills I keep (not enabled)

These are pinned, verbatim copies of other people's skills, kept as examples of good structure. Claude Code loads project skills from `.claude/skills/`, so these folders are **not loaded**. Each has a `SOURCE.md` with the repository, commit, version and license. Read the code before you enable or run anything.

| Folder | What it is |
|---|---|
| [.claude/explainer/](.claude/explainer/SOURCE.md) | The `explainer` skill: Markdown with data blocks to an interactive HTML page |
| [.claude/knowledge/](.claude/knowledge/SOURCE.md) | The `knowledge` skill: designs a knowledge base and leaves it a skill of its own |

## Repository rules

The rules for working in this repo are in [AGENTS.md](AGENTS.md). [CLAUDE.md](CLAUDE.md) only imports it. The main ones:

- Check what already exists before writing. Extend or link, do not duplicate.
- Fact-check the lecturer. Fix outdated facts in the body and everywhere they repeat.
- Diagrams are Mermaid only.
- **Content scope:** the notes hold how I think, analyze and struggle. They never hold Aras business secrets, customer data, PII, credentials or other Restricted Data. Examples are abstracted. Internal tools go through the [AI Solutions Catalog](http://aitools.aras.com/).
- Never read or print `.env`, `github.pat` or `configuration.txt`.
- Do not commit unless asked. One branch per lecture.
- These notes are drafted with AI assistance (Claude Code). When you share one outside this repository, add: "Prepared with AI assistance; reviewed and validated by [Name]."

## References I check against

Each note lists its own sources. These are the main ones I rely on, grouped by kind. I prefer the ones at the top.

### Vendor and project documentation

- Claude Code docs: [best practices](https://code.claude.com/docs/en/best-practices), [memory](https://code.claude.com/docs/en/memory), [subagents](https://code.claude.com/docs/en/sub-agents), [scheduled tasks](https://code.claude.com/docs/en/routines)
- Anthropic engineering: [Effective harnesses for long-running agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents), [Claude Code best practices](https://www.anthropic.com/research/claude-code-best-practices)
- GitHub: [webhook events and payloads](https://docs.github.com/en/webhooks/webhook-events-and-payloads)
- Letta (MemGPT): [memory tiers](https://docs.letta.com/letta_memgpt)
- Cline: [Memory Bank](https://docs.cline.bot/best-practices/memory-bank) (a community pattern)

### Specifications and formats

- [Agent Skills specification](https://agentskills.io/specification)
- [AGENTS.md](https://agents.md/)
- [Open Knowledge Format (OKF) v0.2](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/main/okf/SPEC.md)
- [MDX](https://mdxjs.com/docs/what-is-mdx/) and [mdsvex](https://mdsvex.pngwn.io/docs)
- [MADR](https://adr.github.io/madr/) (Markdown architectural decision records)

### Papers

- [Evaluating AGENTS.md: are repository-level context files helpful for coding agents? (arXiv 2602.11988)](https://arxiv.org/abs/2602.11988)
- [Language models don't always say what they think (arXiv 2305.04388)](https://arxiv.org/abs/2305.04388)
- [Towards understanding sycophancy in language models (arXiv 2310.13548)](https://arxiv.org/abs/2310.13548)
- [Reasoning models don't always say what they think (Anthropic)](https://www.anthropic.com/research/reasoning-models-dont-say-think)
- [Psychological safety and learning behavior in work teams (Edmondson, 1999)](https://web.mit.edu/curhan/www/docs/Articles/15341_Readings/Group_Performance/Edmondson%20Psychological%20safety.pdf)

### Course material and examples

- [MEGA-DOT-DEV/examples](https://github.com/MEGA-DOT-DEV/examples): the course examples I read (`file-picker`, `unreached-notes`, `cleanup-routine-drift`, `knowledge-health-check`) and my fork [Glareone/mega-dev-examples](https://github.com/Glareone/mega-dev-examples)
- [overment/skills](https://github.com/overment/skills): the author's skills (`explainer`, `knowledge`, `skill-shaper`)
- [dzhng/jevgrep](https://github.com/dzhng/jevgrep) and [Karpathy's llm-wiki gist](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)

### Methods and practice (lower trust, often secondary)

- [Diátaxis](https://diataxis.fr/), [Evergreen notes](https://notes.andymatuschak.org/z5E5QawiXCMbtNtupvxeoEX), [KCS v6 Practices Guide](https://library.serviceinnovation.org/KCS/KCS_v6/KCS_v6_Practices_Guide)
- [Cognition: SWE-grep](https://cognition.com/blog/swe-grep)
- Blogs and write-ups are used only to find a topic. The note that uses them marks them as lower trust.

### Lectures 1 and 2

Their sources are listed at the bottom of each note. They lean on the Model Context Protocol site, the Claude and OpenAI developer docs, the OWASP GenAI project, Simon Willison on prompt injection, and the Claude Code docs.
