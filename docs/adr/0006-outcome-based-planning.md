# ADR-0006: Plans connect requirements, task outcomes, and evidence

Date: 2026-09-17
Status: Accepted

## Context

The user found the existing requirements useful but the resulting plans ambiguous. The workflow specified phases, source-edit restrictions, and ticket Input/Output fields more precisely than it specified how to divide requirements into work. A phase list could substitute for a deliverable plan, domino heuristics could obscure dependencies, and an approval date did not identify the approved revision.

Research into [tmonk/pi-goal-x](../research/2026-09-17-work-with-chaos-planning.md) informed the separation of an outcome contract, persistent tasks, execution mode, and final evidence review. This is an adaptation for a portable Markdown skill, not an integration with the Pi runtime.

## Decision

1. Maintain one canonical plan: objective, stable requirement IDs, scope boundaries, observed facts, decisions, task outcomes, dependencies, verification, and revision history. STATUS.md is its routing index, not a duplicate plan.
2. Divide work into coherent deliverable outcomes. Each task has stable IDs, requirement ownership, code-anchored Input/Output, Gate inputs, and observable verification. Phases are workflow controls, not task titles. No fixed task count or compulsory framework-building stage.
3. Distinguish flexible dependency-driven execution from ordered execution. Validate dependencies before applying domino tie-breaks. A blocked ordered step cannot be bypassed.
4. Review requirement coverage, scope, anchor truth, dependencies, and discriminating evidence before presenting the plan. Final review evaluates the original objective against actual artifacts; task completion alone is insufficient.
5. Revise in place: preserve unchanged task IDs and evidence, reopen changed acceptance contracts, and identify affected downstream verification. Approval records name the revision and scope. Historical approval and evidence are retained but never silently applied to a changed contract.
6. Preserve the full phase protocol, source-edit discipline, approval boundary, and performance evidence ladder. Settled phases may cite existing evidence concisely. Functional work does not acquire invented performance targets or compulsory external integrations.
7. A plan-only request ends with a reviewed phase-4 plan. Execution credentials and execution approval are not prerequisites for completing that request. Existing explicit approval remains valid for the scope it actually covers.

## Relationship to earlier decisions

ADR-0001 and ADR-0003 remain in force. This refines ADR-0004's approval record and presentation without removing the implementation gate. It replaces the unconditional “move to the next ticket” rule with mode-aware readiness and replaces an unconditional new Quality Contract with applicable accepted thresholds.

## Consequences

Plans require explicit traceability and evidence, but no longer need a separate ceremony for each settled axis. More state is recorded at revision time so resuming work does not discard valid progress or treat old checks as proof of new requirements. The bundled planning guide and template carry details while the entrypoint stays focused on routing.
