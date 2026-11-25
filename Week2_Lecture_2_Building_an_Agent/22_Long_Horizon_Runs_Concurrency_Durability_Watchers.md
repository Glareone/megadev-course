# 22. For long-horizon runs I need one writer or a version check per entity, a durable runtime for waits across days, and a real scheduler: the article's pi-until is session-scoped and pi-durable is experimental

> The article warns that parallel updates can lose data and suggests queues or versioning, plus pi-durable for recovery and pi-until for watchers; the sources confirm the first (Redis check-and-set, one writer per entity in Durable Objects) but the pi-until README says it is "a session primitive, not another scheduler or daemon" and pi-durable calls itself experimental, so a two-day wake-up needs a platform scheduler or a workflow engine such as Temporal.

Related: [24 pi-durable in detail](24_Pi_Durable_How_It_Recovers_Long_Running_Tasks.md) · [16 Memory-centric approach with events](16_Memory_Centric_Approach_With_Events.md) · [21 Engagement signals](21_Engagement_Signals_And_Proactive_Agents.md) · [23 Wake and reflect on the market](23_Wake_And_Reflect_Agents_On_The_Market.md) · [08 Mastra workflow mapped to LangGraph](08_Mastra_Workflow_Mapped_To_LangGraph.md) · [06 Workflow vs LangGraph](06_Workflow_vs_LangGraph.md) · [09 Cache hit rate and P90](09_Cache_Hit_Rate_And_P90_Latency.md) · [W2L1 14 Tool approval, durable waits](../Week2_Lecture_1_Agent_Primitives/14_Tool_Approval_Durable_Waits.md) · [W2L1 12 Audit ledger](../Week2_Lecture_1_Agent_Primitives/12_Memory_Audit_Ledger_In_Memory_Or_State.md) · [W2L1 19 Pi, LangGraph and the DeepSeek paper](../Week2_Lecture_1_Agent_Primitives/19_Pi_LangGraph_DeepSeek_Harnesses.md) · [W2L3 14 MCP events and lifecycle hooks](../Week2_Lecture_3_MCP_MCP+Resources_Skills/14_MCP_Events_And_Lifecycle_Hooks.md) · [W2L3 16 MCP events in real systems](../Week2_Lecture_3_MCP_MCP+Resources_Skills/16_MCP_Events_In_Real_Systems.md)

