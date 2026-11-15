# Week 2, Lecture 1 — Agent primitives

Source: S02E01 article (primary), S02E01 transcript (a retail-agent demo, used only as a worked example), web research. Every note opens with a Glossary, stays within 150 lines and links to its sources.

## Where to look for what

| If I want to know | Go to |
|---|---|
| What current vendor system prompts look like and what an unattended agent needs in its prompt | [01](01_Advanced_Prompt_Techniques.md) |
| How to write and trim skills and AGENTS.md for newer models | [02](02_Rethinking_The_Skills.md) |
| What ends a run, how a loop is capped, how it recovers | [03](03_Agent_Loop_Stop_Limits_Recovery.md) |
| What a harness draws around the loop: callers, hooks, limits | [14](14_Harness_Around_The_Loop.md) |
| How Pi, LangGraph and the DeepSeek paper differ | [15](15_Pi_LangGraph_DeepSeek_Harnesses.md) |
| Which hooks a loop declares and what each may change | [16](16_Loop_Hooks_Declared.md) |
| Whether the AI SDK can replace my adapters and official SDKs | [17](17_AI_SDK_Or_Official_SDKs.md) |
| Whether an audit ledger belongs in graph state or in memory | [10](10_Memory_Audit_Ledger_In_Memory_Or_State.md) |
| What a self-configuring harness can change and what guards it | [19](19_Self_Configuring_Harness.md) |
| Whether to add a tool, adjust a harness or leave a framework | [13](draft_13_Extend_Adjust_Or_Leave_The_Framework.md) |
| What a harness stores and how users are separated | [04](04_HITL_And_Execution_Isolation.md) |
| Threads, sessions, and subagent in-process versus over A2A | [18](18_Threads_Vs_A2A_Subagents.md) |
| What belongs in instructions and what code must enforce | [05](05_Instructions_Five_Parts_And_Enforcement.md) |
| How to keep context small and not lossy: window, compaction, what survives | [06](06_Context_Window_And_Compaction.md) |
| What the KV and prompt cache is, which attributes control it, what to cache | [20](20_KV_Cache_And_Prompt_Caching.md) |
| How to organize memory: relations, placement, search, immutable and append-only pieces | [08](08_Memory.md) |
| Memory known problems and how to count and beat them | [09](09_Memory_Known_Problems.md) |
| How an agent knows its tools and finds them at scale | [07](draft_07_Context_Tool_Awareness_Avoids_Compression.md) |
| Running tools from a script, and keeping large results in memory | [21](21_Tool_Execution_Instead_Of_Tool_Calls.md) |
| How a run waits days for approval and resumes | [11](draft_11_Tool_Approval_Durable_Waits.md) |
| How to find a wrong answer's source and check a change | [12](draft_12_Evals_And_Traces_For_Agent_Changes.md) |

## Files

