# megadev-course

A personal knowledge base. It follows the order of the **MEGA.dev course** on building with AI agents, but it is not only the course. It also holds my own knowledge and experience.

**How it is organized.**
- **By lecture,** the way the course goes: one folder per lecture.
- **By topic inside each lecture:** one file per topic. A file does not retell the lecture. It follows how I get the things the lecture touches. I dive into the problem, add my own understanding and clarifications, and check the result against industry standards.
- **What it holds:** lecture notes, refined insights, challenge work and my experiments.

It is **not a codebase**. The output is Markdown with Mermaid diagrams that I re-read and present. This file is the table of contents, the list of references I check against, the reference setup the lecturer uses, and the rules every note follows.

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
| **Outdated** | It was true once. I rewrite the sentence in the note body at once, in every note that repeats it |
| **Lecture-specific** | The lecturer's opinion or method. No outside source |
| **Unverified** | I could not check it. It stays marked "verify before presenting" |

- **I keep my own reasoning apart.** Each note's Sources section says which parts are mine and not from the lecture or the sources.
- **I check examples by running them or by reading their results,** and the note says which one I did. A search summary is not a primary source, and the note says when that is all we had.

**Coverage of the checks.** The Lecture 3 and Lecture 4 notes carry full fact-check tables. The Lecture 1 and 2 notes mark their sources and my own reasoning but have no fact-check tables, so their time-sensitive claims (models, tool behavior, limits, versions) have no check date.

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
3. The sections (the exact order and minimums are in [.claude/rules/note-format.md](.claude/rules/note-format.md)): the problem, the words I pin down, the picture (its story, what is important, what is not), my view, the fact-check, cautions, summary, open questions, sources.
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
| [12](Lecture_2_Context_Agents_md_Skills_Tools/12_subagents_vs_workers.md) | Subagents versus workers, and which model and effort each helper gets (A2A peers are opaque) |

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
| [6](Lecture_4_Harness/06_Self_Management_Pi_Herdr.md) | Self-management: Pi and Herdr, self-configuring agents, spawning workers that survive a closed terminal |
| [7](Lecture_4_Harness/07_Multi_Agent_Coordination.md) | Multi-agent coordination: coordinator, workers, supervisor, files as messages, worktrees, vision and styleguide, the job lifecycle as a state machine, where the lifecycle hooks attach |
| [8](Lecture_4_Harness/08_Settings_Model_Routing_Cost.md) | Settings: model routing, reasoning effort, cost per task, deterministic privacy boundary |
| [9](Lecture_4_Harness/09_Teamwork_Knowledge_Base_Tool_Stack.md) | Teamwork: internal knowledge base, AI-friendly tool stack, sharing skills |
| [10](Lecture_4_Harness/10_Automation_Repository_Agents.md) | Automation: repository agents, PR review, issue to PR, doc updates, trigger → agent → human loop |
| [11](Lecture_4_Harness/11_Cloud_Coding_Agents.md) | Cloud coding agents vs agent hosting platforms: comparison table, vendor docs, self-hosted options, Aras caveat, open questions |
| [12](Lecture_4_Harness/12_Context_Language_Models.md) | Context language models: the model edits its own context file. What the paper shows, wins and non-wins, what it does not test, how it differs from Mixture-of-Experts and other model types, weights, license and serving (checked against the PDF) |
| [13](Lecture_4_Harness/13_Herdr_vs_Orca_Agent_Orchestration.md) | Herdr vs Orca: terminal multiplexer vs worktree orchestrator, real Herdr commands checked, comparison table, where each fits |
| [14](Lecture_4_Harness/14_What_Agent_Fleets_Need_Beyond_Spawning.md) | What an agent fleet needs beyond spawning workers: the lecture's 11 requirements as a checklist, coverage in my notes, gaps, test questions for my platform |
| [15](Lecture_4_Harness/15_Pi_Limen_Behind_The_Scenes.md) | Behind the scenes of the limen setup: what Pi's hooks do, what limen's files, supervisor and Herdr do, the real job-record layout, a sequence diagram, where the code differs from the lecture, how to try limen, and ideas worth taking from it |
| [16](Lecture_4_Harness/16_SOTA_And_Reasoning_Effort.md) | SOTA and reasoning effort as two separate dials: the 2×2 grid, what each dial changes, what Anthropic and OpenAI docs say about effort, the course effort-routing example, effort in a portable runner |
| [17](Lecture_4_Harness/17_Cost_Per_Task.md) | Cost per task instead of token price: the lecture's worked example, tasks per dollar, cost per solved task, why tokens per task differ, who publishes it, what to measure in my own runner |
| [18](Lecture_4_Harness/18_Sharing_Approved_Skills_AI_Marketplace.md) | Sharing approved skills across teams: Git, `npx skills` and Skills over MCP checked against their docs, and an AI marketplace as an approval step on top of them |

