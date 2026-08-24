---
name: report
description: Render decision reports (options, trade-offs, labeled evidence) and delivery reports (end-to-end flow plus per-module input/output), as markdown source-of-truth files with optional HTML views. Use after research, at milestones, on-demand, or when another skill needs its findings rendered for review.
---

# Report

Two artifacts, two moments:

- **Decision Report** — after research, before choosing. Its reader is deciding.
- **Delivery Report** — at a milestone or on demand (`/report`). Its reader is accepting work.

Markdown in the repo is the source of truth; HTML is a view, rendered on top, never edited directly.

## Decision Report

Save as `docs/research/<slug>.md` in the target repo, following the `research` skill's citation discipline (every claim carries its source). Structure:

1. **Question** — the measurable question the research set out to answer.
2. **Options** — one section per option: what it is, how it works, what it costs.
3. **Evidence table** — the `benchmark` skill's output pasted whole: option, result, ladder label, conditions. Reject the table if any number lacks a label.
4. **Trade-offs** — per option, what you gain and what you pay. No option gets only-gains prose.
5. **Open choices** — the axes still needing a human decision, phrased so the `decide` skill can turn each into one question with options.

## Delivery Report

Save as `docs/reports/<date>-<slug>.md`. Two forms, both required:

**Form 1 — Flow**: the end-to-end path the implemented change takes through the system, as a mermaid diagram plus a paragraph walking through it. A reader who sees only this form understands *what happens now that didn't before*.

**Form 2 — Per-module table**: one row per module touched, in the chain order:

| Task | Module | Interfaces | Tests | Architecture rules honored |
|---|---|---|---|---|

- **Task** — the ticket this module work belonged to.
- **Module / Interfaces** — its input and output contract (from the ticket's Input/Output fields; `codebase-design` vocabulary for the seams).
- **Tests** — the tests that pin this module's behavior, named.
- **Architecture rules honored** — the ADRs and quality-contract thresholds this module satisfies, cited with the measured evidence label where performance is claimed.

Close with **Unverified claims** — anything this report states that carries ⚫, listed plainly. An empty list is the goal; a hidden list is a defect.

## HTML view

When rendering HTML (artifact or file), load the `artifact-design` skill first, keep the markdown structure 1:1, and pull numbers straight from the markdown source — the moment the HTML drifts from the markdown, the view is lying.
