# Could my own agent's rules give the check and the explanation from one source?

Date: 2026-11-23
Topic: the lecture builds a return-policy resource from the same rules the eligibility check uses; I want to see whether my agent has rules that deserve the same treatment, and what keeps the text and the check from drifting apart
Lecture: S02E03 Agentic Capabilities, transcript part on resources (the policy resource and the eligibility checks)

I want to look at where my own rules live today (prompt, code, data) and which of them a user should be able to read. I found no published source for building prompt text and the check from one rule source. The closest I found is OPA, where a rule can carry annotations that feed both the documentation tools and the decision message.

Where the topic already appears:

| Where | What it holds |
|---|---|
| [03 Policy resource from the check rules](../Week2_Lecture_3_MCP_MCP+Resources_Skills/03_MCP_Resource_Policy_Text_From_The_Check_Rules.md) | The pattern, the question table (policy, case, refusal), the mapping to OPA, hooks and guardrails, the drift test idea |
| [01 MCP resources](../Week2_Lecture_3_MCP_MCP+Resources_Skills/01_MCP_Resources_Static_Context_By_URI.md), section 2 | Static content generated from rules as one resource form |
| [W2L1 05 Instructions and what code must enforce](../Week2_Lecture_1_Agent_Primitives/05_Instructions_Five_Parts_And_Enforcement.md) | A boundary in the prompt is a request, a rule in code is a guarantee |
| [W2L2 14 Execution flows](../Week2_Lecture_2_Building_an_Agent/14_Execution_Flows_Skill_Tool_Or_Workflow.md) | Which flows need enforcement |

Open: which rules are for customers and which must stay internal, whether a test that checks the generated text against every rule id is worth its cost, and whether the demo's rules sit in code or in data (the transcript does not show it).
