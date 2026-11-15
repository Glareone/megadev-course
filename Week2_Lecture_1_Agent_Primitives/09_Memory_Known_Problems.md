# 9. Memory fails in three known ways, and each can be counted and beaten

> The lecture names contradiction, duplication and ambiguity as the hard part of memory; the lecturer's memory-extraction example turns them into counters over six dated chats and shows that an append-only profile keeps a stale city, mixes two people and stores paraphrases twice, while one document per person with replace-by-key and a held note removes most of that, so I keep the counters in my evals and treat identity, supersede and a hold state as the fixes.

Related: [08 Memory](08_Memory.md) · [10 Memory audit ledger](10_Memory_Audit_Ledger_In_Memory_Or_State.md) · [12 Evals and traces](draft_12_Evals_And_Traces_For_Agent_Changes.md) · [06 Context window and compaction](06_Context_Window_And_Compaction.md) · [07 Tools: awareness, discovery, gateway](draft_07_Context_Tool_Awareness_Avoids_Compression.md)

Source: S02E01 article, "Context and Memory" (figures 20 and 21). The lecturer's [memory-extraction example](https://github.com/MEGA-DOT-DEV/examples/tree/main/examples/memory-extraction): README, `memory.ts`, `memory.test.ts`, `api.ts`, `index.ts` and the UI read in full by a fetch agent on 2026-11-15. Mem0, Zep and Hindsight facts from the research behind [08](08_Memory.md). See [Fact-check](#fact-check).

## Glossary

| Term | What it means here | Same thing elsewhere | Not to be confused with |
|---|---|---|---|
| Contradiction | A new statement conflicts with a stored value | Mem0 paper UPDATE or DELETE, Zep invalidation | Duplication |
| Duplication | The same fact stored twice, often as a paraphrase | Mem0 hash dedup, Hindsight merge | A repeat that changes nothing |
| Ambiguity | A fact cannot be tied to one owner | Two clients with the same name | Contradiction |
| Stale fact | A stored value that no longer matches the expected one | The example's `stale` counter | An old fact kept on purpose with its history |
| Held note | A fact kept aside until its owner is known | The example's `pending` | A stored fact |
| Replace-by-key | One value per owner and key, a new one removes the old | The example's `memory_update` | Append |
| Cross-person write | A fact saved under someone other than the speaker | The example's `crossPerson` | A shared fact |
| Confidence score | A number saying how sure the extractor is | The lecture's remedy | Not present in the example |

## 1. The problem

The lecture: "Storing a preference is easy. The hard part is keeping one current, single and clearly owned value over time." **What are the failure modes, how does the lecturer's example measure them, and how do I beat them with scoring and other abilities?**

## 2. The lecture's figure