### Lecture 5: Workflows, not tool sets

| # | Topic |
|---|---|
| [01](Lecture_5_Workflows_not_tool_sets/01_Skill_Or_Agent_For_Explore_Loops.md) | Skill or agent for exploring: thread and settings are the real difference, a loop for `explore-*` agents, skill plus agent |
| [02](Lecture_5_Workflows_not_tool_sets/02_Merge_Review_Second_Pair_Of_Eyes.md) | Before the merge: a read-only reviewer agent on a fast, cheap model next to tests, PR bots and a human, a three-round revision loop, what the evidence says |
| [03](Lecture_5_Workflows_not_tool_sets/03_The_Gap_Build_Speed_Vs_Keeping_Up.md) | The gap: building speed outruns what I can keep up with. The lecture article's first figure, what does not speed up (review, testing, docs, people, agents that need me), three moves to shrink the gap |
| [04](Lecture_5_Workflows_not_tool_sets/04_Executable_Markdown_Skills_As_Programs.md) | Executable Markdown: a skill as a program. The article's five problems and four strengths, the nightly PR triage, and a design for a nightly agent that prepares tech-debt fixes with Playwright screenshots as proof |
| [05](Lecture_5_Workflows_not_tool_sets/05_Agents_Maintain_The_Tools_I_Review.md) | Agents build and maintain my tools, I review them: the system built once, a standing review checklist (still needed, simplify, merge, archive), why old rules go stale as models improve, guards for agents editing agent instructions |
| [06](Lecture_5_Workflows_not_tool_sets/06_Run_The_Fleet_On_A_Remote_Seat.md) | Running the fleet on a remote seat: the lecturer's Pi, Herdr and Limen setup on a VPS and tailnet, where Orca fits, setup split between me and the agent, a nightly timer the docs do not provide, security and Aras governance gates |
| [07](Lecture_5_Workflows_not_tool_sets/07_Herdr_Or_Orca_For_My_Fleet.md) | Herdr or Orca for my fleet: what the Orca docs add to the Lecture 4 comparison, a decision flow, a fair trial of both, the security posture of each. Links to [Lecture 4: 13](Lecture_4_Harness/13_Herdr_vs_Orca_Agent_Orchestration.md) |
| [08](Lecture_5_Workflows_not_tool_sets/08_Skills_As_Building_Blocks.md) | Skills as building blocks: skills or code, blocks then workflow skills then a prompt, Full Send and Full Stop, a skill from a real bad example, global or repo or harness, the PR comment skill, keeping the set small |
| [09](Lecture_5_Workflows_not_tool_sets/09_Local_Fleet_Lab_Sandboxes_And_Worktrees.md) | A local fleet lab: `sbx` microVM in clone mode for execution, a worktree per item for changes, four levels from Claude-only to a sandbox per worker, portable skills for Pi and Claude Code, DeepSeek workers through OpenRouter, my architecture repository as the pilot |
| [10](Lecture_5_Workflows_not_tool_sets/10_Fleet_Lab_Threat_Model.md) | Fleet lab threat model: three zones (alone, with me, never by mechanism), R1 to R9 with OWASP agentic mapping, SSH forwarding and the Balanced preset as unsafe defaults, the poisoned return path, a ten-step run gate |

