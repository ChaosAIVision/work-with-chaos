# Report

Two artifacts, two moments:

- **Decision Report** — after research, before choosing. Its reader is deciding.
- **Delivery Report** — at a milestone or on demand (request a report through work-with-chaos). Its reader is accepting work.

Markdown in the repo is the source of truth; HTML is a view, rendered on top, never edited directly.

## Decision Report

For substantial research, save as `docs/research/<slug>.md` and link from the canonical plan. Short settled findings can live directly in the plan. Cite sources for researched claims. Structure, omitting inapplicable comparison sections:

1. **Question** — the measurable question the research set out to answer.
2. **Options** — one section per option: what it is, how it works, what it costs.
3. **Evidence table** — the [benchmark guide](benchmark.md)'s output pasted whole: option, result, ladder label, conditions. Reject the table if any number lacks a label.
4. **Trade-offs** — per option, what you gain and what you pay. No option gets only-gains prose.
5. **Open choices** — the axes still needing a human decision, phrased so the [decide guide](decide.md) can turn each into one question with options.

## Delivery Report

Save as `docs/reports/<date>-<slug>.md`. Two forms, both required:

First reconcile the original outcome contract with actual evidence:

| Requirement | Verdict: met / unmet / unverified | Evidence and conditions | Remaining work |
| --- | --- | --- | --- |

Use stable requirement IDs from the active plan revision. Inspect outputs and verification results; ticket status and an executor's summary are not proof. Missing required evidence means incomplete or unverified, even if every task is checked. For a plan-only request, deliver the reviewed plan and planning limitations instead of pretending to produce an implementation Delivery Report.

**Form 1 — Flow**: explain the end-to-end path the implemented change takes through the system. Use a Mermaid diagram where relationships are clearer visually; a short path can be prose. The reader should understand what happens now that did not happen before.

**Form 2 — Per-module table**: one row per module touched, in the chain order:

| Task | Module | Interfaces | Tests | Architecture rules honored |
|---|---|---|---|---|

- **Task** — the ticket this module work belonged to.
- **Module / Interfaces** — its input and output contract (from the ticket's Input/Output fields; `codebase-design` vocabulary for the seams).
- **Tests** — the tests that pin this module's behavior, named.
- **Architecture rules honored** — the ADRs and quality-contract thresholds this module satisfies, cited with the measured evidence label where performance is claimed.

Close with **Unverified claims** — anything this report states that carries ⚫, listed plainly. An empty list is the goal; a hidden list is a defect.

## HTML view

When rendering an optional HTML view, use an available design skill when relevant, preserve the markdown structure, and pull numbers straight from the source. Do not block reporting on an unavailable external skill.
