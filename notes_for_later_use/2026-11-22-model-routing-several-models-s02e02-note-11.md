# Several models in one execution: how well is LangGraph prepared?

Date: 2026-11-22
Topic: model routing (the model that fits the task) and using several models together, for different purposes in one run
Lecture: S02E02 Building an Agent, part "Providers and configuration" (figure 8)

I feel that after compile I cannot adjust the graph or the `call_model` node, so I would register two models and pick one, or add a planning node and an execution node. I do not believe routing is widely used: it adds graph complexity and may need graphs composed on the fly, beyond the Deep Agents and ReAct archetypes.

Where it is written: [Lecture 2: 11](../Week2_Lecture_2_Building_an_Agent/11_Model_Routing_In_LangGraph.md). Open: the cost of the second prefill in my agent, and which of my steps are short and separate enough for a secondary model.
