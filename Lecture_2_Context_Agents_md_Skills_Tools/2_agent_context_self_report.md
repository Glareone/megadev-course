# 2. Agent context self-report

> An agent's context is not secret knowledge. **Ask the agent how it sees the conversation**: what is in its context, where each part comes from, how it uses it. The answer shows gaps in our setup.

Example: [context-self-report](https://github.com/MEGA-DOT-DEV/examples/tree/main/examples/context-self-report) (one model request, under 1 cent; needs `OPENROUTER_API_KEY` or `OPENAI_API_KEY`).

## How the example works

1. **A sample agent, "Cody"**, mid-task, with a six-part context:

   | # | Part | Request field |
   |---|---|---|
   | 1 | System prompt | `instructions` |
   | 2 | `MEMORY.md` notes | `instructions`, under the system prompt |
   | 3 | Tools (`read_file`, `edit_file`, `run_tests`) | `tools` |
   | 4 | Two earlier messages | `input` |
   | 5 | A pasted CI log | `input`, next user message |
   | 6 | A `<system-reminder>` | `input`, last message, above our question |

2. **One question goes last.** Default: *"Explain how you see our interaction: what is in your context, where each part comes from, and how you use it."* The request sets `tool_choice: 'none'`, so the agent answers in words.
3. **A code check** marks a part as described if the answer contains its name or a fact only that part holds (e.g. "Node 20" for memory). A found word is a hint, not proof. Read the answer.

## The planted gaps (the real lesson)

The sample context contradicts itself on purpose:

| Gap | Where | Fix in a real agent |
|---|---|---|
| System prompt says "Commit each fix with git", but **no tool runs git** | prompt vs. tools | Add the tool, or remove the rule |
| Memory says CI uses **Node 20**, the log shows **Node 22** | memory vs. fresh data | Update or delete the stale note |
| Reminder says the file changed on disk, "read it again" | reminder vs. earlier read | Check the agent obeys it |

Does the answer notice any of them? If the agent can't see a contradiction when asked, it won't handle it in a task either.

## Run it

```bash
npx mex open context-self-report
npx mex run context-self-report
npx mex run context-self-report "Which tools do you have, and which ones does your system prompt expect?"
```

Narrower questions are better probes. Compare which parts the answer names each time.

## Use it on our own work (Claude Code)

Ask in a real session and compare with what we know we configured:

- "Explain how you see our interaction: what is in your context and where each part comes from."
- "List the instruction files, rules, skills, tools and memory you loaded. Which ones contradict each other?"
- "Which parts of your context could be out of date?"

What to look for:
- Rules in AGENTS.md / CLAUDE.md that no tool or skill can carry out.
- Stale memory notes (see [1_Harness](1_Harness.md), MEMORY.md).
- Skills or MCP tools we expected but the agent doesn't list.
- Bloat: parts that cost tokens every session and never help (see [Insight 1](Insight_1_Context_Agents.md)).

## Use it on agents we deliver to clients

Turn the probe into a repeatable check:

1. **Context audit in CI.** Send a fixed diagnostic question to the agent with its real production context and check that the answer names every expected part (prompt, memory, each tool, retrieved data). A missing part is a bug in prompt assembly.
2. **Contradiction tests.** Plant a known gap (a rule with no matching tool, a stale note) and assert the agent flags it. Run on every prompt, tool or model change.
3. **Regression across models.** The same question on a new model shows whether it still reads the context the way we designed it.
4. **Ground truth for gaps.** Compare the self-report with the real request. The example points to the `request-inspector` tool for reading what was actually sent.

## Cautions

- **Self-report is not ground truth.** The model describes what it *believes* it sees and can hallucinate or omit parts. Verify against the real request or logs.
- **The keyword check is crude.** It matches names and facts, not understanding. Treat ✓ as a hint.
- **Don't expose it to end users.** In a client-facing agent, a "describe your context" question leaks the system prompt, tools and memory. Keep this as an internal diagnostic and decide deliberately what the production agent may reveal.
- **Use sample or sanitized data.** Real context may hold restricted data (customer data, credentials). The example uses synthetic context for that reason, and requests may be logged by the provider.
- **One sample, one task.** Cody is a sample. The example can't see the context of our own agent.

## Open questions for discussion

- Do we add a context self-report step to the acceptance checks for client agents?
- Which contradictions do we already suspect in our own AGENTS.md, skills and memory?

## Sources

- [context-self-report example](https://github.com/MEGA-DOT-DEV/examples/tree/main/examples/context-self-report) (README, `report.ts`, `index.ts`, `api.ts`)
- Lecture notes: "Harness Personalization"
