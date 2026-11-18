# 7. A model can write and edit a plan as data on the fly, but changing a workflow's structure at runtime costs resumability, so a fixed executor over a plan is the safe shape

> Deep Agents' todo list is a plan the model rewrites through a tool, stored in agent state and not enforced, while real workflow structure is fixed when the graph is built in LangGraph, Mastra and Microsoft Agent Framework; only code-driven forms (LangGraph Functional API, ADK dynamic workflows, orchestrator-workers) decide steps at runtime, and they trade away stable resume.

Related: [06 Workflow vs LangGraph](06_Workflow_vs_LangGraph.md) · [01 LLM vs classification](01_LLM_vs_Classification.md) · [W2L1 03 Loop, limits, recovery](../Week2_Lecture_1_Agent_Primitives/03_Agent_Loop_Stop_Limits_Recovery.md) · [W2L1 12 Audit ledger](../Week2_Lecture_1_Agent_Primitives/12_Memory_Audit_Ledger_In_Memory_Or_State.md) · [W2L1 14 Approval and durable waits](../Week2_Lecture_1_Agent_Primitives/14_Tool_Approval_Durable_Waits.md) · [W2L1 23 Self-configuring harness](../Week2_Lecture_1_Agent_Primitives/23_Self_Configuring_Harness.md) · [08 Mastra workflow mapped to LangGraph](08_Mastra_Workflow_Mapped_To_LangGraph.md)

