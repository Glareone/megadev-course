# Source of this copy

This folder is a **verbatim copy** of the `knowledge` skill, kept as an **example of a skill that designs and maintains a knowledge base**. It is not our own skill, and it is not enabled.

| | |
|---|---|
| Original | https://github.com/overment/skills/tree/main/skills/knowledge |
| Author | overment |
| Version | 0.4.0 (from `SKILL.md`) |
| Pinned commit | `ab5cc432e435ca51da4ec0b035a4de27ac15ac3d` (2026-10-02, "knowledge 0.4.0: generate a skill for each base instead of an AGENTS.md") |
| Copied on | 2026-11-08 |
| Files | 12 copied unchanged, plus `LICENSE-overment-skills` and this file (both added by us) |
| License | MIT, see `LICENSE-overment-skills` (the repository's license file) |

## Status

- **Not enabled.** Claude Code finds project skills in `.claude/skills/<name>/`. This folder is `.claude/knowledge/`, so the harness does not load it. Move or link it into `.claude/skills/` only after a review.
- **Not run.** We did not install Bun or run `scripts/check.ts`.
- **Not code reviewed.** We read `SKILL.md` and five reference files (`methods`, `structure`, `upkeep`, `scale`, and the skill entry). For `scripts/check.ts` (about 29 KB) we only ran a text search: no network calls, shell execution, `eval` or file-writing patterns, no instruction-like text aimed at agents, and no hidden characters. That is not a security review. Read it before running.
- **Needs, if ever run:** Bun 1.4 or later (for `check.ts`).
- **Pinned on purpose.** Do not auto-update. The skill changed its design between versions (0.4.0 stopped generating an `AGENTS.md` for each base and generates a skill instead), so re-read it before taking a newer version.

## Layout (what to study)

| Path | What it is |
|---|---|
| `SKILL.md` | The entry point: purpose, ten rules, four tests, a table of reference "nodes", and how to ask and act |
| `references/` | Read on demand: `survey`, `methods`, `structure`, `templates`, `content`, `instructions`, `upkeep`, `scale`, `examples` |
| `scripts/check.ts` | One file with no dependencies that checks links, required fields and drift in a Markdown base. The base's own skill carries a copy |
| `scripts/check.test.ts` | Tests for the checker |
