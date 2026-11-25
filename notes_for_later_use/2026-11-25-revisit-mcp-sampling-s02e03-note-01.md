# Revisit MCP sampling: the server asks the host to run an LLM call

Date: 2026-11-25
Topic: sampling lets an MCP server get a completion from the host's model, with no server API key; the lesson lists it as a live feature, the 2026-07-28 spec deprecates it, and I had never heard of it
Lecture: S02E03 Agentic Capabilities, part "Model Context Protocol" (resources, prompts and sampling, "support varies by client")

I want to come back to this and decide whether sampling has any place in my design. What I know now: the server nests the request inside a tool call, the host can show, edit and deny it, and the host picks the model. In the stateless spec it travels as an `InputRequiredResult` and a retry. The spec says new implementations should not adopt it and should call an LLM provider directly. VS Code Copilot supports it during an active turn with per-server approval, and I found nothing for Claude Code, Cursor or ChatGPT. I found no shipped server that uses it.

Where the topic already appears:

| Where | What it holds |
|---|---|
| [01 MCP resources and sampling](../Week2_Lecture_3_MCP_MCP+Resources_Skills/01_MCP_Resources_Static_Context_And_Sampling.md), section 5 | What sampling is, the stateless form, the deprecation, the host status, what I do |
| [13 MCP tools loading and code mode with many servers](../Week2_Lecture_3_MCP_MCP+Resources_Skills/13_MCP_Tools_Loading_And_Code_Mode_With_Many_Servers.md) | The multi-server picture that a server-side LLM call would sit in |
| [07 Sandbox against jailbreak and prompt injection](../Week2_Lecture_3_MCP_MCP+Resources_Skills/07_Sandbox_Against_Jailbreak_And_Prompt_Injection_Per_Tenant.md) | Why model calls triggered by untrusted data need a boundary |

Open: whether my MCP server has a task that needs a model (for example summarizing a large result before it returns), whether my own provider call is the better answer for keys, cost and data policy, whether any server I consume still depends on sampling, and when the spec removes it (the deprecation registry has the schedule, and I have not read it).
