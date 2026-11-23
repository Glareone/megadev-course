# MCP resources, plugins and policy text: what to check, read and adjust

Date: 2026-11-23, 23:01 CET
Topic: the first three Week 2 Lecture 3 notes (resources, plugins, policy text built from the check rules), and what is still open after them
Lecture: S02E03 Agentic Capabilities, parts "Model Context Protocol" (resources) and the transcript passages on resources and eligibility checks

I want to come back to these three notes with a clear list. Each section below says what to do, where it sits, and what depends on it.

Where the topic appears:

| Where | What it holds |
|---|---|
| [01 MCP resources](../Week2_Lecture_3_MCP_MCP+Resources_Skills/01_MCP_Resources_Static_Context_By_URI.md) | Ten misreadings, resource forms, stateless fit, host support table |
| [02 MCP resources and plugins](../Week2_Lecture_3_MCP_MCP+Resources_Skills/02_MCP_Resources_Plugins.md) | Three meanings of "plugin", what each host plugin packs, where resources travel |
| [03 Policy resource from the check rules](../Week2_Lecture_3_MCP_MCP+Resources_Skills/03_MCP_Resource_Policy_Text_From_The_Check_Rules.md) | The return-policy resource, resource explains and check decides, mapping to OPA, hooks, guardrails |
| [Lecture 1: 12 MCP resources and skills](../Lecture_1_Mechanics_Behind_Generative_AI/12_mcp_resources_and_skills.md) | Older, shorter note on resources and skills over MCP |

## To check (claims I could not confirm)

| # | What | Where it sits | How I would check it |
|---|---|---|---|
| 1 | Does Cursor read resources today? Docs say Supported, a forum thread of 2026-02-13 says not | 01, fact-check row 11 | Cursor changelog, then a test with a server that has one resource |
| 2 | Do Codex, VS Code Copilot and the OpenAI remote MCP tool expose resources to the model? Pages are silent | 01, row 12 | Release notes and a test per host |
| 3 | Names of the Claude Code resource tools, and whether a plugin-bundled server's resources show in the `@` menu | 01 row 8, 02 open question | The hooks reference or the tool list in a session, read only |
| 4 | Skills over MCP stage: Beta on the extensions page, Final on the SEP page | 02 row 4, [Lecture 1: 12](../Lecture_1_Mechanics_Behind_Generative_AI/12_mcp_resources_and_skills.md) says Final | The extension repository and the client matrix |
| 5 | Claude Code cuts server instructions at 4,096 characters, and the 10% tool-search threshold | 01 section 4, only from a docs summary | Read the verbatim MCP page section |
| 6 | Gemini CLI was replaced by Antigravity CLI on 2026-06-18: do the resource tools carry over? | 01 host table | Antigravity CLI docs |
| 7 | MCP Apps spec status and whether the MIME type is `text/html;profile=mcp-app`, and whether the HTML may be generated per request | 01 section 4 mentions `ui://` only | The ext-apps specification |
| 8 | Cursor `mcp.json` key names, the Codex plugin manifest, the Agent Plugins schema | 02 section 2 | The Cursor reference (404 so far), Codex developer guide, agent-plugins.org |
| 9 | Does OPA generate documentation from policies? Four pages say nothing | 03 row 6 | OPA policy-language page, annotations section |
| 10 | Whether any published source builds prompt policy text and the check from one rule source | 03 row 11 | A new search later, and the lecturer's own demo code if it is public |
| 11 | OPA `explain` on POST requests (the REST page contradicts itself) | 03 row 5 | The OPA REST API page, explanations section |
| 12 | `subscriptions/listen` and SEP-2575 wording | 01 row 7, from a search summary | Read the SEP text |

## To read (pages and sources not read yet)

- MCP Subscriptions page (acknowledgment, `subscriptionId`, cancel).
- The skills extension client matrix and the ext-skills repository.
- The ext-apps specification (`draft` and the dated 2026-01-26 version).
- OPA policy-language page: annotations, `# METADATA`, `rule_labels`.
- The lecturer's `tool-skill-links` and `rule-with-reason` examples, since the lesson links them (not read).
- The rest of the S02E03 lesson: personalization, MCP fundamentals, designing a custom MCP, skills with tools.

## To adjust

- [Lecture 1: 12](../Lecture_1_Mechanics_Behind_Generative_AI/12_mcp_resources_and_skills.md): re-check its time-sensitive claims (skills extension status, `skills/list` and `skills/get`, "not every client supports resources") against 01 and 02. Fix them in the note body if they differ.
- README "lecturer's reference setup": the S02E03 table has four entries. Add the `tool-skill-links`, `rule-with-reason` and `tool-search`-style examples when I read them, and name the lecture.
- Note 01, row "Generated from rules": keep it in line with 03 if 03 changes.
- Note 02: add Codex and Cursor manifest facts once item 8 is read, and update the host table.
- Check whether other notes repeat the "resources are stale" idea. Grep for `stale`, `resources`, `Resources` before I present.

## To try (needs my explicit yes first)

- An eval that checks per host whether the model reads a resource. It runs agents and model calls.
- The `read_doc(uri)` fallback tool over the same content as a resource, in my own server.
- The drift test for note 03: assert the generated policy text covers every rule id.

## Notes still to write for this lecture

- Packing tools, resources, prompts and server instructions in one MCP server (named in 02 as a separate note).
- MCP Apps and elicitation, skills over MCP, code mode numbers from the transcript, personalization and generalized instructions. The full gap list is in [CHANGELOG.md](../CHANGELOG.md).
