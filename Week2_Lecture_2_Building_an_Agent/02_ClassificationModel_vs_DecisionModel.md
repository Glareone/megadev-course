# 2. A classification model fixes its labels at training time and returns scores; a decision model takes the question and its options with each request and returns a typed probability distribution, so the difference is the contract more than the architecture

> Both turn text into a category, but a classification model learns its labels in training while a decision model receives questions with their options at call time and answers in a typed shape without generating text; TypedBench shows the interface is built on an encoder (Laya), on decoders (Kev, Decision-1) and by a hosted model (Jev) whose mechanism is not published.

Related: [01 LLM vs classification](01_LLM_vs_Classification.md) · [03 Classification options](03_Classification_Options_Market.md) · [04 Jev and Microsoft Decision-1](04_Jev_And_Microsoft_Decision_1.md) · [05 Support chat in production](05_Support_Chat_In_Production.md)

Source: vendor docs, library docs and one preprint, read on 2026-11-18, listed in [Sources](#sources). The TypedBench HTML text has typos, so quotes are checked against the abstract. The timeline and the comparison rows are my own reasoning where marked.

## Glossary

| Term | What it means here | Same thing elsewhere | Not to be confused with |
|---|---|---|---|
| Classification model | A model whose label set is fixed by training and which returns scores per label | scikit-learn classifier, BERT with a softmax head, Comprehend custom | A decision model |
| Decision model | A model behind a contract: state plus typed questions in, probability vector out, no text generated | "System One" model (TypeSafe), Jev, Decision-1 | A decision tree |
| State | The text being judged, shared by all questions in one call | Ollama `state` | A chat history |
| Typed answer | `choice` (one option), `score` (ordinal level), yes/no as a number | Ollama and Telnyx question types | Free text |
| Head | The small output layer on top of a model body | Decision head, pointer head, softmax head | The model body |
| Calibration | Whether a 0.8 score is right about 80% of the time | scikit-learn `CalibratedClassifierCV` | Confidence |
| Framing sensitivity | The answer moves when the same rule is worded differently | TypedBench | Prompt injection |

## 1. The problem

Jev and Decision-1 do classification work, yet their vendors call them decision models, and I first read "decision model" as an LLM or a kind of tree. **What exactly differs from a classification model, and what does it change in use?**

## 2. How the answer to "which labels?" moved

```mermaid
flowchart LR
    R["Rules, keywords"] --> T["Trained classifier: labels in the weights"]
    T --> Z["Zero-shot NLI: labels in the call"]
    Z --> L["LLM with an enum: labels in the prompt"]
    L --> D["Decision model: typed questions in the call"]
    style D fill:#d44,stroke:#d44,color:#fff
```

| Step | Labels defined | Adding a category | Scores |
|---|---|---|---|
| Rules | In code | Edit a rule | None |
| TF-IDF plus linear model, fine-tuned BERT | At training | Label data, retrain | Per class. scikit-learn: `predict_proba` reads as a confidence only if calibrated. `LogisticRegression` is "more likely to return well calibrated predictions", naive Bayes "tends to push probabilities to 0 or 1" ([calibration](https://scikit-learn.org/stable/modules/calibration.html)) |
| Intent NLU (Lex, Dialogflow) | Training phrases | Add phrases, retrain | Confidence and a threshold, see [05](05_Support_Chat_In_Production.md) |
| Zero-shot NLI | In the call: `candidate_labels` and a `hypothesis_template` | Edit the call | Sum to 1 by default. With `multi_label=True` they are independent ([HF pipeline](https://huggingface.co/docs/transformers/main_classes/pipelines)) |
| LLM with an enum | In the prompt | Edit the prompt | Text, or first-token log probabilities restricted to option letters (TypedBench's baseline) |
| Decision model | In the call, per question | Edit the call | Probabilities over the supplied options |

NLI zero-shot already moved the labels into the call. What a decision model adds is the typed contract, shown next.

## 3. The decision model contract

TypedBench defines the interface as a function from state and question to a probability vector, answered "in one call and without generating text", with `choice`, `score` (2 to 10 ordered levels) and `noul` (yes/no) questions. Ollama's schema agrees: named questions about one shared state, answers "not passed to later questions", `criteria` that map option keys to descriptions, probabilities "normalized over the supplied candidates".

| | Classification model | Decision model |
|---|---|---|
| Question | Implied by training | A named question with instructions, in each request |
| Options | Learned labels | Supplied, with descriptions |
| Several questions on one text | Several models or heads | One call, shared state |
| Output | Class and scores | Per question: winner, `probabilities`, `confidence`. Score: a weighted level |
| Probabilities | Meaning depends on the model and on calibration | Relative to the options supplied. Confidence is `1 - H(p)/ln(N)`, "not calibrated correctness" |
| Unknown case | A forced label unless trained with `other` | An `unclear` option, or explicit abstention in Decision-1 |
| Explanation | None | None: "does not generate explanations" |
| Evaluation | Held-out set, F1, calibration | Same, plus framing sensitivity |

The two-flag design in [note 01](01_LLM_vs_Classification.md) matches this: `multi_label=True` in NLI and separate yes/no questions in a decision model both give independent flags, while one `choice` sums to 1.

## 4. Decision-1 and what sits underneath

Decision-1 lists yes/no, multiple-choice, rating, classification and rubric-based questions, explicit abstention, a 32,768-token context, text only, and no rationale ([catalog](https://ai.azure.com/catalog/models/Microsoft-Decision-1)). Its base is Qwen3.5-9B post-trained by Microsoft, so my first reading ("a full Qwen underneath") is right for this model. It does not hold for the class:

| Model | Underneath | Source |
|---|---|---|
| Decision-1 | Qwen3.5-9B, post-trained | Catalog |
| Kev | LoRA plus a pointer head on Qwen3.5 at 0.8B, 4B, 9B | TypedBench |
| Laya | A 421M ModernBERT-large encoder with a decision head | TypedBench |
| Jev | Hosted, mechanism not found | TypedBench |
| Generative baseline | An LLM "restricted to the option letters, with probabilities from their first-token log-probabilities" | TypedBench |

A decision model is a contract that different bodies can fill, from a small encoder to a 9B decoder. How Decision-1 or Jev compute their probabilities is **unverified**.

## 5. What it changes in use

- **Per-request categories:** the category list is data in the call, which suits tenants with their own categories ([note 01](01_LLM_vs_Classification.md) scenario table). A classification model needs a retrain.
- **Cost:** input tokens only, and the shared state is counted again for each question (Telnyx, Ollama).
- **Limits:** the options must be supplied, so a decision model cannot propose categories, and its probabilities are not calibrated per Telnyx, Ollama and TypedBench.
- **Names:** "classification model" for a trained, fixed-label model, "decision model" for the typed-answer contract. Jev answering a `choice` is classification through a decision interface.

## Cautions

- TypedBench is an October 2026 preprint. I read the abstract and the first part of the text.
- Decision-1's response schema is only partly documented, and the blog warns to confirm the route and header.

## Summary

A classification model binds its labels at training and returns per-label scores. A decision model binds the question and options per request and returns typed probabilities. Decision-1 is a Qwen decoder, Laya shows an encoder can fill the same contract, and the labels-in-the-call idea already exists in zero-shot NLI.

## Open questions

- How do Decision-1 and Jev compute probabilities over options?
- Does a small decision encoder (Laya) match a decoder on my categories?

## Fact-check

| # | Claim | Verdict | Source | Checked |
|---|---|---|---|---|
| 1 | A decision model outputs probabilities over typed answers without generating text, in one call | **Agrees** | [TypedBench](https://arxiv.org/html/2610.11392v2), abstract and Section 3.1 read | 2026-11-18 |
| 2 | A decision model is an LLM underneath | **Differs**: Decision-1 and Kev are decoders, Laya is an encoder, Jev unknown | TypedBench Section 4.1, [catalog](https://ai.azure.com/catalog/models/Microsoft-Decision-1) | 2026-11-18 |
| 3 | Probabilities are normalized over the supplied options; confidence is concentration | **Agrees** | [Ollama](https://docs.ollama.com/api/systemone.md), page read | 2026-11-18 |
| 4 | Zero-shot NLI takes labels at call time | **Agrees**. Scores sum to 1 unless `multi_label=True` | [HF pipelines](https://huggingface.co/docs/transformers/main_classes/pipelines), page read | 2026-11-18 |
| 5 | `predict_proba` is a confidence only if calibrated | **Agrees** | [scikit-learn](https://scikit-learn.org/stable/modules/calibration.html), page read | 2026-11-18 |
| 6 | Decision-1 supports abstention and five question types | **Agrees** | Catalog, page read | 2026-11-18 |
| 7 | How Decision-1 and Jev produce their probabilities | **Unverified** | Not documented in the pages read | 2026-11-18 |

## Sources

- [TypedBench, arXiv 2610.11392](https://arxiv.org/html/2610.11392v2)
- [Microsoft-Decision-1 catalog](https://ai.azure.com/catalog/models/Microsoft-Decision-1) · [Ollama System One](https://docs.ollama.com/api/systemone.md) · [Telnyx decision models](https://developers.telnyx.com/docs/inference/decision-models.md)
- [scikit-learn probability calibration](https://scikit-learn.org/stable/modules/calibration.html) · [Hugging Face pipelines](https://huggingface.co/docs/transformers/main_classes/pipelines)
- My own reasoning: the timeline of where labels are bound and the naming guidance.
