# One pending record for every confirmation channel

Date: 2026-11-24
Topic: my cards' buttons are HITL confirmations over AG-UI and A2A; for third-party hosts (Claude Code, Copilot, ChatGPT) I want to think about one server-held pending record that any channel can resolve, so that a click or a host approval is never the proof
Lecture: S02E03 Agentic Capabilities, transcript part on elicitation and MCP Apps (the `decide_exchange` tool with a signed reference), applied to my stateless MCP server

I want to come back to this and think about it again. The shape looks like this: the first call mints a record bound to the tenant, the principal and a hash of the parameters, a channel resolves it once, and the server checks and consumes it before the action runs. The lecturer calls this approach MCP elicitation and compares it with MCP Apps, and I agree with that comparison for confirmations. I do not know yet which actions need a server-verified confirmation, and whether my AG-UI interrupt id can be the same as the record id.

Where the topic already appears:

| Where | What it holds |
|---|---|
| [16 Human confirmation across channels](../Week2_Lecture_3_MCP_MCP+Resources_Skills/16_Human_Confirmation_Across_AG-UI_A2A_And_MCP_Channels.md) | The channels, why a click is not proof, the pending record, the stateless elicitation flow, my three hosts |
| [15 MCP Apps and the lecturer's preview tool](../Week2_Lecture_3_MCP_MCP+Resources_Skills/15_MCP_Apps_And_The_Lecturers_Preview_Tool.md) | A button in a View, app-only tools, fallback |
| [W2L1 14 Tool approval, durable waits](../Week2_Lecture_1_Agent_Primitives/14_Tool_Approval_Durable_Waits.md) | Approval before an irreversible action, with a saved wait |
| [20 Sandbox against jailbreak and prompt injection](../Week2_Lecture_3_MCP_MCP+Resources_Skills/20_Sandbox_Against_Jailbreak_And_Prompt_Injection_Per_Tenant.md) | Tenant checks and logging behind the server |

Open: which actions must use a server-verified channel, whether ChatGPT supports elicitation, what an A2A input-required message looks like for an approval, and how the AG-UI schema words its statuses.
