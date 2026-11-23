# Review the sandbox protection against jailbreak and prompt injection

Date: 2026-11-23
Topic: protecting a code execution sandbox against jailbreak and prompt injection so that no tenant's data can reach another tenant; I want to review the ten rules and the wall choice again before my agent gets code capabilities
Lecture: S02E03 Agentic Capabilities, transcript part on code mode (the model writes a program that calls the tools), applied to my multi-tenant agent

I want to come back to this note in the future and review it with fresh eyes. It says I cannot promise that injection fails, and that the promise I can make is structural: a tenant-bound tool bridge, a per-tenant wall with no secrets and no egress, and tests that assume the model is already compromised. No rule is tested yet, and I have not chosen a wall or a provider.

Where the topic already appears:

| Where | What it holds |
|---|---|
| [07 Sandbox against jailbreak and prompt injection](../Week2_Lecture_3_MCP_MCP+Resources_Skills/07_Sandbox_Against_Jailbreak_And_Prompt_Injection_Per_Tenant.md) | What no source promises, the attack paths, the tool bridge, wall strength, rules R1 to R10, tests |
| [W2L2 17 Auto penetration testing of my agent](../Week2_Lecture_2_Building_an_Agent/17_Auto_Penetration_Testing_Of_My_Agent.md) | Synthetic tenants and canaries for authorization attacks |
| [04 Workspaces and code sandboxes in frameworks](../Week2_Lecture_3_MCP_MCP+Resources_Skills/04_Workspaces_And_Code_Sandboxes_In_Frameworks.md) and [05 Where the sandbox attaches](../Week2_Lecture_3_MCP_MCP+Resources_Skills/05_Where_The_Sandbox_Attaches_Tool_Node_Backend_Or_Run_Config.md) | Which frameworks give a sandbox and where it plugs in |
| [Lecture 5: 10 Fleet lab threat model](../Lecture_5_Workflows_not_tool_sets/10_Fleet_Lab_Threat_Model.md) | The same risks mapped to OWASP for my fleet lab |

Open: which wall and provider fit and who approves them, whether my bridge can give the program tools without exposing the token, who writes the program's output to Redis memory, whether the unread papers (the six design patterns) and Meta's "Rule of Two" change the rules. Running any test needs my explicit yes.