Source: framework docs read on 2026-11-18, listed in [Sources](#sources). The three levels, the executor design and the guards are my own reasoning where marked.

## Glossary

| Term | What it means here | Same thing elsewhere | Not to be confused with |
|---|---|---|---|
| Plan as data | A list of steps the model writes and edits | Deep Agents `write_todos` | A workflow that executes |
| Topology | Which nodes and edges exist | LangGraph graph structure, MAF executor identities | The data flowing through |
| `Send` | LangGraph routing that starts a declared node a runtime-chosen number of times | Map-reduce fan-out | Creating a node |
| `Command` | A node returns a state update and the next node together | Dynamic edge | A tool call |
| Dynamic workflow (ADK) | A parent node calls child nodes in ordinary code | `ctx.run_node` | A template agent |
| Orchestrator-workers | A central LLM splits a task at runtime and delegates | Anthropic pattern | A fixed pipeline |
| Executor | Fixed code that runs the next step of a plan | My term | The model |

## 1. The problem

Can workflows be created on the fly and managed like the `todo_list` in Deep Agents, by the model, in a separate LangGraph node? **What can change at runtime, and what does it cost?**

## 2. What the Deep Agents todo list is

| Fact | Detail |
|---|---|
| Mechanism | A `write_todos` tool that `TodoListMiddleware` adds to the agent |
| Storage | Persisted in agent state; the reference example reads `result["todos"]` |
| Statuses | `pending`, `in_progress`, `completed` |
| Who writes | The model; the tool "replaces the entire todo list" |
| Enforced | At most one `write_todos` call per model turn. Completion is not enforced |
| Default | Opt-in from v0.7 |
| Purpose | The overview calls planning "an explicit accountability tool" for "Less capable models" and a source for progress UIs |

The docs read describe a tool added by middleware. They do not describe a separate graph node, so that part is unconfirmed. The todo list is a plan as data. It does not run steps, so it is not a workflow in the sense of [note 06](06_Workflow_vs_LangGraph.md).

## 3. Three levels of "on the fly"

| Level | What changes at runtime | Where | Source |
|---|---|---|---|
| 1. Plan as data | The list of intended steps | Any framework, Deep Agents todos | Deep Agents docs |
| 2. Choice inside a fixed structure | Which declared nodes run, how many times, with what input | LangGraph `Send` and `Command`, Mastra `.branch` and `.foreach` | LangGraph: "the topology is fixed when you build the graph" |
| 3. Structure decided by code or by a model | The steps themselves | LangGraph Functional API (ordinary `if` and loops), ADK dynamic workflows (`ctx.run_node`), Anthropic orchestrator-workers ("subtasks … decided at runtime") | Pages read |

Not found: creating new node definitions at runtime in LangGraph, or runtime-created workflows in Mastra (only `cloneWorkflow`). Compiling a new graph for each request should work, but no source I read states it.

## 4. The cost: resume

```mermaid
flowchart TD
    M["Model writes or edits the plan"] --> S["Plan stored in state"]
    S --> E["Fixed executor: pick next pending step"]
    E --> T["Run step: tool or subagent"]
    T --> K["Checkpoint, update status"]
    K --> E
    E -- "side-effect step" --> G["Approval gate, suspend"]
    G --> E
    style E fill:#d44,stroke:#d44,color:#fff
```

- LangGraph restarts the node on resume and needs deterministic code before an `interrupt`.
- Microsoft Agent Framework requires the topology and executor identities to match the checkpoint.
- ADK skips sub-nodes that already succeeded when it resumes.

So a structure that changes under a saved run is risky. My reasoning: let the model change the plan (level 1) and keep the executor, the step types and the checkpoints fixed (red node). A resumed run then reads the saved plan and continues.

## 5. Which level for which need

| Need | Level | Why |
|---|---|---|
| Show progress, keep a long task on track | 1 | A todo list is enough |
| Fan out over an unknown number of items | 2 | `Send` handles it in a fixed graph |
| Unpredictable subtasks, no resume needed | 3 | Orchestrator-workers or ordinary code |
| Risky side effects with approvals | 2, with a fixed process | Order and gates must not move |

## 6. Guards for model-written plans

My reasoning, in line with the controls in the article outline ("execution budgets, isolation, approval"):
- A fixed set of allowed step types; the executor rejects the rest.
- A step budget ([W2L1 03](../Week2_Lecture_1_Agent_Primitives/03_Agent_Loop_Stop_Limits_Recovery.md)).
- Approval on any step with a side effect ([W2L1 14](../Week2_Lecture_1_Agent_Primitives/14_Tool_Approval_Durable_Waits.md)).
- An append-only journal of plan edits ([W2L1 12](../Week2_Lecture_1_Agent_Primitives/12_Memory_Audit_Ledger_In_Memory_Or_State.md), [W2L1 23](../Week2_Lecture_1_Agent_Primitives/23_Self_Configuring_Harness.md)).

## Cautions

- ADK's dynamic workflows page was partly read, and its maturity is not labeled.
- The todo-list facts come from the Deep Agents overview and the middleware reference; behavior may change by version.

## Summary

A model can write a plan as data on the fly, like Deep Agents' todo list. The structure of a workflow is fixed at build time in most engines, and code-driven forms decide steps at runtime but weaken resume. A fixed executor over a model-written plan keeps both.

## Open questions

- Does compiling a LangGraph graph per request keep a paused run resumable?
- Where in the compiled graph does `TodoListMiddleware` run?

## Fact-check

| # | Claim | Verdict | Source | Checked |
|---|---|---|---|---|
| 1 | `write_todos` is a tool added by `TodoListMiddleware`, stored in agent state, replaced whole by the model | **Agrees** | [Deep Agents overview](https://docs.langchain.com/oss/python/deepagents/overview), [middleware reference](https://reference.langchain.com/python/langchain/agents/middleware/todo/TodoListMiddleware), pages read | 2026-11-18 |
| 2 | At most one `write_todos` call per model turn, completion not enforced | **Agrees** | Middleware reference | 2026-11-18 |
| 3 | Planning runs in a separate LangGraph node | **Unverified**: not described in the docs read | Same pages | 2026-11-18 |
| 4 | LangGraph's structure is fixed at build time, `Send` and `Command` choose at runtime | **Agrees** | [Graph API](https://docs.langchain.com/oss/python/langgraph/graph-api), page read | 2026-11-18 |
| 5 | The Functional API uses ordinary control flow | **Agrees**. Docs: "Prefer the Graph API for building new agents" | [Functional API](https://docs.langchain.com/oss/python/langgraph/functional-api) | 2026-11-18 |
| 6 | ADK dynamic workflows call child nodes in code and skip successful ones on resume | **Agrees**, page partly read | [ADK dynamic](https://adk.dev/graphs/dynamic/) | 2026-11-18 |
| 7 | Microsoft resume needs the same topology | **Agrees** | [MAF checkpoints](https://learn.microsoft.com/en-us/agent-framework/workflows/checkpoints) | 2026-11-18 |
| 8 | Orchestrator-workers decides subtasks at runtime | **Agrees** | [Anthropic](https://www.anthropic.com/research/building-effective-agents) | 2026-11-18 |
| 9 | A graph can be compiled per request and stay resumable | **Unverified** | No source read | 2026-11-18 |

## Sources

- [Deep Agents overview](https://docs.langchain.com/oss/python/deepagents/overview) · [TodoListMiddleware reference](https://reference.langchain.com/python/langchain/agents/middleware/todo/TodoListMiddleware)
- [LangGraph Graph API](https://docs.langchain.com/oss/python/langgraph/graph-api) · [Functional API](https://docs.langchain.com/oss/python/langgraph/functional-api) · [interrupts](https://docs.langchain.com/oss/python/langgraph/interrupts)
- [ADK dynamic workflows](https://adk.dev/graphs/dynamic/) · [Microsoft Agent Framework checkpoints](https://learn.microsoft.com/en-us/agent-framework/workflows/checkpoints) · [Mastra control flow](https://mastra.ai/docs/workflows/control-flow)
- [Anthropic: Building effective agents](https://www.anthropic.com/research/building-effective-agents)
- My own reasoning: the three levels, the executor design and the guards.
