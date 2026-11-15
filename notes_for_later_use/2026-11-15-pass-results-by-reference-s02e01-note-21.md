# Pass results by reference to a memory segment

Date: 2026-11-15
Topic: using a reference to a stored result (a file or memory segment) instead of copying the content into the context, and binding memory to context that way
Lecture: S02E01 Agentic Primitives, part "Agentic Loop" (figure 13: big results go to a file)

I find this concept interesting: do not copy the information, use a reference to the memory segment. The model reads a chunk, shows the file or passes the reference to another tool, and the rest stays in memory.

Where the topic already appears:

| Where | What it holds |
|---|---|
| [21 Tool execution instead of tool calls](../Week2_Lecture_1_Agent_Primitives/21_Tool_Execution_Instead_Of_Tool_Calls.md), section 5 | Figure 13, pass by reference, where the result lives, risks |
| [08 Memory](../Week2_Lecture_1_Agent_Primitives/08_Memory.md) | Memory as the store behind the context |
| [10 Audit ledger](../Week2_Lecture_1_Agent_Primitives/10_Memory_Audit_Ledger_In_Memory_Or_State.md) | Why a large result does not belong in a state channel |
| [Lecture 2: 10 Tool results to file and back](../Lecture_2_Context_Agents_md_Skills_Tools/10_tool_results_context_to_file_and_back.md) | Earlier notes on results to file |
