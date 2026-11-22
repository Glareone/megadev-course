# Wake and reflection: my interest against the market

Date: 2026-11-22
Topic: an agent that wakes on a schedule it set, logs actions in a journal, writes insights to documents and reflects on both before the next wake-up
Lecture: S02E02 Building an Agent, closing section (figure 14)

| Idea | What the market and research show | Match |
|---|---|---|
| Scheduled wake with memory and feedback | ChatGPT Pulse: nightly research from memory, chat history and feedback, once a day, preview | Close, fixed cadence |
| Reflection on memory in the background | Letta dreaming, LangMem; Generative Agents, Reflexion, sleep-time compute | Used and studied |
| The agent sets its own next wake-up | Possible with Cloudflare `schedule()` and Claude Code `/loop`; no product found that publishes it as its core loop | Capability exists, adoption not shown |
| Reflection improves the agent over time | Works with external feedback; models struggle to self-correct without it (ICLR 2024) | Needs outside signals |

Where it is written: [Lecture 2: 23](../Week2_Lecture_2_Building_an_Agent/23_Wake_And_Reflect_Agents_On_The_Market.md). Open: which outside signals my loop sees, and an ablation with and without reflection.