### Example skills I keep (not enabled)

These are pinned, verbatim copies of other people's skills, kept as examples of good structure. Claude Code loads project skills from `.claude/skills/`, so these folders are **not loaded**. Each has a `SOURCE.md` with the repository, commit, version and license. Read the code before you enable or run anything.

| Folder | What it is |
|---|---|
| [.claude/explainer/](.claude/explainer/SOURCE.md) | The `explainer` skill: Markdown with data blocks to an interactive HTML page |
| [.claude/knowledge/](.claude/knowledge/SOURCE.md) | The `knowledge` skill: designs a knowledge base and leaves it a skill of its own |

### Example skills I wrote (not enabled)

| Folder | What it is |
|---|---|
| [.claude/review-loop/](.claude/review-loop/README.md) | A `review-loop` skill and a read-only `review-second-eyes` agent (`model: claude-sonnet-5-5` in its header): independent review before the PR, then the PR until CI and bots are green, `MAX = 3` rounds per loop, no merge. Built from [Lecture 5: 02](Lecture_5_Workflows_not_tool_sets/02_Merge_Review_Second_Pair_Of_Eyes.md). Not run yet |
| [.agents/fleet-lab/](.agents/fleet-lab/README.md) | `fleet-plan`, `fleet-run` and `fleet-worker` skills for Pi and Claude Code, a Pi runner script (a worktree per item, `xargs -P` cap), a Claude worker agent with `isolation: worktree`, and an installer that puts the skills in `.agents/skills/` with `.claude/skills/` symlinks. Built from [Lecture 5: 09](Lecture_5_Workflows_not_tool_sets/09_Local_Fleet_Lab_Sandboxes_And_Worktrees.md). Windows versions (`install.ps1`, `run-pi-workers.ps1`). Shell logic tested with a stub `pi`. No model run yet. Read [Lecture 5: 10](Lecture_5_Workflows_not_tool_sets/10_Fleet_Lab_Threat_Model.md) before any run |

## The lecturer's reference setup

The tools and workflows the lecturer names across the lectures. They show what the course aims at. They are the lecturer's choices, not my recommendations, and I have not checked each tool's fit. Each section names the lecture it comes from.

### Tool stack the MEGA team uses (S01E04)

