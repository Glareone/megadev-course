# A recall-first step before the agent answers

Date: 2026-11-15
Topic: asking the model to recall what it knows, which methods apply and what the answer must satisfy, before it acts or answers (latent space activation)
Lecture: S02E01 Agentic Primitives, part "Personality and Environmental Awareness"

I have not used this approach yet. I want to remember it and try it on one of my agents.

The idea in three steps, from the repository the lecturer cites:

| Step | The repository's prompt |
|---|---|
| Recall knowledge | "What do I know about Rome that is relevant?" |
| Recall methods and define criteria | "What techniques or methods do I know...?" and "What criteria am I looking to judge on?" |
| Answer last | "render my final answer" |

How I would test it: add the step to one agent's prompt and run my golden set with and without it. The repository gives no evidence, and reasoning models may already do part of it.

Where the topic already appears:

| Where | What it holds |
|---|---|
| [01 Advanced prompt techniques](../Week2_Lecture_1_Agent_Primitives/01_Advanced_Prompt_Techniques.md), section 6 | The repository read in full, what it says and does not say, my mapping to agents |
| [10 Evals and traces](../Week2_Lecture_1_Agent_Primitives/draft_10_Evals_And_Traces_For_Agent_Changes.md) | How I would compare the two versions |
