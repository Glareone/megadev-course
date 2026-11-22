# 23. Wake-and-reflect agents exist as products and have research behind them, but reflection without an outside signal can make results worse, so my loop reads my feedback as well as its own journal

> A scheduled wake, a journal and insight documents, and a reflection step before the next wake-up appear in ChatGPT Pulse, Letta's dreaming and LangMem's background memory, and in Generative Agents, Reflexion and sleep-time compute; I found no product that publishes the agent setting its own next wake-up as its core loop, and a 2024 ICLR paper finds that models struggle to self-correct without external feedback, so I add explicit signals, evidence links, expiry and an ablation to the design.

Related: [16 Memory-centric approach with events](16_Memory_Centric_Approach_With_Events.md) · [21 Engagement signals](21_Engagement_Signals_And_Proactive_Agents.md) · [22 Long-horizon runs](22_Long_Horizon_Runs_Concurrency_Durability_Watchers.md) · [19 Evict tool results to memory](19_Evict_Tool_Results_To_Memory_By_Reference.md) · [09 Cache hit rate and P90](09_Cache_Hit_Rate_And_P90_Latency.md) · [W2L1 13 Memory operations](../Week2_Lecture_1_Agent_Primitives/13_Memory_Operations.md) · [W2L1 11 Memory known problems](../Week2_Lecture_1_Agent_Primitives/11_Memory_Known_Problems.md)

Source: S02E02 article, "Workflows and long-horizon tasks" (figure 14). OpenAI's Pulse announcement, Letta and LangMem docs, and arXiv abstracts read on 2026-11-22 through fetch summaries. See [Fact-check](#fact-check).

## Glossary

| Term | What it means here | Same thing elsewhere | Not to be confused with |
|---|---|---|---|
| Wake-and-reflect loop | A scheduled run that acts, logs, then reads its memory to decide the next wake-up | Ambient agent with memory | A fixed cron job |
| Reflection | Reading past runs and insights to draw conclusions or change plans | Generative Agents reflection, Reflexion, Letta dreaming | Summarizing a chat |
| Memory between runs | The Journal (past runs) and Documents (insights) | MemFS, store, notes | A conversation history |
| Sleep-time compute | Work done between queries to prepare for the next one | Letta, arXiv 2504.13171 | Test-time reasoning |
| External signal | Feedback from outside the model: my thumbs, a test result, a click | Task feedback in Reflexion | The agent's own opinion |

## 1. The problem

The article's loop: a schedule wakes the agent, it scans activity, logs its actions in the Journal and writes insights to Documents; reflection reads both before the next wake-up and sets it. **How well adopted is this on the market, and what does the evidence say?**

