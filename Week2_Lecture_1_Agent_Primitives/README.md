# Week 2, Lecture 1 — Agent primitives

Source: S02E01 article (primary), S02E01 transcript (a retail-agent demo, used only as a worked example), web research. Every note opens with a Glossary, stays within 150 lines and links to its sources.

## Where to look for what

| If I want to know | Go to |
|---|---|
| What current vendor system prompts look like and what an unattended agent needs in its prompt | [01](01_Advanced_Prompt_Techniques.md) |
| How to write and trim skills and AGENTS.md for newer models | [02](02_Rethinking_The_Skills.md) |
| Tool search: names first, schemas on demand, which tools stay native | [08](08_Tool_Search_Instead_Of_Many_Tools.md) |
| A proxy gateway for many tools: registry, authorization, one door | [09](09_Tool_Search_And_Proxy_Gateway.md) |
| What ends a run, how a loop is capped, how it recovers | [03](03_Agent_Loop_Stop_Limits_Recovery.md) |
| What a harness draws around the loop: callers, hooks, limits | [18](18_Harness_Around_The_Loop.md) |
| How Pi, LangGraph and the DeepSeek paper differ | [19](19_Pi_LangGraph_DeepSeek_Harnesses.md) |
| Which hooks a loop declares and what each may change | [20](20_Loop_Hooks_Declared.md) |
| Whether the AI SDK can replace my adapters and official SDKs | [21](21_AI_SDK_Or_Official_SDKs.md) |
| Whether an audit ledger belongs in graph state or in memory | [12](12_Memory_Audit_Ledger_In_Memory_Or_State.md) |
| What a self-configuring harness can change and what guards it | [23](23_Self_Configuring_Harness.md) |
| Whether to add a tool, adjust a harness or leave a framework | [17](17_Extend_Adjust_Or_Leave_The_Framework.md) |
| What a harness stores and how users are separated | [04](04_HITL_And_Execution_Isolation.md) |
| Threads, sessions, and subagent in-process versus over A2A | [22](22_Threads_Vs_A2A_Subagents.md) |
| What belongs in instructions and what code must enforce | [05](05_Instructions_Five_Parts_And_Enforcement.md) |
| How to keep context small and not lossy: window, compaction, what survives | [06](06_Context_Window_And_Compaction.md) |
| What the KV and prompt cache is, which attributes control it, what to cache | [24](24_KV_Cache_And_Prompt_Caching.md) |
| How to organize memory: relations, placement, search, immutable and append-only pieces | [10](10_Memory.md) |
| Memory known problems and how to count and beat them | [11](11_Memory_Known_Problems.md) |
| Memory operations: search, update, insert, reflect, consolidate, maintain | [13](13_Memory_Operations.md) |
| How an agent knows its tools and finds them at scale | [07](07_Context_Tool_Awareness_Avoids_Compression.md) |
| Running tools from a script, and keeping large results in memory | [25](25_Tool_Execution_Instead_Of_Tool_Calls.md) |
| What makes an agent-made tool reusable, and what guards it needs | [26](26_Packages.md) |
| How a run waits days for approval and resumes | [14](14_Tool_Approval_Durable_Waits.md) |
| How to find a wrong answer's source and size the step limit | [15](15_Trace_A_Run_And_Size_Its_Step_Limit.md) |
| How to check a change did not break behaviour, and pick the smallest model | [16](16_Evals_For_Agent_Changes.md) |

## Files

