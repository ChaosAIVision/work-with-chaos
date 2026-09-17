---
name: work-with-chaos-subagent
description: Plan and coordinate work across subagents using clear task contracts, dependencies, exclusive write ownership, and integrated verification. Use when the user invokes work-with-chaos-subagent or wants work-with-chaos to delegate parallel work with an explicit division of responsibilities. Reuses the bundled work-with-chaos workflow; the coordinator owns the plan, approval, integration, and final acceptance.
---

# Work With Chaos Subagent

Use one coordinator to turn the user's objective into bounded assignments. Delegate useful independent work, then verify that the combined result meets the objective. A collection of successful worker summaries is not a completed project.

## Load the base workflow

The coordinator reads [work-with-chaos](../work-with-chaos/SKILL.md) and, for planning, its [planning guide](../work-with-chaos/references/planning.md). Install these two skill folders together. Reuse its phases, requirement IDs, code anchors, evidence rules, revision handling, and approval boundary; do not duplicate or independently evolve those rules here. If the base skill is missing, report the dependency and prepare the useful dispatch outline without inventing its contents.

This variant adds the scheduling and handoff rules below. In phase 5, the base workflow's singular **frontier ticket** becomes a set of approved, ready tickets with disjoint write ownership. Each worker is still restricted to its assigned ticket. The coordinator alone advances phases and accepts work. Workers receive the [assignment template](references/dispatch-template.md), not instructions to run the whole orchestrator again.

## 1. Establish the team and available capabilities

- Keep one coordinator responsible for the canonical plan, STATUS.md, user questions, dispatch, integration, and the final report. The coordinator may implement an explicitly reserved task while workers handle other scopes.
- Use the host's actual agent tools and concurrency limits. Select a small useful set of independent assignments; do not create an agent per file or fill slots merely because they exist. Keep capacity for coordination and review.
- Workers do not spawn further workers by default. Any deeper delegation requires a coordinator-approved split with new ownership boundaries and sufficient host capacity; it cannot enlarge the authorized scope.
- If agent execution is unavailable, state that plainly. Produce a usable assignment plan and continue sequentially where the user's authorization permits it; never label sequential work as parallel execution.

## 2. Make the plan dispatchable

Use one canonical plan from the base workflow and add the [team plan and assignment fields](references/dispatch-template.md). Preserve an overview the user can scan: outcome → owner → dependencies → write scope → proof. Keep detailed contracts in the linked tickets or inline, without maintaining competing plans.

Every assignment needs:

| Field | Required clarity |
| --- | --- |
| Outcome and requirements | One reviewable result, its R/T IDs, and the portion this worker owns |
| Inputs | Observed anchors, exact source artifacts or accepted upstream results, and their revision; label proposed additions |
| Dependencies | The artifact/decision consumed and the acceptance condition that makes it available |
| Ownership | One writer for each allowed file/path and mutable shared resource; separate read access from write access |
| Interface contract | Exact names, shapes/types, error behavior, invariants, and fixture/example at the boundary when needed; cite the accepted contract version |
| Verification | Fixture/action/expected result, the checks the worker runs, and the integration proof reserved for the coordinator |
| Handoff | Where changes/results will be returned, their provenance, blockers, and the next consumer |

Resolve interface disagreements in planning before dispatching producers and consumers together. For example, API and UI can work in parallel against an accepted response/error contract and matching fixtures, with a later integration check. A real data export or migration output cannot be replaced by an assumption just to start its consumer early.

Inspect the change surfaces, not just task titles. Shared source files, schema/migration files, lockfiles, generated outputs, test databases, ports, and canonical planning files need a named owner or isolated resources. If two proposed workers require the same write scope, split ownership, assign the common change to the coordinator, or serialize those tasks. Separate worktrees isolate edits but do not resolve incompatible contracts or shared databases.

Before presenting the plan, check requirement coverage, dependency cycles, interface compatibility, write/resource overlap, and final integration ownership. For substantive plans, use a read-only reviewer when available; reconcile its findings before the approval gate. A reviewer may inspect the whole plan but cannot edit source or silently change scope.

## 3. Dispatch according to readiness

The base phases still control permissions:

