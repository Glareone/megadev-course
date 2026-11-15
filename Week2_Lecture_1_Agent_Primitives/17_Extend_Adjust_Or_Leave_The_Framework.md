# 17. Knowing the primitives turns a framework into a choice: add tools, adjust the harness, or step out of it

> When I understand the loop and the parts around it, an improvement to an agent is one of three moves (add a tool, adjust the harness at an extension point, or leave the framework's paradigm for the part it fights), and I pick the smallest move that works for that one part.

Related: [03 Agent loop, stop, limits, recovery](03_Agent_Loop_Stop_Limits_Recovery.md) · [05 Instructions](05_Instructions_Five_Parts_And_Enforcement.md) · [06 Context window and compaction](06_Context_Window_And_Compaction.md) · [07 Tools: awareness, discovery, gateway](07_Context_Tool_Awareness_Avoids_Compression.md) · [14 Tool approval and durable waits](14_Tool_Approval_Durable_Waits.md) · [15 Evals and traces](draft_15_Evals_And_Traces_For_Agent_Changes.md) · [Lecture 4: 01 Harness lock-in](../Lecture_4_Harness/01_Harness_Lock-in_Keep_Doors_Open.md) · [Lecture 4: 02 Agent runner portability](../Lecture_4_Harness/02_Agent_Runner_Portability.md) · [Lecture 2: 3 Lifecycle hooks](../Lecture_2_Context_Agents_md_Skills_Tools/3_lifecycle_hooks.md)

Source: S02E01 article, intro and figure 4 ("knowledge of agentic logic" and its four uses). LangChain, LangGraph, Pi and Anthropic documents checked on 2026-11-15, see [Fact-check](#fact-check). The three-move ladder and the decision flow are my own reasoning.

## Glossary

| Term | What it means here | Same thing elsewhere | Not to be confused with |
|---|---|---|---|
| Framework | A library that gives me agent abstractions (graphs, nodes, middleware). LangGraph, Semantic Kernel | - | A harness |
| Harness | Everything around the loop: wake, context, limits, hooks, history, memory, observability (see [03](03_Agent_Loop_Stop_Limits_Recovery.md)) | - | The loop alone |
| Agentic tool | An agent used for myself or shipped as a product feature | - | A tool the model calls |
| Extension point | A place the framework or harness lets me add behaviour without forking it (a hook, middleware, a plugin) | - | A fork or a patch |
| Paradigm | The way the framework wants control flow expressed, such as a graph of nodes | Graph of nodes in LangGraph | The model or the prompt |
| Middleware | Code wrapped around the model call, the tool call or the whole agent run | LangChain `create_agent` middleware, Semantic Kernel filters, Claude Code hooks | - |
| Extension | A module loaded into a harness to add tools and subscribe to events | Pi extensions | - |
| Functional API | LangGraph's way to write control flow as ordinary code with `entrypoint` and `task` | Graph API is the node-and-edge form | - |
| Durable execution | A run that can stop and resume from saved progress | LangGraph checkpointer, see [14](14_Tool_Approval_Durable_Waits.md) | - |

## 1. The problem

The lecture says the point of learning the primitives is that I can "either create a harness from scratch or customize a harness at any level", and build agentic tools for myself or for a product. I already run a framework. **When I want to improve an agent, or upgrade or replace that framework, which move fits, and what do I need to understand to choose well?**

## 2. What the figure says

![The lecture's figure. One box, agentic logic: patterns and options, sends four arrows. Two go into a frame named Harnesses: build from scratch (your own harness) and customize at any level (an existing harness). Two go into a frame named Agentic tools: for your own use (agents for yourself) and as product features (for clients). Caption: an agent is more than a loop; when you know the patterns of agentic logic, you can build or customize a harness, and build agentic tools for yourself or for a product.](img/agent-logic-to-harness-or-tools.png)

Source: S02E01 article, figure 4.

Important:
- One source of knowledge feeds four uses, so the same understanding serves a platform team and a product team.
- "Customize at any level" sits next to "build from scratch": the lecture treats adjusting a harness as a normal outcome, not a failure to build.

Not important: the line routing, the frame borders, the corner pattern.

## 3. Three moves, smallest first

The lecture's two harness boxes become, in my reading, three moves for an agent I already run.

| Move | What changes | In LangChain / LangGraph | Elsewhere | Cost |
|---|---|---|---|---|
| Add a tool | The agent gets a new capability. The loop is untouched | A tool, an MCP server, a skill | Same in Claude Code, Pi, Semantic Kernel plugins | Lowest |
| Adjust the harness | Behaviour at a fixed point changes: watch, change or block | Middleware hooks `before_agent`, `before_model`, `wrap_model_call`, `after_model`, `wrap_tool_call`, `after_agent` | Pi extensions subscribe to lifecycle events and register tools. Semantic Kernel filters. Claude Code hooks | Low to medium |
| Step out of the paradigm | The control flow is written another way | LangGraph Functional API (`entrypoint`, `task`), or my own loop on a provider SDK, or another harness | Pi, Deep Agents | Highest |

```mermaid
flowchart TD
    N["I want the agent to do or avoid X"] --> Q1{"Is it a capability<br/>the agent lacks?"}
    Q1 -- "yes" --> T["Move 1: add a tool,<br/>MCP server or skill"]
    Q1 -- "no" --> Q2{"Can a hook at an existing<br/>point watch, change or block it?"}
    Q2 -- "yes" --> H["Move 2: middleware,<br/>filter or extension"]
    Q2 -- "no" --> Q3{"Does the framework's shape<br/>fight this part of the problem?"}
    Q3 -- "yes" --> S["Move 3: another control flow<br/>for that part only"]
    Q3 -- "no" --> R["Rethink the requirement"]
    style T fill:#2a7,stroke:#2a7,color:#fff
    style H fill:#2a7,stroke:#2a7,color:#fff
    style S fill:#d44,stroke:#d44,color:#fff
```

Stepping out of the paradigm does not mean losing persistence. In the Functional API a task can be called from an entrypoint, another task or a Graph API node. Replay starts at the entrypoint and restores completed task results from the checkpointer, and `interrupt` works inside an entrypoint when a checkpointer is passed ([Functional API](https://docs.langchain.com/oss/python/langgraph/functional-api), page read). So I can write one part as ordinary code and keep resume.

## 4. What industry sources say

Anthropic's "Building effective agents" advises starting with LLM APIs directly. Frameworks simplify calling the model, defining tools and chaining calls, but add layers that can obscure the prompts and responses and make debugging harder, so a team that uses one should understand the code underneath ([source](https://anthropic.com/engineering/building-effective-agents), search summary). That agrees with the lecture's reason for learning the primitives. Anthropic also sells the API, so the advice is not neutral on the SDK question. The lecture's own line, to prefer official SDKs over multi-provider abstractions, is an opinion (see [Lecture 4: 02](../Lecture_4_Harness/02_Agent_Runner_Portability.md) for the portability trade-off).

Worked example, abstract. The requirement: block a tool call when the caller lacks a role.

| Option | Verdict |
|---|---|
| Add a tool that checks roles | The model could skip it. Not a guarantee |
| Hook at the tool-call point (a `wrap_tool_call` middleware, a Pi `tool` event, a Claude Code `PreToolUse` hook) | Fits. It blocks whatever the model decides, see [05](05_Instructions_Five_Parts_And_Enforcement.md) |
| Rewrite the loop | Not needed, so the cost is not justified |

## 5. What I must understand before choosing

Each move needs a different part of the harness to be clear in my head. The earlier notes cover them.

| Before I … | I need to know | Note |
|---|---|---|
| Add a tool | How the agent finds and loads it | [07](07_Context_Tool_Awareness_Avoids_Compression.md) |
| Add a hook | Which points exist and what a hook may do | [18](18_Harness_Around_The_Loop.md) |
| Change context or prompts | What is cached and what compaction drops | [06](06_Context_Window_And_Compaction.md) |
| Add an approval step | How the run waits and resumes | [14](14_Tool_Approval_Durable_Waits.md) |
| Leave the paradigm | What state the framework stored for me, and how I would see a regression | [04](04_HITL_And_Execution_Isolation.md), [15](draft_15_Evals_And_Traces_For_Agent_Changes.md) |

## Summary

An agent improvement is a tool, a hook or a different control flow, in that order of cost. Knowing the loop and its harness is what lets me tell which one the problem needs. Leaving the framework's paradigm can be local to one part, and LangGraph's Functional API keeps the same runtime.

## Fact-check

| # | Claim | Verdict | Source | Checked |
|---|---|---|---|---|
| 1 | Knowing agentic logic lets me build or customize a harness and build agentic tools for myself or a product | **Lecture-specific** | Figure 4 of the article | 2026-11-15 |
| 2 | Start with direct API calls, frameworks add abstraction that obscures prompts and makes debugging harder, understand the code under a framework | **Agrees** | [Building effective agents](https://anthropic.com/engineering/building-effective-agents), search summary. Vendor sells the API | 2026-11-15 |
| 3 | LangChain agents expose middleware hooks `before_agent`, `before_model`, `wrap_model_call`, `after_model`, `wrap_tool_call`, `after_agent` | **Agrees** | [Custom middleware](https://docs.langchain.com/oss/python/langchain/middleware/custom), page read: all six listed. That `create_agent` supersedes `create_react_agent` is **unverified**: only a forum thread says so, the docs read do not | 2026-11-15 |
| 4 | Functional API: tasks callable from a Graph API node, replay restarts at the entrypoint, `interrupt` works in an entrypoint with a checkpointer | **Agrees** | [Functional API](https://docs.langchain.com/oss/python/langgraph/functional-api), page read. "One shared runtime" is not stated in any page read: **unverified** | 2026-11-15 |
| 5 | Pi extensions subscribe to lifecycle events and register tools the model can call | **Agrees** | [Pi extensions](https://docs.pi.dev/latest/extensions), read (middle section summarized). Event names change between versions | 2026-11-15 |
| 6 | Prefer official provider SDKs over multi-provider abstractions | **Lecture-specific** (opinion) | Article, "Connection" paragraph. Anthropic's advice on frameworks points the same way but is not about multi-provider SDKs | 2026-11-15 |

## Sources

- S02E01 article, figure 4.
- [Anthropic: Building effective agents](https://anthropic.com/engineering/building-effective-agents)
- [LangChain: How middleware lets you customize your agent harness](https://blog.langchain.com/how-middleware-lets-you-customize-your-agent-harness) and the [middleware reference](https://reference.langchain.com/python/langchain/middleware/)
- [LangGraph Functional API](https://docs.langchain.com/oss/python/langgraph/functional-api)
- [Pi extensions](https://docs.pi.dev/latest/extensions)
- My own reasoning: the three-move ladder, the decision flow, the worked example and the "what I must understand" table.
