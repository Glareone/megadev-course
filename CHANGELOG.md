# Changelog

What's done, what's in progress, and what gaps remain. This is the only place that tracks the state of the knowledge base. See [AGENTS.md](AGENTS.md).

## Lecture 4 — Working with AI Harnesses (in progress)

Started: 2026-11-08. Branch: `lesson-3` (will move to `feature/lesson-4`).

### Done

- **01 Harness lock-in** — harness as replaceable middle layer, where lock-in sits (table), practical strategies, MCP as portability lever. Fact-checked.
- **02 Agent runner portability** — plugin architecture, adapter boundary, runner contract, MCP as tool protocol. Six evaluation questions for any agent runner. Fact-checked.
- **03 Skill and folder orchestration** — fleet pattern (skills by harness/scope/origin), limen pattern (per-project orchestration), skill metadata as dependency management. Fact-checked.
- **04 COMPUTERS.md — fleet infrastructure** — machine registry, provisioning runbook, infrastructure-as-data pattern, A2A service discovery angle. Fact-checked.
- **Lecture 2 file 5 (Skills) updated** — added fleet metadata section (harness, platform, scope, origin, upstream, model fields). Cross-reference to Lecture 4 file 03.
- **Lecture 3 file 13 (Knowledge skill anatomy) updated** — cross-reference to Lecture 4 file 03.
- **Root README updated** — added Lecture 4 section with all four files.
- **Lecture 4 README created** — index of all files.

### In progress

- Transcript has more topics not yet covered: self-management (Pi + Herdr), multi-agent coordination (coordinator/worker/supervisor pattern), model routing and cost-per-task, teamwork (shared resources, internal knowledge base, AI-friendly tool stack), automated workflows (GitHub-triggered agents).

### Gaps

- No coverage yet of Pi or Herdr specifics — the transcript discusses them in depth.
- Model routing / reasoning effort / cost-per-task — not written.
- Automated workflows (GitHub Actions agents, PR review, issue-to-PR) — not written.
- The limen project structure is referenced in file 03 but not explored in its own file.
- Privacy boundary (deterministic model selection) — mentioned in file 02 fact-check, no dedicated note.

## Lecture 3 — Simplify the Codebase and the Knowledge Base (complete)

14 files covering: simplify first, dumb questions, agent asks dumb questions, ask why, knowledge as files, beyond Markdown, explainer skill, decision models, jevgrep, demos, KB techniques, triggers, knowledge skill anatomy, task board. All fact-checked (2026-11-07/08).

## Lecture 2 — Context, AGENTS.md, Skills and Tools (complete, pre-fact-check-rule)

12 files. Sources and reasoning marked, but written before the systematic fact-check rule. Time-sensitive claims (models, tool behavior, limits) need a re-check pass.

## Lecture 1 — Mechanics Behind Generative AI (complete, pre-fact-check-rule)

17 files. Same status as Lecture 2 — sources marked, systematic re-check pending.
