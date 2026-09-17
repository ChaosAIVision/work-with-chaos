# Plan and ticket templates

Adapt to the repository's conventions. The plan is canonical; `STATUS.md` links to it and records routing state. Keep one task overview, with details inline for a compact plan or linked tickets at `.scratch/<slug>/issues/NN-*.md` when that is the project's convention. Do not duplicate full task contracts in both places.

## Canonical plan

```md
# <Outcome>

Revision: r1
Request: plan only | plan and implement | revise plan | resume
Execution mode: flexible | ordered — <reason>
Approval: none | <revision, date, scope, user instruction>

## Outcome contract
Objective: <what becomes possible, in one sentence>
In scope: <boundaries>
Out of scope: <exclusions>
Constraints: <behavior and interfaces that must remain true>

| Requirement | Acceptance behavior | Responsible tasks | Completion evidence |
| --- | --- | --- | --- |
| R1 | <observable outcome, preserving qualifications> | T1 | <check and expected result; planned until executed> |

## Basis and decisions
- Observed: <file + function and current behavior, or source artifact>
- Accepted: <user requirement or decision, with provenance>
- Proposed default: <implementation assumption, rationale, affected tasks>
- Open/blocking: <unknown, affected work, owner, resolution action; or none>

## Work plan
| ID | Deliverable outcome | Requirements | Depends on / consumed output | Verification | State |
| --- | --- | --- | --- | --- | --- |
| T1 | <result, linked to detailed ticket if separate> | R1 | none | <discriminating proof> | pending |

Next action: <task + concrete action, or exact blocker>
Execution inputs: <only needed inputs, when needed, availability; or none>

## Review
Coverage, scope, anchors, dependencies, verification, readiness: <findings resolved or remaining>
Reviewer: <self-review or independent reviewer; never fabricate a review>

## Revision history
- r1: initial plan; verification not executed.
```

## Task contract

```md
# T1 — <one deliverable outcome>
State: pending
Requirements: <R IDs; clarify this task's portion of shared requirements>
Depends on: <T IDs and specific outputs consumed, or none>

Input:
- <observed file::function — behavior before; cite the supplied snapshot if that is the only source>

Output / allowed change surface:
- <file::function — behavior after; label additions proposed new>
- <test/doc files to add or update; label new ones>

Gate inputs:
- <external input, required stage, availability/check; or none beyond dependencies>

Verification / Quality gate:
- <fixture/precondition → action → expected result>
- <known command or artifact inspection; proposed if not observed>
- <applicable quality contract and performance evidence label; or no performance threshold applies>

Domino Note: <why here; actual dependency or ready-task tie-break>

Evidence: not run | <actual result, artifact location, relevant conditions>
Completion: pending | <met/unmet/unverified criteria, including blockers>
```

Use the user's language for the plan. Omit empty optional sections rather than inventing content. A plan-only response reports what was planned and unresolved, never that implementation checks passed.
