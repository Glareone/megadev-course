# 11. Tools: upfront schemas vs. discovery

> Agents must know which tools exist. Either we **send every schema upfront**, or we let the agent **discover** tools. The idea is attractive, but **does it really save context?** It depends, and it is usually a *second or third* round of optimization, not the first.

Builds on [8 Tools](8_tools_native_and_external.md) (discovery section), [4 Context window](4_context_window.md) and lecture 1 [10 Code mode](../Lecture_1_Mechanics_Behind_Generative_AI/10_code_mode.md).

## The two approaches

| | **Upfront** | **Discovery** |
|---|---|---|
| In the request | JSON schema of **every** tool | a **search tool** plus minimal guidance; schemas load on demand |
| First call | immediate | after a search step |
| Context cost | all schemas, **used or not** | search tool + only the schemas found |
| Extra cost | none | a round trip, and a chance the search misses |
| Typical form | function calling | tool search, or code mode (`find` + `execute`) |

(The lecture has a comparison picture of these two. We don't have it yet.)

## What the evidence says (verified, with caveats)

| Source | Finding | Caveat |
|---|---|---|
| Anthropic, [Advanced tool use](https://www.anthropic.com/engineering/advanced-tool-use) | A five-server MCP setup (58 tools) used about **55K tokens** of definitions before any work; Jira alone about 17K. With the tool search tool: about **500 tokens** for the search tool plus about **3K** for 3-5 discovered tools, about **8.7K** total vs about **77K** | one vendor example. The post says "85% reduction", but 77K to 8.7K is closer to 89%, and some figures in it don't reconcile |
| Same post, accuracy | Opus 4: **49% to 74%**. Opus 4.5: **79.5% to 88.1%** on MCP evaluations with tool search on | their evaluation, older models. Re-measure on ours |
| Anthropic docs, [tool search tool](https://platform.claude.com/docs/agents-and-tools/tool-use/tool-search-tool) | Tool selection accuracy **degrades past about 30-50 tools**. Each search returns up to 5 tools by default | accuracy gain is a separate benefit from token savings |
| Same docs, when to use | **Use:** 10+ tools, definitions over **10K tokens**, accuracy dropping, several MCP servers, a growing library. **Skip:** fewer than 10 tools, every tool used in every request, or total definitions under about 100 tokens | guidance, not a measurement |
| Lecture 1 (`code-mode` example) | 30 function tools spent about **2,300 of 3,000** input tokens on schemas. A one-call task ("Who am I?") **can cost more** in code mode because `find` adds a step | small fake example |
| Anthropic, programmatic tool calling | Average usage **43,588 to 27,297 tokens (37%)** on complex research tasks. Another example: about 200 KB of raw data reduced to about 1 KB | benchmarks from one post |
| Anthropic, [code execution with MCP](https://www.anthropic.com/research/code-execution-with-mcp) | An example workflow went from **150,000 to 2,000 tokens (98.7%)** | one example, from search summary. Results depend on definition size, response volume and call-chain length |

**Reading it honestly:** the savings are large when you have **many tools with big schemas**, and small or negative when you have **few tools that you use all the time**.

## Does it really save context? A break-even view

Let:
- **S** = tokens of all tool schemas (upfront cost, per request)
- **s** = tokens of the few schemas a task actually needs
- **D** = tokens for the search tool and guidance
- **n** = requests in a session

| | Context used per request |
|---|---|
| Upfront | **S** |
| Discovery | **D + s**, plus the search call and its result (once per tool set found) |

Discovery wins on context when **S is much larger than D + s**. The worked numbers above (S about 77K, D + s about 8.7K) clearly win. With a handful of tools (S below about 100 tokens, as Anthropic's own guidance says), discovery only adds overhead.

### Three things that make the real saving smaller than it looks

1. **Prompt caching.** Upfront schemas in a stable prefix are cached, so after the first request they are billed at the cheaper cached-input rate (check your provider's pricing), and they don't add latency. Anthropic says its tool search does **not break caching**, because deferred tools are excluded from the prompt prefix and added inline when found. So the dollar saving can be much smaller than the token saving. The window and attention savings remain.
2. **Extra steps.** Every discovery is another model round trip. Latency and total tokens (the search call, its result, the model's reasoning) go up for simple tasks. Keep the **3-5 most-used tools non-deferred** (Anthropic's advice) so common tasks need no search.
3. **Misses.** If the search doesn't return the right tool, the agent may pick a wrong one, hallucinate a call, or give up. Good tool names, descriptions and namespacing (`github_...`, `slack_...`) matter more under discovery.

Discovery also improves things the token count doesn't show: **selection accuracy** with many tools, and **attention**, because a small context is easier for the model to use ([4 Context window](4_context_window.md)).

## Where this sits in the order of optimizations

Do the cheap, high-yield steps first:

| Round | Action | Typical effect |
|---|---|---|
| **0. Measure** | count tokens before any change: tool schemas, instruction files, skill catalog, first request | tells us which round is worth it |
| **1. Remove waste** | uninstall unused MCP servers and tools, shorten descriptions, trim AGENTS.md and the skill catalog ([Insight 1](Insight_1_Context_Agents.md), [5 Skills](5_skills.md)) | often the biggest and safest win |
| **2. Defer and discover** | load schemas on demand: tool search, deferred tools, or a router | big when many tools and servers |
| **3. Programmatic use / code mode** | the agent writes code; intermediate results stay in a sandbox and only the answer returns ([lecture 1, 10](../Lecture_1_Mechanics_Behind_Generative_AI/10_code_mode.md)) | big for chained calls and large data; **needs a sandbox** and has security cost ([9 Prompt injection](9_tools_prompt_injection.md)) |
| **4. Results** | paginate, summarize, write large results to files ([10 Tool results](10_tool_results_context_to_file_and_back.md)) | reduces what each call adds |

So discovery is round two or three. If a tool or an instruction file is simply unused, deleting it beats deferring it.

## Programmatic tool use (code mode) in one paragraph

Agents increasingly **write code** to act: either against the available capabilities or directly against an API. One script can call many tools, loop, and filter, and only the final output returns to the context. That removes both schema weight and intermediate results. The price: the model's code actually runs, so isolation and review matter, and one injected instruction can drive a whole chain.

## Decision guide

| Situation | Choice |
|---|---|
| under about 10 tools, all used often | **upfront** |
| 10+ tools, or definitions over about 10K tokens | **discovery** (with 3-5 core tools non-deferred) |
| several MCP servers (hundreds of tools) | **discovery**, namespaced names |
| many chained calls, large intermediate data | **code mode**, if we can run a sandbox |
| high-risk or regulated actions needing step-by-step approval | **upfront, fixed tools** with human gates |
| unsure | **measure** first |

## Test it before adopting

1. Record baseline: total input tokens of the first request, number of tools, cost, and task success on 10-15 real tasks.
2. Switch to discovery (or defer a group of tools). Same tasks, same model.
3. Compare: input tokens, **number of steps and latency**, cost **with caching on**, correct tool chosen, success rate.
4. Include tasks that need **no** tools and tasks that need **several**.
5. Repeat across 3 runs and at least two models. Results vary.
6. Adopt only if the saving survives caching and the success rate holds.

## Summary (from the lecture)

1. Agents need to know which tools and capabilities exist, so we either provide schemas upfront or let them discover them.
2. Agents now often use **programmatic tool use**: they write code to interact with the environment through available capabilities, or directly through an API.
3. Base knowledge and available context affect how tools are chosen. Request payloads may be verified, but models can **hallucinate values**, which in extreme cases may lead to data leaks or security incidents ([9 Prompt injection](9_tools_prompt_injection.md)).
4. Tool responses may include **hints** that help the agent recover from errors, explore data better, or decide what to do next (next topic in this block).

## Open questions for discussion

- How many tools and how many schema tokens do our agents carry today?
- Which MCP servers or tools are unused and can simply be removed (round 1)?
- Is our harness already deferring tools, and which settings control it?
- Do we have a sandbox that would allow code mode, and who owns its security?

## Notes on sources and corrections

> Corrections made on 2026-11-04 using information from Anthropic's own pages and other sources, not from the lecture. Re-check before presenting.

| Point | What we found and changed |
|---|---|
| **"85% reduction"** | Anthropic's post states an **85%** reduction, but its own figures (about **77K to 8.7K** tokens) work out to about **89%** (1 - 8.7/77). The post also gives other figures that it doesn't reconcile. We kept the raw token numbers and flagged the percentage as unreliable |
| **"98.7%" (150,000 to 2,000 tokens)** | This comes from **one example workflow** in Anthropic's code-execution post, and we only saw it through **search summaries**. Treat it as an upper-end illustration, not a typical result |
| **Vendor figures in general** | All token and accuracy numbers (55K, 8.7K, 37%, 49% to 74%) come from **vendor posts and docs**, not independent tests. They show the order of magnitude. They are not measurements of our agents |
| **Prompt caching** | Added after checking Anthropic's tool search docs: deferred tools are excluded from the cached prompt prefix and added inline, so tool search does not break caching. This is why the dollar saving can be smaller than the token saving |
| **When to use / skip** | Taken from Anthropic's docs (10+ tools, over 10K tokens, accuracy dropping vs fewer than 10 tools, all used every time, under about 100 tokens in total) |
| **Our reasoning** | The break-even model, the order of optimization rounds and the decision guide are **ours**. Nothing here has been **measured on our own agents** yet |
| **Missing picture** | The lecture's comparison picture of the two approaches has not been provided. The table is based on its text description |
| **Hints** | The fourth lecture point (hints in tool responses) is not covered here. It is the next topic in this block |

## Sources

- [Introducing advanced tool use (Anthropic Engineering)](https://www.anthropic.com/engineering/advanced-tool-use)
- [Tool search tool (Anthropic docs)](https://platform.claude.com/docs/agents-and-tools/tool-use/tool-search-tool)
- [Code execution with MCP (Anthropic)](https://www.anthropic.com/research/code-execution-with-mcp), figures via search summary
- Lecture 1 note [10 Code mode](../Lecture_1_Mechanics_Behind_Generative_AI/10_code_mode.md)
- Lecture text: "To summarize, all we need to know for now is..."
- The break-even model, the order of optimizations and the decision guide are our reasoning, not from the lecture
