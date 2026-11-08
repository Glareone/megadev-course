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
- **01 updated** — added "Split the problem into layers": the lecture's seven-layer stack figure (`img/harness-stack-seven-layers.png`), harness-agnostic vs execution-agnostic vs provider-agnostic, portable / swappable / coupled diagram. Sections renumbered 4–6.
- **05 Don't overspecify** — the four-layer stack (Code → LLMs → Harnesses → Assistants), why overspecifying lower layers is a trap, the platform-eats-the-layer-below pattern. Fact-checked.
- **Root README updated** — added Lecture 4 section with all four files.
- **Lecture 4 README created** — index of all files.

### Drafts (first pass from transcript only, to be refined with my thoughts)

Written 2026-11-08 straight from the transcript outline. Not yet merged with my own insights, so they skip the "listen" step in AGENTS.md. Each will be adjusted one by one as I read the lecture.

- **06 Self-management (Pi, Herdr)** — Pi/Herdr claims are all "verify before presenting". Not checked against their docs.
- **07 Multi-agent coordination** — limen architecture, files as messages, worktrees. Limen repo not read, only the transcript description.
- **08 Settings (model routing, cost per task, privacy)** — "efficient since Opus 4.8" claim unverified. Slopalytics not checked.
- **09 Teamwork (knowledge base, tool stack)** — tool stack list is the lecturer's, AI-friendliness not checked per tool.
- **10 Automation (repository agents)** — GitHub integration table not re-checked against current vendor docs.

### Gaps

- **Fact-check depth:** files 06–10 rely on the transcript and linked example repos existing. No primary-source read of Pi, Herdr, limen, or the examples.
- **CLI vs UI harness comparison, core vs critical features** (transcript section 1) — only touched in 01 and 05, no dedicated note.
- **The limen project** is described in 03 and 07 but its repo is not explored in its own file.
- **My own insights** are missing from 06–10 (architect view, Aras platform mapping, A2A).
- **Cross-references:** older Lecture 2 and 3 notes do not yet link forward to 06–10.

## Lecture 3 — Simplify the Codebase and the Knowledge Base (complete, has unverified claims)

14 files, all fact-checked (2026-11-07/08). No missing file numbers.

### Unverified claims (need resolution)

- **File 01** — #9: Cursor/SpaceX AI tweet could not be found. Still marked "verify before presenting."
- **File 05** — #8: company-scale KB claim, #9: agent-written wiki accuracy, #10: human/LLM edit conflicts, #14b: opponent-role fix, #15: thinking rounds.
- **File 06** — #4: MDX state persistence, #5: source simplicity at scale, #7: MDX security.
- **File 07** — #3: explainer skill made the picture, #4: offline capability.
- **Files 08, 09, 10** — decision model vs vector/hybrid search comparison — no primary source compares them (repeated across three files).
- **File 09** — #4: jevgrep speed, #8: jevgrep skill safety not reviewed after install.
- **File 11** — #15: knowledge skill works (not run), Folgezettel/Johnny.Decimal/Evergreen dates unverified, llms.txt status.
- **File 12** — #7: repo-created webhook trigger, #9: local daemon observation.
- **File 13** — #8: knowledge skill script safety — partial read only, "not a review."

### Open questions

Every file (01–14) has an "Open questions" section. None have been resolved in writing.

### Cross-reference gaps

- Files 02, 03, 04 have no forward links to Lecture 4 material.
- File 08 (Decision models) could link to Lecture 4 file 02 (agent runner portability) re: routing decisions.

## Lecture 2 — Context, AGENTS.md, Skills and Tools (complete, pre-fact-check-rule)

13 files (Insight_1 + files 1–12). Sources and reasoning marked, but **no fact-check tables** — written before the systematic fact-check rule.

### Gaps and staleness risk

- **File 1 (Harness)** — `.claude/rules/*.md` with `paths:` frontmatter mentioned as `(not covered)`. Never got its own treatment.
- **File 4 (Context window)** — context limit "roughly 250k–1M tokens" — stale range, needs update for current models.
- **File 5 (Skills)** — token cost of fetch-based vs embedded skills marked "to be checked" — never checked.
- **File 7 (Skill shaper)** — "Checked in September 2026 and agents change quickly, so re-check details." Placement facts flagged as aging fast.
- **File 11 (Tool upfront vs discovery)** — "Corrections made on 2026-11-04… Re-check before presenting." Tool hints flagged as "not covered here" and "next topic" — no later file covers it.
- **File 12 (Subagents vs workers)** — A2A section from "search summaries only (verify before presenting)." Agent names (Claude Code agent teams, Codex multi-agent, DeepSeek TUI) flagged as changing fast.
- **All files** — no dates on time-sensitive claims (models, context sizes, MCP behavior, hook APIs, tool schemas). **Highest staleness risk in the repo.**

### Open questions

Every file has an "Open questions" section. None have been resolved in writing.

### Cross-reference gaps

- Files 1 (Harness) and 12 (Subagents vs workers) should link to Lecture 4 harness and fleet material.
- File naming: `5_skills.md` uses `N_` style vs Lecture 3's `05_` zero-padded style (cosmetic inconsistency, not a content gap).

## Lecture 1 — Mechanics Behind Generative AI (complete, pre-fact-check-rule)

17 files. Same status as Lecture 2 — sources marked, no fact-check tables, systematic re-check pending. Not audited in detail yet.
