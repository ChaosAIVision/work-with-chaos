---
name: work-with-chaos
description: The master workflow for starting or resuming any piece of work in any project - routes to the right phase (plan, research, decide, tickets, implement, review, report) from the repo's STATUS.md, runs the input gate before implementation, and keeps evidence labels on every performance claim. Use when beginning a task, resuming a session, planning a day across projects, or when unsure which phase a piece of work is in.
---

# Work With Chaos

One protocol for every task, in every project, every size. The human manages; the AI works the pipeline. Consistency is the product — a fast lane would reintroduce the judgement calls this protocol exists to remove.

## Phase Discipline (read this before anything else)

**The phase in `STATUS.md` decides what you may touch. Not your judgement. Not the size of the fix.**

| Phase | Code files (`Edit`/`Write` on source) | What findings become |
|---|---|---|
| 1 Plan, 2 Research, 3 Decide, 4 Tickets | **Forbidden. No exceptions.** | A **Candidate Finding** in the Decision Report or a new ticket |
| 5 Implement | Allowed **only** after the **Approval Gate** (end of phase 4), and only on the frontier ticket's files | The change itself + tests |
| 6 Review, 7 Report | Forbidden (review reports; it doesn't repair) | A finding in the review output → new ticket |
| No `STATUS.md`, no locked phase | Forbidden | Nothing gets touched — write the `STATUS.md` first |

Rules that make this hold:

1. **Planning is the work.** A fix applied during research destroys the plan it was supposed to feed: the Decision Report no longer describes reality, tickets are written against a codebase that silently changed, and the human approved a plan that no longer exists. An un-fixed bug you can see costs minutes; a corrupted decision trail costs the whole pipeline.
2. **There is no "small fix" exemption.** A one-line signature change *is* an implementation decision — it has a caller, a test, and a place in the Decision Report. "It's just one line" is exactly how a session slides from research into unreviewed implementation, edit after edit, without anyone choosing to.
3. **Findings, not fixes.** When research or verification surfaces a defect (wrong signature, dead call, broken import), record it as a **Candidate Finding**: file:line, what's wrong, evidence, proposed fix. File it in the Decision Report (phase 2–3) or as a ticket (phase 4+). The fix happens in phase 5 against a ticket, with tests, at a Checkpoint — or it doesn't happen this cycle.
4. **Verify read-only.** Running tests, grepping, reading files, measuring — always allowed, every phase. These are how findings get their evidence labels. The moment verification tempts an edit, that temptation is the finding.
5. **If you already edited in the wrong phase: revert, then record.** Undo the edit, put the Candidate Finding where it belongs, and say so in `STATUS.md`. Do not keep the edit because "it was right" — the process violation is the defect now.
6. **When the human says fix it now, that's a phase change.** Update `STATUS.md` to phase 5 with that ticket first. One line, then implement. The protocol doesn't block the human — it blocks *drift*.

## Internal guides

The following procedures are bundled references inside this skill. Read the relevant guide directly at its phase; do not invoke a separate benchmark, decide, input-gate, or report skill.

| Phase or need | Read |
| --- | --- |
| Compare options or substantiate performance | [Benchmark](references/benchmark.md) |
| Close open decisions and lock the contract | [Decide](references/decide.md) |
| Verify inputs before implementation | [Input gate](references/input-gate.md) |
| Write a Decision Report or Delivery Report | [Report](references/report.md) |
| Order tickets | [Domino checklist](references/domino-checklist.md) |
| Seed quality thresholds | [Quality contract template](references/quality-contract-template.md) |
| Resolve workflow vocabulary | [Context](references/context.md) |

Resolve these paths relative to this SKILL.md. The repository also contains the independent diagnose-linux-disk skill; its diagnostic workflow does not inherit this orchestration pipeline.

## External skill wiring — what the AI can and cannot call

An external skill referenced below is invoked through the Skill tool, which only works for **model-invocable** skills. Of the matt-pocock set, `research`, `grilling`, `domain-modeling`, `code-review`, `tdd`, `wizard` are model-invocable — the AI calls them on its own when the phase says so. The rest (`to-tickets`, `implement`, `handoff`, `grill-me`, `grill-with-docs`, `to-spec`, `teach`, …) are user-only slash commands (`disable-model-invocation: true`): **the AI cannot call them, ever.** Where a phase leans on one, its behavior is inlined in the phase text and the name is attribution, not an invocation. For the full original, the human runs the slash command.

`grill-with-docs` is the composition `grilling` + `domain-modeling` — both invocable — so the pipeline reproduces it inline where it belongs instead of calling a command it can't.

## Phase 0 — Orient (every session start)

1. Read the target repo's `STATUS.md` (create it if absent — template below). It holds: current phase, active task, **Stalled** tasks with their missing inputs, open decisions, plan approval.
2. If `STATUS.md` shows work in flight → resume that phase, under Phase Discipline above. A file showing phase 5 without `Plan approved:` set is actually at phase 4 behind the Approval Gate — present the package, don't resume the edits. If the session starts clean → Phase 1.

`STATUS.md` is the only routing source. Never ask the human "where were we?" — that question is what this file exists to answer. It is also the only thing that unlocks code edits: no `STATUS.md` at phase 5 *with the Approval Gate passed*, no `Edit`/`Write` on source files.

## Phase 1 — Plan

Two layers, per the ADR on planning:

- **Breadth-Plan** (one session, all projects): thin plans, just deep enough to order the Work Blocks and surface which projects lack inputs. Output: the day's block order + the first Stalled list (feed to the [input gate](references/input-gate.md)).
- **Deep-Plan** (per project, in the block before that project's implement block): full pipeline below for that project's task.

## Phase 2 — Research

Two background agents in parallel (dispatch both, keep working):

- **Inside agent** — scans the existing codebase: current patterns, dependencies, constraints, prior art.
- **Outside agent** — the `research` skill: primary sources only.

Read [benchmark](references/benchmark.md) to turn comparisons into labeled evidence. Output: a **Decision Report** ([report guide](references/report.md), Decision form) — options, trade-offs, evidence table, open choices, **Candidate Findings** (defects seen while scanning, recorded — not fixed — per Phase Discipline).

## Phase 3 — Decide

Two instruments, in order:

1. **Grill first** — the `grilling` skill (model-invocable): interview the human in frontier rounds over the Decision Report — every open decision, numbered questions, recommended answer each. The [decide guide](references/decide.md)'s six-axis sweep is the *map* of what to grill; grilling is how each genuinely open axis gets closed. Where an ADR or glossary entry crystallizes mid-grill, write it per `domain-modeling` as you go (this is `grill-with-docs` inlined — its parts are invocable even though the command isn't).
2. **Then lock** — the [decide guide](references/decide.md): settle anything grilling left as clicks (one AskUserQuestion per remaining open axis — settled axes get one line citing their ADR, not a question). Lock `QUALITY-CONTRACT.md` here if not yet locked. Decisions land in `docs/adr/` per the `domain-modeling` skill. Candidate Findings get triaged here: fix-in-phase-5 (becomes a ticket), defer, or reject — one decision each.

## Phase 4 — Tickets

Ticket format follows `to-tickets` (user-only command — behavior inlined here; run `/to-tickets` for the full original): each ticket keeps the local-file convention (`.scratch/<slug>/issues/NN-*.md`, blockers first) plus five fields —

- **Input** — a **code anchor**: `file` + `function/class` this ticket starts from, and its current behavior in one line — the logic being changed, where it lives *today*. Not "what must exist" in the abstract; that's the pipeline's job. A ticket starts from code, or from the empty file it will create.
- **Output** — the same anchors *after* the change: which functions/files are added, modified, or deleted — new signature + one line of new behavior. The code is the artifact; name it. Bad: "swap detection source to ABBOTT API". Good: "`_check_ra_shop()` (`scripts/run_batch_async.py`) → GET `{ABBOTT_API_BASE}/api/ai-qc/intraday/records?callId=`; `_ra_shop_api_target` + 3rd-party path deleted."
- **Gate inputs** — the checkable externals `input-gate` verifies before phase 5 (credentials, data, env, access, a verified API, an accepted ADR). Lives here — never mixed into Input/Output.
- **Quality gate** — the contract thresholds + evidence label (🟢/🟡/🔴/⚫) this ticket must meet
- **Domino Note** — why this ticket sits at this position ([domino checklist](references/domino-checklist.md))

Input = before, Output = after, both as code locations. Code-anchored Input/Output is what makes phase 5's scope check enforceable: "the functions this ticket's Output names" is matchable; "swap the detection source" is not.

Order by the domino checklist, top-down; the first discriminating rule decides. Each accepted Candidate Finding becomes a ticket here before anything touches it.

**Approval Gate (4 → 5).** Tickets end the plan; they don't start the build. Present the whole package to the human in one pass — one line per locked ADR, the full ticket list in domino order, the `QUALITY-CONTRACT.md` thresholds — then one AskUserQuestion: approve and enter phase 5, or revise. Until `STATUS.md` records `Plan approved: <date>`, phase stays 4 and the only permitted work is revising the plan. The per-axis clicks of phase 3 closed decisions; they are not approval of the plan as a whole. No ticket starts and `input-gate` passes nothing until this gate is passed.

## Phase 5 — Implement

1. Precondition: the Approval Gate has passed — `STATUS.md` shows `Plan approved: <date>`. If it doesn't, the work is at phase 4, not here. Then apply the [input gate](references/input-gate.md) to the frontier ticket. Stalled → park it in `STATUS.md`, offer a `wizard` for the human-only step, move to the next ticket. The block never waits.
2. **Scope check before the first edit**: the files this ticket names are the files you may edit. A defect found mid-implementation *outside* that scope is a Candidate Finding for the next ticket — not a detour. (Inside scope: fix it, it's why the ticket exists.)
3. Implement in the `implement` style (user-only command — inlined; run `/implement` for the full original): /tdd at pre-agreed seams, regular typechecks, full suite at the end.
4. In parallel: a background agent hunts edge cases against the *current* ticket; findings feed the *next* ticket's test cases, never the running one.
5. **Checkpoint** at each ticket's end: commit + tick the ticket's acceptance criteria + update `STATUS.md`. Scope ends at the Checkpoint: new findings after it wait for the next ticket, including "obvious" cleanups.

## Phase 6 — Review

The `code-review` skill (two axes, as-is), plus one added sub-agent: performance vs `QUALITY-CONTRACT.md` and edge-case/error-handling sweep. Unlabeled performance numbers found in code or docs count as findings.

Review is read-only. Every defect it finds — including one-line fixes — is reported as a finding with file:line and goes back through tickets. Review that repairs is review that grades its own homework.

## Phase 7 — Report

At a milestone or when a report is requested: the [report guide](references/report.md), Delivery form — end-to-end flow + per-module table (Task → Module → Interfaces → Tests → Architecture rules honored), plus the plain **Unverified claims** list. Update `STATUS.md`; if the block ends, write a handoff in the `handoff` style (user-only command — inlined; run `/handoff` for the full original).

## Vocabulary

The glossary lives in [references/context.md](references/context.md) — Work Block, Stalled Task, Input Gate, Checkpoint, Breadth-Plan, Deep-Plan, Domino Note, Quality Contract, Evidence Ladder, Candidate Finding, Decision Report, Delivery Report. Use these terms; don't rename them mid-flight.

## STATUS.md template

```md
# Status

Phase: <1-7 or in-flight note>
Active: <ticket or task>
Plan approved: <date> | — (phase 5 locked until the Approval Gate passes)

## Stalled
- <ticket> — missing <input> — unblocked by <human action>

## Open decisions
- <axis>: <what's unresolved>

## Candidate Findings
- <file:line> — <defect + evidence> — <proposed fix> — <triage: ticket / defer / reject>
```
