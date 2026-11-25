# Review my prompts and skills after the move to gpt-6-luna

Date: 2026-11-25
Topic: I moved my agent from `gpt-5.4-mini` to `gpt-6-luna`. My skills are verbose and I have already started reviewing them. I want to make sure they live together with the three prompt pieces (platform, agent archetype, system), which speak about slightly different aspects, and that the whole set works on the modern OpenAI and Anthropic models
Lecture: S02E03 Agentic Capabilities, part "Personalization" (principles over procedures, the reason behind a principle, dynamic boundaries, default behavior, preferences, extensibility)

I want to come back to this and do the review as a relocation exercise with an eval behind it: for each line of the three pieces and the skills, where should it live, and what does the move change. Things to find: lines repeated in two or more skills (promote), layer lines that one skill needs (demote), fixed sequences that should be scripts, compensation lines for the old model, and whether the 5,000-character `<loaded_skill>` forces the split. The lecturer's `rule-with-reason` example is my template for testing a reason: rule alone against rule with reason, at my effort setting, graded by code.

Where the topic already appears:

| Where | What it holds |
|---|---|
| [12 Relocating instructions between layers, skills, code and tools](../Week2_Lecture_3_MCP_MCP+Resources_Skills/12_How_To_Adjust_System_Prompt_And_Make_It_Flexible.md) | A ten-question test for where each line should live, what a move changes, moves for verbose skills, the order of operations |
| [W2L1 02 Rethinking the skills](../Week2_Lecture_1_Agent_Primitives/02_Rethinking_The_Skills.md) | OpenAI's recommendations for skills and AGENTS.md on newer models |
| [W2L1 05 Instructions, five parts and my tagged chapters](../Week2_Lecture_1_Agent_Primitives/05_Instructions_Five_Parts_And_Enforcement.md) | My layout of tagged chapters |
| [11 Instruction precedence and tool pollution](../Week2_Lecture_3_MCP_MCP+Resources_Skills/11_Sys_Prompt_vs_Skills_Content_And_Threats.md) | Where a skill ranks against my layers |
| [10 Self-evolution of the harness](../Week2_Lecture_3_MCP_MCP+Resources_Skills/10_Self_Evolution_Of_Harness_On_Event.md) | The review loop and the assumption register |

Open: which effort Luna needs before it applies a reason, whether the GPT-6.2 migration advice holds for Luna, and what replaces OpenAI's prompt optimizer and Evals platform after 2026-11-30. Running the lecturer's example or my own evals calls a paid API, so it needs my explicit yes.
