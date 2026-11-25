# MCP as an event source, and hooks organized around it

Date: 2026-11-25
Topic: the MCP Events extension (draft design sketch, Beta extension, SEP-3415) lets a server push upstream occurrences to an agent; I had never thought of MCP as an event source, and I want to think about organizing my lifecycle hooks around it
Lecture: S02E03 Agentic Capabilities, part "Model Context Protocol" ("Events (draft)")

I want to come back to this and think it through. The idea: put an event layer in front of my agent loop that verifies, dedupes by event id, authorizes the principal and saves a cursor, then a router hook decides to drop, record in memory or wake the agent. Lifecycle hooks stay the control points inside the turn. Support is early: ChatGPT takes webhook events, Claude Code has a separate channels feature, and both official SDKs have only open pull requests.

Where the topic already appears:

| Where | What it holds |
|---|---|
| [14 MCP events and lifecycle hooks](../Week2_Lecture_3_MCP_MCP+Resources_Skills/14_MCP_Events_And_Lifecycle_Hooks.md) | How Events works, its status, security, support today, the hook layer I have in mind |
| [W2L2 16 Memory-centric approach with events](../Week2_Lecture_2_Building_an_Agent/16_Memory_Centric_Approach_With_Events.md) | Every change to memory as an event, and the three records |
| [W2L2 22 Long-horizon runs and watchers](../Week2_Lecture_2_Building_an_Agent/22_Long_Horizon_Runs_Concurrency_Durability_Watchers.md) | Durable waits, a real scheduler, one writer per entity |
| [W2L1 20 Loop hooks declared](../Week2_Lecture_1_Agent_Primitives/20_Loop_Hooks_Declared.md) | The hook points a harness declares |

Open: which of my MCP servers has an upstream source worth exposing, where my harness saves cursors, whether to build my own event layer now or wait for the SDKs, and whether the event payloads need the same boundary as tool results (notes 07 and 11).
