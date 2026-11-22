# MEMORY — S02E02 Building an Agent

Navigation and restore index for this lecture. It holds pointers and the backlog, not lecture content. The state of the work (done, gaps, corrections) is in [CHANGELOG.md](CHANGELOG.md), section "Week 2 Lecture 2".

## How to restore a session

1. Read this file, then the "Week 2 Lecture 2" section of CHANGELOG.md.
2. Read [AGENTS.md](AGENTS.md) and `.claude/rules/note-format.md` (the rule's path glob does not match Week 2 folders, so I apply it by hand).
3. Open the notes in `Week2_Lecture_2_Building_an_Agent/` (table below). Note 01 shows the house style for this lecture.
4. The two source files are kept outside the repo and are not in git: the article `s02e02-building-an-agent.md` (written lesson, 15 figures on hq.mega.dev) and the audio transcript `s02e02-transcript.md` (one block, about 20 minutes). Ask me to provide them again before turning a backlog item into a note.
5. Branch `week2-lecture2`. Check `git status` and `git log` first, since I commit myself.

## Notes written (01 to 08)

| # | File | The answer in one line |
|---|---|---|
| 01 | `01_LLM_vs_Classification.md` | Trained classifiers against LLM-based steps: how each is used and supported, scenarios (volume, latency, hosted, tenant categories), cascade |
| 02 | `02_ClassificationModel_vs_DecisionModel.md` | A decision model is a typed-answer contract, not an architecture (Decision-1 and Kev decoders, Laya encoder, Jev unknown) |
| 03 | `03_Classification_Options_Market.md` | Options by how much I own, what each returns per class, Azure Language retirements 2029-03-31 |
| 04 | `04_Jev_And_Microsoft_Decision_1.md` | Reference card for trying Jev and Decision-1, calibration findings |
| 05 | `05_Support_Chat_In_Production.md` | How Lex, Rasa, Dialogflow CX, Azure CLU and Zendesk route a message, where to start |
| 06 | `06_Workflow_vs_LangGraph.md` | Guardrail, workflow and durable told apart, nine frameworks compared |
| 07 | `07_Workflows_On_The_Fly_And_Todo_Lists.md` | Plan as data against runtime structure, the resume cost, a fixed executor |
| 08 | `08_Mastra_Workflow_Mapped_To_LangGraph.md` | The lecture's exchange flow in Mastra and LangGraph, what reruns on resume |

## Backlog: what the lecture has that no note covers yet

Article (sections in order):

| # | Section | Core idea | Figures | Link to, when written |
|---|---|---|---|---|
| A1 | Intro | Why build an agent when Claude or Devin exist: a tenant's own harness cannot use platform-wide insights | 1 | A2 |
| A2 | Architecture | 13 design questions (autonomy, UI, profiles, capabilities, memory, self-evolve, cache 99%, security). Chosen path: self-evolving, primitive-based, durable agent. Scratch, framework (Mastra, Cloudflare Agents SDK) or open harness (Pi, Goose) | 2 | W2L1 17, 19 |
| A3 | Core features | Shape the environment (interface, rules, limits) instead of features. Photo-filter example, then tools, panels, workflows. Ambient knowledge-base agent with no UI | 3, 4, 5 | W2L1 23 |
| A4 | Primitives | Event, Schedule, Document, Skill, Journal (append-only), Channel (only way to the user). Filesystem against database | 6 | W2L1 26, 12 |
| A5 | Providers and configuration | Gateway plus adapters, multi-model, OpenRouter, Bedrock, Azure, Arena "Max" router, primary and secondary routing, Chat Completions to Responses | 7, 8 | W2L1 21, note 01 cascade |
| A6 | Designing tools | False-positive 200 (music player), Stripe price change chain, four native tools (core.exec, web.search, web.fetch, channel.send), read-only workspace, guide as documents and skills, "dreaming" | 9 to 12 | W2L1 25, 07, 08 |
| A7 | Context management | Cache-friendly stack, mid-turn developer message with only what changed, tool hooks, scheduled user message | 13 | W2L1 24, 06, 20 |
| A8 | Workflows and long-horizon (rest) | Events as activity signals, journal and documents as memory between runs, reflection sets the next wake-up, queues or versioning for parallel updates, pi-durable, pi-until | 14, 15 | W2L1 10 to 15; notes 06 to 08 cover only the engines |
| A9 | Takeaways and links | Custom harness or extensions, Lee Robinson's always-on agents lecture, MCP Apps, generative UI | none | A2 |

Transcript (exchange agent, partly covered by notes 01 and 06 to 08):

| # | Topic | State |
|---|---|---|
| T1 | Policy enforced in code, customer identity from the session so the model cannot choose whose order | Mentioned in 01 only |
| T2 | Inventory tool with filters returning real product IDs, quote computed in code | Not covered |
| T3 | Structured output with a Zod schema for the UI (status, message, amounts, exchange ID or null, field descriptions) | Not covered |
| T4 | Validating the decision answer before branching, threshold 0.8 arbitrary | In 01 and 02 |
| T5 | Retry limits inside tools (2 retries, 10 s timeout) not counted in the agent's 5-step limit | Not covered; idempotency is in 08 |
| T6 | Test set built around the distinctions the agent must make | In 01 (test set), link W2L1 16 |
| T7 | Next chapter: service connections behind MCP | Not covered |

Ideas raised in the session, not yet written:
- A two-step pattern for tenant-defined categories: a generative LLM proposes categories, a fast model classifies.
- The handoff payload for a support chat (what a person needs).
- A guardrails note: content safety at the entry and prompt protection inside the harness, including whether tool results need the same check.
- A plan to try Jev and Decision-1 on a synthetic labeled set. No call has been run. Any install or model call needs my explicit yes first (AGENTS.md).
- Fine-tuning a small LLM later for tenant categories; per-request categories as data in the call.

## Fact-check backlog

Resolved: the decision model is Jev (TypeSafe), the engine is Mastra, "System 1" is the System One API class.

Still unchecked from the lecture: "99% cache hit rate is critical" and mid-turn developer messages keeping the cache; Chat Completions to Responses limits models and features; OpenRouter loses provider-native features; Arena "Max" router; the Cloudflare Agents SDK link target; Pi, Goose, pi-durable, pi-until claims; Lee Robinson's lecture; the false-success example repo.

Unverified items inside the written notes are listed in the CHANGELOG gaps.

## Reference setup candidates

Added to the root README table "Tools the lecturer names (S02E02)": Jev, Microsoft-Decision-1, Mastra (links note 06). Still "Not yet covered": OpenRouter, Amazon Bedrock, Azure AI Foundry, pi-durable, pi-until. Not yet in the table: Cloudflare Agents SDK, Pi, Goose, Arena Max, MCP Apps.

## Working agreement

The working rules (no upfront drafts, distilled notes titled by the finding, production focus, primary-source checks, Week 2 shape, no local paths or names, no commits unless asked) are in [AGENTS.md](AGENTS.md).
