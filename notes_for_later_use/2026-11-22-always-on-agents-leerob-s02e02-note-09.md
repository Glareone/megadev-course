# Always-on agents: durable and event-driven

Date: 2026-11-22
Topic: agents that sleep, wake on an event, load state, work and go back to sleep (Lee Robinson's Stanford CS146S talk "How always-on agents work")
Lecture: S02E02 Building an Agent, intro (the article points to the talk)

This is a very interesting concept for me: durable agents, or agents that react to events. It touches many things I discussed earlier: durable waits, memory, caching, sub-agents and sandboxes. I want a note on it.

What I have so far, all secondary and unverified: a [write-up of the talk](https://tianpan.co/notes/2026-10-21-designing-always-on-agent) (thin client, thick server, sleeping server and VM, two kinds of state, a trigger router). The X post returned HTTP 402 and the YouTube page gave no transcript. I need the primary text first (transcript or my own notes from the video).

Where the topic already appears:

| Where | What it holds |
|---|---|
| [14 Tool approval, durable waits](../Week2_Lecture_1_Agent_Primitives/14_Tool_Approval_Durable_Waits.md) | Pause and resume across a wait |
| [08 Mastra workflow mapped to LangGraph](../Week2_Lecture_2_Building_an_Agent/08_Mastra_Workflow_Mapped_To_LangGraph.md) | Suspend, snapshot, what reruns on resume |
| [09 Cache hit rate and P90](../Week2_Lecture_2_Building_an_Agent/09_Cache_Hit_Rate_And_P90_Latency.md) | Why a wake-up after a long gap misses the cache |
