# Measure TTFT, token speed and the step waterfall before optimizing

Date: 2026-11-22
Topic: time to first token is not acceptable and token-to-token time is huge; golden set: mean run 75 s, P90 120 s
Lecture: S02E02 Building an Agent (my own agent, not a lecture claim)

Tool calls (MCP to REST sources) cost a lot, but other parts cost a lot too. Before I optimize anything I need the whole picture: TTFT and tokens per second are not measured yet. I do not want to make this complex: the fields are in section 5 of the cache note.

To do: record per step TTFT, input and cached tokens, reasoning and output tokens, decode speed, tool time, step count; then split the P90 runs by bucket. Open: which tracing I use, how many steps a run takes, whether the MCP servers sit near the agent. The OpenTelemetry GenAI latency metrics were not read (the spec moved to a separate repository): verify before using their names.

Where it is written: [Lecture 2: 09](../Week2_Lecture_2_Building_an_Agent/09_Cache_Hit_Rate_And_P90_Latency.md#5-measure-the-whole-picture-first).
