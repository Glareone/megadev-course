# MEMORY — S02E02 Building an Agent

Navigation index only. No lecture content is copied here. Work folder: `Week2_Lecture_2_Building_an_Agent/` (notes 01 to 07 written, the rest is built live during the lecture; state in CHANGELOG.md).

## Sources

| Source | File (kept outside the repo) | What it is |
|---|---|---|
| Article | `s02e02-building-an-agent.md` | Written lesson, 15 figures (hq.mega.dev links), sections below |
| Audio transcript | `s02e02-transcript.md` | One block, about 20 min, different topic from the article (see Transcript) |

## Article map (section → what it answers)

| Section | Core idea | Figures |
|---|---|---|
| Intro | Why build an agent when Claude / Devin exist: the user's harness cannot use platform-wide insights, so the platform needs its own harness | 1 |
| Architecture | 13 design questions (autonomy, UI, profiles, capabilities, memory, self-evolve, cache 99%, security...). Chosen path: self-evolving, primitive-based, durable agent. Build from scratch, framework (Mastra, Cloudflare Agents SDK) or open harness (Pi, Goose) | 2 |
| Core features | We stop designing features and shape the environment (interface, rules, limits). Example: photo-editing filters, then whole tools / panels / workflows. Ambient knowledge-base agent with no UI | 3, 4, 5 |
| Primitives | Six: Event, Schedule, Document, Skill, Journal (append-only), Channel (only way to the user). Combined, they give behavior not designed upfront | 6 |
| Providers and configuration | Gateway + provider adapters, multi-model, primary / secondary routing, OpenRouter, Bedrock, Azure, Arena "Max" router, Chat Completions to Responses migration | 7, 8 |
| Designing tools | Do not trust raw APIs: false-positive 200 (music player), required action chains (Stripe price change). Four native tools: core.exec, web.search, web.fetch, channel.send. Harness-only: journal.append, events.add. Read-only vs read-write workspace. Guide = Documents + Skills ("augmented tools") | 9, 10, 11, 12 |
| Context management | Cache-friendly stack: system prompt (role, capabilities, agent-editable notes), tools (exec / search / fetch), initial developer message, scheduled user message, mid-turn developer message with only what changed, tool hooks | 13 |
| Workflows and long-horizon | Events as activity signals, Journal + Documents as memory between runs, reflection sets next wake-up. Parallel updates need queues or versioning. pi-durable, pi-until | 15, 14 |
| Takeaways | Custom harness or extensions for specialization; the experience outlives the agent | none |

## Transcript map (audio lecture, retail exchange agent)

Worked example, not the article's agent. Same pattern as the S02E01 retail demo.

1. Exchange policy enforced in code (30 days, no final sale, quantity not already exchanged); customer identity comes from the session, never from the model.
2. Inventory tool with size / color filters, returns real product IDs. Quote computed in code ("anything you can do in code, you should").
3. Decision model for issue classification: choice (fit / defect / unclear), score (frustration 0..N), yes/no probability. Returns probabilities + confidence. Validate the answer, then branch in code. Threshold 0.8 is arbitrary, tune with evals. Defect goes to a human.
4. Structured output via Zod schema for the UI (status, message, amounts, exchange ID or null).
5. Workflow with suspend / resume: assess, propose, wait for the customer, confirm or decline. Progress saved in DB and linked to the conversation.
6. Idempotency: the request ID ties retries together; saved receipt returned on a repeat. Retry limits inside the tool (2 retries, 10 s timeout) do not count toward the agent's step limit (5).
7. Next chapter: move service connections behind MCP.

Transcription oddities to resolve before presenting: the decision model is called "JEFF" / "JEV", the vendor "System 1", the workflow engine "Maestro" (the API shape, create_step / suspend / resume_data, looks like Mastra). Names are unverified.

## Links to Week 2 Lecture 1 notes (extend, do not duplicate)

| Topic here | Existing note |
|---|---|
| Step limits, retries, recovery | `Week2_Lecture_1_Agent_Primitives/03_Agent_Loop_Stop_Limits_Recovery.md` |
| Approval, durable waits (suspend / resume) | `04_HITL_And_Execution_Isolation.md`, `14_Tool_Approval_Durable_Waits.md` |
| Memory, journal, audit ledger | `10_Memory.md` to `13_Memory_Operations.md` |
| Evals before changing an agent | `16_Evals_For_Agent_Changes.md` |
| Framework vs scratch vs open harness | `17_Extend_Adjust_Or_Leave_The_Framework.md`, `19_Pi_LangGraph_DeepSeek_Harnesses.md` |
| Harness, hooks, self-configuring | `18_Harness_Around_The_Loop.md`, `20_Loop_Hooks_Declared.md`, `23_Self_Configuring_Harness.md` |
| Cache hit rate, mid-turn context | `24_KV_Cache_And_Prompt_Caching.md`, `07_Context_Tool_Awareness_Avoids_Compression.md` |
| Code mode / tool execution | `25_Tool_Execution_Instead_Of_Tool_Calls.md` |
| Packages primitive | `26_Packages.md` |

## Claims to fact-check (mandatory, none checked yet)

- "99% cache hit rate is critical", mid-turn developer message keeps the cache valid.
- Stripe cannot modify an existing price (create new, deactivate old).
- Chat Completions to Responses migration limits access to models / features.
- OpenRouter loses provider-native features. Arena "Max" router exists as described.
- Cloudflare "Agents SDK" link target, Mastra, Pi, Goose, pi-durable, pi-until repo claims.
- Lee Robinson Stanford CS146S "How always-on agents work".
- "A decision model from TypeSafe" (vendor name unverified).
- False-success example repo (MEGA-DOT-DEV/examples, false-success-tool).

## Reference setup candidates (add to README "lecturer's reference setup" when confirmed)

Mastra, Cloudflare Agents SDK, Pi, Goose, OpenRouter, Amazon Bedrock, Azure AI Foundry, Arena Max, pi-durable, pi-until, MCP Apps. Source lecture: S02E02.

## Working agreement for this lecture

- No upfront drafts. I navigate during the lecture and audio; notes are written step by step.
- Follow the six-step way of thinking in AGENTS.md; wait for my input before the final file.
- Week 2 note shape: Glossary first, `.claude/rules/note-format.md` by hand (glob does not match Week 2 folders).
- Numbering style in this week: `NN_Title.md`.
- Progress goes to CHANGELOG.md only.