![The lecture's problems figure. In a client profile in memory, the thread says "Give me detailed answers from now on" and it must override answer length short (contradicts, in red). The summary email every Friday is duplicated by a separate note "Friday summary by email". Adam reports weekly is ambiguous between two clients named Adam.](img/memory-known-problems-contradiction-duplication-ambiguity.png)

Source: S02E01 article, figure 21. Caption: "Storing a preference is easy. The hard part is keeping one current, single and clearly owned value over time."

## 3. The example: three modes, six chats

Each mode starts empty and replays the same six dated chats. The model never sees the labels. The messages are test data.

| Date | Speaker | Message | Problem it exercises |
|---|---|---|---|
| 09-01 | Alex Chen | Lives in Berlin, designs products, prefers short answers | First facts |
| 09-08 | Alex Rivera | Lives in Porto, works as a chef | A second person named Alex |
| 09-17 | Alex Chen | Moved from Berlin to Vienna | Contradiction |
| 09-25 | Alex Rivera | Shifts still in Porto, cooks for a living | Duplication by paraphrase |
| 10-02 | unknown | "Alex ... started cycling. I cannot tell which Alex" | Ambiguity |
| 10-06 | Alex Chen | Brief replies as usual, in Lisbon until October 9 | Temporary stay and a repeat |

| Mode | How it saves | Update rule (decided in code, not by the model) |
|---|---|---|
| Profile, background extraction | One request per chat | Always appends. Uses the chat's identity and ignores which Alex the model named |
| Memory tools, in session | The agent calls `memory_save` or `memory_update`, then one confirm request | Save appends, update replaces the old value for that person and key. A tool call that does not match the known speaker is refused |
| One document per person, background extraction | One request per chat | Replaces on the same person and key. Holds a note when the speaker is unknown or differs |

A city or activity from a chat with an expiry date is skipped in every mode. Expected final memory: five facts (Chen: Vienna, designer, short answers; Rivera: Porto, chef), and no cycling.

## 4. The scores

| Counter | Measures | Problem |
|---|---|---|
| retained (of 5) | Expected facts present | Coverage |
| stale | A key present with a value other than the expected one | Contradiction |
| duplicates | Same person, key and normalized value seen again | Duplication |
| crossPerson | Facts filed under the wrong person | Ambiguity |
| pending | Held notes | Ambiguity, deferred |
| requests, extraRequests, cost | Model calls and estimated cost | Price of the approach |

The test uses a mock model with scripted outputs, so its numbers show the scoring harness, not model behavior. Profile: retained 5, stale 1 (Berlin stays after the move), crossPerson 2, duplicates 3. Tools and one document per person: stale 0, duplicates 0. One document per person: pending 1. Requests 6, 10 and 6. The README reports no live results: "Results depend on the model's decisions". Matching is exact after lowercasing and a hand-written synonym map ("cook" to "chef").

## 5. How I beat each problem

| Problem | Detect | Fix | Evidence |
|---|---|---|---|
| Contradiction | `stale` counter on a labelled chat | Replace by key or supersede and keep the old value. State the rule in the extraction prompt ("a move replaces an old city") | The example; Zep invalidates contradicted edges. Mem0 OSS v3 never overwrites: it adds, ranks the current fact first and dedups by hash |
| Duplication | `duplicates` counter | Normalize, then compare. "A paraphrase of a stored fact is not new". Merge near-duplicates | Example prompt; Hindsight merges at 0.97 by default; Mem0 hash dedup catches exact copies only. A synonym map does not scale: a judge or embeddings is my reasoning |
| Ambiguity | `crossPerson` and `pending` | Identity comes from the session, never from the model. Hold the note until the owner is known | Example: the profile mode ignores the model's person. It never resolves the unattributed chat |
| Temporary facts | A labelled chat with an end date | Skip or store with an expiry | Example skips them by a hard-coded rule |
| Change over time | Ask "what was true in September" | Keep history with valid-from and valid-to | Zep bi-temporal edges |

**Scoring.** The lecture suggests confidence scores. The example uses none: no confidence, similarity or recency. My proposal, untested: store source chat and date with every fact, write only above a confidence threshold, hold the rest, and break ties by recency. The cheaper step is the example's own method: a labelled set of chats and the counters above, run after every change to the extractor ([12](draft_12_Evals_And_Traces_For_Agent_Changes.md)).

## 6. What the example does not solve

- **Reading back:** memory is built and never queried to answer.
- **Identity:** supplied by the harness per chat, not inferred from the text.
- **The unattributed chat:** not resolved in any mode. The profile stores it with no owner, the tool guard refuses it, and one document per person holds it with no way to resolve it later.
- **Confidence and decay:** none. Expiry is a hard-coded check on city and activity.
- **Deletion:** only by replacement.

## Summary

Contradiction, duplication and ambiguity can each be counted on a labelled set of chats. Replace-by-key or supersede, normalized comparison, identity from the session and a hold state remove most failures in the example. Confidence scoring and resolving a held note are open, so I add the counters to my memory evals and test them on my own store.

## Open questions

- Which of my memory writes are append-only today, and which counter would catch it?
- How does a held note get resolved: by a later message, a question, or a human?

## Fact-check

| # | Claim | Verdict | Source | Checked |
|---|---|---|---|---|
| 1 | The three problems are contradiction, duplication, ambiguity | **Lecture-specific**, matches the example | Figure 21. The example exercises all three plus temporary facts | 2026-11-15 |
| 2 | The example scores retained, stale, duplicates, crossPerson, pending, requests and cost | **Agrees** | [memory.ts](https://github.com/MEGA-DOT-DEV/examples/tree/main/examples/memory-extraction) read in full, `index.ts`, `api.ts` | 2026-11-15 |
| 3 | The example uses confidence scores | **Differs**: it does not | No confidence, similarity or recency found. Binary hold only | 2026-11-15 |
| 4 | The example's numbers show how models behave | **Differs** | `memory.test.ts` uses a mock model with scripted outputs. No live results in the README | 2026-11-15 |
| 5 | Zep invalidates contradicted edges, Mem0 deletes them | **Agrees** for Zep, **Outdated** for Mem0 | [Zep](https://arxiv.org/abs/2501.13956). Mem0's paper and OSS v2 decided UPDATE or DELETE, current OSS v3 is ADD-only, see [08](08_Memory.md) section 7 | 2026-11-15 |
| 6 | Hindsight merges near-duplicates at 0.97 | **Agrees**, vendor | [Hindsight observations](https://hindsight.vectorize.io/developer/observations) | 2026-11-15 |
| 7 | Confidence thresholds beat the problems | **Unverified**, my proposal | No source or test | 2026-11-15 |

## Sources

- S02E01 article, figures 20 and 21.
- [memory-extraction example](https://github.com/MEGA-DOT-DEV/examples/tree/main/examples/memory-extraction) · [Zep](https://arxiv.org/abs/2501.13956) · [Mem0](https://arxiv.org/abs/2504.19413) · [Hindsight](https://hindsight.vectorize.io/developer/observations)
- My own reasoning: the fix table, the scoring proposal and section 6.
