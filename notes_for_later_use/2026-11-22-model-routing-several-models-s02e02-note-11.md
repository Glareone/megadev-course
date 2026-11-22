# Several models in one execution: my suspicions against the industry

Date: 2026-11-22
Topic: model routing (the model that fits the task) and using several models together in one run, with LangGraph
Lecture: S02E02 Building an Agent, part "Providers and configuration" (figure 8)

| My suspicion | What the sources say | Match |
|---|---|---|
| After compile I cannot adjust the graph or the `call_model` node | The docs do not say a compiled graph can be edited. The model is chosen per call: `wrap_model_call` middleware, configurable models, runtime context, Deep Agents subagent `model` | Partly: the shape is fixed, the model is not |
| I would need two registered models or a planner node and an executor node | Those are two of six ways. Three need no graph change | Differs |
| Routing is not widely used, it adds graph complexity and needs graphs composed on the fly | Used by role: Claude Code `opusplan`, Aider architect mode, Deep Agents subagents; Foundry's router per prompt (search summary). No adoption numbers. No source found for graph composition on the fly | Partly: role-based use is common, dynamic graphs are not |

Where it is written: [Lecture 2: 11](../Week2_Lecture_2_Building_an_Agent/11_Model_Routing_In_LangGraph.md). Open: the cost of the second prefill in my agent, and which of my steps are short and separate enough for a secondary model.
