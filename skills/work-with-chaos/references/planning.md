# Planning: requirements to executable outcomes

Read this for a new plan, an ambiguous task list, or a revision. Preserve the user's requirements; improve how the work is divided and verified. Use [plan-template.md](plan-template.md) as a shape, not a demand for filler.

## 1. Establish the outcome contract

Read the request, existing plan/status, accepted decisions, and relevant code. State:

- **Objective:** one sentence describing what becomes possible for the user.
- **Requirements:** stable `R1`, `R2`, … IDs with observable acceptance behavior. Keep qualifications such as “all filtered rows,” permission rules, exclusions, and failure behavior. Do not replace them with “works correctly.”
- **Boundaries:** in scope, out of scope, and constraints the implementation must preserve.
- **Evidence:** what would demonstrate the objective, including failure and integration paths where required.
- **Unknowns:** separate repository facts to inspect, proposed reversible defaults, and decisions only the user can make. Give each material unknown an owner, the work it blocks, and a way to resolve it.

Do not ask the user what code can answer. Do not reopen an accepted choice without conflicting evidence. State a reasonable implementation default when it is within the authorized scope; label it as proposed rather than turning it into a new requirement. Ask only for decisions that materially affect the deliverable. An execution credential is not automatically a planning blocker.

For a missing technical fact, perform bounded read-only research. If it cannot be resolved now, give the affected task a conditional contract and mark it not ready. Do not hide the uncertainty inside “investigate and implement.” If investigation itself is substantial work, its outcome must be a specific answered question, evidence, and the decision it unlocks.

## 2. Divide by deliverable outcome

Work backward from acceptance behavior to the smallest useful changes a reviewer can verify. Prefer a first usable end-to-end slice, followed by additional behavior and hardening that have their own acceptance criteria. A single coherent task is valid; do not target an arbitrary task count.

A task should have one clear outcome and a coherent change surface. Merge tasks that merely split the same behavior by file without providing a separately verifiable result. Split an umbrella task if its parts have independent outcomes, materially different blockers, or different verification. Tests for a behavior belong to its task; reserve a separate integration task for evidence that truly needs several outputs together.

Do not force a UI into a server-only request to manufacture a vertical slice. A foundation task is justified only by a concrete output consumed by named later tasks. Do not add a framework, schema, abstraction, performance target, or deployment step merely because a template has room for it.

| Ambiguous | Executable |
| --- | --- |
| Implement backend | An authorized caller can download the filtered dataset; existing list pagination is preserved |
| Add tests | An unauthorized caller receives 403 and no data; the responsible feature ticket includes this check |
| Improve performance | Meet the already agreed latency threshold under its named workload; otherwise performance remains a proposal |
| Research integration | Confirm the provider's pagination and retry contract with cited docs or a permitted read-only probe; record which adapter decision the result settles |

Use stable `T1`, `T2`, … IDs independently of execution order. Each task links to the requirements it contributes to. A requirement spanning tasks needs explicit ownership of each part and the combined verification; listing `R1–R9` on every task is not coverage.

## 3. Make dependencies and mode explicit

- **Flexible:** the default when the user gives no hard sequence. Start any task whose dependencies are satisfied, gate inputs are available, and scope is approved.
- **Ordered:** preserve an explicit user sequence or a verified hard ordering constraint. A blocked step prevents later steps from starting. Do not insert unrequested prerequisite steps or switch modes to avoid a blocker.

A dependency is an output another task must consume, not “these files are nearby.” Write `T2 depends on T1: consumes <artifact/contract>`. Validate every referenced ID, reject self-dependencies and cycles, and ensure at least one task is initially ready or explain the external blocker. Distinguish dependencies from optional scheduling preferences. Use the [domino checklist](domino-checklist.md) only to choose between eligible tasks.

Use parallel work only when both the dependency graph and the change surfaces permit it. Shared files require an explicit coordination plan or sequential work; do not claim independence because two task titles differ.

## 4. Give every task an executable contract

Use the ticket template. Keep these distinctions:

