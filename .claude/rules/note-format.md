---
paths:
  - "Lecture_*/**/*.md"
---

# Note format

Every lecture note has the same shape, so I can jump from one note to another and find the same thing in the same place. [AGENTS.md](../../AGENTS.md) says how I gather and check information. This rule says what the finished note looks like.

The model notes: [Lecture 4: 05](../../Lecture_4_Harness/05_Dont_Overspecify_Work_At_Assistants_Level.md) for density and diagrams, [Lecture 3: 13](../../Lecture_3_Simplify_Codebase_&_Knowledge_Base/13_Knowledge_Skill_Anatomy.md) for structure.

## The skeleton

Keep this order. Leave a section out when I have nothing real to put in it (never a placeholder).

| # | Part | What it holds | Required |
|---|---|---|---|
| 1 | `# N. Title` | Number in the folder's style (`01_` in Lectures 3 to 5). The title names the idea, not the lecture part | Yes |
| 2 | `> ` summary | One sentence: the answer, not the topic. A reader who stops here has the point | Yes |
| 3 | `Related:` | Links to sibling notes and to earlier lectures, in both directions. No broken relative links | Yes |
| 4 | `Source:` | The transcript part, picture or documents I actually read, and the check date | Yes |
| 5 | `## 1. The problem` | The question this note answers, in two to four sentences | Yes |
| 6 | `## 2. Words` | A table (term, what it means here, not to be confused with). Only when terms are conflated | If needed |
| 7 | Body sections | Numbered. One concept per section. See "Body sections" | Yes |
| 8 | `## My take` | Architect view, Aras mapping, an infrastructure analogy. Only if it adds what the other sections lack | If needed |
| 9 | `## Cautions` | Real limits and risks of the idea or of my check | If needed |
| 10 | `## Summary` | Two to four lines | Yes |
| 11 | `## Open questions` | Real questions only | If needed |
| 12 | `## Fact-check` | Table: `# \| Claim \| Verdict \| Source \| Checked` | Yes |
| 13 | `## Sources` | Links. Says which parts are my own reasoning | Yes |

**File name while a note is being redone:** the file carries a `draft_` prefix (`draft_04_The_Merge_Button.md`). When the note is final, I drop the prefix and give it its number in the folder. The prefix is the only place the state shows. The note body and the READMEs do not say "draft".

**Why one shape:** I come back to these notes weeks later to decide something. A fixed order means I know where the problem, the evidence and the verdicts are without reading the whole note.

## Body sections

Each concept in the body gets, in this order:

1. **One or two plain sentences** that state the idea.
2. **A visual:** a Mermaid diagram or a table. A paragraph alone is not enough.
3. **Concrete evidence:** a short quote from the lecture (marked as the lecturer's), a worked example, or a real excerpt in a tagged code block.
4. **Important / Not important** bullets when the source is a picture or a long demo. What carries the point, what is decoration.

Keep the three voices apart, as the root README says: what the lecture says, what I add, what industry sources say. Label each where they meet.

## Richness minimums

These keep a note from reading dry.

- At least **one Mermaid diagram** and **one table** per note. Longer notes have more.
- **Every key claim has a link** to a primary source (vendor docs, paper, spec, official repo), or is marked "verify before presenting".
- **Color carries meaning in diagrams.** The point of the diagram is red (`style X fill:#d44,stroke:#d44,color:#fff`). The durable or good path is green (`#2a7`). Fragile or neutral parts stay default or grey (`#888`). Color only what the argument needs.
- **Show the mechanism, not the topic.** A flowchart of how the thing works beats a box labelled with its name.
- **A worked example** for each rule or pattern: the bad case and the good case side by side when the lecture gives both.
- **Numbers over adjectives:** counts, sizes, versions, dates. "Three loops", not "a few loops".

## Diagrams

- Mermaid only (` ```mermaid `). Pick the type that fits: `flowchart`, `sequenceDiagram`, `stateDiagram-v2`, `timeline`, `quadrantChart`.
- Quote node labels that hold punctuation: `A["Label: with colon"]`.
- A literal format (a prompt, a config, a skill file) is not a diagram. Keep it in a code block with a language tag (`text`, `json`, `markdown`).
- No ASCII art, box-drawing characters, or folder-tree drawings.
- A picture from the lecture: copy it to the lecture's `img/` (kebab-case name), link it relatively, then describe the story, what is important and what is not.

## Fact-check table

| Column | Content |
|---|---|
| `#` | Running number |
| Claim | One claim, in plain words, as the lecture states it |
| Verdict | **Agrees** / **Differs** / **Outdated** / **Lecture-specific** / **Unverified** (as in AGENTS.md) |
| Source | Link to the primary source and what I read there (page, file, line). Say when it was a search summary |
| Checked | `YYYY-MM-DD` |

A claim marked **Outdated** or **Differs** is already corrected in the body. The table keeps the verdict, not the history.

## Length and splitting

- A note holds **one question**. Two questions mean two notes.
- Aim for 120 to 250 lines. Past 250, split, or move a long table or example to its own note and link it.
- Each note ends where the next decision begins. Link forward in `Related:`.

## Before I call a note finished

Answer yes to all of these.

1. Does the summary line give the answer, and does `Related:` link both ways?
2. Is there a diagram, a table, and a concrete example in the body?
3. Does every key claim have a link or a "verify before presenting"?
4. Does the fact-check table have a verdict, source and date for each claim?
5. Is the voice first person, with no work-in-progress traces and no empty sections (see [AGENTS.md](../../AGENTS.md))?
6. Do all relative links resolve, and does [CHANGELOG.md](../../CHANGELOG.md) say what was added?
