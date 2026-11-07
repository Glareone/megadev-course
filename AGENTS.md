# AGENTS.md

## What this repo is
Personal knowledge base for the **MEGA.dev course**: lecture notes, refined insights, challenge work and my experiments.
Not a codebase. Output is Markdown (+ diagrams) that I re-read and present.

## How it's organized
- `Lecture_N_<Topic>/` = one course day: lecture material + challenge + my experiments.
- Each file inside = one topic, holding the refined ideas and diagrams we built together.
- Images live in `<lecture>/img/` (kebab-case names), linked relatively.
- Root: course setup (`how-to-start-mega-dev-challenge.md`), known issues (`mega-mcp-auth-issues.md`).
- New file: next number, **same numbering style already used in that folder** (`01_` vs `1_`).

## Before writing anything
1. **Check what already exists.** Grep the repo for the topic; extend or link an existing file instead of duplicating it.
2. **Check cross-references.** Every file has a `Related:` line. When you add/rename/split a topic, update links in both directions and keep numbers/titles in sync. No broken relative links.
3. Match the existing file shape (H1 `# N. Title`, `>` one-line summary, `Related:`, sections, Important / Not important for diagrams).

## How we work
- Take the lecture's recommendation → **refine** it → **check how it maps to industry standards** (vendor docs, papers, common practice). Say where it agrees, differs, or is lecture-specific.
- Mark anything not verified from a primary source: "verify before presenting" + link the source.
- Keep it simple: plain words, short sentences, tables/mermaid when they beat prose.

## Fact-check the lecturer (mandatory)
The lecturer's ideas may be outdated, stale, or wrong. Never copy a claim into a note unchecked.
- **Web-search every key claim** against primary sources (vendor docs, papers, specs, official repos) before writing it down.
- Use WebSearch (and Context7 for library/tool docs). Prefer primary over blog/social posts.
- For each claim record a verdict: **agrees** / **differs** / **outdated** / **wrong** / **lecture-specific (opinion)** / **unverified**, plus the source link and the date checked.
- Models, tools and harnesses change fast: note the date, and flag anything that may age.
- If sources contradict the lecturer, say so plainly in the note. Don't soften it.
- Anything we could not verify stays marked "verify before presenting".

## Way of thinking (follow in order, don't skip)
1. **Problem** – state what question the topic answers.
2. **Words refinement** – pin down terms; split terms that are being conflated (e.g. subagent vs worker vs A2A).
3. **Validation** – check against sources and what's already in the repo.
4. **Initial simplification** – the shortest correct version.
5. **Listen** – stop and wait for my recommendations and insights. Don't write the final file before this.
6. **Refined insight** – merge my input, then write/update the file and its cross-references.

## Rules
- Never read or print `.env`, `github.pat`, `configuration.txt` (secrets).
- Don't commit unless asked. Branch per lecture: `feature/lesson-N`.
- Diagrams from images: describe the story, what's important, what's not.
