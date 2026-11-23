# Which plugin format do I target when I ship a server with its skills?

Date: 2026-11-23
Topic: a host plugin packs an MCP server with skills, hooks and files, but each host names the manifest and the server file differently; I want to decide which format I would ship, and what I would give up
Lecture: S02E03 Agentic Capabilities, part "Skills & Tools" (tools augmented with skills)

I want to come back to this once I know which hosts I really use. The shared core is skills plus MCP servers, and VS Code reads the Claude and OpenPlugin layouts besides its own. I have not read the Cursor MCP keys, the Codex manifest or the Agent Plugins schema.

Where the topic already appears:

| Where | What it holds |
|---|---|
| [02 MCP resources and plugins](../Week2_Lecture_3_MCP_MCP+Resources_Skills/02_MCP_Resources_Plugins.md), section 2 | What each host plugin packs, the manifest file and where the server is declared |
| [02 MCP resources and plugins](../Week2_Lecture_3_MCP_MCP+Resources_Skills/02_MCP_Resources_Plugins.md), section 4 | A plugin can run arbitrary code, so the whole bundle is the unit I review |
| [W2L1 02 Rethinking the skills](../Week2_Lecture_1_Agent_Primitives/02_Rethinking_The_Skills.md) | How skills are written and loaded |

Open: which hosts I want to support, whether one layout loads in all of them, what happens to hooks and the server command when the host differs, and who approves an update that auto-updates in the background.
