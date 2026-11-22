# Sandboxing for agent-run code

Date: 2026-11-15
Topic: letting the agent write and run code (Python, CLI) in a sandbox, so it can do complex tasks on its own without getting out of control
Lecture: S02E01 Agentic Primitives, part "Tools" (sandboxing)

I find sandboxing very promising for my agents. Today code runs through an MCP tool on servers outside the agent. The dedicated note is [Lecture 2: 12](../Week2_Lecture_2_Building_an_Agent/12_Sandbox_For_Agent_Code_Pi_And_Search_Execute.md). It still waits for my answers on who writes the code, multi-tenancy, network needs, state and hosting.

Where the topic already appears:

| Where | What it holds |
|---|---|
| [04 HITL and execution isolation](../Week2_Lecture_1_Agent_Primitives/04_HITL_And_Execution_Isolation.md), section 5 | Per-tenant workspaces, containers, shell sandbox coverage, escape hatches |
| [07 Tools: awareness, discovery, gateway](../Week2_Lecture_1_Agent_Primitives/07_Context_Tool_Awareness_Avoids_Compression.md) | Code mode and per-user workspace isolation as it concerns tools |
| [Lecture 4: 14 What agent fleets need beyond spawning](../Lecture_4_Harness/14_What_Agent_Fleets_Need_Beyond_Spawning.md) | Sandboxing pointers for agent fleets |

Added 2026-11-22 (S02E02, "Capabilities" and "Integrations"): I want to check in the Pi and DeepSeek harnesses whether I can organize a sandbox for custom code, and a "search then execute" way to reach tools, as Claude does. Checked in the docs in note 12. Not tried: a runnable test of Pi's `tool_search` with the Gondolin micro-VM needs an install, so it waits for my explicit yes.
