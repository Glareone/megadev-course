# Week 2, Lecture 1 — Agent primitives

Source: S02E01 article (primary), S02E01 transcript (a retail-agent demo, used only as a worked example), web research. Every note opens with a Glossary, stays within 150 lines and links to its sources.

## Where to look for what

| If I want to know | Go to |
|---|---|
| What ends a run, how a loop is capped, how it recovers | [01](01_Agent_Loop_Stop_Limits_Recovery.md) |
| What a harness draws around the loop: callers, hooks, limits | [10](draft_10_Harness_Around_The_Loop.md) |
| How Pi, LangGraph and the DeepSeek paper differ | [11](draft_11_Pi_LangGraph_DeepSeek_Harnesses.md) |
| Which hooks a loop declares and what each may change | [12](draft_12_Loop_Hooks_Declared.md) |
| Whether the AI SDK can replace my adapters and official SDKs | [13](draft_13_AI_SDK_Or_Official_SDKs.md) |
| Whether to add a tool, adjust a harness or leave a framework | [09](draft_09_Extend_Adjust_Or_Leave_The_Framework.md) |
| What a harness stores and how users are separated | [02](draft_02_Threads_Persistence_Isolation.md) |
| What belongs in instructions and what code must enforce | [03](03_Instructions_Five_Parts_And_Enforcement.md) |
| How to keep context small, cacheable and not lossy | [04](draft_04_Context_Window_Cache_Compaction.md) |
| Why memory is hard and what exists | [05](draft_05_Agentic_Memory_Extraction_Retrieval.md) |
| How an agent knows its tools and chains them cheaply | [06](draft_06_Tools_Awareness_Discovery_Code_Mode.md) |
| How a run waits days for approval and resumes | [07](draft_07_Tool_Approval_Durable_Waits.md) |
| How to find a wrong answer's source and check a change | [08](draft_08_Evals_And_Traces_For_Agent_Changes.md) |

## Files

| # | File | Topic |
|---|---|---|
| 01 | [Agent loop](01_Agent_Loop_Stop_Limits_Recovery.md) | The routing function behind the stop condition, step limits across runtimes, budget and deadline, three recovery layers, retry only what is idempotent. |
| 02 | [Threads, persistence, isolation](draft_02_Threads_Persistence_Isolation.md) | Threads, sessions and subagent threads, what a harness persists, who may touch it, per-user workspaces and sandbox coverage. |
| 03 | [Instructions](03_Instructions_Five_Parts_And_Enforcement.md) | The five prompt parts, my tagged-chapter layout, boundaries as requests versus rules in code, start simple and iterate with evals. |
| 04 | [Context window, cache, compaction](draft_04_Context_Window_Cache_Compaction.md) | Stable prefix and prompt cache, tools loaded on demand, compaction, skill re-injection, why a long AGENTS.md hurts. |
| 05 | [Agentic memory](draft_05_Agentic_Memory_Extraction_Retrieval.md) | Structure, extraction, retrieval, context; contradiction, duplication, ambiguity; retention window versus memory; existing projects. |
| 06 | [Tools: awareness, discovery, code mode](draft_06_Tools_Awareness_Discovery_Code_Mode.md) | Capability maps, search tool versus files, function calling versus code mode, large results to files, a gateway at scale. |
| 07 | [Tool approval and durable waits](draft_07_Tool_Approval_Durable_Waits.md) | Approval as a harness duty, persisted run state, resume after days, LangGraph `interrupt`, permission grants. |
| 08 | [Evals and traces](draft_08_Evals_And_Traces_For_Agent_Changes.md) | Traces, the debugging rule, step-limit tuning, behaviour evals, self-revision cases, tool comparison. |
| 09 | [Extend, adjust or leave the framework](draft_09_Extend_Adjust_Or_Leave_The_Framework.md) | Three moves from cheapest to costliest, a decision flow, what I must understand before choosing. |
| 10 | [The harness around the loop](draft_10_Harness_Around_The_Loop.md) | The lecture's harness figure: four caller forms, six hook points, the limits frame, history, memory, observability. |
| 11 | [Pi, LangGraph and the DeepSeek paper](draft_11_Pi_LangGraph_DeepSeek_Harnesses.md) | Who owns the loop in each, extension points, state and resume, and why the DeepSeek paper is a composability paper. |
| 12 | [Loop hooks declared](draft_12_Loop_Hooks_Declared.md) | The lecture's three illustrative hooks against Pi's real callbacks, the same points in Claude Code and LangChain middleware, fail-open versus fail-closed. |
| 13 | [AI SDK or official SDKs](draft_13_AI_SDK_Or_Official_SDKs.md) | What the Vercel AI SDK gives (providers, loop, middleware, telemetry), what leaks through the abstraction, whether a layer really goes, a parity check before migrating. |

## Images

| File | Used in |
|---|---|
| [agent-loop-state-model-tools-hooks.png](img/agent-loop-state-model-tools-hooks.png) | 01 |
| [agent-harness-loop-hooks-limits.png](img/agent-harness-loop-hooks-limits.png) | 10 |
| [agent-logic-to-harness-or-tools.png](img/agent-logic-to-harness-or-tools.png) | 09 |
| [naive-loop-with-hooks-code.png](img/naive-loop-with-hooks-code.png) | 12 |
| [threads-sessions-subagent-thread.png](img/threads-sessions-subagent-thread.png) | 02 |

Personal review reminders live in [notes_for_later_use](../notes_for_later_use/). The form of every note is set by [.claude/rules/note-format.md](../.claude/rules/note-format.md). State of the work: [CHANGELOG.md](../CHANGELOG.md).
