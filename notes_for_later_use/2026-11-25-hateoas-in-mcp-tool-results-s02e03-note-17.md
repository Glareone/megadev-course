# HATEOAS in MCP tool results: results that say what to do next

Date: 2026-11-25
Topic: the lecturer's Spotify MCP example returns an answer plus how to continue (next calls, a cursor, a general tool), which I read as HATEOAS: the response carries the next available moves, with examples of how to do them after a GET
Lecture: S02E03 Agentic Capabilities, part "Designing a custom MCP" (the Spotify example, figure 9, and "MCP is... a way to shape that interaction")

I want to come back to this and decide where hypermedia-style hints belong in my own MCP tools. What I know now: the lesson's figure shows a `hints` array and a general `api` tool, while the lecturer's published server uses a sentence for the model, recovery notes, usage notes in descriptions and a read-back check of playback. Hints are options and never approvals, they pay when the next step depends on state, and the evidence is opinion and one small self-run test.

Where the topic already appears:

| Where | What it holds |
|---|---|
| [17 HATEOAS in MCP tool results](../Week2_Lecture_3_MCP_MCP+Resources_Skills/17_HATEOAS_In_MCP_Tool_Results_Spotify_Example.md) | The figure against the repository, HATEOAS sources, cases, consequences, what others say, my system |
| [13 MCP tools loading and code mode with many servers](../Week2_Lecture_3_MCP_MCP+Resources_Skills/13_MCP_Tools_Loading_And_Code_Mode_With_Many_Servers.md) | Fewer, consolidated tools and the loading side |
| [09 Human confirmation across channels](../Week2_Lecture_3_MCP_MCP+Resources_Skills/09_Human_Confirmation_Across_AG-UI_A2A_And_MCP_Channels.md) | Why an approval must never be advertised as a hint |
| [W2L2 15 Tool navigation and flexibility](../Week2_Lecture_2_Building_an_Agent/15_Tool_Navigation_And_Flexibility.md) | Vendor advice on names, schemas, errors and tool count |

Open: which of my tools return results where the next call depends on the result, whether one `actions` list should drive both my card buttons and the model's hints, whether I need a general escape hatch at all, and a test of results with and without hints on my golden set (running it calls a paid API, so it needs my yes).
