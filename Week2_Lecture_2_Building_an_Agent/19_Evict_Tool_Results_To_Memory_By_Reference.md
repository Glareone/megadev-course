# 19. Evicting old tool results to my own store and leaving a reference is used on the market and matches published results; I do it in batches, because each eviction rewrites the prefix once

> Manus, Anthropic's context editing and LangChain's Deep Agents all drop old tool results from the context and keep a pointer, and a JetBrains and TUM study found that masking old observations roughly halves cost and matches LLM summarization on SWE-bench Verified; for my agent that means evict large old results to Runtime and Redis with a reference at a threshold below my 75% summarization, keep calls and decisions, and accept one cache miss per batch.

Related: [10 Cache and context window](10_Cache_And_Context_Window.md) · [09 Cache hit rate and P90](09_Cache_Hit_Rate_And_P90_Latency.md) · [16 Memory-centric approach with events](16_Memory_Centric_Approach_With_Events.md) · [17 Auto penetration testing](17_Auto_Penetration_Testing_Of_My_Agent.md) · [W2L1 25 Tool execution instead of tool calls](../Week2_Lecture_1_Agent_Primitives/25_Tool_Execution_Instead_Of_Tool_Calls.md) · [W2L1 06 Context window and compaction](../Week2_Lecture_1_Agent_Primitives/06_Context_Window_And_Compaction.md) · [W2L1 24 Prompt caching](../Week2_Lecture_1_Agent_Primitives/24_KV_Cache_And_Prompt_Caching.md)

Source: my agent: a loop that adds reasoning and tool results to the history, summarized at 75% of the window, with my own Runtime and Redis store. Manus's blog, Anthropic's context-editing docs and engineering article, LangChain's Deep Agents docs and two arXiv abstracts read on 2026-11-22 through fetch summaries. See [Fact-check](#fact-check).

## Glossary

| Term | What it means here | Same thing elsewhere | Not to be confused with |
|---|---|---|---|
| Eviction | Moving an old tool result out of the context into a store, leaving a reference | Offloading, restorable compression | Deleting it |
| Observation masking | Replacing old tool outputs with a placeholder | Tool result clearing | Summarizing |
| Reference | An ID, path or URL that lets the agent fetch the result again | Handle, file path | The result itself |
| Compaction | Summarizing the history into a shorter one | History compression | Eviction |

## 1. The problem

My agent's context grows with tool results, and I summarize at 75%. I want to evict old results to my own store and keep references. **Does anyone do this, what does the evidence say, and what does it do to the cache?**

## 2. Who does it

