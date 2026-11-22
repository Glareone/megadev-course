# Execution flows: the skill grows, one skill per conversation

Date: 2026-11-22
Topic: how the agent follows a pattern to finish the work properly; my approach is to load the skill that explains how to act, then do the job
Lecture: S02E02 Building an Agent, part "Designing tools" (the Stripe price flow, figure 10)

It works for me, but the skill size grows. I also limit it to one skill per conversation, with the ability to unload it and load another. I want to review whether to split skills, move sequences into tools, and what my unload does to the cache.

Where it is written: [Lecture 2: 14](../Week2_Lecture_2_Building_an_Agent/14_Execution_Flows_Skill_Tool_Or_Workflow.md). Open: how my unload works, which numbered steps are really tools, which flows need enforcement.
