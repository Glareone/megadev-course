# 25. Lee Robinson's always-on agents talk, as far as secondary sources show, matches most of what I already wrote; the primary video is still unread, so every talk claim here stays unverified

> The 45-minute Stanford CS146S talk on always-on agents describes a cloud agent that sleeps and wakes on triggers, a thin client with a thick server, state in a database and files, durable execution, a trigger router, dynamic tool discovery with a stable prefix, sub-agents and safeguards; I mapped each point to the notes I already have, found two points not yet covered (a retrieval escalation order, notification heuristics), and found two secondary sources that disagree on whether the talk names Temporal and Firecracker.

Related: [16 Memory-centric approach with events](16_Memory_Centric_Approach_With_Events.md) · [22 Long-horizon runs](22_Long_Horizon_Runs_Concurrency_Durability_Watchers.md) · [24 pi-durable in detail](24_Pi_Durable_How_It_Recovers_Long_Running_Tasks.md) · [10 Cache and context window](10_Cache_And_Context_Window.md) · [12 Sandbox for agent code](12_Sandbox_For_Agent_Code_Pi_And_Search_Execute.md) · [17 Auto penetration testing](17_Auto_Penetration_Testing_Of_My_Agent.md) · [21 Engagement signals](21_Engagement_Signals_And_Proactive_Agents.md) · [W2L1 14 Tool approval, durable waits](../Week2_Lecture_1_Agent_Primitives/14_Tool_Approval_Durable_Waits.md)

Source: S02E02 article, which links the talk as further viewing. The X post and the YouTube page could not be read (HTTP 402; no transcript). I read four secondary sources on 2026-11-22: the Lifeboat blog, a Digg post quoting the speaker's chapter list, an AI-generated YouTubeSummary page and the tianpan.co write-up. See [Fact-check](#fact-check).

## Glossary

| Term | What it means here | Same thing elsewhere | Not to be confused with |
|---|---|---|---|
| Always-on agent | A cloud agent that sleeps and wakes on messages, triggers and its own schedule | Ambient agent | A process that never stops |
| Thin client, thick server | Clients only show messages; the server runs the loop, tools and state | Server-side agent | A chat UI |
| Trigger router | Code that dedupes, prioritizes and batches events before they reach the agent | Event router | The agent's own search of events |
| Durable execution | Work that resumes after failure without repeating completed steps | Temporal, [24](24_Pi_Durable_How_It_Recovers_Long_Running_Tasks.md) | A job queue |

## 1. The problem

I want to come back to this talk and use it as a check on my own design. **What does it claim, how does it map to my notes, and what do I verify in the primary source?**

## 2. What is known about the talk

- **Speaker and date:** Lee Robinson, a 45-minute Stanford CS146S lecture, posted in October 2026 (Lifeboat).
- **Chapters** (from his post, quoted by Digg): 2:35 How we got here, 6:13 What changed in the models, 10:06 Inside an always-on agent, 18:07 The harness, 27:26 Context engineering, 34:26 Where this is going.
- **Slides:** Harrison Chase's post is said to share extracted screenshots (link in [Sources](#sources), not readable).
- **Video:** YouTube, `L1OBRtfPS34`.

## 3. The talk against my notes

All talk claims below come from secondary summaries.

