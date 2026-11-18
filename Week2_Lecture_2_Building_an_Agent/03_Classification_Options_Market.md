# 3. Text classification options on the market, ordered by how much I own: classical ML, trained encoders, managed classifiers, LLMs and decision models

> For a fixed set of categories I can own the whole model (scikit-learn, a fine-tuned encoder), rent a trainable one (Comprehend, Azure AI Language), prompt a general LLM, or call a decision model; the real differences are labeled data, what each returns per class, and vendor status, and some returns are not documented.

Related: [01 LLM vs classification](01_LLM_vs_Classification.md) · [04 Jev and Microsoft Decision-1](04_Jev_And_Microsoft_Decision_1.md) · [05 Support chat in production](05_Support_Chat_In_Production.md) · [W2L1 16 Evals](../Week2_Lecture_1_Agent_Primitives/16_Evals_For_Agent_Changes.md) · [W2L1 21 AI SDK or official SDKs](../Week2_Lecture_1_Agent_Primitives/21_AI_SDK_Or_Official_SDKs.md) · [02 Classification model vs decision model](02_ClassificationModel_vs_DecisionModel.md)

Source: vendor docs and model cards read on 2026-11-18, listed in [Sources](#sources). Where I only saw a search summary, the table says so. The ordering and the comparison axes are my own reasoning.

## Glossary

| Term | What it means here | Same thing elsewhere | Not to be confused with |
|---|---|---|---|
| Multi-class | Exactly one class per document | Comprehend `Classes`, Azure single-label | Multi-label |
| Multi-label | Several classes may apply to one document | Comprehend `Labels`, Azure multi-label | Multi-class |
| Few-shot | A handful of labeled examples per class | SetFit: 8 or 16 | Zero-shot |
| Managed classifier | A cloud service I train with labeled data and call by API | Comprehend custom, Azure custom text classification | A decision model |
| Flywheel | Comprehend's retraining lifecycle for a custom model | - | A feedback loop in the agent |

## 1. The problem

[Note 01](01_LLM_vs_Classification.md) fixed the question: one step, text to one of N categories. **What can I actually use, what does it need from me, and what does it hand back?** The market also contains classical ML, which a decision model is not.

## 2. Options, from most owned to least

| Option | Labeled data | I maintain | Verified facts |
|---|---|---|---|
| Classical ML: TF-IDF plus logistic regression or linear SVM | Hundreds or more (my estimate) | Pipeline, retraining, hosting | A scikit-learn [text tutorial](https://scikit-learn.org/1.3/_sources/tutorial/text_analytics/working_with_text_data.rst.txt) exists. "Linear models suit sparse text" is from guides. Decision trees on raw text: my reasoning, **unverified** |
| Fine-tuned encoder (BERT, DeBERTa) | Hundreds or more | Training, GPU, hosting | One preprint reports "one to two orders of magnitude lower cost and latency" than zero- and few-shot LLM prompting, on four generic datasets ([arXiv 2602.06370](https://arxiv.org/abs/2602.06370), abstract read) |
| SetFit | 8 or 16 per class | Small | [HF blog, 2022](https://huggingface.co/blog/setfit): about 30 s and $0.025 on a V100, 2022 price |
| DeBERTa zero-shot NLI | None | Hosting | [Model card](https://huggingface.co/MoritzLaurer/deberta-v3-base-zeroshot-v1.1-all-33): MIT, English only, 33 datasets, 387 classes. Scores "not strictly zeroshot" |
| AWS Comprehend custom classification | 50 per class multi-class, 10 per class multi-label | Low | [Quotas](https://docs.aws.amazon.com/comprehend/latest/dg/guidelines-and-limits.html): 2 to 1,000 classes (multi-class), 2 to 100 (multi-label), 10 KB real-time document. No zero-shot found |
| Azure AI Language custom text classification | 50 per class recommended | Low | [Limits](https://learn.microsoft.com/en-us/azure/ai-services/language-service/custom-text-classification/service-limits): 10 to 100,000 documents, 1 to 200 classes. [FAQ](https://learn.microsoft.com/en-us/azure/ai-services/language-service/custom-text-classification/faq): about 6 h to train on 12.8M characters. About 100 languages. **Retires from Azure Language on 2029-03-31**, new projects go to Microsoft Foundry ([overview](https://learn.microsoft.com/en-us/azure/ai-services/language-service/custom-text-classification/overview)) |
| Azure ML AutoML NLP | Labeled set | Medium | [Doc](https://learn.microsoft.com/azure/machine-learning/how-to-auto-train-nlp-models): multi-class and multi-label text classification. Model sweeping is preview. BERT-family and GPU detail from search summaries |
| Vertex AI AutoML Text | n/a | n/a | **Deprecated**, shutdown scheduled 2025-06-15 ([deprecations](https://docs.cloud.google.com/vertex-ai/docs/deprecations)). Replacement: Gemini prompts and tuning |
| LLM with an enum schema | None | Prompt, test set | Structured output on OpenAI, Anthropic, Azure OpenAI, Vertex. Per-token probabilities: see section 3 |
| Decision model | None | Test set | Jev, Microsoft-Decision-1. Details in [04](04_Jev_And_Microsoft_Decision_1.md) |

## 3. What each returns per class

This decides whether I can set a threshold at all.

| Option | Per-class output | Documented as probability? |
|---|---|---|
| Comprehend | `Classes` with `Name`, `Score`, `Page` | No. The pages do not call `Score` a probability and do not say it sums to 1. One example sums to about 0.94 |
| Azure AI Language | `confidenceScore` per category | Not stated whether it sums to 1 or is calibrated |
| Azure ML AutoML NLP | Multi-label mentions "predicted probabilities" and a threshold | Inference response format **not found** |
| OpenAI | `logprobs`, `top_logprobs`; Responses API `message.output_text.logprobs` | Token log probabilities. No statement on use with `json_schema`. One forum report says the field is empty with `json_schema` on some models |
| Anthropic | No `logprobs` parameter found in the part of the Messages API reference I read. Structured output via `output_config.format` | Not available as far as read; the rest of the page is unread |
| Vertex AI | `responseLogprobs`, `logprobs` | Token log probabilities. Google's AutoML-to-Gemini page says Gemini "doesn't support confidence scores" |
| Azure OpenAI | `logprobs` in the chat request body | No statement on use with structured outputs |
| Decision model | `probabilities` per option and `confidence` | Normalized across the options, not calibrated per Telnyx and Ollama |

## 4. Industry reading

- Anthropic's routing pattern allows an LLM or "a more traditional classification model/algorithm", so no option here is non-standard ([post](https://www.anthropic.com/research/building-effective-agents)).
- Google retired its trainable text classifier in favor of Gemini prompting. The vendor pull is toward LLM-based classification, and Google's own page lists the loss of confidence scores as a difference.
- The managed services need about 50 labeled examples per class. Three classes is about 150 labeled messages before the first useful model. Zero-shot options need none but need a test set anyway.

## Cautions

- I read Comprehend and Azure pages for limits and response fields only. Prices and training-hour rates are **unverified**.
- Comprehend "$3 per hour" training and per-unit inference rates come from third-party pages, not read from the AWS price list.
- Azure custom text classification, CLU, orchestration workflow and question answering retire on 2029-03-31 ([note 05](05_Support_Chat_In_Production.md)). Custom NER: no notice found. LUIS: **not checked**.
- Vendors change these services. The dates below are the check dates.

## Summary

I can own the model, rent a trainable one, prompt an LLM or call a decision model. Only the decision model documents per-option probabilities, and even those are not calibrated. Managed classifiers return scores whose meaning is not documented. Either way I need my own test set.

## Open questions

- Do Comprehend `Score` and Azure `confidenceScore` behave like probabilities on a held-out set?
- Does Azure ML AutoML NLP return class probabilities at inference?
- Do OpenAI logprobs survive `json_schema` on the models I would use?

## Fact-check

| # | Claim | Verdict | Source | Checked |
|---|---|---|---|---|
| 1 | Comprehend needs 50 documents per class (multi-class) and 10 (multi-label) | **Agrees** | [Quotas](https://docs.aws.amazon.com/comprehend/latest/dg/guidelines-and-limits.html), page read | 2026-11-18 |
| 2 | Comprehend returns a score per class | **Agrees**, meaning of `Score` **unverified** | [ClassifyDocument](https://docs.aws.amazon.com/comprehend/latest/APIReference/API_ClassifyDocument.html), page read | 2026-11-18 |
| 3 | Azure recommends 50 tagged instances per class | **Agrees** | [FAQ](https://learn.microsoft.com/en-us/azure/ai-services/language-service/custom-text-classification/faq), page read | 2026-11-18 |
| 4 | Azure returns `confidenceScore` per class | **Agrees** | [Quickstart](https://learn.microsoft.com/en-us/azure/ai-services/language-service/custom-text-classification/quickstart), page read | 2026-11-18 |
| 5 | Vertex AutoML Text is deprecated | **Agrees**. Whether it is switched off: **unverified** | [Deprecations](https://docs.cloud.google.com/vertex-ai/docs/deprecations), page read | 2026-11-18 |
| 6 | Gemini has no confidence scores | **Differs** from the API: token logprobs exist on Vertex. Google's page means AutoML-style class confidence | [Comparison](https://docs.cloud.google.com/vertex-ai/docs/start/automl-gemini-comparison), [GenerationConfig](https://docs.cloud.google.com/vertex-ai/generative-ai/docs/reference/rest/v1/GenerationConfig), pages read | 2026-11-18 |
| 7 | SetFit works with 8 to 16 examples per class | **Agrees** | [HF blog](https://huggingface.co/blog/setfit), page read | 2026-11-18 |
| 8 | Anthropic has no logprobs | **Unverified**: parameter not found in the part read | [Messages API](https://platform.claude.com/docs/en/api/messages), partly read | 2026-11-18 |
| 9 | Azure custom text classification is a long-term option | **Differs**: it retires on 2029-03-31 | [Overview](https://learn.microsoft.com/en-us/azure/ai-services/language-service/custom-text-classification/overview), page read | 2026-11-18 |

## Sources

- [Comprehend quotas](https://docs.aws.amazon.com/comprehend/latest/dg/guidelines-and-limits.html) · [ClassifyDocument](https://docs.aws.amazon.com/comprehend/latest/APIReference/API_ClassifyDocument.html)
- Azure AI Language: [limits](https://learn.microsoft.com/en-us/azure/ai-services/language-service/custom-text-classification/service-limits), [FAQ](https://learn.microsoft.com/en-us/azure/ai-services/language-service/custom-text-classification/faq), [quickstart](https://learn.microsoft.com/en-us/azure/ai-services/language-service/custom-text-classification/quickstart)
- [Azure ML AutoML NLP](https://learn.microsoft.com/azure/machine-learning/how-to-auto-train-nlp-models)
- [Vertex AutoML Text deprecation](https://docs.cloud.google.com/vertex-ai/docs/deprecations)
- [OpenAI Chat Completions reference](https://developers.openai.com/api/reference/resources/chat/subresources/completions/methods/create) · [Anthropic structured outputs](https://platform.claude.com/docs/en/build-with-claude/structured-outputs) · [Azure OpenAI structured outputs](https://learn.microsoft.com/azure/ai-foundry/openai/how-to/structured-outputs)
- [SetFit](https://huggingface.co/blog/setfit) · [DeBERTa zero-shot card](https://huggingface.co/MoritzLaurer/deberta-v3-base-zeroshot-v1.1-all-33)
- My own reasoning: the ordering by ownership and the comparison axes.