| # | File | Topic |
|---|---|---|
| 01 | [Advanced prompt techniques](01_Advanced_Prompt_Techniques.md) | The lecture's direct-work-versus-unattended table, Anthropic's published prompt sections, what the extracted Codex and Opus prompts show (provenance unverified), what Anthropic and OpenAI recommend, how it maps to the five parts. |
| 02 | [Rethinking the skills](02_Rethinking_The_Skills.md) | OpenAI's ten recommendations for skills and AGENTS.md on newer models, the limits behind them in the Agent Skills spec, Claude Code and Codex, bad and good examples, a skill review list. |
| 03 | [Agent loop](03_Agent_Loop_Stop_Limits_Recovery.md) | The routing function behind the stop condition, step limits across runtimes, budget and deadline, three recovery layers, retry only what is idempotent. |
| 04 | [HITL and execution isolation](04_HITL_And_Execution_Isolation.md) | Where threads are stored, what else a harness persists, who may read, write or grant each kind, access checks inside tools, per-user workspaces and sandbox coverage. |
| 05 | [Instructions](05_Instructions_Five_Parts_And_Enforcement.md) | The five prompt parts, my tagged-chapter layout, boundaries as requests versus rules in code, start simple and iterate with evals. |
| 06 | [Context window and compaction](06_Context_Window_And_Compaction.md) | Window and compaction, tools and results kept out of the thread, what survives compaction in Claude Code, skill re-injection, why a long AGENTS.md hurts. |
| 07 | [Context: tool awareness avoids compression](07_Context_Tool_Awareness_Avoids_Compression.md)(07_Context_Tool_Awareness_Avoids_Compression.md) | Capability lists, native versus deferred tools, search tool versus files and bash, agent-written integrations and MCP, a gateway at scale, per-user workspaces. |
| 08 | [Tool search instead of many tools](08_Tool_Search_Instead_Of_Many_Tools.md) | The lecturer's tool-search example (keyword scoring, names only, no native tools, mock numbers), Anthropic, OpenAI and Claude Code tool search, when it pays, how to pick the native tools. |
| 09 | [Tool search and proxy gateway](09_Tool_Search_And_Proxy_Gateway.md) | The lecture's gateway figure, Uber's control plane and data plane (registry with tools off, approval of description changes, proxy that authorizes, redacts and trims) against Treg, what I take for managing many tools. |
| 10 | [Memory](10_Memory.md) | The lecture's memory figures, a comparison of Mem0 OSS, supermemory and Hindsight, five principles (relations, placement, search, readable pieces, immutable and append-only) against Zep, Hindsight, Mem0, Claude Code, the Anthropic memory tool, LangMem and Redis BM25, extraction choices, review questions for my flat RediSearch store. |
| 11 | [Memory known problems](11_Memory_Known_Problems.md) | Contradiction, duplication and ambiguity, the lecturer's memory-extraction example (three modes over six dated chats and its counters), how I beat each with replace-by-key, identity from the session and a hold state, what the example leaves open. |
| 12 | [Audit ledger: state or memory](12_Memory_Audit_Ledger_In_Memory_Or_State.md) | My Ledger idea checked against the LangGraph docs: state against Store, what a state channel does not guarantee, write-ahead entries, ten review questions for the implementation, an external append-only sink. |
| 13 | [Memory operations](13_Memory_Operations.md) | Search, update and insert against Hindsight's retain, recall and reflect with its worker, Mem0, supermemory, the Anthropic memory tool and lamarck's maintenance (gates, lifecycle, decay, budget), what reflect and mental models add, what Joel Hooks' retired pipeline shows. |
| 14 | [Tool approval and durable waits](14_Tool_Approval_Durable_Waits.md) | Approval as a harness duty, persisted run state, resume after days, LangGraph `interrupt`, permission grants. |
| 15 | [Trace a run and size its step limit](15_Trace_A_Run_And_Size_Its_Step_Limit.md) | Traces, the debugging rule, step-limit tuning against LangGraph supersteps, tracing tools. |
| 16 | [Evals for agent changes](16_Evals_For_Agent_Changes.md) | Behaviour eval cases, self-revision cases, rerun after every change, prompt-eval loop and smallest model, eval tools. |
| 17 | [Extend, adjust or leave the framework](17_Extend_Adjust_Or_Leave_The_Framework.md) | Three moves from cheapest to costliest, a decision flow, what I must understand before choosing. |
| 18 | [The harness around the loop](18_Harness_Around_The_Loop.md) | The lecture's harness figure: four caller forms, six hook points, the limits frame, history, memory, observability. |
| 19 | [Pi, LangGraph and the DeepSeek paper](19_Pi_LangGraph_DeepSeek_Harnesses.md) | Who owns the loop in each, extension points, state and resume, and why the DeepSeek paper is a composability paper. |
| 20 | [Loop hooks declared](20_Loop_Hooks_Declared.md) | The lecture's three illustrative hooks against Pi's real callbacks, the same points in Claude Code and LangChain middleware, fail-open versus fail-closed. |
| 21 | [AI SDK or official SDKs](21_AI_SDK_Or_Official_SDKs.md) | What the Vercel AI SDK gives (providers, loop, middleware, telemetry), what leaks through the abstraction, language and framework fit (no Python SDK, LangGraph only at the UI edge, no CrewAI fit), whether a layer really goes, a parity check before migrating. |
| 22 | [Threads, subagents and A2A](22_Threads_Vs_A2A_Subagents.md) | The lecture's thread figure, in-process subagents against A2A peers, `contextId` and tasks, what the A2A spec, LangGraph, Microsoft, Claude Code, Anthropic and Cognition say, my process-per-agent choice. |
| 23 | [Self-configuring harness](23_Self_Configuring_Harness.md) | The lecture's "Configuration" part: what Claude Code, OpenCode and Pi let the agent change at runtime, what the documented guards cover, what the DeepSeek paper adds, and a change-class design with undo. |
| 24 | [KV cache and prompt caching](24_KV_Cache_And_Prompt_Caching.md) | The KV cache and prefix caching in three layers, Anthropic's `cache_control` against OpenAI's `prompt_cache_key`, options and breakpoints, what to cache and in what order, what breaks a hit, cost arithmetic, isolation. |
| 25 | [Tool execution instead of tool calls](25_Tool_Execution_Instead_Of_Tool_Calls.md) | The lecture's code mode figure, function calling against scripts, what Anthropic, OpenAI, Cloudflare, Pi and DeepSeek do, parallel calls versus scripts, large results stored and read by chunk (memory bound to context), what I would review. |
| 26 | [Packages](26_Packages.md) | The lecture's package figure, Anthropic's code-execution pattern, Voyager's skill library, Agent Skills docs, and the guards a saved package needs. |

