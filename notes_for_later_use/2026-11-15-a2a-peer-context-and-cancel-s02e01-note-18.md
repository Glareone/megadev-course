# What the orchestrator passes to an A2A peer, and task cancel

Date: 2026-11-15
Topic: a decision summary or the full trace for a disposable peer, and stopping a peer when my A2A server cannot cancel a task
Lecture: S02E01 Agentic Primitives, part "Threads and sessions" (subagent thread)

I have never thought about what an orchestrator should hand to a peer. I want to decide on the fields of a decision summary. My A2A server does not support task cancel yet.

Where the topic already appears:

| Where | What it holds |
|---|---|
| [18 Threads, subagents and A2A](../Week2_Lecture_1_Agent_Primitives/18_Threads_Vs_A2A_Subagents.md), sections 5 and 6 | Disposable peers, the four options for what the peer gets, the cancel gap |
| [03 Agent loop](../Week2_Lecture_1_Agent_Primitives/03_Agent_Loop_Stop_Limits_Recovery.md) | Deadlines and limits, no per-subagent wall-clock in the Agent SDK |
