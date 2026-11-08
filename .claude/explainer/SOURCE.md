# Source of this copy

This folder is a **verbatim copy** of the `explainer` skill, kept as an **example of a well-structured skill**. It is not my own skill, and it is not enabled.

| | |
|---|---|
| Original | https://github.com/overment/skills/tree/main/skills/explainer |
| Author | overment |
| Version | 0.5.0 (from `SKILL.md`) |
| Pinned commit | `43b598199f2c843b3a874590c3c92338d9b6af6c` (2026-10-02) |
| Copied on | 2026-11-07 |
| Files | 179 copied unchanged, plus `LICENSE-overment-skills` and this file (both added by me) |
| License | MIT, see `LICENSE-overment-skills` (the repo's license file). Bundled Geist fonts are under OFL-1.1, see `assets/fonts/OFL.txt` |

## Status

- **Not enabled.** Claude Code finds project skills in `.claude/skills/<name>/`. This folder is `.claude/explainer/`, so the harness does not load it. Move or link it into `.claude/skills/` only after a review.
- **Not run.** I did not install Bun, run any script, or build any document.
- **Not code reviewed.** I read `SKILL.md` and `templates/schema.md`. For the rest I only ran a quick text scan: no instruction-like text aimed at agents, no hidden characters, and the only URLs in the scripts are SVG namespace URLs. That scan is not a security review of about 2 MB of TypeScript. Review it before running (see [7 Skill shaper](../../Lecture_2_Context_Agents_md_Skills_Tools/7_skill_shaper_how_to_improve_skills.md) and [5 Skills, Security](../../Lecture_2_Context_Agents_md_Skills_Tools/5_skills.md)).
- **Needs, if ever run:** Bun 1.4 or later. Chrome for `audit`, `shot`, `export` and `gallery`.
- **Pinned on purpose.** Do not auto-update. Re-read the diff before taking a newer version.

## Layout (what to study)

| Path | What it is |
|---|---|
| `SKILL.md` | The entry point: short, with a workflow, a block table and concepts. Details live in `references/` |
| `references/` | Read on demand: `format.md`, `layouts.md`, `writing.md`, `interactions.md`, `capture.md`, `design-law.md`, `blocks/` |
| `templates/` | Starter documents, one per diagram shape |
| `scripts/` | The engine and commands (TypeScript): the fragile, exact work lives in code, not in prose |
| `themes/` | One theme file. Style lives here, never inside documents |
| `assets/fonts/` | Bundled fonts |