## Images

| File | Used in |
|---|---|
| [direct-work-vs-agent-without-us.png](img/direct-work-vs-agent-without-us.png) | 01 |
| [claude-behavior-system-prompt-sections.png](img/claude-behavior-system-prompt-sections.png) | 01 |
| [agentic-memory-four-parts.png](img/agentic-memory-four-parts.png) | 10 |
| [memory-profile-updated-from-thread.png](img/memory-profile-updated-from-thread.png) | 10 |
| [memory-known-problems-contradiction-duplication-ambiguity.png](img/memory-known-problems-contradiction-duplication-ambiguity.png) | 11 |
| [hindsight-three-calls-and-worker.png](img/hindsight-three-calls-and-worker.png) | 13 |
| [agent-loop-state-model-tools-hooks.png](img/agent-loop-state-model-tools-hooks.png) | 03 |
| [agent-harness-loop-hooks-limits.png](img/agent-harness-loop-hooks-limits.png) | 18 |
| [agent-logic-to-harness-or-tools.png](img/agent-logic-to-harness-or-tools.png) | 17 |
| [naive-loop-with-hooks-code.png](img/naive-loop-with-hooks-code.png) | 20 |
| [code-mode-chained-tools-final-result.png](img/code-mode-chained-tools-final-result.png) | 25 |
| [mcp-gateway-control-plane-data-plane.png](img/mcp-gateway-control-plane-data-plane.png) | 08, 09 |
| [large-result-file-reference.png](img/large-result-file-reference.png) | 25 |
| [threads-sessions-subagent-thread.png](img/threads-sessions-subagent-thread.png) | 22 |
| [harness-storage-agent-artifacts-permissions.png](img/harness-storage-agent-artifacts-permissions.png) | 04 |
| [agent-configures-settings-and-ui.png](img/agent-configures-settings-and-ui.png) | 23 |
| [agent-creates-package-reusing-capabilities.png](img/agent-creates-package-reusing-capabilities.png) | 26 |

Personal review reminders live in [notes_for_later_use](../notes_for_later_use/). The form of every note is set by [.claude/rules/note-format.md](../.claude/rules/note-format.md). State of the work: [CHANGELOG.md](../CHANGELOG.md).
