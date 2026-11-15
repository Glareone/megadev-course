# 10. Memory: relations, placement, search, readable pieces, and what stays immutable or append-only

> Modern agent memory keeps an immutable raw layer, derives facts that link back to it and are superseded rather than overwritten, loads a small profile always and everything else on demand, searches by several methods, and lets the agent read small addressable pieces; my flat store with RediSearch BM25 covers search and placement, and the open questions are relations, a raw layer and supersede links.

Related: [13 Memory operations](13_Memory_Operations.md) · [06 Context window and compaction](06_Context_Window_And_Compaction.md) · [04 HITL and execution isolation](04_HITL_And_Execution_Isolation.md) · [12 Audit ledger](12_Memory_Audit_Ledger_In_Memory_Or_State.md) · [25 Tool execution instead of tool calls](25_Tool_Execution_Instead_Of_Tool_Calls.md) · [07 Tools: awareness, discovery, gateway](07_Context_Tool_Awareness_Avoids_Compression.md) · [15 Evals and traces](16_Evals_For_Agent_Changes.md) · [Lecture 1: 15 Self-querying](../Lecture_1_Mechanics_Behind_Generative_AI/15_self_querying.md)

Source: S02E01 article, "Context and Memory" (figures 19 to 23) and the Mastra demo in the transcript (worked example only). Memory docs and papers of Anthropic, Claude Code, Letta, Mem0, Zep, LangMem and Hindsight, Redis search docs and the LongMemEval paper, read through fetch agents on 2026-11-15. My own memory (flat, RediSearch BM25) is the case I review against. See [Fact-check](#fact-check).

## Glossary

| Term | What it means here | Same thing elsewhere | Not to be confused with |
|---|---|---|---|
| Memory | Stored information that outlives a thread and is read back into context | LangMem long-term memory | The thread, or a retention window |
| Raw layer | What was said or ingested, kept as it came | Zep episodes ("non-lossy"), Hindsight raw facts ("always preserved") | A derived fact |
| Derived layer | Facts, observations, profiles and pages built from the raw layer | Hindsight observations and pages, Mem0 memories | The raw layer |
| Relation | A link between pieces: evidence, entity, supersedes | Zep edges, Hindsight evidence links, `@` imports | A namespace, which only groups |
| Placement | Whether a piece is always in context or loaded on demand | Claude Code `CLAUDE.md` against topic files | Retrieval ranking |
| Immutable / append-only | Never edited / only added to | Zep episodes, Hindsight raw facts | A mutable profile field |
| Supersede / invalidate | Mark an old value as replaced and keep it | Zep `t_invalid` | Delete or overwrite |
| BM25 | Lexical ranking by term frequency and length | Redis `BM25STD`, the default scorer | Embedding similarity |

## 1. The problem

A model sees only its context, so memory is what makes last week change today's answer. **Which principles keep memory correct and findable as it grows, and how does my flat store with BM25 hold up against them?**

## 2. The lecture's model

![The lecture's memory figure. Extraction saves information from interactions with the agent and from external systems into a structure (table, tree or graph, with metadata that describes a document and connects it to external sources). Retrieval uses LLMs, pattern matching, embedding models, full-text search, graph search and decision models. Context, in red, presents memory to the agent with the tools read, write, modify and delete.](img/agentic-memory-four-parts.png)

Source: S02E01 article, figure 19. Caption: "Agentic memory has four parts. Extraction saves information into a structure, retrieval finds it, and context presents it to the agent with the tools to change it."

![The lecture's profile figure. In a thread the client says they prefer short answers, asks for a Friday email summary, then asks for detailed answers. A background request and memory.update calls write the client profile: answer length detailed (replacing short), summary email every Friday, source this thread.](img/memory-profile-updated-from-thread.png)

Source: S02E01 article, figure 20. Caption: "Preferences live as structured profile fields. A newer preference updates the stored value instead of creating a separate document." Extraction runs as a background request or as explicit `memory.update` tool calls. The hard part is one current, owned value: contradiction, duplication and ambiguity (figure 21).

## 3. Five principles, and what the systems do

```mermaid
flowchart LR
    RAW["Raw layer<br/>immutable, append-only"] --> X["Extraction"]
    X --> D["Derived layer<br/>facts, observations<br/>superseded, with evidence links"]
    D --> P["Small profile or index<br/>always in context"]
    D --> S["Everything else<br/>searched, read in pieces"]
    P --> C["Context"]
    S --> C
    style RAW fill:#2a7,stroke:#2a7,color:#fff
    style D fill:#888,stroke:#888,color:#fff
```

| Principle | What modern systems do | For my flat store |
|---|---|---|
| Relations | Zep: bidirectional episode and edge indices. Hindsight: facts link to entities and facts, observations to their evidence. Mem0 graph memory: Platform only, removed from the open-source SDK. Claude Code: an index file and `@` imports up to 4 hops. LangMem: namespaces only | Fields can carry the links: `source`, `entity`, `supersedes` |
| Placement | Claude Code: `CLAUDE.md` always, the first 200 lines or 25 KB of `MEMORY.md`, topic files on demand. Anthropic memory tool: not preloaded, the model is told to view the directory first. Hindsight: a token budget, not top-k | A small always-on profile, the rest searched |
| Search | Zep: cosine, BM25 and breadth-first, then rerank. Hindsight: four searches fused and reranked. Anthropic: grep and glob just-in-time, with `CLAUDE.md` up front. LongMemEval: fact-augmented index keys +9.4% recall, time-aware query expansion +6.8% to +11.3% | BM25 is the default Redis scorer. Extra keys and time fields help BM25 too |
| Readable pieces | Anthropic tool: list 2 levels, then view a file with a line range, long views truncate at 16,000 characters. Claude Code: topic files read on demand | Small pieces with ids, read by id and range ([25](25_Tool_Execution_Instead_Of_Tool_Calls.md)) |
| Immutable and append-only | Zep: episodes non-lossy, contradicted edges get `t_invalid`, bi-temporal. Hindsight: raw facts preserved, observations "refined, not overwritten". Mem0 OSS v3: ADD-only, never overwrites or deletes (the paper decided ADD, UPDATE, DELETE, NOOP). Anthropic tool and Claude Code: all mutable, no versioning documented | Raw layer append-only, derived layer superseded |

## 4. Review of my memory (flat, RediSearch BM25)

I have not seen its schema in this session, so these are questions.

| Question | Why |
|---|---|
| Is there a raw layer, or only extracted records? | A wrong extraction is unrecoverable without it |
| Do records carry `source`, `entity`, `supersedes` fields? | Cheap relations in a flat index |
| Is a changed fact overwritten or superseded? | Contradiction without history |
| What is always in context and what is searched? | Placement |
| Which `LANGUAGE` and weights are set per field, and do I add fact keys and timestamps? | Stemming is per index or field. Key expansion helped in LongMemEval |
| Can the agent read one record by id and a range? | Large results by reference |
| Where do deletes go, and who may delete? | Immutability policy, [12](12_Memory_Audit_Ledger_In_Memory_Or_State.md) |
| Do I measure recall on my golden set before adding vectors? | A dense retriever beat BM25 in LongMemEval (summary-only numbers) |

## 5. Window against memory, and the Mastra mapping

Contradiction, duplication and ambiguity are in [11](11_Memory_Known_Problems.md). The principles that answer them here: supersede and keep the old value, one owner per fact, resolve the entity before the write.

A retention window is not memory: it forgets by position, memory by decision. The Mastra demo shows both in one config, with explicit read and save tools scoped per customer. Its option meanings come from the transcript only:

| Demo option | Mechanism | Layer here | My stack |
|---|---|---|---|
| `lastMessages: 20` | Last N messages of the thread | Retention window | Cache store plus message trimming |
| `semanticRecall` | Retrieve past messages by meaning | Search by embedding | AI Search |
| `workingMemory` | Facts kept across conversations | Derived layer, profile | Near-field knowledge store |

## 6. Extraction choices, and what other projects teach

| Choice | Strength | Cost | Where I see it |
|---|---|---|---|
| Background LLM call | No latency on the turn | Extra model cost, I decide when it fires | LangMem background formation, Mem0 provider |
| Explicit tool call | Available at once, visible to the user | Latency, more load on the agent | LangMem hot path, the Mastra save tool |
| Profile (one document) | One place to look | Each update rewrites it, more error-prone as it grows | LangMem profile |
| Collection (documents) | Narrow, better recall | Hard to update or delete, the model over-inserts | LangMem collection |

| Project | What it teaches |
|---|---|
| Semantic Kernel `WhiteboardProvider` (experimental) | Keep requirements, decisions and actions beyond history truncation |
| lamarck | Offline extraction into `MEMORY.md` and topic files with maturity and dedup, no runtime recall |
| Joel Hooks' memory system | Keeps recall lanes separate. His repo's skill says the observe, reflect and promote into `MEMORY.md` stack was retired ([13](13_Memory_Operations.md)) |

## 7. Mem0, supermemory, Hindsight: what to review again

I relied heavily on Mem0 OSS and looked only briefly at the other two. This is the state of their READMEs and docs on 2026-11-15, so I can return and compare.

| | Mem0 OSS | supermemory | Hindsight |
|---|---|---|---|
| License, self-host | Apache 2.0. `pip` or `npm` library, or a Docker server | MIT repo. `npx supermemory local` or Docker. Self-hosted is licensed up to 10,000 documents (release notes) | MIT. Docker, Helm, `pip`. Hosted cloud too |
| Storage | Library: local Qdrant and SQLite history. Server: Postgres and pgvector. 15 vector stores | Postgres and pgvector, local embeddings by default | PostgreSQL and pgvector, or Oracle 23ai |
| Structure | Flat records with `user_id`, `agent_id`, `run_id` scope. Graph is Platform only | Graph of facts, preferences and episodes with `updates`, `extends`, `derives` links | Typed facts linked to entities, observations, pages, in banks |
| Updates | v3 ADD-only, current fact ranked first, hash dedup, `expiration_date` | New fact wins for "what is true now", history can remain, `isLatest` flag | Observations refined with history kept, background consolidation |
| Search | Vector, BM25 and entity matching fused. Rerank off by default | Hybrid by default, or memories only. Profile call (static and dynamic) | Four strategies fused, cross-encoder rerank, token budget |
| Maturity | 69.0k stars, Python SDK 2.2.1 and Node SDK 3.3.1 | 31.6k stars, local server 0.0.9 on 2026-10-12 | 61.2k stars, v1.2.1 on 2026-11-10 |

Review notes. Mem0's OSS benchmarks (LoCoMo 71.4 to 91.6, LongMemEval 67.8 to 93.4) differ from its README's platform figures (92.5 and 94.4). All three vendors report benchmark leads (supermemory "#1 on every major AI memory benchmark", Hindsight LongMemEval-S 94.6%): vendor-reported, not reproduced here. supermemory's README and docs show different call shapes. For my store, the points to compare are ADD-only against supersede, flat against linked records, and the fused search.

## Summary

Keep the raw layer immutable, derive facts with links back and supersede instead of overwrite, load a small profile always and search the rest with more than one method, and let the agent read small pieces. My flat BM25 store has search and placement. I check relations, a raw layer and supersede links, and measure recall before adding vectors.

## Open questions

- Does my store separate raw and derived records, and can I add `supersedes` without a schema break?
- Is BM25 enough on my golden set, or does a hybrid pay?

## Fact-check

| # | Claim | Verdict | Source | Checked |
|---|---|---|---|---|
| 1 | There are no established patterns for agent memory | **Differs** | [LangMem](https://langchain-ai.github.io/langmem/concepts/conceptual_guide/), [Anthropic memory tool](https://platform.claude.com/docs/en/agents-and-tools/tool-use/memory-tool), [Claude Code memory](https://code.claude.com/docs/en/memory.md). No cross-vendor standard found | 2026-11-15 |
| 2 | Zep keeps episodes non-lossy and invalidates contradicted edges | **Agrees** | [Zep paper](https://arxiv.org/abs/2501.13956), first 40k characters verbatim. "Immutable" and an explicit "not deleted" are not stated | 2026-11-15 |
| 3 | Hindsight keeps raw facts and refines observations with history | **Agrees**, vendor | [Hindsight](https://hindsight.vectorize.io/developer/observations). History mechanism not stated. Vendor benchmark numbers unverified | 2026-11-15 |
| 4 | Mem0 decides ADD, UPDATE, DELETE or NOOP per fact | **Outdated** for current OSS | The [paper](https://arxiv.org/abs/2504.19413) and OSS v2 did. Current OSS v3 is "Single-pass ADD-only extraction", "no UPDATE/DELETE", hash dedup, graph memory removed ([README](https://github.com/mem0ai/mem0), [migration guide](https://docs.mem0.ai/migration/oss-v2-to-v3)) | 2026-11-15 |
| 5 | Claude Code loads the first 200 lines or 25 KB of `MEMORY.md`, topic files on demand | **Agrees** | [Claude Code memory](https://code.claude.com/docs/en/memory.md), verbatim | 2026-11-15 |
| 6 | Anthropic's memory tool is client-side with six commands and no versioning documented | **Agrees** | [Memory tool](https://platform.claude.com/docs/en/agents-and-tools/tool-use/memory-tool), verbatim | 2026-11-15 |
| 7 | Redis default scorer is BM25 | **Agrees** | [Scoring](https://redis.io/docs/latest/develop/ai/search-and-query/advanced-concepts/scoring/): `BM25STD` default, renamed from `BM25` in Redis Open Source 8.4. Hybrid search not found in the pages read | 2026-11-15 |
| 8 | Fact-augmented keys and time-aware expansion improve recall | **Agrees** | [LongMemEval](https://arxiv.org/abs/2410.10813): +9.4% recall, +6.8% to +11.3% temporal. BM25 against dense numbers are from a summary: verify before presenting | 2026-11-15 |
| 9 | Recall needs the thread and a profile, not the last message alone | **Lecture-specific** | Figure 23: the last message names no client, proposal or meeting. Semantic Kernel's `Mem0Provider` queries by the request alone, the naive case | 2026-11-15 |
| 10 | Confidence scores handle ambiguity | **Lecture-specific** | No vendor source read | 2026-11-15 |
| 11 | mem0, supermemory, Hindsight, lamarck and Joel Hooks' pipeline | **Agrees** in part | Mem0, supermemory and Hindsight read from their READMEs and docs (section 7). lamarck read ([13](13_Memory_Operations.md)). The Hooks article did not resolve, his repo's skill was read | 2026-11-15 |
| 12 | Mem0 OSS: Apache 2.0, ADD-only v3, hybrid search, graph Platform only | **Agrees** | [README](https://github.com/mem0ai/mem0), [docs](https://docs.mem0.ai/open-source/overview). `update`, `delete` and `history` reference pages not read | 2026-11-15 |
| 13 | supermemory: MIT, graph of facts, hybrid search, 10,000-document self-host cap | **Agrees**, partly vendor | [README](https://github.com/supermemoryai/supermemory), [graph memory docs](https://supermemory.ai/docs/concepts/graph-memory). Cap from release notes, the license not read. Benchmark claims vendor-reported | 2026-11-15 |
| 14 | Hindsight: MIT, PostgreSQL and pgvector, four fused searches | **Agrees**, partly vendor | [README](https://github.com/vectorize-io/hindsight), [docs](https://hindsight.vectorize.io/). Benchmarks vendor-reported | 2026-11-15 |

## Sources

- S02E01 article, figures 19 to 23; transcript demo.
- [Anthropic memory tool](https://platform.claude.com/docs/en/agents-and-tools/tool-use/memory-tool) · [Claude Code memory](https://code.claude.com/docs/en/memory.md) · [LangMem concepts](https://langchain-ai.github.io/langmem/concepts/conceptual_guide/)
- [Mem0 repo](https://github.com/mem0ai/mem0) · [Mem0 OSS v2 to v3 migration](https://docs.mem0.ai/migration/oss-v2-to-v3) · [supermemory](https://github.com/supermemoryai/supermemory) · [Hindsight repo](https://github.com/vectorize-io/hindsight)
- [Mem0 paper](https://arxiv.org/abs/2504.19413) · [Zep paper](https://arxiv.org/abs/2501.13956) · [Hindsight](https://hindsight.vectorize.io/) · [Letta](https://docs.letta.com/configuration/memory) · [lamarck](https://github.com/johnlindquist/lamarck)
- [Redis scoring](https://redis.io/docs/latest/develop/ai/search-and-query/advanced-concepts/scoring/) · [LongMemEval](https://arxiv.org/abs/2410.10813) · [Anthropic: effective context engineering](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)
- My own reasoning: the five-principle table, the review questions and the layer diagram.
