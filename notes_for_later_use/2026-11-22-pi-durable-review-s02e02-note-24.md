# pi-durable: how it supports long-running tasks with recovery

Date: 2026-11-22
Topic: pi-durable, logic for long-running tasks that recover after failures and can pause; I find the concept interesting and want to review it again
Lecture: S02E02 Building an Agent, closing section

| Idea | What the README shows | Gap |
|---|---|---|
| Recover from nearly any failure | Commit before display, tool intent committed first, rerun only `replay: "safe"` tools, restart limit 5. A storage error ends the harness; about 1 s of partial output can be lost | Weaker than "nearly any" |
| Pause as long as needed | A task sleeps until a time or a signal and holds no process. The host arms its own alarm and calls `resume()` | No scheduler of its own |
| Fits my stack | TypeScript only, one writer per storage, experimental | I take the ideas, not the package |

Where it is written: [Lecture 2: 24](../Week2_Lecture_2_Building_an_Agent/24_Pi_Durable_How_It_Recovers_Long_Running_Tasks.md). Open: read `docs/spec.md` and run the recovery example (needs an install and my explicit yes), and whether my tools carry a safe-to-replay flag and an idempotency key.
