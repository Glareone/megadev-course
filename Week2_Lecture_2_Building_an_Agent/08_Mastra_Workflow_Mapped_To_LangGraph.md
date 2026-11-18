# 8. The lecture's Mastra workflow maps onto a LangGraph graph with `interrupt` and a checkpointer; the differences are in what reruns on resume, how a run is tied to a conversation, and how an agent reaches it

> A Mastra step with `suspend()` and `resumeData` corresponds to a LangGraph node with `interrupt()` and `Command(resume=…)`, `runId` to `thread_id` and snapshots to checkpoints, and both rerun the interrupted step from its start, so the exchange flow needs the same split (assess, confirm, then act with an idempotency key) in either engine.

Related: [06 Workflow vs LangGraph](06_Workflow_vs_LangGraph.md) · [07 Workflows on the fly and todo lists](07_Workflows_On_The_Fly_And_Todo_Lists.md) · [W2L1 14 Approval and durable waits](../Week2_Lecture_1_Agent_Primitives/14_Tool_Approval_Durable_Waits.md) · [W2L1 17 Extend, adjust, leave](../Week2_Lecture_1_Agent_Primitives/17_Extend_Adjust_Or_Leave_The_Framework.md)

Source: S02E02 audio transcript (the workflow part) and the Mastra and LangGraph docs read on 2026-11-18, listed in [Sources](#sources). The code blocks are my own sketches in the docs' API shapes, not run. The mapping table's "my reading" cells are my reasoning.

## Glossary

| Term | What it means here | Same thing elsewhere | Not to be confused with |
|---|---|---|---|
| Step | One unit of a workflow with input, output and optional resume data | LangGraph node | A model step in a loop |
| Run | One execution of a workflow, tied to saved progress | Mastra `runId`, LangGraph `thread_id` | A chat session |
| Snapshot, checkpoint | Saved execution state for resume | Mastra snapshot, LangGraph checkpoint | A backup |
| Resume data | The value that continues a suspended step | Mastra `resumeData`, LangGraph `Command(resume=…)` | A new request |
| Idempotency key | A stable key so a repeated action has no extra effect | Request ID in the lecture | A random id |
| Superstep | LangGraph's unit between checkpoints | Microsoft Agent Framework superstep | A model call |

## 1. The problem

The lecture's exchange workflow is written in Mastra. I know LangGraph. **How does each part map, where do they differ, and what stays the same whichever engine I pick?**

## 2. The mapping

| Part of the exchange flow | Mastra | LangGraph |
|---|---|---|
| A step | `createStep({ id, inputSchema, outputSchema, resumeSchema, execute })` | A node function that returns a partial state update |
| The flow | `createWorkflow(...).then(assess).then(confirm).commit()` | `StateGraph` with edges and `add_conditional_edges`, then `compile(checkpointer=…)` |
| Shared data | `stateSchema`, `setState` (replaces), `updateState` (merges) | State as `TypedDict`, dataclass or Pydantic, reducers via `Annotated` |
| Pause | `return await suspend({})` when `resumeData` is empty | `decision = interrupt(payload)` |
| Continue | `run.resume({ step, resumeData })` | `graph.invoke(Command(resume=value), config)` |
| Handle of a run | `runId` (`createRun({ runId })`) | `thread_id` in `config` |
| Saved progress | Snapshot, default libSQL, also Postgres, Upstash, MongoDB, DynamoDB and others | Checkpointer: in-memory is lost on restart, use Postgres or SQLite savers |
| Status after pause | `result.status === 'suspended'` | `__interrupt__` in the result |
| Retries | `retries` per step, `retryConfig` per workflow, `MastraNonRetryableError` | `RetryPolicy(max_attempts=3, …)`. Interrupts bypass retry policies |
| Agent as a step | `createStep(agent)` | A node that calls the model |
| Agent reaches the run | Docs: workflows "can be called from agents, tools". No example found | A `@tool` that calls the compiled graph's `invoke`. No built-in graph-to-tool |

## 3. The same flow in both

```text
// Mastra, sketch
const confirm = createStep({ id: "confirm", resumeSchema: z.object({ approved: z.boolean() }),
  execute: async ({ inputData, resumeData, suspend }) => {
    if (resumeData?.approved === undefined) return await suspend({});
    return { approved: resumeData.approved };
  }});
createWorkflow({ id: "exchange" }).then(assess).then(confirm).then(execute).commit();
```

```python
# LangGraph, sketch
def confirm(state):
    decision = interrupt({"proposal": state["proposal"]})
    return {"approved": decision["approved"]}

def execute(state):
    key = f"exchange:{state['order_id']}:{state['item_id']}"   # from durable state
    ...
builder.add_edge("assess", "confirm"); builder.add_edge("confirm", "execute")
graph = builder.compile(checkpointer=checkpointer)
```

The effect sits in its own node or step after the pause, which is why the lecture has an `assess` step, a `confirm` step and then the action.

## 4. What reruns on resume

- **LangGraph:** "the runtime restarts the entire node from the beginning", so code before `interrupt` runs again. Side effects there must be idempotent, or go after the `interrupt` or into another node.
- **Mastra:** the docs say a suspended workflow "restarts from the step where it paused". The examples read `resumeData` at the top of `execute`, which implies the same rerun from the first line. That is my inference, not stated.
- **Both:** a retry reruns the whole step, so effects have at-least-once semantics. Mastra suggests a key from `runId`, `workflowId`, step `id` and a name per effect. LangGraph says derive the key from durable state and not from a fresh uuid inside the node, and treat missing local state as "unknown, not as proof the effect did not happen".
- **Functional API option:** side effects in a `@task` have their result restored on resume, though a task that started but did not finish may run again.

## 5. Where they differ

| | Mastra | LangGraph |
|---|---|---|
| Run to conversation | Only `runId`. No link to a thread found | `thread_id` is "effectively your persistent cursor" |
| Where resume enters | Names the step, or omits it when one step is suspended | Resumes the pending interrupt on that thread. Multiple interrupts match by index |
| State update | `setState` replaces, so every field must be passed | A node returns only the changed keys, the default reducer replaces per key |
| Changing the definition | Not found | "You can add or remove nodes and edges without breaking resume", but not rename or remove the node a thread is about to enter |
| Language | TypeScript, Zod schemas | Python and JS, typed state |
| Inside a tool | Not documented | A graph called inside a tool cannot show its subgraph state, and per-thread subgraphs warn against parallel tool calls |

Linking a conversation to a run is mine to build in both: store the conversation id next to the `runId` or `thread_id`. This is my reasoning, and the lecture says progress is "linked to the conversation" in the database.

## Cautions

- The Mastra pages on human-in-the-loop, agents and tools, and control flow were not read.
- The sketches use the documented shapes but were not executed. Mastra and LangGraph versions change their APIs.
- LangGraph timeouts, error handlers and `set_node_defaults` need `langgraph>=1.2`.

## Summary

The lecture's flow ports one to one: steps become nodes, `suspend` becomes `interrupt`, `runId` becomes `thread_id`, snapshots become checkpoints. Both rerun the interrupted step, so the action goes after the pause with a key from durable state. The real differences are the conversation link, the resume entry point and how an agent calls the run.

## Open questions

- Does Mastra rerun a suspended step from its first line, as the examples imply?
- How does an agent-called Mastra workflow tie its `runId` to a conversation in practice?

## Fact-check

| # | Claim | Verdict | Source | Checked |
|---|---|---|---|---|
| 1 | Mastra suspends with `suspend()` and resumes with `run.resume({ step, resumeData })`, snapshots persist across restarts | **Agrees** | [Mastra suspend and resume](https://mastra.ai/docs/workflows/suspend-and-resume), [snapshots](https://mastra.ai/docs/workflows/snapshots), pages read | 2026-11-18 |
| 2 | A suspended Mastra step reruns from its first line | **Unverified**: implied by examples, not stated | Same pages | 2026-11-18 |
| 3 | LangGraph restarts the whole node on resume, side effects before `interrupt` must be idempotent | **Agrees** | [Interrupts](https://docs.langchain.com/oss/python/langgraph/interrupts), page read | 2026-11-18 |
| 4 | LangGraph idempotency key comes from durable state, not a new uuid | **Agrees** | [Fault tolerance](https://docs.langchain.com/oss/python/langgraph/fault-tolerance), page read | 2026-11-18 |
| 5 | Mastra suggests a key from `runId`, `workflowId`, step `id` | **Agrees** | [Mastra overview](https://mastra.ai/docs/workflows/overview), page read | 2026-11-18 |
| 6 | Interrupts bypass LangGraph retry policies | **Agrees** | Fault tolerance page | 2026-11-18 |
| 7 | A Mastra run is tied to a conversation | **Unverified**: only `runId` documented | Mastra pages read | 2026-11-18 |
| 8 | A workflow is exposed to a Mastra agent as a tool | **Unverified**: docs say callable from agents and tools, no example read | Mastra overview | 2026-11-18 |
| 9 | LangGraph graph as a tool is a `@tool` wrapper over `invoke`, no built-in | **Agrees** | [Subgraphs](https://docs.langchain.com/oss/python/langgraph/use-subgraphs), page read | 2026-11-18 |
| 10 | LangGraph definitions can change without breaking resume, except the node a thread is about to enter | **Agrees** | [Graph API](https://docs.langchain.com/oss/python/langgraph/graph-api), page read | 2026-11-18 |

## Sources

- S02E02 audio transcript.
- Mastra: [overview](https://mastra.ai/docs/workflows/overview) · [suspend and resume](https://mastra.ai/docs/workflows/suspend-and-resume) · [workflow state](https://mastra.ai/docs/workflows/workflow-state) · [snapshots](https://mastra.ai/docs/workflows/snapshots) · [error handling](https://mastra.ai/docs/workflows/error-handling) · [step reference](https://mastra.ai/reference/workflows/step)
- LangGraph: [interrupts](https://docs.langchain.com/oss/python/langgraph/interrupts) · [persistence](https://docs.langchain.com/oss/python/langgraph/persistence) · [graph API](https://docs.langchain.com/oss/python/langgraph/graph-api) · [subgraphs](https://docs.langchain.com/oss/python/langgraph/use-subgraphs) · [fault tolerance](https://docs.langchain.com/oss/python/langgraph/fault-tolerance) · [Functional API](https://docs.langchain.com/oss/python/langgraph/functional-api)
- My own reasoning: the mapping reading, the conversation link and the shared flow.
