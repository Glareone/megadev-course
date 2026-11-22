# 21. Engagement events can steer a proactive agent, but opens and read receipts are weak signals, so I use them only as bounded hints with a floor that keeps the agent from going silent

> The article lets the agent read events about my activity (busy, email opened, message read) and adjust what it does and how often; LangChain's ambient-agent work and the ProactiveBench paper use explicit accept or reject as the signal, while email vendors warn that opens are inflated by image prefetching, so I rank signals by strength, feed the agent aggregates and not raw events, bound what it may change, and keep a minimum digest.

Related: [16 Memory-centric approach with events](16_Memory_Centric_Approach_With_Events.md) · [22 Long-horizon runs](22_Long_Horizon_Runs_Concurrency_Durability_Watchers.md) · [23 Wake and reflect on the market](23_Wake_And_Reflect_Agents_On_The_Market.md) · [17 Auto penetration testing](17_Auto_Penetration_Testing_Of_My_Agent.md) · [09 Cache hit rate and P90](09_Cache_Hit_Rate_And_P90_Latency.md) · [Lecture 3: 12 Knowledge update triggers](../Lecture_3_Simplify_Codebase_&_Knowledge_Base/12_Knowledge_Event_&_Triggers.md) · [Lecture 1: 17 Ambient, durable agents](../Lecture_1_Mechanics_Behind_Generative_AI/17_ambient_durable_agents.md)

Source: S02E02 article, "Workflows and long-horizon tasks" (figure 15). LangChain's ambient-agents post, the arXiv abstract of ProactiveBench and email-vendor pages on Apple Mail Privacy Protection, read on 2026-11-22 through fetch and search summaries. See [Fact-check](#fact-check).

## Glossary

| Term | What it means here | Same thing elsewhere | Not to be confused with |
|---|---|---|---|
| Engagement event | A record of what I did with the agent's output or my own activity: opened, read, busy | Implicit feedback | A command |
| Explicit signal | I accept, reject, reply or approve | Accept or reject labels, review in LangChain's patterns | A guess from behavior |
| Weak signal | An open or a read receipt | Open rate | Proof that I read it |
| Aggregate | A count over a window, such as "digests read in 4 weeks: 1 of 4" | Engagement rate | A raw event list |
| Floor | The minimum the agent still sends or checks | Exploration rate | A schedule I set once |

## 1. The problem

The article says the agent can use events to learn my activity level and whether I opened its last email or read its message, then adjust or stop actions. **What do others say about steering an agent with such signals, and what can go wrong?**

![The article's figure of engagement events. The Harness adds Events to a stream: activity busy, email opened, message read, and more through events.add. A red line "search, filter" leads to the Agent, which adjusts behavior. The agent acts through Actions: a Document saves insights, a Channel responds, a Schedule creates a wake-up. A dashed line wakes the agent up again from the Schedule.](img/events-activity-search-filter-actions-wake-up.png)

Source: S02E02 article, figure 15. Caption: "Events tell the agent about the user's activity. The agent searches and filters them, and then saves insights, responds or creates schedules that wake it up again."

- **Important:** the agent searches and filters the events, so events are data the agent reads, not triggers that always fire it. The harness writes them with `events.add`.
- **Not important:** the exact event names, which are examples.

## 2. What others say

| Source | What it says | What it leaves out |
|---|---|---|
| [LangChain, ambient agents](https://www.langchain.com/blog/introducing-ambient-agents) (14 Jan 2025) | Agents "listen to an event stream and act on it". Three human-in-the-loop patterns: notify, question, review, where review lets the user approve, edit or give feedback. That feedback supports long-term learning | It gives no guidance on how often to interrupt, and does not use opens or reads |
| [ProactiveBench](https://arxiv.org/abs/2410.12361) (arXiv 2410.12361, Dec 2024) | Real activity events, proposals labeled accepted or rejected by people, a reward model trained on them, 6,790 events, F1 66.47% for proactively offering assistance | When to stay silent is not detailed in the abstract |
| Email vendors (Bird, Postmark, Mailchimp, Bloomreach; search summary) | Apple Mail Privacy Protection prefetches images, so a pixel fires without a read and opens are inflated. Gmail and Yahoo cache images too. They recommend clicks or conversions | Vendor pages with a commercial interest. I did not read Apple's own documentation |

So the sources use explicit accept, reject, review and click, not opens.

## 3. Signal strength (my reasoning)

| Strength | Signals | Use |
|---|---|---|
| Explicit | Approve, reject, reply, edit, "less of this" | Change behavior directly |
| Medium | A click on a link in the digest, a note edited after it | Adjust within bounds |
| Weak | Email opened, message read, "busy" | A hint only. An open can come from a prefetch |

## 4. Design (my reasoning)

1. **Aggregates, not raw events.** The agent reads "1 of 4 digests clicked", which also saves context ([10](10_Cache_And_Context_Window.md)).
2. **Bounded change.** The agent may move volume and frequency between a minimum and a maximum, never switch itself off ([16](16_Memory_Centric_Approach_With_Events.md)).
3. **A floor against a silence spiral.** If weak signals drop, a quiet agent sends less, which produces fewer signals. A minimum digest keeps the loop alive and lets me answer.
4. **Log each adjustment** with the signals behind it, so I can undo it.
5. **Consent.** Tracking opens, reads and activity of other people needs a stated policy. I check it before I use it for tenants.
6. **Trust.** Events that come from outside, such as a feed or a mail body, are untrusted input ([17](17_Auto_Penetration_Testing_Of_My_Agent.md)).
7. **Evaluate:** acceptance rate against ignore rate over a window, the ProactiveBench idea in small.

## Summary

Engagement events can steer the agent, but the sources that work on proactive agents rely on explicit accept or reject, and email opens are unreliable. I feed the agent aggregates of strong and medium signals, bound what it can change, keep a floor and log each adjustment.

## Open questions

- Which of my channels give explicit signals, and which only weak ones?
- What are the minimum and maximum frequency and volume for each agent?
- Whose activity does the agent see, and what is the consent policy for tenants?

## Fact-check

| # | Claim | Verdict | Source | Checked |
|---|---|---|---|---|
| 1 | The agent can use activity events to adjust behavior | **Lecture-specific** | S02E02 article, figure 15 | 2026-11-22 |
| 2 | Ambient agents act on an event stream; notify, question and review are the human-in-the-loop patterns; no interrupt-frequency guidance | **Agrees** | [LangChain](https://www.langchain.com/blog/introducing-ambient-agents), fetch summary | 2026-11-22 |
| 3 | A reward model trained on accept or reject labels, 6,790 events, F1 66.47% | **Agrees** | [arXiv 2410.12361](https://arxiv.org/abs/2410.12361), abstract | 2026-11-22 |
| 4 | Apple Mail Privacy Protection makes email opens unreliable | **Agrees**, vendor sources | Search summary of Bird, Postmark, Mailchimp and others. Verify against Apple's documentation | 2026-11-22 |
| 5 | A floor prevents a silence spiral; aggregates beat raw events | **Unverified** | My reasoning | 2026-11-22 |

## Sources

- S02E02 article, figure 15 and the closing section.
- [LangChain: introducing ambient agents](https://www.langchain.com/blog/introducing-ambient-agents) · [ProactiveBench, arXiv 2410.12361](https://arxiv.org/abs/2410.12361) · email vendor pages on Apple Mail Privacy Protection (search summary)
- My own reasoning: the signal ranking and the design list.
