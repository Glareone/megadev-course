# Long-horizon runs: parallel updates, pi-durable and pi-until against the industry

Date: 2026-11-22
Topic: parallel updates that may lose data, queues or versioning, pi-durable for recovery and pause, pi-until for watchers and recurring wake-ups
Lecture: S02E02 Building an Agent, closing section

| Idea | What the sources say | Match |
|---|---|---|
| Parallel updates need queues or versioning | Redis `WATCH` check-and-set; one writer per entity in Durable Objects | Agrees |
| pi-durable recovers from nearly any failure and pauses as long as needed | Its README: crash resume, restart cap 5, sleep until a time or signal; experimental, no cross-process locking | Agrees in part |
| pi-until sets up watchers and recurring wake-ups | Its README: session-scoped, not crash-safe, "not another scheduler or daemon", "needs a real workload scheduler" for durable work | Differs in scope |

Where it is written: [Lecture 2: 22](../Week2_Lecture_2_Building_an_Agent/22_Long_Horizon_Runs_Concurrency_Durability_Watchers.md). Open: which entities the agent and I edit at once, and what schedules my wake-ups today.