| Phase | Delegated work |
| --- | --- |
| 1–4 | Bounded research, plan drafting, and review; return findings or assigned planning artifacts. No implementation edits. A plan-only request ends with the reviewed team plan. |
| 5 | Implement only after approval covers the revision/scope and required Gate inputs are available. Give each worker its authorized write scope. |
| 6–7 | Read-only review/reporting; required fixes return to scoped phase-5 tickets. |

For **flexible** execution, select the ready set: dependencies accepted, inputs available, scope approved, interfaces settled, and no active ownership conflict. Dispatch independent tasks together. Do not wait for an entire batch when one accepted output already makes another task eligible.

For **ordered** execution, preserve the user's step sequence. Do not start a later step while an earlier step is incomplete or blocked. Parallel subtasks within the current step are allowed only if they respect that sequence and have independent scopes; read-only planning is not execution of a later step.

Send each worker a self-contained assignment using the template. Include the relevant user constraints and explicit authorization; do not rely on inherited conversation memory. Specify the shared workspace or isolated worktree, the input revision, allowed tools/actions, exclusions, expected output, and verification. An assignment lacking an essential decision is not ready to implement.

Record task-to-agent IDs, plan revision, write/resource ownership, dispatch state, and next action in a compact dispatch section of STATUS.md. The coordinator is its sole writer. Progress reports should say what is accepted, running, or blocked and why; do not repeatedly ask the user whether to continue approved work.

## 4. Work without collisions or duplicated effort

- In a shared checkout, workers edit only their owned files. They do not stage, commit, switch/reset branches, merge, push, or modify the canonical plan/status. The coordinator owns the shared Git index and publication. In isolated worktrees, allow local commits only when the assignment explicitly calls for them; external publication remains with the coordinator.
- The coordinator does useful unassigned work, resolves blockers, or integrates submitted results while workers run. Do not implement the same ticket in parallel with its owner.
- Workers report missing inputs, interface mismatches, or out-of-scope findings with evidence. They do not expand their allowlist, change a shared contract, or repair another worker's output without reassignment. A failing acceptance criterion inside their own contract still belongs to them.
- A blocked or failed worker does not release dependents. Diagnose the cause before retrying; reassign or revise the bounded task when that resolves it. Do not repeatedly relaunch an unchanged failing assignment.
- Before transferring write ownership, stop or obtain a handoff from the previous worker and preserve its partial changes. Never let a stale worker and its replacement write the same scope concurrently. Do not revert unrelated user or worker edits.

## 5. Accept and integrate evidence

Workers return **submitted**, **blocked**, or **failed** with changed paths, input/contract revision, actual checks/results, evidence locations, remaining uncertainty, and out-of-scope findings. Proposed checks and worker confidence are not verification results.

On submission, the coordinator inspects the actual diff/artifacts, scope, interface compliance, and evidence. Run the relevant acceptance checks; reject or repair through a scoped assignment if the contract is unmet. Only then accept the output and release its consumers. Record the artifact/commit/snapshot accepted so a consumer does not use an obsolete result.

Integrate in dependency order. Verify the combined workspace after the relevant changes are present: imports/signatures, shared interfaces, generated files, and the requested end-to-end/error behavior. Worker tests against mocks or isolated branches do not substitute for these integration checks. Tests affected by concurrent edits must be confirmed against the integrated state. Mark a task done only after its required acceptance and integration evidence is available; submitted work can remain unverified.

Use a read-only reviewer for the integrated result when available. Compare the original requirements to actual artifacts, not merely to the worker reports. The coordinator owns the final requirement verdicts and remaining limitations.

## 6. Revise or resume without stale assignments

When requirements, interfaces, or ownership change, increment the plan revision and identify affected assignments. Pause affected workers at a safe boundary; tell them which contract is superseded. Reuse unaffected progress and evidence. Record whether existing authorization covers the change, as in the base workflow.

On resume, reconcile actual worker liveness, changed files, and submitted artifacts with the dispatch record before spawning replacements. A worker completing an old contract cannot mark the new contract done. Inspect its useful output, revalidate affected criteria, and give a new assignment only after the old writer has stopped or handed off.

Finish with the delivered outcome, requirement evidence, integrated changes, remaining blockers, and next action. Do not claim a speedup unless elapsed-time evidence supports it.
