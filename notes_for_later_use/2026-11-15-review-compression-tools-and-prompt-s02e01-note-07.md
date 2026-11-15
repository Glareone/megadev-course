# Review my compression mechanism

Date: 2026-11-15
Topic: make sure my compression never compresses the tool definitions and the other super important pieces of the prompt
Lecture: S02E01 Agentic Primitives, part "Agentic Loop" (context columns: stable front, then compaction of the thread)

I want to review our compression mechanism and make sure we do not compress the tools and the other super important pieces of our prompt.

Where the topic already appears:

| Where | What it holds |
|---|---|
| [07 Context: tool awareness avoids compression](../Week2_Lecture_1_Agent_Primitives/07_Context_Tool_Awareness_Avoids_Compression.md) | A short capability list and on-demand loading keep tools out of the compressed thread |
| [06 Context window and compaction](../Week2_Lecture_1_Agent_Primitives/06_Context_Window_And_Compaction.md) | What survives compaction in Claude Code, skill re-injection caps, durable instructions in files |
| [05 Instructions](../Week2_Lecture_1_Agent_Primitives/05_Instructions_Five_Parts_And_Enforcement.md) | Which parts of the prompt are guidance and which are enforced |
