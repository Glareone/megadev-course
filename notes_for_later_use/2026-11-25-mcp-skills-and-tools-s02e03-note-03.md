# Review MCP skills and tools: how to map them, and whether to pilot it

Date: 2026-11-25
Review on: 2026-11-26, in the morning
Topic: the MCP Skills extension lets a server serve skills next to its tools; I want to decide how to map skills and tools, and whether to propose a pilot to my team, which resists the idea
Lecture: S02E03 Agentic Capabilities, part "Skills & Tools" (tools augmented with skills, figures 10 to 12, the `tool-skill-links` example)

I want to review this tomorrow morning. What I know now: the extension has no field that ties a skill to a tool, so the link is text on both sides. The lecturer's own test went from 0 of 3 to 3 of 3 styled images once the tool and the skills named each other. Claude Code and VS Code are said to have beta support, and ChatGPT and Codex are planned. Independent evals (Vercel, LlamaIndex) found skills often go unloaded, and I found no vendor recommending the lecturer's tool-names-skill link; the note lists both sides in section 7. The tool has to keep working without the skill. The note has a pilot plan: one tool with arguments the model cannot guess, two or three skills, a deterministic grader, and stop criteria.

Where the topic already appears:

| Where | What it holds |
|---|---|
| [03 MCP skills and tools](../Week2_Lecture_3_MCP_MCP+Resources_Skills/03_MCP_Skills_And_Tools.md) | The figures, the extension, host support, mapping patterns, the lecturer's test, the objections and the pilot |
| [02 MCP resources and plugins](../Week2_Lecture_3_MCP_MCP+Resources_Skills/02_MCP_Resources_Plugins.md) | Plugins as another way to ship a server with its skills |
| [10 Sys prompt vs skills content and threats](../Week2_Lecture_3_MCP_MCP+Resources_Skills/10_Sys_Prompt_vs_Skills_Content_And_Threats.md) | A server's skills as supply chain |
| [11 How to adjust the system prompt and make it flexible](../Week2_Lecture_3_MCP_MCP+Resources_Skills/11_How_To_Adjust_System_Prompt_And_Make_It_Flexible.md) | Where a skill's lines should live |

Open: which of my tools has arguments the model cannot guess, which of my hosts load server skills today, who approves a skill that a server serves, which objections from my team the pilot must answer, and the pilot itself (running it calls a paid API, so it needs my yes).
