# Where my tools' guidance lives: description, instructions, resource or tool result

Date: 2026-11-23
Topic: long guidance for my tools (the OData contract, usage guides, supporting files) can sit in a tool description, server instructions, a resource or a tool result; hosts read resources unevenly, so I want to decide where mine goes
Lecture: S02E03 Agentic Capabilities, parts "Model Context Protocol" (resources, server instructions) and "Designing a custom MCP"

I want to review which guidance my agent really needs, and test where it arrives. VS Code's developer guide says to return content in a tool result when the agent needs it, rather than rely on resource discovery. Claude Code has model tools for resources and cuts server instructions at 4,096 characters. I do not know which hosts my users run.

Where the topic already appears:

| Where | What it holds |
|---|---|
| [01 MCP resources](../Week2_Lecture_3_MCP_MCP+Resources_Skills/01_MCP_Resources_Static_Context_And_Sampling.md) | Ten misreadings, resource forms, the host table, the stateless fit |
| [02 MCP resources and plugins](../Week2_Lecture_3_MCP_MCP+Resources_Skills/02_MCP_Resources_Plugins.md), section 3 | What a plugin packs next to the tools, and where resources travel |
| [W2L2 15 Tool navigation and flexibility](../Week2_Lecture_2_Building_an_Agent/15_Tool_Navigation_And_Flexibility.md) | My OData contract, validation and docstrings against vendor advice |
| [W2L1 08 Tool search instead of many tools](../Week2_Lecture_1_Agent_Primitives/08_Tool_Search_Instead_Of_Many_Tools.md) | What loads at start and what loads on demand |

Open: which of my guidance is stable context and which is per case, which hosts read a resource on their own (an eval per host would show it, and it needs my yes), whether a `read_doc` tool over the same content is enough, and whether a stateless server needs a no-op `resources/subscribe` handler for Cursor. Before I present, I check whether another note repeats the idea that resources are stale.
