# Lecture 4 — Working with AI Harnesses

Source: S01E04 transcript + lecture video + web research.

## Files

| # | File | Topic |
|---|---|---|
| 01 | [Harness Lock-in — Keep Doors Open](01_Harness_Lock-in_Keep_Doors_Open.md) | How to avoid getting locked into one AI coding harness. The harness is a replaceable middle layer — keep substance in the repo (AGENTS.md, skills, MCP), not in vendor features. |
| 02 | [Agent Runner Portability](02_Agent_Runner_Portability.md) | How to architect my own agent systems so nothing is welded to one provider. Plugin architecture, adapter boundaries, runner contracts, open protocols. Six evaluation questions I can use against any agent runner. |
| 03 | [Skill and Folder Orchestration](03_Skill_And_Folder_Orchestration.md) | How to organize skills by harness, scope, and origin. Treating skills like dependencies with upstream tracking. Folder structure for the agent fleet (fleet pattern) and per-project orchestration (limen pattern). |
| 04 | [COMPUTERS.md — Fleet Infrastructure](04_Computers_md_Fleet_Infrastructure.md) | Machine registry and provisioning runbook. Treating agent environments like infrastructure: registry, desired state, reconciliation. Maps to A2A service discovery for the agentic platform. |
| 05 | [Don't Overspecify — Work at the Assistants Level](05_Dont_Overspecify_Work_At_Assistants_Level.md) | The stack is Code → LLMs → Harnesses → Assistants. Overspecifying lower layers is a trap — models outgrow them. Keep value at the Assistants level (skills, knowledge, vision). |
| 06 | [Self-Management — Pi and Herdr](06_Self_Management_Pi_Herdr.md) | Agents that read their own docs, change their own settings, and spawn workers that survive a closed terminal. **Draft** — Pi/Herdr claims unverified. |
| 07 | [Multi-Agent Coordination](07_Multi_Agent_Coordination.md) | Coordinator, workers, supervisor. Files as messages, git worktrees, vision and styleguide. Code does only what text cannot. **Draft.** |
| 08 | [Settings — Model Routing and Cost](08_Settings_Model_Routing_Cost.md) | SOTA × effort grid, cost per task instead of token price, deterministic privacy boundary. **Draft.** |
| 09 | [Teamwork — Knowledge Base and Tool Stack](09_Teamwork_Knowledge_Base_Tool_Stack.md) | Internal knowledge base on a remote server, AI-friendly tool stack, three ways to share skills. **Draft.** |
| 10 | [Automation — Repository Agents](10_Automation_Repository_Agents.md) | Trigger → agent → human loop. PR review, issue to PR, doc updates, small fixes. **Draft.** |
| 11 | [Cloud Coding Agents](11_Cloud_Coding_Agents.md) | Two things share the name "cloud agent": ready-made coding agents in a remote VM (Cursor, Claude Code cloud) vs hosting platforms for my own agent (AgentCore, Foundry). Comparison table, vendor-doc facts, self-hosted variants, open questions to return to. |
