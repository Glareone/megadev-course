# Memory-centric agent with events: Ledger or Journal?

Date: 2026-11-22
Topic: memory changes through different channels, then an event comes; I register messages, a journal (my Concept Ledger) and a schedule
Lecture: S02E02 Building an Agent, part "Core features" (figure 5, six primitives)

This is the principle I also have in mind: the agent is driven by events from changes to memory. I want to come back and decide whether my Ledger and the article's Journal are one record or two, and how the agent avoids waking on its own writes.

Where it is written: [Lecture 2: 10](../Week2_Lecture_2_Building_an_Agent/10_Memory_Centric_Approach_With_Events.md). Related review: [audit ledger](2026-11-15-audit-ledger-review-s02e01-note-12.md).

The Ledger (Journal) is append-only storage of the session and of the actions that were confirmed. Open: whether "confirmed" means my approval, the tool's result, or both.
