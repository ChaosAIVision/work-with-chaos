# work-with-chaos

> One pipeline for every task. Evidence on every claim. No session left waiting.

The workflow skill in the chaos-skill collection for working with AI across many projects without losing focus. Born from a real failure mode: hopping between project tabs, answering "yes, continue" one question at a time, watching sessions die on a missing password — and losing the deep-work zone every time.

The fix isn't more discipline. It's a protocol: the human manages, the AI works a fixed pipeline. Every task, every size, every project — the same shape.

## Why

| The failure | The fix |
|---|---|
| AI finishes Q1, asks permission for Q2, waits | Pipeline phases advance on `STATUS.md`, not on permission |
| Session dies mid-task on a missing credential | Input gate checks *before* work starts; stalled tasks park, sessions move on |
| "AI recommended a query" — 5s, one index away from 400ms | Every performance claim carries an evidence label; unlabeled numbers are defects |
| Requirements unclear → build → feedback → rebuild | Decisions close up front: six-axis sweep, one click per open question |
| Agent slides from research into unrequested code edits | Phase discipline: edits only in phase 5 on the frontier ticket; other phases file Candidate Findings ([ADR-0003](adr/0003-plan-first-no-edits-outside-implement.md)) |
| Plans go stale before implementation | Two-layer planning: thin breadth-plan for the day, deep-plan per project right before its block |
| Strong requirements become an ambiguous task list | Stable requirement IDs, outcome tasks, explicit dependencies, and observable verification |
| A requirement changes after some tasks are done | Revise the existing plan; keep valid evidence and reopen affected acceptance criteria |

## The pipeline

| Phase | Result |
| --- | --- |
| 0 Orient | Read STATUS.md, its linked plan revision, the active ticket, and evidence |
| 1 Plan | Objective, stable requirements, scope boundaries, facts, and unknowns |
| 2 Research | Resolve uncertainties affecting scope, task boundaries, order, or verification; cite code and primary sources |
| 3 Decide | Close material open choices; preserve accepted requirements and applicable quality thresholds |
| 4 Tickets | Outcome tasks with requirement ownership, code-anchored Input/Output, dependencies, Gate inputs, verification, and Domino Notes; review before presenting |
| 5 Implement | Confirm approval and readiness; implement within the ticket contract, verify, then checkpoint |
| 6 Review | Inspect actual evidence against the original objective, including integration and failure paths |
| 7 Report | Requirement verdicts, end-to-end flow, per-module evidence, remaining unverified claims, and next action |

The phases govern work; they are not the implementation task list. A plan-only request ends at phase 4 with a reviewed plan. Already settled phases can cite their evidence concisely without inventing questions or extra work.

## What a plan contains

Use the [planning guide](../skills/work-with-chaos/references/planning.md) and [plan/ticket templates](../skills/work-with-chaos/references/plan-template.md). One canonical plan owns requirements and acceptance. STATUS.md records its path, revision, active phase, approval scope, and exact next action.

The overview connects each requirement to responsible tasks and completion evidence. Tickets describe current code, intended behavior, allowed files, required inputs, and checks with expected results. New functions are explicitly proposed; a planned test is never reported as a passed test.

Flexible plans follow actual dependencies, with domino rules breaking ties among eligible tasks. Ordered plans preserve the user's required sequence and stop at a blocked step. Requirement changes keep stable task IDs and valid progress, but reopen tasks whose outputs no longer meet the new contract. See [ADR-0006](adr/0006-outcome-based-planning.md) and the [source research](research/2026-09-17-work-with-chaos-planning.md).

## Install

See the [collection installation guide](../README.md#installation).

## Workflow components

| Internal component | What it does |
|---|---|
| `work-with-chaos` | The orchestrator: seven phases, `STATUS.md` routing, two-layer planning, phase discipline (code edits only in phase 5; everything else files Candidate Findings) |
| `benchmark` | The evidence ladder — 🟢 measured · 🟡 sandbox · 🔴 cited · ⚫ unverified — and the sandbox method behind 🟡 |
| `planning` | Requirement coverage, outcome decomposition, dependencies, verification, and state-preserving revision |
| `decide` | Six-axis sweep for genuine decisions; ADRs where consequential and applicable Quality Contract thresholds |
| `input-gate` | Gate inputs and approval checked before affected execution; Stalled section in STATUS.md, with mode-aware task selection |
| `report` | Decision reports (options, trade-offs, labeled evidence) and delivery reports (flow + per-module table) |

## The evidence ladder

Every performance number that leaves this workflow carries exactly one label:

- 🟢 **Measured** — real environment, real data, real scale
- 🟡 **Sandbox** — local/docker micro-benchmark at realistic scale, conditions stated
- 🔴 **Cited** — primary source with methodology, applicability stated
- ⚫ **Unverified** — reasoning only; may back a hunch, never a recommendation

A number found without a label is a defect, treated like a failing test.

## Design rules

1. **Every task, no fast lane** — uniformity is the point; lane assignment is the judgement call this set exists to remove ([ADR-0001](adr/0001-full-pipeline-for-every-task.md))
2. **Reuse available integrations** — external skills are used as-is when installed and invocable; internal guides provide a portable fallback ([ADR-0005](adr/0005-two-top-level-skills.md))
3. **Markdown is the source of truth** — HTML is a view; the moment it drifts, it's lying
4. **Stalled tasks respect dependencies** — continue eligible flexible work; never jump over a required ordered step
5. **Ask only material open questions** — use the host's available question mechanism, preserve settled decisions, and reuse valid authorization
6. **Completion requires evidence** — task checkboxes and green builds alone cannot establish the user's objective

## Bundled resources

The entrypoint is [work-with-chaos/SKILL.md](../skills/work-with-chaos/SKILL.md). Benchmarking, decisions, the input gate, reports, the domino checklist, the quality contract template, and vocabulary are bundled under its `references/` directory. These guides are read internally; only work-with-chaos is an invocable workflow skill.

## Vocabulary

`Work Block` · `Stalled Task` · `Input Gate` · `Checkpoint` · `Breadth-Plan` · `Deep-Plan` · `Domino Note` · `Quality Contract` · `Evidence Ladder` · `Decision Report` · `Delivery Report` — defined in [the workflow vocabulary](../skills/work-with-chaos/references/context.md).

---

*Built from a grilling session, 2026-08-24. The ADRs remember why.*
