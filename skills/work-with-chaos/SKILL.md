---
name: work-with-chaos
description: The master workflow for starting or resuming any piece of work in any project - routes to the right phase (plan, research, decide, tickets, implement, review, report) from the repo's STATUS.md, runs the input gate before implementation, and keeps evidence labels on every performance claim. Use when beginning a task, resuming a session, planning a day across projects, or when unsure which phase a piece of work is in.
---

# Work With Chaos

One protocol for every task, in every project, every size. The human manages; the AI works the pipeline. Consistency is the product — a fast lane would reintroduce the judgement calls this protocol exists to remove.

## Phase 0 — Orient (every session start)

1. Read the target repo's `STATUS.md` (create it if absent — template below). It holds: current phase, active task, **Stalled** tasks with their missing inputs, open decisions.
2. If `STATUS.md` shows work in flight → resume that phase. If the session starts clean → Phase 1.

`STATUS.md` is the only routing source. Never ask the human "where were we?" — that question is what this file exists to answer.

## Phase 1 — Plan

Two layers, per the ADR on planning:

- **Breadth-Plan** (one session, all projects): thin plans, just deep enough to order the Work Blocks and surface which projects lack inputs. Output: the day's block order + the first Stalled list (feed to `input-gate`).
- **Deep-Plan** (per project, in the block before that project's implement block): full pipeline below for that project's task.

## Phase 2 — Research

Two background agents in parallel (dispatch both, keep working):

- **Inside agent** — scans the existing codebase: current patterns, dependencies, constraints, prior art.
- **Outside agent** — the `research` skill: primary sources only.

Then the `benchmark` skill turns comparisons into labeled evidence. Output: a **Decision Report** (`report` skill, Decision form) — options, trade-offs, evidence table, open choices.

## Phase 3 — Decide

The `decide` skill: sweep the six axes (architecture · performance · database · api · security · test), one AskUserQuestion per *genuinely open* axis — settled axes get one line citing their ADR, not a question. Lock `QUALITY-CONTRACT.md` here if not yet locked. Decisions land in `docs/adr/` per the `domain-modeling` skill.

## Phase 4 — Tickets

The `to-tickets` skill, extended: each ticket keeps the local-file convention (`.scratch/<slug>/issues/NN-*.md`, blockers first) plus four fields —

- **Input** — what must exist before starting (feeds `input-gate`)
- **Output** — the verifiable artifact the ticket delivers
- **Quality gate** — the contract thresholds + evidence label (🟢/🟡/🔴/⚫) this ticket must meet
- **Domino Note** — why this ticket sits at this position (`${CLAUDE_SKILL_DIR}/domino-checklist.md`)

Order by the domino checklist, top-down; the first discriminating rule decides.

## Phase 5 — Implement

1. Run `input-gate` on the frontier ticket. Stalled → park it in `STATUS.md`, offer a `wizard` for the human-only step, move to the next ticket. The block never waits.
2. Implement per the `implement` skill (/tdd at pre-agreed seams, regular typechecks, full suite at the end).
3. In parallel: a background agent hunts edge cases against the *current* ticket; findings feed the *next* ticket's test cases, never the running one.
4. **Checkpoint** at each ticket's end: commit + tick the ticket's acceptance criteria + update `STATUS.md`.

## Phase 6 — Review

The `code-review` skill (two axes, as-is), plus one added sub-agent: performance vs `QUALITY-CONTRACT.md` and edge-case/error-handling sweep. Unlabeled performance numbers found in code or docs count as findings.

## Phase 7 — Report

At milestone or `/report`: the `report` skill, Delivery form — end-to-end flow + per-module table (Task → Module → Interfaces → Tests → Architecture rules honored), plus the plain **Unverified claims** list. Update `STATUS.md`; if the block ends, write a `handoff` doc.

## Vocabulary

The glossary lives in this repo's `CONTEXT.md` — Work Block, Stalled Task, Input Gate, Checkpoint, Breadth-Plan, Deep-Plan, Domino Note, Quality Contract, Evidence Ladder, Decision Report, Delivery Report. Use these terms; don't rename them mid-flight.

## STATUS.md template

```md
# Status

Phase: <1-7 or in-flight note>
Active: <ticket or task>

## Stalled
- <ticket> — missing <input> — unblocked by <human action>

## Open decisions
- <axis>: <what's unresolved>
```
