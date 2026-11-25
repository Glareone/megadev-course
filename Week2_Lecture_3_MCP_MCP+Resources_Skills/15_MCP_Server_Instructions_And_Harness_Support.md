# 15. Server instructions are an optional field that a client may put in the system prompt, so I write a short one, put the key line first, and check per host that it arrives

> The field exists in the spec and in both official SDKs, but the spec sets no length limit and no rule for where a client places it. Claude Code cuts it at 4,096 characters, Pi uses the first line, Codex advises a self-contained first 512 characters, and the Claude API connector, which supports only tool calls, does not consume it. I write a short, non-duplicating instruction and test it on each host.

Related: [01 MCP resources and sampling](01_MCP_Resources_Static_Context_And_Sampling.md) · [02 MCP resources and plugins](02_MCP_Resources_Plugins.md) · [13 MCP tools loading and code mode with many servers](13_MCP_Tools_Loading_And_Code_Mode_With_Many_Servers.md) · [11 Sys prompt vs skills content and threats](11_Sys_Prompt_vs_Skills_Content_And_Threats.md) · [W2L1 08 Tool search instead of many tools](../Week2_Lecture_1_Agent_Primitives/08_Tool_Search_Instead_Of_Many_Tools.md)

Source: S02E03 lesson, "Server instructions can be set although most harnesses either ignore them or trim." The 2026-07-28 schema, the MCP blog post of 2025-11-03, the TypeScript and Python SDK docs through Context7, Claude Code, Claude API, OpenAI, Codex and VS Code docs, the Pi repository docs and source, the Codewhale repository and DeepSeek docs, read on 2026-11-25. See [Fact-check](#fact-check).

## Glossary

| Term | What it means here | Same thing elsewhere | Not to be confused with |
|---|---|---|---|
| Server instructions | One text the server sends about the server as a whole | `instructions` field | A tool description |
| Discover or initialize result | The response where the field travels | `DiscoverResult`, `InitializeResult` | A tool result |
| Cut | A host truncating the text at a length | Trim | A rejection |

## 1. The problem

I have never used server instructions. **What are they, how well do TypeScript, Python and the harnesses (Claude, Pi, DeepSeek) support them, and what should I write?**

## 2. What it is

- The 2026-07-28 schema: an optional `instructions` string, "natural-language guidance describing the server and its features", that clients can use "by including it in a system prompt". It "should focus on information that helps the model use the server effectively and should not duplicate information already in tool descriptions". There is no length limit and no MUST for clients. Earlier versions carry it on the initialize result.
- The MCP blog (2025-11-03): it "may be injected into the system prompt", so write it "with caution and diligence", it is "not always guaranteed" to arrive, and "no instructions are better than poorly written instructions". Good content is how tools relate, operating patterns and constraints. Marketing, general behavior and a 500-word manual are not.

## 3. Support in the SDKs

| SDK | How |
|---|---|
| TypeScript | `new McpServer({ name, version }, { instructions: "..." })`. The client reads it with `getInstructions()`. It is returned in the initialize and discover results |
| Python v2 | `MCPServer("Demo", instructions="...")`. The client has an `instructions` property. In v1 it was `FastMCP("Demo", "...")` |

- **A Python trap:** in v2 the second positional parameter is `title`, so an old positional call runs without error and silently stops sending `instructions`. I pass it by keyword.

## 4. Support in harnesses

| Harness | What the sources say |
|---|---|
| Claude Code | Documented. Cut at 4,096 characters (2,048 before v2.1.296), adjustable with `CLAUDE_CODE_MAX_MCP_DESCRIPTION_LENGTH` (v2.1.280 or later). Under tool search only tool names and server instructions load at start, and they "help Claude understand when to search for your tools". "Put critical details near the start" |
| Claude API MCP connector | Supports only tool calls, so it does not consume instructions (my inference) |
| OpenAI Responses MCP tool | The prose is silent. `server_description` is a client-side field |
| Codex | Reads the field at initialization as server-wide guidance, and advises keeping "the first 512 characters self-contained" (docs summary) |
| VS Code Copilot | Not stated |
| Pi | The client reads and stores it. Servers whose tools are deferred or in code mode get one line in the system prompt: the configured description, or the first line of the instructions. Codemode scripts read the full text. Direct servers: not stated |
| DeepSeek | The API docs mention no MCP. DeepSeek Harness (developer preview) has unverified MCP coverage. The community Codewhale (formerly DeepSeek TUI) supports MCP and does not document instructions |

The lesson says most harnesses "either ignore them or trim". That is partly right: Claude Code and Pi trim, the Claude API connector and others do not use them or say nothing, and Claude Code and Codex do use them.

## 5. Is it worth adding, and when

It is a hint that a host may ignore, so the question is where a short text changes behavior.

| Case | Add it? | Why |
|---|---|---|
| Tools have an order or dependency ("Call list-trips before book-trip"), or share a format ("Dates are ISO 8601") | Yes | The TypeScript SDK's own example. One tool's description cannot state a relation between two tools |
| Many tools or servers behind tool search, deferred loading or code mode | Yes | Claude Code loads only tool names and server instructions at start, and they "help Claude understand when to search for your tools". Pi lists one line per deferred server, taken from the instructions |
| A constraint the agent cannot guess: rate limits, pagination, which identity a call uses | Yes, short | The blog's "operating patterns and constraints" |
| Two or three self-explanatory tools | No | Their descriptions already carry it, and the schema says not to duplicate them |
| Long guidance, examples, policies | No: a resource or a skill | It would be cut at 4,096 characters or cost tokens on every request (note 01) |
| A rule that must hold | No: code | A host may ignore the field |
| Hosts that do not use the field (Claude API connector, VS Code not stated) | Optional | No gain there, and no harm |

If I add it: a self-contained first line (Pi uses it, Codex weights the first 512 characters), well under 4,096 characters, nothing already in a description.

## 6. Consequences of adding and of avoiding

| | A good, short instruction | A poor or long one | Avoiding it |
|---|---|---|---|
| Behavior | Better tool order and selection where the host uses it (Claude Code, Codex, Pi for deferred servers) | The blog: "no instructions are better than poorly written instructions" | Relations between tools move into tool descriptions, which grow and repeat |
| Discoverability | My server gets searched when its tools are deferred | The key line can be cut and lost | Under tool search the agent may never search for my tools |
| Tokens | A few hundred characters in each request that injects it | A bigger always-on prefix to keep stable | None |
| Security | The host may place it at system level, so I review it like a prompt | A sloppy or manipulated text carries that weight | None |
| Maintenance | One more text to keep aligned with the tools | It drifts and contradicts the descriptions | Nothing to align |
| Hosts | The server behaves differently where the field is ignored | Same | The same everywhere |

My reading of the asymmetry: a good short instruction costs little and may help, a bad or long one costs tokens and can mislead, and avoiding it mainly risks discoverability under deferred loading. So I add a short one when a row in section 5 says yes, and I check per host that it arrives (note 01's eval).

## Cautions

- The Codex facts come from a docs summary. I read Pi's client source and docs, not its coding-agent source. Gemini CLI and Cursor were not checked.
- The Claude Code behavior without tool search is not stated.

## Summary

Server instructions are a small, optional hint that hosts treat differently. I add a short one when tools have an order or constraints, or when the server sits behind tool search or code mode, skip it when descriptions already say it, and keep long guidance and must-hold rules elsewhere. I verify it on each host, and in Python v2 I pass it by keyword.

## Open questions

- Does my MCP server set `instructions`, and does it arrive in the hosts I use?
- Which of my guidance belongs in instructions, a resource or a skill, by the cases in section 5?

## Fact-check

| # | Claim | Verdict | Source |
|---|---|---|---|
| 1 | The field's purpose and content rules, no length limit, no client MUST | agrees | [Schema 2026-07-28](https://modelcontextprotocol.io/specification/2026-07-28/schema) |
| 2 | Blog guidance on writing it | agrees | [MCP blog, 2025-11-03](https://blog.modelcontextprotocol.io/posts/2025-11-03-using-server-instructions/) |
| 3 | TypeScript `instructions` option and `getInstructions()`, with the example "Call list-trips before book-trip. Dates are ISO 8601." | agrees, through Context7 | [typescript-sdk](https://github.com/modelcontextprotocol/typescript-sdk) |
| 4 | Python v2 keyword and the positional trap | agrees, through Context7 | [Python SDK migration](https://py.sdk.modelcontextprotocol.io/migration/) |
| 5 | Claude Code limit, variable, tool search interplay | agrees, verbatim | [Claude Code MCP docs](https://code.claude.com/docs/en/mcp) |
| 6 | The Claude API connector supports only tool calls | agrees. That it ignores instructions is my inference | [MCP connector](https://platform.claude.com/docs/en/agents-and-tools/mcp-connector) |
| 7 | OpenAI docs are silent. Samples set `instructions` server-side | agrees | [OpenAI MCP](https://developers.openai.com/api/docs/mcp) |
| 8 | Codex reads the field, advises 512 characters | unverified, docs summary | [Codex MCP](https://learn.chatgpt.com/docs/extend/mcp?surface=cli) |
| 9 | VS Code states nothing on instructions | agrees, by absence | [MCP developer guide](https://code.visualstudio.com/docs/copilot/guides/mcp-developer-guide) |
| 10 | Pi reads the field and uses the first line for deferred servers | agrees, client source and docs | [pi-mcp client](https://github.com/earendil-works/pi/blob/main/packages/mcp/src/client.ts), [mcp.md](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/docs/mcp.md) |
| 11 | DeepSeek: no MCP in the API docs. Harness MCP unverified. Codewhale supports MCP | agrees, by absence | [DeepSeek API docs](https://api-docs.deepseek.com), [Codewhale](https://github.com/codewhale-hq/Codewhale) |
| 12 | The lesson: most harnesses ignore or trim | agrees in part | rows 5 to 11 |
| 13 | The cases in section 5, the consequences in section 6 and the placement reading | lecture-independent, my reasoning | |

## Sources

- The pages linked above. Sections 5 and 6 are my own reasoning.
