# 05 · Lesson Page: Harnesses, Providers and Steering

From the written lesson: the tools around the model and how to steer them.

## Platforms and harnesses
Harnesses hide mechanics for convenience, which requires generalization.

- **Auto compaction**: the model gets only a summary + recent messages. Tool results are dropped and attachments set aside, so the agent may see only a small part of the thread.
- **Plan mode**: helps unless the plan is too broad or detailed. Models struggle to follow all rules in one thread. Splitting into smaller tasks helps, but coordination costs time.
- **Skills**: files with instructions/scripts. Once enabled they stay in context until compaction or a new thread. The model picks a skill only by its name and description, and may pick wrongly.
- **Attachments**: files and folders shown in the UI are not necessarily visible to the model. Content is loaded only when the AI loads it, sometimes partially.
- **Environment**: files and git change during work, but instructions can't be modified (caching), so the harness adds `<system-reminder>` blocks. Your message is not the only thing the model gets.

```mermaid
flowchart LR
    TH["Thread you see:<br/>older messages, tool results,<br/>attachments, recent messages"] --> H["Harness"]
    H --> CX["Context the model gets:<br/>summary + recent messages"]
    H --> NS["Not sent to model:<br/>tool results, attachments"]
```

## Providers
- **OpenAI**: GPT, wide multimodal range, ChatGPT, Responses API.
- **Anthropic**: Claude, text generation and image understanding, Claude and Claude Code.
- **xAI**: full multimodal aim, Grok and Grok Bot.
- **DeepMind / Google**: full multimodal incl. video understanding, Interactions API.
- **OpenRouter**: access to many models.
- Best model changes often, so avoid vendor lock-in. Use different models per task (cost/speed) or several for one task (quality). Use the best models by default, then try lower reasoning or smaller models for tasks run at scale.
- The course suggests harness-agnostic tools: Pi, OpenCode, T3 Code, Superset.

## Generalized steering
Guide the model toward behaviors rather than give precise instructions.

- **Different perspectives**: ask several models, or use **subagents** in separate threads. In the lesson's runs, one subagent per contract got 79-80 of 80 fields right, vs 75-79 for one agent holding all sixteen.
- **Self-querying**: the model asks itself supporting questions first, building context before answering.
- **Memory**: each thread starts from scratch, so the agent needs a way to access needed info (example: "Email the report to Anna" -> search knowledge base -> address).
- **Self-management**: agents change their own settings in place (Pi, OpenCode 2). Agents become first-class citizens in software.
- **Ambient, durable agents**: remote agents started by schedule or event, running in sandboxes with dedicated accounts and limited human contact.

```mermaid
flowchart LR
    Q["User question"] --> M["Model"]
    M --> SQ["Asks itself supporting questions"]
    SQ --> CTX["Relevant context"]
    CTX --> R["Response"]
```

## Lesson takeaways
- A broad overview of the core of generative AI. Not everything needs to be clear yet.
- Models progressed mostly by scaling, not architecture changes, so this knowledge stays valid.
- Understanding the basics helps reason from first principles and tell hype from value.
