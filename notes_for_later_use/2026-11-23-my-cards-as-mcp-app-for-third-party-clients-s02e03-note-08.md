# Should my own cards also live on my MCP server as an MCP App?

Date: 2026-11-23
Topic: my project shows cards in my own UI; I want to think about shipping the same cards as an MCP App (a `ui://` HTML resource linked to a tool) so that third-party clients can show them, with a text fallback for hosts that cannot
Lecture: S02E03 Agentic Capabilities, transcript part on elicitation and MCP Apps (the `preview_exchange` tool, the `decide_exchange` tool, the branded proposal)

I want to get back to this a little later and think about it again. The sound base looks like one data contract for the cards, with my UI and a bundled View as two renderers. I do not know how my cards are built, who the third-party clients are, or whether my cards need buttons that call tools.

Where the topic already appears:

| Where | What it holds |
|---|---|
| [08 MCP Apps and the lecturer's preview tool](../Week2_Lecture_3_MCP_MCP+Resources_Skills/08_MCP_Apps_And_The_Lecturers_Preview_Tool.md) | How an MCP App works, the fallback, security, the market, four options for my cards |
| [01 MCP resources](../Week2_Lecture_3_MCP_MCP+Resources_Skills/01_MCP_Resources_Static_Context_By_URI.md) | `ui://` as a resource form, and Claude Code hiding it from its list |
| [07 Sandbox against jailbreak and prompt injection](../Week2_Lecture_3_MCP_MCP+Resources_Skills/07_Sandbox_Against_Jailbreak_And_Prompt_Injection_Per_Tenant.md) | Tenant checks stay behind the server when a View calls tools |

Open: which hosts my users run, whether the card renderer fits one self-contained HTML file, whether a click must call a tool, whether Claude Code and Microsoft 365 Copilot render apps, and whether a smaller step (elicitation for confirmations) is enough.