Source: S02E02 article, "Workflows and long-horizon tasks": parallel updates, queues or versioning, pi-durable and pi-until. The READMEs of pi-durable and pi-until, Redis, Cloudflare and Temporal docs read on 2026-11-22 through fetch summaries. See [Fact-check](#fact-check).

## Glossary

| Term | What it means here | Same thing elsewhere | Not to be confused with |
|---|---|---|---|
| Optimistic locking | Read a version, write only if it has not changed, retry on conflict | Redis `WATCH`, compare-and-set, `If-Match` | A lock that blocks |
| Single writer | All updates for one entity go through one serialized worker | Durable Object, actor, queue consumer | A shared lock |
| Durable execution | A run that resumes after a crash from a record of its steps | Temporal replay, pi-durable | A checkpoint of state alone |
| Watcher | A condition checked in the background that wakes the agent | pi-until `start` | A scheduler |
| Session primitive | Lives only while one live session exists | pi-until | A daemon |

## 1. The problem

The article says parallel updates "may even lead to data loss", so I need queues or versioning, and it names pi-durable (recover from nearly any failure, pause as long as needed) and pi-until (watchers and recurring wake-ups). **What do others say, and do those two tools cover a wake-up two days later?**

## 2. Parallel updates

| Pattern | What the source says | Fits |
|---|---|---|
| Version check | [Redis](https://redis.io/docs/latest/develop/using-commands/transactions/): `WATCH` gives check-and-set. If a watched key changes, `EXEC` aborts and I retry. "Optimistic locking" suits cases where clients mostly touch different keys. Since 8.4, `SET` with `IFEQ` does it in one command. Redis has no rollback | Notes or documents that the agent and I both edit |
| One writer per entity | [Cloudflare Durable Objects](https://developers.cloudflare.com/durable-objects/what-are-durable-objects/): single-threaded, requests to one object run one at a time, no locks, strongly consistent storage. Route all updates for an entity to its object | A user's state, a queue |
| Merge by reducer | LangGraph merges parallel writes to a state key through a reducer ([06](06_Workflow_vs_LangGraph.md)) | Parallel branches in one run |
| Append-only journal | Entries are only added ([16](16_Memory_Centric_Approach_With_Events.md), [W2L1 12](../Week2_Lecture_1_Agent_Primitives/12_Memory_Audit_Ledger_In_Memory_Or_State.md)) | The record of what happened |

For my Redis store I would use a version field and `WATCH` or a script, and a conflict copy when I and the agent edit one note (my reasoning).

## 3. Durability and waiting

| | pi-until | pi-durable | Temporal | A platform scheduler |
|---|---|---|---|---|
| What it is | Shell-condition watches and recurring follow-ups in one Pi session | A durable agent harness on `pi-ai` | A workflow engine | Cloudflare Agents `schedule()` |
| Survives | `/reload` and graceful quits. "Not crashes, SIGKILL, or reboots" | Crashes: reopening storage resumes. Restart cap 5 | "Run for years", replays from the event history | Restarts and evictions, stored in SQLite |
| Waits | Polls, default 30 s | Sleep until a time or a signal, no process held | Durable timers, recorded as events | Delay, date or cron |
| Caveats | "A session primitive, not another scheduler or daemon". Conditions must be idempotent and fail closed. "Long-lived durable work needs a real workload scheduler" | Experimental, API changes without notice. One process writes a storage at a time, no cross-process locking. A crash can lose about a second of partial output | Workflow code must be deterministic. Side effects belong in Activities | Cloudflare only |

So a wake-up two days later needs the last two columns. pi-until covers a watch inside a live session, and pi-durable is experimental. Sources: the [pi-until](https://github.com/joelhooks/pi-until) and [pi-durable](https://github.com/earendil-works/pi/tree/main/packages/durable) READMEs, [Temporal](https://docs.temporal.io/workflows), [Cloudflare schedule](https://developers.cloudflare.com/agents/api-reference/schedule-tasks/).

## 4. What it means for my agent (my reasoning)

- Every wake-up is idempotent and carries a key, so a repeated wake does not repeat its effect ([08](08_Mastra_Workflow_Mapped_To_LangGraph.md)).
- A wake-up after a gap longer than the TTL starts with a cache miss ([09](09_Cache_Hit_Rate_And_P90_Latency.md)).
- Where I use LangGraph, the checkpointer gives resume per thread. Where I need timers across days I need a scheduler under it, as in [W2L1 14](../Week2_Lecture_1_Agent_Primitives/14_Tool_Approval_Durable_Waits.md).

## Summary

For parallel updates I use a version check or one writer per entity. For waits across days I use a platform scheduler or a workflow engine, and treat pi-until as a session helper and pi-durable as experimental, as their own READMEs say.

## Open questions

- Which entities do the agent and I update at the same time?
- What schedules my wake-ups today, and does it survive a restart?
- Is a version field in my Redis documents enough, or do I need one writer per entity?

## Fact-check

| # | Claim | Verdict | Source | Checked |
|---|---|---|---|---|
| 1 | Parallel updates can lose data; queues or versioning help | **Agrees** | [Redis transactions](https://redis.io/docs/latest/develop/using-commands/transactions/): the lost-update example and `WATCH`. S02E02 article | 2026-11-22 |
| 2 | Durable Objects serialize access per object | **Agrees** | [Durable Objects](https://developers.cloudflare.com/durable-objects/what-are-durable-objects/), fetch summary | 2026-11-22 |
| 3 | pi-durable recovers from crashes and can pause as long as needed | **Agrees**, experimental | [README](https://github.com/earendil-works/pi/tree/main/packages/durable), read to 100,000 of 112,893 characters | 2026-11-22 |
| 4 | pi-until gives watchers and recurring wake-ups | **Differs** in scope: session-scoped, not durable | [README](https://github.com/joelhooks/pi-until): not crash-safe, "not another scheduler or daemon" | 2026-11-22 |
| 5 | Temporal replays from the event history and records timers | **Agrees** | [Temporal workflows](https://docs.temporal.io/workflows). Signals and Continue-As-New not read | 2026-11-22 |
| 6 | Cloudflare schedules persist across restarts | **Agrees** | [Schedule tasks](https://developers.cloudflare.com/agents/api-reference/schedule-tasks/), fetch summary | 2026-11-22 |
| 7 | LangGraph durable-execution rules (determinism, tasks) | **Unverified** | The docs page was not retrievable. See [W2L1 14](../Week2_Lecture_1_Agent_Primitives/14_Tool_Approval_Durable_Waits.md) | 2026-11-22 |

## Sources

- S02E02 article, closing section.
- [Redis transactions](https://redis.io/docs/latest/develop/using-commands/transactions/) · [Cloudflare Durable Objects](https://developers.cloudflare.com/durable-objects/what-are-durable-objects/) · [Cloudflare schedule tasks](https://developers.cloudflare.com/agents/api-reference/schedule-tasks/) · [Temporal workflows](https://docs.temporal.io/workflows)
- [pi-durable](https://github.com/earendil-works/pi/tree/main/packages/durable) · [pi-until](https://github.com/joelhooks/pi-until)
- My own reasoning: the pattern choice for my Redis store and section 4.