| Category | Tools |
|---|---|
| Observability and product telemetry | [PostHog](https://posthog.com/), [Axiom](https://axiom.co/docs) |
| Build, storage and remote reach | [Vercel](https://vercel.com/), [Minio](https://www.min.io/), [Depot](https://depot.dev/), [Cloudflare](https://www.cloudflare.com/) with [Alchemy](https://alchemy.run/), [Tailscale](https://tailscale.com/), [UploadThing](https://uploadthing.com/) |
| Agent surfaces and harnesses | [Pi](https://pi.dev/), [Herdr](https://herdr.dev/), [Moshi](https://getmoshi.app/), [OpenRouter](https://openrouter.com/) |
| Typed app substrate | [XState](https://stately.ai/docs/xstate), [Effect](https://effect.website/), [oxlint](https://oxc.rs/), [mdsvex](https://svelte.dev/docs/cli/mdsvex) |
| Auth and backend | [Clerk](https://clerk.com/), [Convex](https://www.convex.dev/) |
| Work the agent can write | [Linear](https://linear.app/), [Stripe](https://stripe.com/), [Resend](https://resend.com/), [Attio](https://attio.com/) |
| Design | [Paper](https://paper.design/), [Figma](https://figma.com/) |

The lecturer says not everything on the list will be useful for everyone. It is also a source of inspiration for finding new tools and refreshing a stack. My reading of why each category matters for agents is in [Lecture 4: 09 Teamwork](Lecture_4_Harness/09_Teamwork_Knowledge_Base_Tool_Stack.md).

### Automated workflows that run in the background (S01E04)

Agents that integrate with GitHub: [Claude Code](https://code.claude.com/docs/en/github-actions), [Cursor](https://cursor.com/docs/cli/github-actions), [Devin](https://devin.ai/) and [CodeRabbit](https://www.coderabbit.ai/). They can be called in GitHub comments and pull requests, and events in the repository can trigger them. The lecturer lists these uses:

1. Keep documentation, a knowledge base, or even the entire website up to date
2. Convert an issue into a pull request enriched with the necessary context
3. Review pull requests as soon as they are created and leave a brief comment ([pr-review-rules example](https://github.com/MEGA-DOT-DEV/examples/tree/main/examples/pr-review-rules))
4. Autonomously fix small bugs and publish the changes
5. Detect issues in code and dependencies
6. Assign pull requests to the person responsible for a given feature
7. Gather data from external systems or even from people
8. Handle routine tasks such as cleaning up dead code

My notes on these uses, with triggers and the human review step, are in [Lecture 4: 10 Automation](Lecture_4_Harness/10_Automation_Repository_Agents.md).

### Repository the lecturer asks to study (S01E04)

[overment/limen](https://github.com/overment/limen) is a working coordinator, workers and supervisor setup built from plain text files, git worktrees, Pi extensions and Herdr, with a small CLI. The lecturer says that if one thing is taken from S01E04, it should be this: play with the repository, chat about it with an AI agent, and extract ideas or modify it to fit your needs. His steps to apply it:

1. Run `limen init`
2. Shape `vision.md` and `styleguide.md` together with an agent
3. Install Pi and Herdr
4. Open Pi and ask it to implement something

limen runs on macOS and Linux. My notes read the commit `01fc400`: [Lecture 4: 07 Multi-agent coordination](Lecture_4_Harness/07_Multi_Agent_Coordination.md) describes the design, and [15 Pi and limen behind the scenes](Lecture_4_Harness/15_Pi_Limen_Behind_The_Scenes.md) covers how to try it and the ideas I take from it.

### Skills and workflows the lecturer names (S01E05)

| Name | What it does | Notes |
|---|---|---|
| sol-loop | Asks a second model family to review a change, fixes, repeats up to three loops, then files a PR | [02](Lecture_5_Workflows_not_tool_sets/02_Merge_Review_Second_Pair_Of_Eyes.md#how-the-sol-loop-got-here-seven-edits) |
| File PR | Files a concise PR with a good title and description, using bad and good examples | [08](Lecture_5_Workflows_not_tool_sets/08_Skills_As_Building_Blocks.md) |
| Babysit PR, watch pull request | Keeps watching a PR until reviewers and CI are green | [08](Lecture_5_Workflows_not_tool_sets/08_Skills_As_Building_Blocks.md) |
| File upload | Shows a video in a PR without committing it to the repo | [08](Lecture_5_Workflows_not_tool_sets/08_Skills_As_Building_Blocks.md) |
| PR comment skill | Makes an agent say that it, and which model, wrote a comment | [08](Lecture_5_Workflows_not_tool_sets/08_Skills_As_Building_Blocks.md) |
| Full Send, Full Stop | Workflow skills: to a merged PR, or to a PR ready for me | [08](Lecture_5_Workflows_not_tool_sets/08_Skills_As_Building_Blocks.md) |
| Nightly PR triage | A scheduled prompt: cheap delegates audit PRs, strong delegates verify, a list of eight or fewer | [04](Lecture_5_Workflows_not_tool_sets/04_Executable_Markdown_Skills_As_Programs.md) |
| [T3 Code](https://github.com/pingdotgg/t3code) | The lecturer's GUI harness for Codex, Claude and others | [02](Lecture_5_Workflows_not_tool_sets/02_Merge_Review_Second_Pair_Of_Eyes.md#how-the-sol-loop-got-here-seven-edits) |
| [Matt Pocock's skills](https://github.com/mattpocock/skills) | Includes the grilling skill used to settle a plan with the agent | [08](Lecture_5_Workflows_not_tool_sets/08_Skills_As_Building_Blocks.md) |

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
