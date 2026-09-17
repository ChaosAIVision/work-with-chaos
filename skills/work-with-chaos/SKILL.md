---
name: work-with-chaos
description: Plan, execute, and resume work through an explicit workflow. Turns requirements into outcome-based tasks with code anchors, dependencies, and verifiable completion criteria; routes phases through STATUS.md, requires plan approval before implementation, and labels performance evidence. Use when starting or resuming work, creating or revising a project plan, planning a day across projects, or resolving an ambiguous task list.
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
5. **If you already edited in the wrong phase: revert your edit, then record.** Undo only your out-of-phase changes, preserving unrelated user work. Put the Candidate Finding where it belongs and say so in `STATUS.md`.
6. **When the human says fix it now, that's a phase change.** Update `STATUS.md` to phase 5 with that ticket first. One line, then implement. The protocol doesn't block the human — it blocks *drift*.

## Internal guides

The following procedures are bundled references inside this skill. Read the relevant guide directly at its phase; do not invoke a separate benchmark, decide, input-gate, or report skill.

| Phase or need | Read |
| --- | --- |
| Create, review, or revise a plan | [Planning](references/planning.md) and [plan / ticket templates](references/plan-template.md) |
| Compare options or substantiate performance | [Benchmark](references/benchmark.md) |
| Close open decisions and lock the contract | [Decide](references/decide.md) |
| Verify inputs before implementation | [Input gate](references/input-gate.md) |
| Write a Decision Report or Delivery Report | [Report](references/report.md) |
| Order tickets | [Domino checklist](references/domino-checklist.md) |
| Seed quality thresholds | [Quality contract template](references/quality-contract-template.md) |
| Resolve workflow vocabulary | [Context](references/context.md) |

Resolve these paths relative to this SKILL.md. The repository also contains the independent diagnose-linux-disk skill; its diagnostic workflow does not inherit this orchestration pipeline.

## External skill wiring

Use installed, model-invocable `research`, `grilling`, `domain-modeling`, `code-review`, `tdd`, and `wizard` skills when available. Inspect their actual availability and invocation rules; do not assume a tool or skill exists. Names such as `to-tickets`, `implement`, and `handoff` are attribution for the behavior inlined below, not permission to invoke a user-only command. If an integration is absent, follow this skill's bundled procedure directly. If agents are unavailable, perform the relevant checks yourself and do not call that an independent review.

## Phase 0 — Orient (every session start)

1. Read the target repo's `STATUS.md` (create it if absent — template below), its linked plan, active ticket, and recorded evidence. Re-read the objective and requirements after a handoff or context compaction, not just the last checkbox.
2. Resume the recorded phase under Phase Discipline. Phase 5 requires approval covering the active plan revision and scope; a date alone is not sufficient if the requirements changed. For an older plan, reconcile its recorded approval with the unchanged scope instead of discarding valid consent. If the session starts clean → Phase 1.
3. User steering updates the existing plan through the revision procedure in [planning](references/planning.md). Keep stable task IDs and valid completed work; revalidate changed acceptance criteria.

`STATUS.md` is the routing index; the linked plan owns requirements, task order, and acceptance criteria. Do not maintain a second competing plan in status or chat. Recover state from artifacts before asking the human. A user correction overrides stale status; record it before acting.

## Phase 1 — Plan

Two layers, per the ADR on planning:

