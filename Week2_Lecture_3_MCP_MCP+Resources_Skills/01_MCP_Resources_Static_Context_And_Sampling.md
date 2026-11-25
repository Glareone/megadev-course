# 1. MCP resources are application-controlled context by URI that hosts read unevenly, and sampling, the server borrowing the host's model, is deprecated, so I build on resources and call my own provider

> A resource is data a host reads by URI, and the host decides what to do with it. The protocol supports it and stateless servers keep it, so I use resources for stable context and never rely on the model reading them. Sampling, which lets a server ask the host to run an LLM call, is deprecated since the 2026-07-28 spec, so I do not build on it.

Related: [02 MCP resources and plugins](02_MCP_Resources_Plugins.md) · [03 Policy resource from the check rules](03_MCP_Resource_Policy_Text_From_The_Check_Rules.md) · [Lecture 1: 12 MCP resources and skills](../Lecture_1_Mechanics_Behind_Generative_AI/12_mcp_resources_and_skills.md) · [W2L2 15 Tool navigation and flexibility](../Week2_Lecture_2_Building_an_Agent/15_Tool_Navigation_And_Flexibility.md) · [W2L1 08 Tool search instead of many tools](../Week2_Lecture_1_Agent_Primitives/08_Tool_Search_Instead_Of_Many_Tools.md) · [08 MCP Apps and the lecturer's preview tool](08_MCP_Apps_And_The_Lecturers_Preview_Tool.md)

Source: S02E03 written lesson and transcript (a resource for a return policy, list and read tools), MCP spec 2026-07-28 (resources, tools, server overview), MCP learn page, TypeScript SDK docs, client docs. Checked 2026-11-23. Sampling: the 2026-07-28 sampling, multi round-trip and changelog pages, VS Code and Cursor docs, checked 2026-11-25.

## Glossary

| Term | What it means here | Same thing elsewhere | Not to be confused with |
|---|---|---|---|
| Resource | Data with a URI, read with `resources/read`. Nothing runs. | Context attachment | A tool result |
| Application-controlled | The host decides what to load and show | User-attached context | Model-controlled (tools) |
| Static resource | Fixed URI, listed by `resources/list` | Document, file | Resource template |
| Resource template | A URI pattern with variables (RFC 6570) | Parameterized path | A tool with arguments |
| Resource link | A pointer to a resource inside a tool result (`resource_link`) | Link in a response | The content itself |
| Embedded resource | The content itself inside a tool result (`type: resource`) | Inline attachment | A link |
| Sampling | The server asks the client to run an LLM call and return the completion | Server-initiated completion | A tool call |

## 1. Ten misreadings and what I do instead

| # | Misreading | What the sources say | What I do |
|---|---|---|---|
| 1 | Resources are stale and dropped | The 2026-07-28 spec has a full resources page and marks nothing deprecated. Subscriptions were redesigned (`subscriptions/listen`). Support in hosts is the uneven part. | Keep using them, and check each host (section 4) |
| 2 | The model reads resources by itself | The spec calls them application-driven. Listed patterns: UI selection, user search, and automatic inclusion "based on heuristics or the AI model's selection". It mandates no interaction model. | Assume nothing. The tool must work when no resource is read |
| 3 | Publishing a resource puts it in context | It does not. In the lecture demo the agent needed two extra tools, list resources and read resource, before it could answer. | Name the URI in the tool description or server instructions, or return a `resource_link` |
| 4 | A resource is a read-only tool, and it saves tokens | The control differs: tools are model-controlled, resources application-controlled. The content tokens are the same. Only the tool schema and the decision to fetch are saved. | Resource for stable context, tool when the model must decide to fetch or the call has effects |
| 5 | A resource must be a file | The URI scheme is free, if it follows RFC 3986. `file://` need not map to a disk. `https://` only if the client can fetch it directly. | Pick the scheme by meaning, e.g. `guide://`, and return a constant, a file or a query |
| 6 | Resources need sessions, so they clash with stateless MCP | `resources/list` must not vary per connection. It may vary by the authorization on the request. Reads and lists carry `ttlMs` and `cacheScope`. | Static content, same list for everyone, no subscriptions |
| 7 | A link in a tool result appears in `resources/list` | The spec says links returned by tools are not guaranteed to be listed. | Register the resource as well if clients should list it |
| 8 | A resource is public once listed | Servers MUST validate URIs and sanitize `file://` paths. Access controls and permission checks SHOULD be done. | Check permissions on read, not only on list |
| 9 | If the host ignores resources, they are useless | The user can still attach them in hosts with a picker or `@` mention. | A thin `read_doc(uri)` tool over the same source (my reasoning, not a sourced pattern) |
| 10 | A template lets clients browse every URI | In the SDK, a template with `list: undefined` is readable but never listed. A `list` callback makes instances appear. | Add `list` for a countable set and use the completion API for parameters |

## 2. What a resource can hold

| Form | How it looks | Listed | Typical use |
|---|---|---|---|
| URI only | A list entry (`uri`, `name`, `description`) or a `resource_link` in a tool result | Entry yes. A link from a tool is not guaranteed | Point to a guide without sending its text |
| Static content | The read handler returns `contents: [{ uri, text }]` from a constant | Yes | A workflow, a policy, a glossary |
| Static file | The read handler reads a file at request time, text or base64 `blob` | Yes | A manual, a schema, a size guide |
| Generated from rules | The handler builds the text from the stored rules a check also uses | Yes | A policy text that cannot drift from the check, see [03](03_MCP_Resource_Policy_Text_From_The_Check_Rules.md) |
| Template | `scheme://{id}/path`, variables go to the handler | Only with a `list` callback | One page per entity |
| Embedded in a tool result | `type: resource` with the content inline | No | Attach the record a tool just used |

- One read can return several `contents` parts.
- Annotations are hints for the host: `audience` (`user`, `assistant`), `priority` 0.0 to 1.0, `lastModified`.
- A missing resource returns error -32602, never an empty `contents`.

## 3. Resources in a stateless server

```mermaid
flowchart LR
    C["Request<br/>version, capabilities, auth in every request"] --> L["resources/list<br/>same set for every connection"]
    C --> R["resources/read uri"]
    R --> H["Handler: constant, file or template variables"]
    H --> T["contents + ttlMs + cacheScope"]
```

- A read may answer with `InputRequiredResult` when it needs more input, which keeps even that step request-scoped.
- The 2026-07-28 revision removed protocol sessions and the `Mcp-Session-Id` header, so list endpoints no longer vary per connection. It also removed the `initialize` handshake: version and capabilities travel in `_meta` on every request.
- Change notifications: `list_changed` when the set changes, and `subscriptions/listen` for content updates. The server's first message on a subscription must be `notifications/subscriptions/acknowledged`. Static documents need neither.
- Cursor 2.4.31 still sent `resources/subscribe` to a server that declared `subscribe: false`, and a stateless server failed with "Missing handler for request type: resources/subscribe". Cursor staff called it a known bug on 2026-02-13 and suggested a no-op handler. I did not find a fix.

## 4. What the industry says and does

**Spec and docs (primary)**
- Official definition: "passive data sources that provide read-only access to information for context". Examples: file contents, database schemas, API documentation, git history, calendar events.
- The learn page contrasts them with tools by example: read the calendar as a resource, create an event with a tool. Neither page gives a rule for choosing between them.
- Both pages say the application decides how to use a resource: select parts, search with embeddings, or pass all of it to the model.

**Hosts on 2026-11-23**

| Host | Status | Evidence |
|---|---|---|
| Claude Code | `@server:protocol://path` by the user, and model tools `ListMcpResourcesTool` and `ReadMcpResourceTool`, both without a permission prompt. The list tool leaves out MCP Apps UI resources | Docs, verbatim |
| Gemini CLI | Model tools `list_mcp_resources` and `read_mcp_resource`, no confirmation. The CLI was replaced by Antigravity CLI on 2026-06-18, and I found no resource tool documented for it | Docs, page dated 2026-04-16 |
| Cursor | Changelog 1.6 (2025-09-12): "We've added support for MCP Resources". The docs table says Supported. How resources reach the user or the model is not stated | Docs |
| VS Code Copilot | In Copilot sessions MCP Apps can read resources. Native servers do not appear in the resource browser. Add Context and MCP: Browse Resources exist only in the deprecated local harness, removed in February 2027 | Docs, page shows 2026-11-18 |
| Codex | No doc line found. An issue says the runtime has `list_mcp_resources`, `list_mcp_resource_templates` and `read_mcp_resource`, and another issue shows the VS Code extension returning an empty list | Issue text only |
| Claude API connector, OpenAI remote MCP tool | Connector: tool calls only. OpenAI: not stated | Docs |

- **Vendor guidance:** VS Code's MCP developer guide says: "Return content in a tool result when the agent needs it to complete a task, rather than relying on resource discovery." This is the only vendor line I found that tells a server author what to do when the host may not read resources.

**Practice (secondary, blogs)**
- The advice repeated across blogs: stable context the user would attach is a resource, anything that changes state is a tool, and important data is exposed both ways (a tool returns a `resource_link` to the same URI). One blog says most hosts show resources to the user and do not let the model browse them.
- One author argues hosts have not built the UX for resources, on his own tests and undated issues. Another blog reports 114K against 27K tokens with no method, and I do not use the number.

**Built on resources**
- Skills over MCP serve `SKILL.md` files as `skill://` resources. SEP-2640 is Final, the extensions overview lists the extension as Beta, and host support is still being implemented.
- MCP Apps (Stable, spec dated 2026-01-26) serve their UI as `ui://` resources with the MIME type `text/html;profile=mcp-app`. Claude Code hides these from `@` suggestions and from its list tool.

## 5. Sampling: the server asks the host's model (deprecated)

- **What:** `sampling/createMessage` lets a server get a completion through the client, "no server API keys necessary", nested inside a tool call, `prompts/get` or `resources/read`. A human SHOULD be able to view, edit and deny the request and review the response. `modelPreferences` (hints, cost, speed and intelligence priorities) are advisory and the client picks the model. `maxTokens` must be respected, and `systemPrompt` may be changed or ignored.
- **Stateless form:** in 2026-07-28 the server returns an `InputRequiredResult` that carries the request, and the client retries with `inputResponses` and the same `requestState`. "The previous pattern of server-initiated requests is no longer supported."
- **Status:** SEP-2577 deprecates Roots, Sampling and Logging: "New implementations SHOULD NOT adopt it; existing implementations SHOULD migrate to integrating directly with LLM provider APIs." The TypeScript SDK v2 throws on `requestSampling` for 2026-07-28 connections.
- **Hosts:** VS Code Copilot: "Deprecated in MCP", supported during an active turn with per-server approval. Claude Code, Cursor and ChatGPT: not stated, and the official client matrix has no sampling column. I found no shipped server that uses it.
- **What I do:** I do not build on it. If my server needs a model, it calls my own provider (my key, my cost, my data policy), or returns data for the host's model to use. The lesson presents sampling as a live feature, and as of 2026-07-28 it is deprecated.

## 6. Cautions

- A resource nobody reads gives no signal, so I need an eval per host. Remote resource text steers the model like any instruction.
- Host support changes quickly, so I re-check section 4 before presenting.

## Summary

Resources stay in the spec and fit stateless servers when static and identical for every caller. The host decides whether the user or the model reads them. I design the tool to work without them and treat a resource as optional context. A server that needs a model calls its own provider, because sampling is deprecated.

## Open questions

- Which of my target hosts let the model read resources, measured with an eval?
- Does Codex document resource support, and does the OpenAI remote MCP tool read resources?
- Does Cursor still send `resources/subscribe` to servers that declare `subscribe: false`, and how do its resources reach the model?
- Does any MCP server I consume still rely on sampling, and when will it be removed?

## Fact-check

| # | Claim | Verdict | Source |
|---|---|---|---|
| 1 | Resources are application-driven and not deprecated | agrees | [Resources spec 2026-07-28](https://modelcontextprotocol.io/specification/2026-07-28/server/resources) |
| 2 | The spec mandates no interaction model. `resources/list` must not vary per connection, only by per-request authorization | agrees | same page |
| 3 | Links returned by tools are not guaranteed to be listed | agrees | [Tools spec](https://modelcontextprotocol.io/specification/2026-07-28/server/tools) |
| 4 | The official pages give no rule for resource against tool | agrees, by absence | [Server concepts](https://modelcontextprotocol.io/docs/learn/server-concepts), [Server overview](https://modelcontextprotocol.io/specification/2026-07-28/server) |
| 5 | A template without `list` is readable but not listed | agrees | [TypeScript SDK resources](https://github.com/modelcontextprotocol/typescript-sdk/blob/main/docs/servers/resources.md), through Context7 |
| 6 | Subscriptions moved to `subscriptions/listen`, sessions and `initialize` were removed | agrees. Spec 2026-07-28 changelog and subscriptions page, read through Context7 | [Subscriptions](https://modelcontextprotocol.io/specification/2026-07-28/basic/patterns/subscriptions), [SEP-2575](https://modelcontextprotocol.io/seps/2575-stateless-mcp), [SEP-2567](https://modelcontextprotocol.io/seps/2567-sessionless-mcp) |
| 7 | Claude Code supports `@` resources and the model tools `ListMcpResourcesTool` and `ReadMcpResourceTool` | agrees, verbatim | [Tools reference](https://code.claude.com/docs/en/tools-reference), [MCP docs](https://code.claude.com/docs/en/mcp) |
| 8 | Claude API connector supports only tool calls | agrees | [MCP connector docs](https://platform.claude.com/docs/en/agents-and-tools/mcp-connector) |
| 9 | Gemini CLI has model tools for resources | agrees | [Gemini CLI docs](https://geminicli.com/docs/tools/mcp-resources/) |
| 10 | Cursor supports resources | agrees in part: changelog and docs say Supported, a forum bug of 2026-02-13 shows a subscribe problem. The path to the model is not stated | [Changelog 1.6](https://cursor.com/changelog/1-6), [docs](https://cursor.com/docs/context/mcp), [forum](https://forum.cursor.com/t/mcp-resources-support/151758) |
| 11 | VS Code Copilot native servers are not in the resource browser, and content should go in a tool result | agrees, verbatim | [MCP developer guide](https://code.visualstudio.com/docs/copilot/guides/mcp-developer-guide) |
| 12 | Codex has resource tools | unverified: issue text only, no doc line | [issue 20195](https://github.com/openai/codex/issues/20195), [issue 6465](https://github.com/openai/codex/issues/6465) |
| 13 | Lecture: support for resources, prompts and sampling varies by client | agrees for resources and prompts (rows 7 to 12). **Outdated for sampling**: it is deprecated, rows 16 and 17 | the lesson, "Model Context Protocol" |
| 14 | Blogs: tool for actions and resource for stable context, hosts lack the UX, 114K against 27K tokens | lecture-independent opinion, one author's tests, no method | [mcp.so](https://mcp.so/blog/mcp-resources-vs-tools), [layered.dev](https://layered.dev/mcp-resources-the-overlooked-primitive/), [dev.to](https://dev.to/kenimo49/mcp-resources-vs-tools-vs-prompts-3-layers-that-cut-my-agents-tokens-from-114k-to-27k-440a) |
| 15 | Skills over MCP: SEP-2640 is Final and the stage is Beta. MCP Apps are Stable with `text/html;profile=mcp-app` | agrees. The apps spec was read verbatim in part | [SEP-2640](https://modelcontextprotocol.io/seps/2640-skills-extension), [Extensions overview](https://modelcontextprotocol.io/extensions/overview), [ext-apps spec](https://github.com/modelcontextprotocol/ext-apps/blob/main/specification/2026-01-26/apps.mdx) |
| 16 | Sampling is deprecated (SEP-2577), new implementations SHOULD NOT adopt it, it moved to the multi round-trip pattern | agrees | [Sampling](https://modelcontextprotocol.io/specification/2026-07-28/client/sampling), [changelog](https://modelcontextprotocol.io/specification/2026-07-28/changelog), [MRTR](https://modelcontextprotocol.io/specification/2026-07-28/basic/patterns/mrtr) |
| 17 | VS Code: "Deprecated in MCP", supported with per-server approval. Claude Code, Cursor, ChatGPT: not stated. TypeScript SDK v2 throws. No shipped server found | agrees. Silence is "not stated", and parts of the Claude Code and OpenAI pages were summarized | [VS Code guide](https://code.visualstudio.com/docs/copilot/guides/mcp-developer-guide), [Cursor docs](https://cursor.com/docs/context/mcp), [TypeScript SDK v2](https://ts.sdk.modelcontextprotocol.io/v2/servers/sampling) |

## Sources

- MCP spec 2026-07-28 and the MCP learn page, read through fetch agents and Context7. TypeScript SDK docs through Context7.
- Client docs and blogs as linked in the fact-check. The sampling section comes from the 2026-07-28 spec pages and the host docs. The `read_doc` fallback, the eval and the "design so the tool works without it" rule are my own reasoning.
