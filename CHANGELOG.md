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
- **01 updated again** — added "Native harness vs multiprovider harness" (`img/native-vs-multiprovider-harness.png`): vendor-locked vs open, trade-offs, my default of flexibility first. Two claims marked unverified (native optimization advantage, product classification).
- **05 Don't overspecify** — the four-layer stack (Code → LLMs → Harnesses → Assistants), why overspecifying lower layers is a trap, the platform-eats-the-layer-below pattern. Fact-checked.
- **Root README updated** — added Lecture 4 section with all four files.
- **Lecture 4 README created** — index of all files.

- **11 Cloud coding agents** — comparison of cloud coding agents (Cursor Cloud Agents, Claude Code in the cloud) vs agent hosting platforms (AgentCore, Foundry). Written from a web search, not from the transcript detail. Vendor facts checked via search summaries of vendor docs (pages not read in full). **Marked "to return to"**: six open questions at the end of the note.

- **12 Context language models** — what the paper is, how a CLM works (context as an editable file), levers, results table, what it does not test, injection risk. Second pass done against the full PDF text (extracted locally). Added: how a CLM differs from Mixture-of-Experts and other model types, weights, code and license, running on standard inference, and the harness plumbing in the zero-shot setup. Resolved earlier unverified items (Table 1 values, 128K result, affiliations, code link). Still open: no weights found, one unreconciled 9B number, Pi package and Software World speedups unverified.
- **13 Herdr vs Orca (agent orchestration)** — Herdr model figure (`img/herdr-server-workspace-tab-pane-agent.png`), two Herdr products, lecture commands checked against the CLI reference, Orca (`stablyai/orca`) worktrees and experimental orchestration, comparison table, layer mapping, cautions. **First pass.** I assumed the stablyai Orca; the note asks the user to confirm. Neither tool was installed or run. Also added the Herdr + Pi coordinator/worker sequence figure (`img/herdr-coordinator-worker-sequence.png`), the Hello World exercise, and a table of how the coordinator learns the result (pull vs push vs files). The exercise itself has not been run.
- **14 What agent fleets need beyond spawning** — the lecture's 11 requirements grouped into four themes, a coverage table against my notes, industry pointers for the weak spots (sandboxing, hooks, agent identity, OpenTelemetry GenAI), 11 test questions for my own platform, and the text-vs-infrastructure split. **First pass.** Industry facts are from search summaries of vendor docs, not full reads.
- **Lecture 2 file 12 (Subagents vs workers) updated** — new section "Which model and effort for each helper" with the lecture's parent-agent figure (`Lecture_4_Harness/img/parent-agent-picks-model-and-reasoning-for-managed-agents.png`), a table of who can set a helper's model (subagent, worker, A2A peer), and the point that model routing stops at the A2A boundary because A2A peers are opaque. The A2A paragraph now carries what the official docs say (search summaries). **The rest of file 12 was not re-checked**, and its Claude Code, Codex and DeepSeek TUI details are time-sensitive.
- **08 and 16 updated** — 08 uses the real figure instead of my redrawn diagram, and "workers" and "based on task complexity" are corrected to "managed agents" and "general recommendation adapted to the ongoing context". 16 now says how common mixing inside one task is (`opusplan`, Aider architect mode).
- **17 Cost per task** — the lecture's cost figure (`img/token-price-vs-cost-per-task.png`) worked through, tasks per dollar, cost per solved task (with a clearly invented illustration), why tokens per task differ, who publishes cost per task, what to measure in my own runner. **First pass.** Billing and Artificial Analysis facts come from search summaries. **slopalytics.com could not be read** (client-rendered page), so the lecture's claim about it is marked unverified. 08 now links to 17 instead of holding the example, and its slopalytics fact-check row is corrected.
- **16 SOTA and reasoning effort** — the lecture's 2×2 grid (`img/sota-model-vs-reasoning-effort-grid.png`), the two dials explained, Anthropic and OpenAI effort docs, vendor-reported cost numbers, the course effort-routing example read (a harness with no measured results), a neutral effort scale for a portable runner. **First pass.** Vendor facts come from search summaries, not full page reads. Added my step-down practice (high effort for the initial reasoning, then lower), how it differs from the course example, the cache cost of changing effort mid-session, and how Claude Code's `/effort` works.
- **08 trimmed and corrected** — the grid and effort detail moved to note 16 (08 links to it), and the effort-routing fact-check row now says what the example really contains. Lecture 1 file 06 links to note 16.
- **15 Pi and limen behind the scenes** — the job-record figure (`img/pi-orchestration-spec-job-record-branch.png`) explained arrow by arrow against Pi's extension docs and the limen repo at the pinned commit: Pi's events and `sendUserMessage` delivery modes, limen's three hooks, the real job-record layout, a sequence diagram, a job `state` state machine, cautions. **First pass**, read through reader agents. Nothing was run.
- **07 corrected (limen details)** — file names now match the limen repo (`spec/vision.md`, `spec/build.md`, `.agents/limen/styleguide.md`, `spec/features/<state>/`, `.limen/jobs/<id>/`). The worker-steering and job-end examples are simulations, not Pi extensions. No final-report tool was found. styleguide re-injection is confirmed in limen's `communication.ts`. The figure replaces my redrawn diagram. Lecture 2 file 3 now links to 15 and its final-report bullet is softened.
- **07 updated** — added the lecture's swimlane figure (`img/pi-lifecycle-hooks-job-states-swimlane.png`), the job lifecycle as a state machine, a corrected job-record diagram, and "Where the lifecycle hooks attach" (a table mapping each limen extension to the nearest Claude Code hook event, and why the supervisor is not a hook). **Corrected:** the old diagram showed workers reporting directly to the coordinator, which the lecture's figure says does not happen. Two event mappings (`PostToolUse` for steering, `FileChanged` for the job watcher) are marked unverified.
- **Lecture 2 file 3 (Lifecycle hooks) updated** — new section "Hooks across several agents: a worked example" with the swimlane figure (linked from `Lecture_4_Harness/img/`, one copy), each hook tagged with its stage, and a cross-reference to Lecture 4 files 07 and 15. Lecture 4 file 07 links back.
- **06 corrected** — "Herdr wraps around Pi" replaced (Herdr keeps any terminal program alive, Pi is one integration), `agent start` needs a pane id, keep-alive claim verified. Markers added in the body and the fact-check row.
- **05 corrected** — the paper claim was marked "Agrees" after I only confirmed the paper exists. Reading it showed the claim is narrower (wins over named baselines, one tie, one trail, no commercial harness tested). Fixed in the body and the fact-check row, with a `Corrected 2026-11-08` marker.

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
- **From the 11-point fleet checklist (note 14), no dedicated note yet:** own accounts and agent identity (8), monitoring and evaluation (11), human-involvement and approval policy (5), sandboxes and guardrails (6). Point 7 (own VPS or device) and point 10 (per-person agents in a team) are only partly covered. The lecturer says later lessons cover these, so I map them into note 14 when they arrive.
- **From note 17 (cost per task):** slopalytics.com is unread. It needs a browser, and the lecture's claim that it provides a Cost Per Task metric is unverified.
- **From note 15 (limen behind the scenes), not read:** `coordinator-wake.ts`, `wrapper.ts`, `hook/hosted.ts`, `git.ts`, `finish-webhook.ts`, the templates and docs, the tail of `hook/wake.ts`, and the middle of Pi's extensions page (it came as a summary). Open: is there a final-report tool, is `.limen/` git-ignored, can the coordinator get the job-end message twice.

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