![The article's wake-and-reflect loop. A Schedule set by the agent wakes an Agent run that scans activity. The run logs actions in the Journal (past runs) and writes insights to Documents. Both sit in a red frame, "Memory between runs". Reflection reads the past runs and the past insights, and sets the next wake-up on the Schedule.](img/schedule-wake-reflection-memory-between-runs.png)

Source: S02E02 article, figure 14. Caption: "Each run logs its actions in the Journal and writes what it learned to Documents. Reflection reads both before the next wake-up, so the agent can observe and learn about us over time."

- **Important:** reflection reads two stores, what happened (Journal) and what was learned (Documents), and it also decides when to wake. The agent owns its schedule.
- **Not important:** the box positions.

## 2. On the market

| Who | What | Compared with the loop |
|---|---|---|
| [ChatGPT Pulse](https://openai.com/index/introducing-chatgpt-pulse/) (OpenAI, 25 Sep 2025, preview for Pro on mobile) | Each night it "synthesizes information from your memory, chat history, and direct feedback" and delivers cards once a day. Thumbs up or down, topic requests | The closest product: scheduled wake, memory, my feedback. The cadence is fixed daily, and the page does not say the agent sets it |
| [Letta](https://docs.letta.com/guides/agents/architectures/sleeptime) | "Dreaming": background subagents consolidate lessons into git-backed memory after N steps or at compaction, with optional review before applying | Reflection on memory, triggered by activity and not by a wake-up the agent chose |
| [LangMem](https://langchain-ai.github.io/langmem/background_quickstart/) | Background memory manager. It warns that processing every message "can be expensive", and points to a delayed-processing guide (not read) | Deferred reflection |
| Claude Code `/loop`, Cloudflare `schedule()` | The agent can set its own next wake-up ([16](16_Memory_Centric_Approach_With_Events.md)) | The scheduling part exists as a capability |

## 3. What the research says

| Paper | Finding |
|---|---|
| [Generative Agents](https://arxiv.org/abs/2304.03442) (2023) | A natural-language record of experience, synthesized into "higher-level reflections"; ablations show observation, planning and reflection each "contribute critically to the believability" |
| [Reflexion](https://arxiv.org/abs/2303.11366) (2023) | Verbal reflections stored in an episodic memory, driven by task feedback; 91% pass@1 on HumanEval against 80% for GPT-4 |
| [Sleep-time compute](https://arxiv.org/abs/2504.13171) (2025) | Precomputing between queries: about 5× less test-time compute for the same accuracy, up to 13% and 18% higher accuracy on two benchmarks; best when queries are predictable |
| [Cannot self-correct yet](https://arxiv.org/abs/2310.01798) (ICLR 2024) | Models "struggle to self-correct their responses without external feedback", and performance "at times ... even degrades" |

The last row is the caution: Reflexion has task feedback, and Pulse has thumbs. My loop reads its own journal, which is internal. The paper is on reasoning tasks, so its transfer to memory reflection is untested.

## 4. Design checks (my reasoning)

| Risk | Guard |
|---|---|
| A wrong insight persists in Documents | Each insight links to the journal entries behind it, carries a date and an expiry, and can be reviewed (Letta offers a review step) |
| Reflection with no outside signal drifts | Feed it explicit feedback and aggregates ([21](21_Engagement_Signals_And_Proactive_Agents.md)) |
| Reflection runs when nothing changed | Run it only if the journal has new entries since the last wake |
| A runaway schedule | Minimum and maximum interval, a daily wake budget ([16](16_Memory_Centric_Approach_With_Events.md)) |
| Cold cache at each wake | Keep the wake prefix small ([09](09_Cache_Hit_Rate_And_P90_Latency.md)) |
| Lost updates between runs | Append-only journal, a version check on documents ([22](22_Long_Horizon_Runs_Concurrency_Durability_Watchers.md)) |

**Test it:** run the agent for a few weeks with reflection and without it, like the ablations in the Generative Agents paper, and compare acceptance rate, tokens per wake and number of wakes.

## Summary

Each part of the loop is available: Pulse for a scheduled, memory-driven product, Letta and LangMem for background reflection, Cloudflare and Claude Code for self-scheduling. The research supports reflection when it has feedback. I add outside signals, evidence links with expiry, and an ablation.

## Open questions

- Which outside signals does my loop see: thumbs, replies, clicks?
- Is the agent allowed to change its own cadence, and within what bounds?
- Does reflection on my Journal change the answers, measured against a run without it?

## Fact-check

| # | Claim | Verdict | Source | Checked |
|---|---|---|---|---|
| 1 | Pulse researches overnight from memory, chat history and feedback, once a day, in preview | **Agrees** | [OpenAI](https://openai.com/index/introducing-chatgpt-pulse/), fetch summary | 2026-11-22 |
| 2 | Letta runs background consolidation after N steps or at compaction | **Agrees** | [Letta docs](https://docs.letta.com/guides/agents/architectures/sleeptime), fetch summary | 2026-11-22 |
| 3 | LangMem processes memory in the background and warns about per-message cost | **Agrees** in part | [LangMem](https://langchain-ai.github.io/langmem/background_quickstart/). The delayed-processing guide and `ReflectionExecutor` were not read | 2026-11-22 |
| 4 | Reflection, planning and observation each contribute to believability | **Agrees** | [arXiv 2304.03442](https://arxiv.org/abs/2304.03442), abstract; no numbers on reflection alone | 2026-11-22 |
| 5 | Reflexion 91% pass@1 against 80% | **Agrees** | [arXiv 2303.11366](https://arxiv.org/abs/2303.11366), abstract | 2026-11-22 |
| 6 | Sleep-time compute: about 5× less compute, up to 13% and 18% | **Agrees** | [arXiv 2504.13171](https://arxiv.org/abs/2504.13171), abstract | 2026-11-22 |
| 7 | Models struggle to self-correct without external feedback | **Agrees**, for reasoning tasks | [arXiv 2310.01798](https://arxiv.org/abs/2310.01798), abstract. Transfer to memory reflection **Unverified** | 2026-11-22 |
| 8 | An agent that sets its own next wake-up is a widely adopted core loop | **Unverified** | Found as capability (Cloudflare, Claude Code), not as a published product loop | 2026-11-22 |
| 9 | The design: schedule, journal, documents, reflection | **Lecture-specific** | S02E02 article, figure 14 | 2026-11-22 |

## Sources

- S02E02 article, figure 14.
- [ChatGPT Pulse](https://openai.com/index/introducing-chatgpt-pulse/) · [Letta](https://docs.letta.com/guides/agents/architectures/sleeptime) · [LangMem](https://langchain-ai.github.io/langmem/background_quickstart/)
- [Generative Agents](https://arxiv.org/abs/2304.03442) · [Reflexion](https://arxiv.org/abs/2303.11366) · [Sleep-time compute](https://arxiv.org/abs/2504.13171) · [Cannot self-correct yet](https://arxiv.org/abs/2310.01798)
- My own reasoning: the guards table and the ablation.