- **Input:** observed file/function anchors and current behavior. For a new file, say **proposed new**, with the observed integration point. If repository access is unavailable, call the anchor unverified and state what must be inspected.
- **Output:** changed/new/deleted anchors, behavior after the change, and allowed files, including tests and documentation. Name a proposed signature only when it helps constrain the interface; do not pretend it already exists.
- **Gate inputs:** the external data, access, environment, or decision actually needed for this task. State when it is needed. Do not demand production credentials for local fixtures or a planning deliverable.
- **Verification:** precondition or fixture → action → expected observable result. Use a known repository command when available and explain what it must demonstrate. Label proposed commands and new test names as proposed, never as inspected facts.
- **Quality gate:** applicable accepted thresholds and evidence labels. If no performance contract applies, say so; functional acceptance still applies.
- **Domino Note:** why this task is eligible at this point, with its real dependency or tie-break rule.

“Tests pass,” “review complete,” “secure,” and “no regressions” are insufficient alone. Name the relevant behavior and distinguishing fixture. A verification plan has no actual result yet. Retain evidence only after the check runs, with enough environment/fixture information to interpret it. For a document task, inspect its required contents and consistency rather than inventing a code test.

## 5. Review before presenting

Review against the original request and observed repository facts, not just against your own task titles. An independent read-only reviewer should report defects, not rewrite requirements. If unavailable, perform a second pass yourself and label it accurately.

- **Coverage:** every required clause and constraint appears in the requirement table, has responsible tasks, and has evidence that could reveal failure. No accidental additions or omitted edge cases.
- **Coherence:** each task produces a reviewable result; no duplicate ownership, phase headings masquerading as work, or unjustified infrastructure.
- **Truth:** anchors are observed or explicitly proposed; assumptions and missing inputs are visible. No invented test results, measurements, or approval.
- **Order:** dependency IDs exist, the graph is acyclic, ordered steps match the user's sequence, and any parallelism is viable.
- **Verification:** evidence establishes the behavior, including required error paths. Integration evidence covers requirements that span tasks.
- **Readiness:** the next action names a task and concrete action; a blocker names the missing input and who can resolve it. Separate planning completion from execution readiness.
- **Readability:** the overview shows objective, scope, task outcomes, dependencies, proof, and open decisions without requiring a tour through many files. Detailed tickets expand that overview rather than contradict it.

Fix defects before requesting approval. Present the complete task list and material uncertainties in one pass. Keep settled research and routine decisions short. Do not provide multiple competing plans unless the user actually needs to choose between unresolved approaches.

## 6. Revise without losing state

When the user changes requirements or a finding invalidates the plan:

1. Read the active revision, task states, and evidence. Record the requirement delta in a short changelog; preserve unchanged IDs.
2. Map the delta to affected tasks and dependent verification. Keep unrelated completed tasks and their evidence. Add new IDs only for genuinely new work; do not regenerate or renumber the task list.
3. Reopen a completed task if its output no longer satisfies the changed contract. Historical evidence stays recorded but does not prove the new criterion. Revalidate affected downstream results; leave unrelated results intact.
4. Publish a new revision with updated coverage, task states, and exact next action. Do not guess new counts or outcomes that require rerunning checks.
5. Record whether existing user authorization explicitly covers the changed scope. Do not carry an old approval date forward as approval of new requirements. If the user requested only a plan revision, finish that revision without requesting execution access or approval.

Task states: `pending`, `ready`, `in_progress`, `done`, `stalled`, or `skipped` (with reason). Reopened tasks return to `pending` or `ready` with the cause recorded. A skipped task's requirements must be reassigned or explicitly removed by the user; task completion percentages cannot waive them.

## 7. Judge completion against the objective

At each Checkpoint, check the ticket contract before marking it done. At final review, evaluate each requirement against actual outputs and evidence, independently of task status. Report `met`, `unmet`, or `unverified` and the evidence location. A green build, all tasks marked done, or a persuasive summary is not enough. Required unverified behavior means the objective is not yet proven complete.