- **Breadth-Plan** (one session, all projects): thin plans, just deep enough to order the Work Blocks and surface which projects lack inputs. Output: the day's block order + the first Stalled list (feed to the [input gate](references/input-gate.md)).
- **Deep-Plan** (per project, in the block before that project's implement block): full pipeline below for that project's task.

For every Deep-Plan, read [planning](references/planning.md) and use the [templates](references/plan-template.md). Create one canonical plan using the project's existing convention, otherwise `.scratch/<slug>/PLAN.md`. Start with the objective, stable requirement IDs, scope boundaries, observed code, and genuine unknowns. Distinguish user requirements, facts, accepted decisions, and proposed assumptions.

The phases describe how to work; they are **not the task list**. Plan deliverable outcomes, not "research → backend → frontend → test" headings. Include a first useful end-to-end slice, explicit dependencies, and observable completion evidence. Phases still apply to every task, but a settled phase can cite existing evidence in one line; do not manufacture questions, tickets, or documents to fill the process.

If the request is **plan only**, the deliverable is a reviewed plan through phase 4. Do not implement, require production access to finish planning, or ask for execution approval unless the user wants to proceed.

## Phase 2 — Research

Research the uncertainties that can change scope, task boundaries, order, or verification. When both investigations are needed and agents are available, run them in parallel:

- **Inside agent** — scans the existing codebase: current patterns, dependencies, constraints, prior art.
- **Outside agent** — the `research` skill: primary sources only.

Read [benchmark](references/benchmark.md) for comparisons and performance claims. Record sources, observed file/function anchors, trade-offs, open choices, and **Candidate Findings** in a **Decision Report** ([report guide](references/report.md), Decision form). Link substantial research from the plan; a short settled finding can live in the plan itself. Resolve repository facts by inspection before asking the user. Do not invent an existing API or function; mark additions as **proposed new**.

## Phase 3 — Decide

Two instruments, in order:

1. **Grill genuinely open decisions** using the [decide guide](references/decide.md)'s six-axis sweep. Preserve settled requirements. Ask only when the answer materially changes scope, architecture, acceptance, or a required user choice; do not turn each axis into a compulsory question. Recommend a supported default and explain its trade-off.
2. **Lock the outcome contract** in the plan: objective, requirement coverage, boundaries, verification, and unresolved blockers. Record consequential decisions in `docs/adr/`; keep routine decisions in the plan. Preserve an existing `QUALITY-CONTRACT.md`; add supported thresholds only where applicable, without inventing a performance SLA. Triage Candidate Findings: include in phase 5, defer, or reject.

## Phase 4 — Tickets

Compile the plan into tickets using [planning](references/planning.md) and the [ticket template](references/plan-template.md). Keep the existing local-file convention, otherwise `.scratch/<slug>/issues/NN-*.md`. Every ticket has a stable ID, an outcome title, requirement IDs, dependencies (including the output consumed), and these fields:

- **Input** — a **code anchor**: `file` + `function/class` this ticket starts from, and its current behavior in one line — the logic being changed, where it lives *today*. Not "what must exist" in the abstract; that's the pipeline's job. A ticket starts from code, or from the empty file it will create.
- **Output** — the same anchors *after* the change: which functions/files are added, modified, or deleted — new signature + one line of new behavior. The code is the artifact; name it. Bad: "swap detection source to ABBOTT API". Good: "`_check_ra_shop()` (`scripts/run_batch_async.py`) → GET `{ABBOTT_API_BASE}/api/ai-qc/intraday/records?callId=`; `_ra_shop_api_target` + 3rd-party path deleted."
- **Gate inputs** — the checkable externals `input-gate` verifies before phase 5 (credentials, data, env, access, a verified API, an accepted ADR). Lives here — never mixed into Input/Output.
- **Verification / Quality gate** — observable pass/fail behavior, fixtures or inspection method, and the evidence to retain. Cite applicable contract thresholds and performance evidence labels. Planned checks are not passed checks.
- **Domino Note** — why this ticket sits at this position ([domino checklist](references/domino-checklist.md))

Input = before, Output = after, both as code locations. Code-anchored Input/Output is what makes phase 5's scope check enforceable: "the functions this ticket's Output names" is matchable; "swap the detection source" is not.

Choose **flexible** execution (follow actual dependencies) or **ordered** execution (preserve the user's required sequence). Validate dependency IDs and cycles first; use the [domino checklist](references/domino-checklist.md) only among ready tasks. Each accepted Candidate Finding joins a scoped ticket before anything touches it.

Before presenting the plan, run the review checklist in [planning](references/planning.md). Ensure every requirement has an owner and discriminating verification, every dependency names a real prerequisite, and the next action is executable. Where available, have a read-only reviewer inspect the plan against the original request and repository evidence. Repair planning defects before approval.

**Approval Gate (4 → 5).** Present one coherent package: objective and boundaries, outcome/task table in execution order, settled decisions, applicable quality thresholds, and remaining blockers. Record approval as `<revision>, <date>, <scope>, <user instruction>`. Existing explicit authorization covering that package remains valid; never ask again merely because a session resumed. Per-axis choices are not automatically whole-plan approval. If execution is requested but approval is missing, ask once after the concrete plan is reviewable, using the host's supported approval channel. For a plan-only request, deliver the plan and leave phase 4; execution approval is not needed to finish that request.

## Phase 5 — Implement

1. Confirm approval covers the active revision and ticket. Apply the [input gate](references/input-gate.md) to its **Gate inputs**. In flexible mode, a stalled task permits other dependency-ready work. In ordered mode, do not jump over a blocked step; report its exact missing input and continue only permitted planning or another independent project.
2. **Scope check before the first edit**: edit only the ticket's allowed files to meet its approved outcome. A defect outside that outcome becomes a Candidate Finding even when it is in the same file. Fix failures of the current acceptance contract before completing the ticket.
3. Implement in the `implement` style (user-only command — inlined; run `/implement` for the full original): /tdd at pre-agreed seams, regular typechecks, full suite at the end.
4. Where useful, a background agent checks edge cases against the current ticket. A failing acceptance criterion blocks that ticket's completion; an out-of-scope improvement becomes a Candidate Finding for a later ticket.
5. **Checkpoint**: inspect the output and retain actual verification results before marking the ticket done; commit authorized changes and update `STATUS.md` with the next action. A blocked test leaves its criterion unverified. Skipping a ticket never silently waives its requirements. New scope after the Checkpoint goes through plan revision.

## Phase 6 — Review

Review code and the original outcome contract, using an independent read-only reviewer when available. Check each requirement against inspectable artifacts and results, including integration and error paths. A completed task list, green build, or executor summary alone does not establish that the objective was met. Include performance vs applicable `QUALITY-CONTRACT.md` thresholds; unlabeled performance numbers are findings.

Review is read-only. Every defect it finds — including one-line fixes — is reported as a finding with file:line and goes back through tickets. Review that repairs is review that grades its own homework.

## Phase 7 — Report

At a milestone or when a report is requested: the [report guide](references/report.md), Delivery form — requirement-to-evidence verdicts, end-to-end flow, per-module table, and **Unverified claims**. Distinguish done, partial, and blocked outcomes. Update `STATUS.md` with the plan revision, active ticket, remaining blockers, and exact next action for a handoff.

## Vocabulary

The glossary lives in [references/context.md](references/context.md) — Work Block, Stalled Task, Input Gate, Checkpoint, Breadth-Plan, Deep-Plan, Domino Note, Quality Contract, Evidence Ladder, Candidate Finding, Decision Report, Delivery Report. Use these terms; don't rename them mid-flight.

## STATUS.md template

```md
# Status

Phase: <1-7 or in-flight note>
Plan: <canonical path>, <revision>
Mode: flexible | ordered
Active: <stable ticket ID, or planning>
Next action: <one concrete action, or exact blocker>
Plan approved: <revision; date; scope; user instruction> | none

## Stalled
- <ticket> — missing <input> — unblocked by <human action>

## Open decisions
- <axis>: <what's unresolved>

## Candidate Findings
- <file:line> — <defect + evidence> — <proposed fix> — <triage: ticket / defer / reject>
```