| Claim in the summaries | Where I cover it |
|---|---|
| Runs in the cloud, not on a laptop; the server and the machine sleep and wake on a trigger; machine snapshots | [12](12_Sandbox_For_Agent_Code_Pi_And_Search_Execute.md) (micro-VM walls), [22](22_Long_Horizon_Runs_Concurrency_Durability_Watchers.md) (who wakes it) |
| Thin client, thick server; the client mostly handles "send to user" | The article's Channel in [16](16_Memory_Centric_Approach_With_Events.md) |
| State on the server: conversation, memory, routines; files for preferences, journals, skills, notes | [16](16_Memory_Centric_Approach_With_Events.md), [W2L1 10 to 13](../Week2_Lecture_1_Agent_Primitives/10_Memory.md) |
| Durable workflows resume without repeating completed steps, unlike plain job queues | [22](22_Long_Horizon_Runs_Concurrency_Durability_Watchers.md), [24](24_Pi_Durable_How_It_Recovers_Long_Running_Tasks.md), [08](08_Mastra_Workflow_Mapped_To_LangGraph.md) |
| Events are routed, de-duplicated, added to the right conversation, batched; heuristics decide whether to interrupt me | Dedupe keys in [22](22_Long_Horizon_Runs_Concurrency_Durability_Watchers.md). **Not covered:** the interrupt heuristics ([21](21_Engagement_Signals_And_Proactive_Agents.md) is close) |
| Skills as Markdown; plugins and connectors | [14](14_Execution_Flows_Skill_Tool_Or_Workflow.md), [15](15_Tool_Navigation_And_Flexibility.md) |
| Retrieval escalates: conversation, then files or APIs, then web, then browser or desktop, asking me last | **Not covered** |
| Dynamic tool discovery; stable prompts and tool definitions for the cache; long outputs to files; pruning and summarizing is hard to do well | [10](10_Cache_And_Context_Window.md), [19](19_Evict_Tool_Results_To_Memory_By_Reference.md), [W2L1 08](../Week2_Lecture_1_Agent_Primitives/08_Tool_Search_Instead_Of_Many_Tools.md) |
| Sub-agents with fresh context return only results | [11](11_Model_Routing_In_LangGraph.md), [W2L1 22](../Week2_Lecture_1_Agent_Primitives/22_Threads_Vs_A2A_Subagents.md) |
| Check commands, treat emails and webhooks as untrusted, approve irreversible actions, keep secrets out of the conversation | [17](17_Auto_Penetration_Testing_Of_My_Agent.md), [12](12_Sandbox_For_Agent_Code_Pi_And_Search_Execute.md) |
| Record errors, fix prompts, evaluate, maybe train | [20](20_Repair_Tool_Calls_Before_A_Step_Is_Spent.md), [W2L1 16](../Week2_Lecture_1_Agent_Primitives/16_Evals_For_Agent_Changes.md) |
| Better models make the interface simpler: direct it by talking, not by approving every command | [12](12_Sandbox_For_Agent_Code_Pi_And_Search_Execute.md) section 7 |

## 4. Where the secondary sources disagree

The tianpan.co write-up says its Temporal and Firecracker details are its own recommended implementation and go beyond what the talk confirms. The YouTubeSummary page, generated from the video, says the talk names both. I cannot settle it without the video.

## 5. To check in the primary source

1. Whether the talk names Temporal and Firecracker.
2. The retrieval escalation order and the interrupt heuristics, which I do not cover.
3. The "Context engineering" chapter (27:26) against my notes 10 and 19, including how it handles summarizing.
4. Which of my table's rows come from the slides and not the speech.

Ways to get it: watch the video with the chapter timestamps, paste the captions, or read Harrison Chase's slide screenshots.

## Summary

The secondary sources describe a design that my existing notes already cover almost point by point. Two points are new, and one factual question is open. Nothing from the talk is verified until I read the video or the slides.

## Open questions

- Does the talk name Temporal and Firecracker?
- What are the interrupt heuristics and the retrieval escalation order?
- Do I add notes for those two after I read the primary?

## Fact-check

| # | Claim | Verdict | Source | Checked |
|---|---|---|---|---|
| 1 | The talk is 45 minutes, by Lee Robinson, for Stanford CS146S, with six chapters | **Unverified** | [Digg](https://digg.com/ai/vra86c5o) quoting the speaker's post, [Lifeboat](https://lifeboat.com/blog/2026/10/stanford-cs146s-how-always-on-agents-work). The X post returned HTTP 402 | 2026-11-22 |
| 2 | Architecture, state, triggers, context practices, sub-agents, safeguards as in section 3 | **Unverified** | [YouTubeSummary](https://youtubesummary.com/summary/L1OBRtfPS34), AI-generated, and [tianpan.co](https://tianpan.co/notes/2026-10-21-designing-always-on-agent) | 2026-11-22 |
| 3 | The talk names Temporal and Firecracker | **Unverified**, sources disagree | Same two pages | 2026-11-22 |
| 4 | My notes cover the listed points | **Agrees** | The notes linked in section 3 | 2026-11-22 |

## Sources

- S02E02 article.
- [Digg post](https://digg.com/ai/vra86c5o) · [Lifeboat](https://lifeboat.com/blog/2026/10/stanford-cs146s-how-always-on-agents-work) · [YouTubeSummary](https://youtubesummary.com/summary/L1OBRtfPS34) · [tianpan.co](https://tianpan.co/notes/2026-10-21-designing-always-on-agent)
- The speaker's post (not readable): https://x.com/leerob/status/2108650243365736855 · slides thread (not read): https://x.com/hwchase17/status/2109297234864971878 · video: https://www.youtube.com/watch?v=L1OBRtfPS34
- My own reasoning: the mapping in section 3.