| Who | What | Detail |
|---|---|---|
| [Manus](https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus) | "Restorable compression": a web page's content is dropped while its URL stays, a document while its path stays. The file system is "the ultimate context" | Calls the KV-cache hit rate "the single most important metric". Reports about 100:1 input to output tokens and $0.30 against $3 per million tokens, cached against uncached |
| [Anthropic context editing](https://platform.claude.com/docs/en/build-with-claude/context-editing) | `clear_tool_uses_20250919` (beta) replaces the oldest results with placeholder text. Defaults: trigger at 100,000 input tokens, keep 3 recent uses. Options `clear_at_least`, `exclude_tools`, `clear_tool_inputs` | "Invalidates cached prompt prefixes", so clear enough to be worth it. With the memory tool, Claude is warned before clearing to save what matters |
| [Anthropic engineering](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) | Tool result clearing is "one of the safest lightest touch forms of compaction". Agents keep "lightweight identifiers (file paths, stored queries, web links)" | Notes persisted outside the context |
| [Deep Agents](https://docs.langchain.com/oss/python/deepagents/context-engineering) | A result over 20,000 tokens (default) goes to the backend, replaced by a path and the first 10 lines. The agent re-reads with `read_file` and `grep`. At 85% of the window, older file writes are truncated to a pointer, then older messages are summarized, keeping 10% | A text copy of the originals is kept as a record |
| [MemGPT](https://arxiv.org/abs/2310.08560) (2023) | "Virtual context management": the model moves data between context and external memory tiers | The earliest form of the idea |

Anthropic's own page calls server-side compaction "the primary strategy for managing context in long-running conversations" and clearing a tool for "more fine-grained control", so my 75% summary is the mainstream and eviction is the supplement. So it is used, by a production agent, a model vendor and a framework. My Runtime and Redis store is the "configured backend". The idea is not new, which makes it safer to adopt.

## 3. Eviction against summarization

| | Eviction by reference | Summarization at 75% |
|---|---|---|
| Extra model call | No | Yes, adds latency and cost |
| Detail | Whole result restorable | Lost unless I also store it |
| What it touches | Old tool results only | Everything old, including reasoning |
| Evidence | [The Complexity Trap](https://arxiv.org/abs/2508.21433) (JetBrains Research, TUM; v3 Oct 2025): masking roughly halves cost against the raw agent and matches LLM summarization's solve rate; a hybrid cuts a further 7% and 11% | The same paper: LLM summarization did not consistently beat masking |

The study is on SWE-bench Verified with SWE-agent, five model configurations, and a probe on OpenHands. It is a coding setting, so I treat it as a hypothesis for my agent.

## 4. The cache cost (my arithmetic)

An eviction rewrites earlier content, so the next call misses once and caches the new prefix. Anthropic says so and offers `clear_at_least` for that reason. With a cached read at 0.1× and a write at 1.25× ([W2L1 24](../Week2_Lecture_1_Agent_Primitives/24_KV_Cache_And_Prompt_Caching.md)), prefix `P`, evicted part `E`: the one-time extra is about `(P − E) × 1.15`, the saving per later call is about `E × 0.1`, so it pays back after about `11.5 × (P − E) ÷ E` calls.

| Evicted share of the prefix | Calls to pay back |
|---|---|
| 50% | about 11 |
| 80% | about 3 |
| 90% | about 1 |

So I evict big results, in batches, and many at once. Small results are not worth a miss. This fits Deep Agents' 20,000-token threshold. If the window forces me to cut anyway, the miss is unavoidable. The ratios are from note 24 and unchecked for GPT-6-luna.

## 5. Design for my store (my reasoning)

1. **Store, then replace.** Write the full result under an ID in Redis, tenant-scoped, with a TTL. Put a fixed placeholder in the context: ID, size, a short preview, how to read it.
2. **Threshold.** Evict when evictable tokens pass a limit well below 75%, oldest first, and keep the last K results and a never-evict list.
3. **Evict results, keep calls and decisions.** The agent still sees what it did and why.
4. **Read back at the end.** A `read_ref(id, offset, limit)` tool appends fragments, so the cache survives. The handle pattern is in [W2L1 25](../Week2_Lecture_1_Agent_Primitives/25_Tool_Execution_Instead_Of_Tool_Calls.md).
5. **Identity.** Reference IDs must be checked against the session's tenant, or a guessed ID reads another tenant's data ([17](17_Auto_Penetration_Testing_Of_My_Agent.md)).
6. **Journal.** Each eviction is an entry, so I can see what the agent no longer holds ([16](16_Memory_Centric_Approach_With_Events.md)).
7. **Keep the 75% summary** as a fallback for the reasoning text.
8. **Deterministic placeholder text**, so the rewritten prefix is stable afterwards.

## Summary

Evicting old tool results to a store with a reference is used by Manus, Anthropic and Deep Agents, and a masking study matches it with summarization at lower cost. For me it means a threshold-based batch eviction below 75%, calls and decisions kept, a read-back tool, tenant checks and a journal entry, measured on the golden set against summarization alone.

## Open questions

- How much of my context is tool results, and how many are over 20,000 tokens?
- How often does the agent need an old result again, and what does a read-back cost in steps?
- Does masking hurt answer quality on my golden set against summarization?
- What is GPT-6-luna's write and read price ratio?

## Fact-check

| # | Claim | Verdict | Source | Checked |
|---|---|---|---|---|
| 1 | Manus keeps references and drops content, treats the hit rate as the top metric, reports 100:1 and $0.30 against $3 | **Agrees** | [Manus blog](https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus), fetch summary. A company's own account | 2026-11-22 |
| 2 | Anthropic clears old tool results with a placeholder, defaults 100,000 and 3, the clearing invalidates the cache, and server-side compaction is the primary strategy | **Agrees** | [Context editing](https://platform.claude.com/docs/en/build-with-claude/context-editing), last 2,210 characters unread. Beta | 2026-11-22 |
| 3 | Tool result clearing is a light form of compaction; agents keep lightweight identifiers | **Agrees** | [Anthropic engineering](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents), fetch summary | 2026-11-22 |
| 4 | Deep Agents offloads results over 20,000 tokens with a path and 10-line preview, summarizes at 85% | **Agrees** | [Context engineering](https://docs.langchain.com/oss/python/deepagents/context-engineering). It does not mention the cache | 2026-11-22 |
| 5 | Masking halves cost and matches summarization's solve rate on SWE-bench Verified; hybrid saves 7% and 11% | **Agrees** | [arXiv 2508.21433](https://arxiv.org/abs/2508.21433), abstract. Figures such as "84% of a turn" come from a search summary: **Unverified** | 2026-11-22 |
| 6 | MemGPT manages context and external memory tiers | **Agrees** | [arXiv 2310.08560](https://arxiv.org/abs/2310.08560), abstract only | 2026-11-22 |
| 7 | "I am not sure anyone on the market uses it" | **Differs** | Rows 1 to 4 | 2026-11-22 |
| 8 | The payback arithmetic and thresholds | **Unverified** | My reasoning with the note 24 ratios | 2026-11-22 |

## Sources

- My agent's setup: history summarization at 75%, Runtime and Redis.
- [Manus](https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus) · [Anthropic context editing](https://platform.claude.com/docs/en/build-with-claude/context-editing) · [Anthropic context engineering](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) · [Deep Agents](https://docs.langchain.com/oss/python/deepagents/context-engineering)
- [The Complexity Trap](https://arxiv.org/abs/2508.21433) · [MemGPT](https://arxiv.org/abs/2310.08560)
- My own reasoning: the arithmetic in section 4 and the design in section 5.
