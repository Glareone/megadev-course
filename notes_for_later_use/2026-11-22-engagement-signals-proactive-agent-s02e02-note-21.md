# Steering the agent with activity events: my approach against the industry

Date: 2026-11-22
Topic: the agent reads events about my activity (busy, email opened, message read) and adjusts its behavior or stops some actions
Lecture: S02E02 Building an Agent, closing section (figure 15)

| Idea | What others use | Match |
|---|---|---|
| Adjust behavior from opens and reads | LangChain ambient agents: notify, question, review with user feedback. ProactiveBench: accept or reject labels and a reward model | Differs: the sources use explicit signals |
| Treat "email opened" as a signal | Email vendors: Apple Mail Privacy Protection prefetches images, so opens are inflated; clicks are recommended | Weak signal |
| Let the agent search and filter events | Not found in the sources I read | Lecture-specific |

Where it is written: [Lecture 2: 21](../Week2_Lecture_2_Building_an_Agent/21_Engagement_Signals_And_Proactive_Agents.md). Open: which channels give explicit signals, the minimum frequency, the consent policy.
