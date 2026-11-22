# Evict tool results to memory and keep references: my idea against the industry

Date: 2026-11-22
Topic: my agent piles up reasoning and tool results and I summarize at 75%; my idea is to evict old results to my own Runtime and Redis store and keep references
Lecture: S02E02 Building an Agent, part "Context management" (my own agent)

| My approach | What the industry does | Match |
|---|---|---|
| Evict old tool results, keep a reference | Manus: restorable compression (URL or path stays). Anthropic: tool result clearing with a placeholder. Deep Agents: results over 20,000 tokens offloaded with a path and a 10-line preview | Same idea, in production |
| My own store (Runtime and Redis) | Deep Agents: a configured backend. Manus: the file system. Anthropic: the memory tool | Same pattern, different store |
| Summarize at 75% | Anthropic: server-side compaction is "the primary strategy" for most uses, clearing is for fine-grained control. Deep Agents: summarizes at 85% and keeps 10% | Mainstream, my threshold is earlier |
| Expect it to cut cost and keep quality | A JetBrains and TUM study: masking halves cost and matches summarization on SWE-bench Verified, a coding setting | Supported there, untested on my agent |
| Evict every time it is possible | Anthropic: clearing invalidates the cache, so clear enough to be worth it | Differs: I batch |

Where it is written: [Lecture 2: 19](../Week2_Lecture_2_Building_an_Agent/19_Evict_Tool_Results_To_Memory_By_Reference.md). Open: how much of my context is tool results, how often the agent needs an old result again, whether masking hurts quality on my golden set. My code and logs are not reachable from my personal Mac.
