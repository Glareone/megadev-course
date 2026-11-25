# MCP server instructions: set them, and check where they arrive

Date: 2026-11-25
Topic: an MCP server can send one text about itself (`instructions`) that a client may add to the system prompt; the lesson says most harnesses ignore or trim it; I have never used it
Lecture: S02E03 Agentic Capabilities, part "Model Context Protocol" (what to keep in mind when developing an MCP server)

I want to come back to this and add a short instruction to my own MCP server, then test where it arrives. What I know now: the TypeScript and Python SDKs both support it (in Python v2 I must pass it by keyword), Claude Code cuts it at 4,096 characters, Pi uses the server's configured description, or the first line of its instructions when none is set, for deferred servers, Codex is said to read it and advise a self-contained first 512 characters, and the Claude API connector probably does not use it (my inference: its docs only say it supports tool calls). For VS Code, OpenAI's MCP tool and DeepSeek's harnesses I found nothing.

Where the topic already appears:

| Where | What it holds |
|---|---|
| [08 MCP server instructions and harness support](../Week2_Lecture_3_MCP_MCP+Resources_Skills/08_MCP_Server_Instructions_And_Harness_Support.md) | What the field is, SDK support, the harness table, what to write |
| [01 MCP resources and sampling](../Week2_Lecture_3_MCP_MCP+Resources_Skills/01_MCP_Resources_Static_Context_And_Sampling.md) | Where longer guidance lives, and the per-host eval |
| [09 MCP tools loading and code mode with many servers](../Week2_Lecture_3_MCP_MCP+Resources_Skills/09_MCP_Tools_Loading_And_Code_Mode_With_Many_Servers.md) | Under tool search, names and server instructions are what loads first |
| [10 Sys prompt vs skills content and threats](../Week2_Lecture_3_MCP_MCP+Resources_Skills/10_Sys_Prompt_vs_Skills_Content_And_Threats.md) | A third-party server's instructions can get system-level placement |

Open: whether my server sets instructions today, which of my hosts show them to the model (an eval would tell, and running it needs my yes), and which guidance belongs in instructions, a resource or a skill.
