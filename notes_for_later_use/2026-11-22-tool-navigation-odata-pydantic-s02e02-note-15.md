# Tool errors: my setup against how others keep the error rate low

Date: 2026-11-22
Topic: my tools use an OData contract, parameter validation on the MCP side, a docstring and a Pydantic annotation on each parameter; each failed tool call adds a whole step to the run, so I want a low error rate with supervised freedom for the model
Lecture: S02E02 Building an Agent, part "Designing tools"

| Layer | My setup | What others use | Gap |
|---|---|---|---|
| Shape the call | Structured, typed input and output on the MCP tools, with variable validation | The same: JSON Schema input, an optional output schema the client validates (MCP) | Same |
| Constrain generation | Not stated: does the harness send `strict` to the model API? | Anthropic strict tool use and OpenAI strict mode (constrained decoding, so the call cannot break the schema). OpenAI custom tools with a Lark or regex grammar for free-form text | Open: strict or not, and `$filter` is a free string |
| Teach | Docstring and a Pydantic description per parameter | Same, plus Anthropic `input_examples` (72% to 90% on complex parameters, vendor test) | Examples are not used |
| Narrow the choice | Not stated | Tool search (49% to 74% on Opus 4), per-step tool hiding in Pydantic AI | Open |
| Repair before a step is spent | Not stated | Normalize in code (Pydantic lax mode), one side-model repair (AI SDK `repairToolCall`), then a re-ask with a retry budget per tool (Pydantic AI, Instructor, LangChain) | Open: written up in [Lecture 2: 20](../Week2_Lecture_2_Building_an_Agent/20_Repair_Tool_Calls_Before_A_Step_Is_Spent.md) |
| Self-correct | Validation on the MCP side | MCP: validation errors returned to the model so it can fix them | Same |
| Measure | My own error taxonomy, counted per call: about 1 to 1.5% with the skill loaded, about 3 to 5% without skills (external agents using my MCP server) | Failure taxonomies (arXiv 2507.15296, 2504.15546), counted on a test set | Same practice. Open: the split by error class, and which classes remain with the skill |

Where it is written: [Lecture 2: 15, section 6](../Week2_Lecture_2_Building_an_Agent/15_Tool_Navigation_And_Flexibility.md#6-low-error-rate-with-supervised-freedom). Open: the size of my metadata document in tokens, the five questions that make most of my OData calls, which error classes cost the most steps, and whether dynamic enums per tenant cost more in cache than they save.