| # | File | Topic |
|---|---|---|
| 01 | [Advanced prompt techniques](01_Advanced_Prompt_Techniques.md) | The lecture's direct-work-versus-unattended table, Anthropic's published prompt sections, what the extracted Codex and Opus prompts show (provenance unverified), what Anthropic and OpenAI recommend, how it maps to the five parts. |
| 02 | [Rethinking the skills](02_Rethinking_The_Skills.md) | OpenAI's ten recommendations for skills and AGENTS.md on newer models, the limits behind them in the Agent Skills spec, Claude Code and Codex, bad and good examples, a skill review list. |
| 03 | [Agent loop](03_Agent_Loop_Stop_Limits_Recovery.md) | The routing function behind the stop condition, step limits across runtimes, budget and deadline, three recovery layers, retry only what is idempotent. |
| 04 | [HITL and execution isolation](04_HITL_And_Execution_Isolation.md) | Where threads are stored, what else a harness persists, who may read, write or grant each kind, access checks inside tools, per-user workspaces and sandbox coverage. |
| 05 | [Instructions](05_Instructions_Five_Parts_And_Enforcement.md) | The five prompt parts, my tagged-chapter layout, boundaries as requests versus rules in code, start simple and iterate with evals. |
| 06 | [Context window and compaction](06_Context_Window_And_Compaction.md) | Window and compaction, tools and results kept out of the thread, what survives compaction in Claude Code, skill re-injection, why a long AGENTS.md hurts. |
| 07 | [Context: tool awareness avoids compression](draft_07_Context_Tool_Awareness_Avoids_Compression.md)(draft_07_Context_Tool_Awareness_Avoids_Compression.md) | Capability lists, native versus deferred tools, search tool versus files and bash, agent-written integrations and MCP, a gateway at scale, per-user workspaces. |
| 08 | [Memory](08_Memory.md) | The lecture's memory figures, a comparison of Mem0 OSS, supermemory and Hindsight, five principles (relations, placement, search, readable pieces, immutable and append-only) against Zep, Hindsight, Mem0, Claude Code, the Anthropic memory tool, LangMem and Redis BM25, extraction choices, review questions for my flat RediSearch store. |
| 09 | [Memory known problems](09_Memory_Known_Problems.md) | Contradiction, duplication and ambiguity, the lecturer's memory-extraction example (three modes over six dated chats and its counters), how I beat each with replace-by-key, identity from the session and a hold state, what the example leaves open. |
| 10 | [Audit ledger: state or memory](10_Memory_Audit_Ledger_In_Memory_Or_State.md) | My Ledger idea checked against the LangGraph docs: state against Store, what a state channel does not guarantee, write-ahead entries, ten review questions for the implementation, an external append-only sink. |
| 11 | [Tool approval and durable waits](draft_11_Tool_Approval_Durable_Waits.md) | Approval as a harness duty, persisted run state, resume after days, LangGraph `interrupt`, permission grants. |
| 12 | [Evals and traces](draft_12_Evals_And_Traces_For_Agent_Changes.md) | Traces, the debugging rule, step-limit tuning, behaviour evals, self-revision cases, tool comparison. |
| 13 | [Extend, adjust or leave the framework](draft_13_Extend_Adjust_Or_Leave_The_Framework.md) | Three moves from cheapest to costliest, a decision flow, what I must understand before choosing. |
| 14 | [The harness around the loop](14_Harness_Around_The_Loop.md) | The lecture's harness figure: four caller forms, six hook points, the limits frame, history, memory, observability. |
| 15 | [Pi, LangGraph and the DeepSeek paper](15_Pi_LangGraph_DeepSeek_Harnesses.md) | Who owns the loop in each, extension points, state and resume, and why the DeepSeek paper is a composability paper. |
| 16 | [Loop hooks declared](16_Loop_Hooks_Declared.md) | The lecture's three illustrative hooks against Pi's real callbacks, the same points in Claude Code and LangChain middleware, fail-open versus fail-closed. |
| 17 | [AI SDK or official SDKs](17_AI_SDK_Or_Official_SDKs.md) | What the Vercel AI SDK gives (providers, loop, middleware, telemetry), what leaks through the abstraction, language and framework fit (no Python SDK, LangGraph only at the UI edge, no CrewAI fit), whether a layer really goes, a parity check before migrating. |
| 18 | [Threads, subagents and A2A](18_Threads_Vs_A2A_Subagents.md) | The lecture's thread figure, in-process subagents against A2A peers, `contextId` and tasks, what the A2A spec, LangGraph, Microsoft, Claude Code, Anthropic and Cognition say, my process-per-agent choice. |
| 19 | [Self-configuring harness](19_Self_Configuring_Harness.md) | The lecture's "Configuration" part: what Claude Code, OpenCode and Pi let the agent change at runtime, what the documented guards cover, what the DeepSeek paper adds, and a change-class design with undo. |
| 20 | [KV cache and prompt caching](20_KV_Cache_And_Prompt_Caching.md) | The KV cache and prefix caching in three layers, Anthropic's `cache_control` against OpenAI's `prompt_cache_key`, options and breakpoints, what to cache and in what order, what breaks a hit, cost arithmetic, isolation. |
| 21 | [Tool execution instead of tool calls](21_Tool_Execution_Instead_Of_Tool_Calls.md) | The lecture's code mode figure, function calling against scripts, what Anthropic, OpenAI, Cloudflare, Pi and DeepSeek do, parallel calls versus scripts, large results stored and read by chunk (memory bound to context), what I would review. |

## Images

| File | Used in |
|---|---|
| [direct-work-vs-agent-without-us.png](img/direct-work-vs-agent-without-us.png) | 01 |
| [claude-behavior-system-prompt-sections.png](img/claude-behavior-system-prompt-sections.png) | 01 |
| [agentic-memory-four-parts.png](img/agentic-memory-four-parts.png) | 08 |
| [memory-profile-updated-from-thread.png](img/memory-profile-updated-from-thread.png) | 08 |
| [memory-known-problems-contradiction-duplication-ambiguity.png](img/memory-known-problems-contradiction-duplication-ambiguity.png) | 09 |
| [agent-loop-state-model-tools-hooks.png](img/agent-loop-state-model-tools-hooks.png) | 03 |
| [agent-harness-loop-hooks-limits.png](img/agent-harness-loop-hooks-limits.png) | 14 |
| [agent-logic-to-harness-or-tools.png](img/agent-logic-to-harness-or-tools.png) | 13 |
| [naive-loop-with-hooks-code.png](img/naive-loop-with-hooks-code.png) | 16 |
| [code-mode-chained-tools-final-result.png](img/code-mode-chained-tools-final-result.png) | 21 |
| [large-result-file-reference.png](img/large-result-file-reference.png) | 21 |
| [threads-sessions-subagent-thread.png](img/threads-sessions-subagent-thread.png) | 18 |
| [harness-storage-agent-artifacts-permissions.png](img/harness-storage-agent-artifacts-permissions.png) | 04 |
| [agent-configures-settings-and-ui.png](img/agent-configures-settings-and-ui.png) | 19 |

Personal review reminders live in [notes_for_later_use](../notes_for_later_use/). The form of every note is set by [.claude/rules/note-format.md](../.claude/rules/note-format.md). State of the work: [CHANGELOG.md](../CHANGELOG.md).
