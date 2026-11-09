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
3. Match the existing file shape (H1 `# N. Title`, `>` one-line summary, `Related:`, sections, Important / Not important for diagrams). The full form (order, minimums, colors, checklist) is in `.claude/rules/note-format.md`.

## How we work
- Take the lecture's recommendation → **refine** it → **check how it maps to industry standards** (vendor docs, papers, common practice). Say where it agrees, differs, or is lecture-specific.
- Mark anything not verified from a primary source: "verify before presenting" + link the source.
- Keep it simple: plain words, short sentences, tables/mermaid when they beat prose.
- **Voice: first person singular.** Write as me: "I", "my", "me". Never "we", "our" or "us" in the notes. Keep "we" only inside quotes from the lecture or a source. After renaming a heading, fix the anchors that link to it.
- **The lecturer's reference setup** (the tools, automated workflows and repositories he names) is kept in README.md under "The lecturer's reference setup". When a lecture names a new tool or workflow, add it to the matching category there and name the lecture it came from: [https://github.com/overment/limen](https://github.com/overment/limen)

## Fact-check the lecturer (mandatory)
The lecturer's ideas may be outdated, stale, or wrong. Never copy a claim into a note unchecked.
- **Web-search every key claim** against primary sources (vendor docs, papers, specs, official repos) before writing it down.
- Use WebSearch (and Context7 for library/tool docs). Prefer primary over blog/social posts.
- For each claim record a verdict: **agrees** / **differs** / **outdated** / **wrong** / **lecture-specific (opinion)** / **unverified**, plus the source link and the date checked.
- Models, tools and harnesses change fast: note the date, and flag anything that may age.
- If sources contradict the lecturer, say so plainly in the note. Don't soften it.
- Anything we could not verify stays marked "verify before presenting".
- **Fix outdated or wrong facts at once, in the note body.** A verdict in the fact-check table is not enough. Rewrite the sentence so it is simply right and cite the primary source. Leave no correction marker. What changed goes in CHANGELOG.md.
- **Fix it everywhere.** Grep the whole repo (all lectures) for the same claim and correct every note that repeats it. When we edit an old note, re-check its time-sensitive claims (models, tool behaviour, versions, prices, limits).
- Prefer the primary source over a search summary. When a search summary supports a correction, confirm it against the vendor docs and say which one we read.

## Way of thinking (follow in order, don't skip)
1. **Problem** – state what question the topic answers.
2. **Words refinement** – pin down terms; split terms that are being conflated (e.g. subagent vs worker vs A2A).
3. **Validation** – check against sources and what's already in the repo.
4. **Initial simplification** – the shortest correct version.
5. **Listen** – stop and wait for my recommendations and insights. Don't write the final file before this.
6. **Refined insight** – merge my input, then write/update the file and its cross-references.

## Progress tracking
- **[CHANGELOG.md](CHANGELOG.md) is the single source of truth** for what's done, what's in progress, and what gaps remain. Don't track progress anywhere else. Update it when files are added, updated, or when gaps are identified.
- Before starting a new topic, check the changelog for what's already covered and what's still missing.

## Documents stay clean and finished
A note, a README or a table always reads as a finished document. It states what is true now.
- **Leave no work-in-progress traces anywhere** (notes, READMEs, tables, image captions). Forbidden: `Corrected YYYY-MM-DD: was X, now Y`, "my first version said", "this is provisional", "first pass", "draft", "to be refined", "worth fixing", "probably", "found an issue", and any reasoning about how we got to the current text.
- **When a fact is wrong, rewrite it.** The sentence becomes right and cites its source. The history lives in git and in CHANGELOG.md.
- **If I have nothing to add to a section, leave the section out.** Never keep an empty or placeholder section.
- **Do not leave notes to the reader or to me** inside a document ("tell me if…", "I want to come back to this"). Real open questions go in an "Open questions" section as questions.
- **What stays:** a fact-check verdict (agrees, differs, outdated, wrong, lecture-specific, unverified) with its source and date, and "verify before presenting" on an unverified claim. They describe the claim, not the work.
- **The state of the work** (done, in progress, gaps, what changed) is written only in CHANGELOG.md.

## Rules
- Never read or print `.env`, `github.pat`, `configuration.txt` (secrets).
- **Content scope:** notes hold how we think, analyze and struggle. Never put Aras business secrets, customer data, PII, credentials or other Restricted Data in any file. If an example needs business detail, abstract it. If something slips in, stop and tell me.
- Don't commit unless asked. Branch per lecture: `feature/lesson-N`.
- Diagrams from images: describe the story, what's important, what's not.
- **Diagrams are Mermaid only** (` ```mermaid `). No ASCII art, box-drawing characters or arrow sketches in code blocks, and no folder-tree drawings. Pick the fitting type: `flowchart`, `sequenceDiagram`, `stateDiagram-v2`, etc.
- A code block that quotes a **literal format** (what the model really sees, a prompt to paste, a config file) is not a diagram. Keep it as code and give it a language tag (`text`, `json`, ...).
- When touching an old note, convert any ASCII diagram you find to Mermaid.
