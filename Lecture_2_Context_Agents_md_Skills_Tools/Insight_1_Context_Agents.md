# Insight 1. Context: AGENTS.md / CLAUDE.md

> AGENTS.md is loaded into **every** session, so it is the main source of token waste.
> Every line must earn its place. Treat it as a **map**, not an encyclopedia.

## Why it matters (evidence)

- [Evaluating AGENTS.md (arXiv:2602.11988, ICLR 2026)](https://arxiv.org/abs/2602.11988): context files raised inference cost by >20%.
  - LLM-generated files slightly *reduced* task success.
  - Human-written files gave only a small gain (~4%).
  - Files did not work as repo overviews: agents did not reach the relevant files in fewer steps.
  - They helped most with **non-standard, non-discoverable** requirements (e.g. "use `uv`, not `pip`").
- Anthropic's test for every line: *"Would removing this cause the agent to make mistakes?"* If not, cut it.
- Long files get the middle ignored ("lost in the middle"). Target: **< 200 lines, ideally 60-100.**

## What to put in (recommended structure)

1. **Project scope** (2-4 lines)
   - What the project is, what it is *not*, who uses it.
   - Out-of-scope areas the agent must not touch.
2. **What's where** (only the non-obvious)
   - A numbered list of key entry points: `1. src/billing/ - invoice engine, start in engine.py`
   - Skip anything inferable from `ls`, `package.json` or the README.
3. **What exists and what was done** (pointers, not prose)
   1. Numbered list of main components or features, each with a path and a one-line status.
   2. **Glossary**: domain terms the agent can't guess (`Tenant`, `Run`, `Sandbox`...). One line each.
   3. **Decisions**: link to ADRs or `docs/decisions/*.md` ("why X, not Y"), so the agent doesn't re-litigate settled choices.
   4. **Explanations**: link to deeper docs. Load on demand, never inline.
   5. **Notes for other contributors**: gotchas, ownership, in-flight work, "don't touch X until Y".
   6. **What it does and how**: build, test and run commands, copy-pasteable, plus the one-paragraph request flow.
4. **Rules the agent gets wrong without being told**
   - Non-default conventions, forbidden patterns, required checks before commit.

## Rules for writing it

- **Pointers over content.** Link to `docs/...` and let the agent read it when needed. (Note: `@imports` in CLAUDE.md still load at launch, so they organize but don't save tokens. Plain path references do.)
- **Only non-discoverable facts.** No directory dumps, no stack descriptions, nothing duplicating the README.
- **Hand-write it.** Don't auto-generate it with `/init` and leave it as is. Prune the output hard.
- **Be specific and verifiable.** "Run `pnpm test:unit` before commit", not "write good tests".
- **Scope it.** Nested `AGENTS.md` per package in a monorepo, and `.claude/rules/*.md` with `paths:` frontmatter, load only when relevant.
- **Move workflows to skills.** Task-specific procedures (deploy, release, migration) belong in Skills, which load on demand.
- **Keep the index fresh.** Stale pointers cost more than no pointers. Update it in the same PR as the change.
- **Evaluate it.** Compare token use and task success with and without a change before rolling out to prod repos.
- **Use ignore files** (e.g. `.claudeignore`) for generated and vendor code.

## Template

```markdown
# <Project>
## Scope
<2-4 lines: what it is, what it is not, out-of-scope>

## Map (non-obvious only)
1. `path/` - what and where to start
2. `path/` - ...

## Done / status
1. <component> - <status> - see `docs/<x>.md`

## Glossary
- **Term**: one-line meaning

## Decisions
- <decision> -> `docs/decisions/001-....md`

## Commands
- Build: `...`   Test: `...`   Run: `...`

## Rules (agent gets these wrong otherwise)
- ...

## Notes for contributors
- ...
```

## Sources

- [Evaluating AGENTS.md: Are Repository-Level Context Files Helpful for Coding Agents?](https://arxiv.org/abs/2602.11988)
- [AGENTS.md: Research & Best Practices](https://agentmd.vercel.app/docs/research-best-practices)
- [The Always-On Context Problem: Why Less Is More](https://olivomarco.github.io/github-copilot-token-optimization/07-agents-md-problem/)
- [CLAUDE.md Best Practices: The Complete 2026 Guide](https://dev.to/nishilbhave/claudemd-best-practices-the-complete-2026-guide-435j)
- [Progressive disclosure (Claude Code Guide)](https://ytrofr.github.io/claude-code-guide/docs/guide/part4-context-engineering/05-progressive-disclosure.html)
