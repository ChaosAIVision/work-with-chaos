# Team plan and worker handoff

Extend the base plan rather than creating a second source of truth. Fill only applicable fields, but do not dispatch implementation with unresolved ownership, input, interface, or acceptance conditions. Use the user's language for the overview.

## Team plan section

```md
## Delegation
Coordinator: <identity; owns canonical plan/status, integration, acceptance>
Plan revision / approval: <revision and existing authorization scope>
Execution mode: flexible | ordered — <reason>
Workspace: shared checkout | isolated worktrees — <delivery mechanism>
Available concurrency: <observed host limit or conservative supported cap>

| Task / requirement IDs | Deliverable | Owner | Depends on / accepted input | Write scope and shared resources | Proof / next consumer |
| --- | --- | --- | --- | --- | --- |
| T1 / R1 | <observable result> | <agent or coordinator> | <artifact + acceptance condition, or none> | <explicit files; DB/output/port claims if applicable> | <check + expected result; consumer> |

Shared contract: <canonical path/section, version, agreed interface and fixture>
Shared-file owner: <who updates common schema/lockfile/config, if relevant>
Initial ready set: <T IDs and why their inputs and ownership are ready>
Later releases: <accepted result that unlocks each next task>
Integration owner and checks: <coordinator's combined-result verification>
Open blockers: <missing decision/input, affected assignments, resolution owner>
```

Use ownership labels during planning; actual runtime agent IDs are recorded only after spawning. Do not invent a running team in a plan-only response.

## Worker assignment

```md
You own <T ID> under plan <path, revision>. Return one bounded result.

Objective and requirements: <outcome + R IDs + exact acceptance clauses>
Phase and authorization: <read-only research/review, or approved implementation scope>
Workspace / input version: <absolute working directory, base commit or observed snapshot>
Inputs to read: <specific code anchors, artifacts, accepted upstream outputs>
Contract: <versioned interface, input/output examples, error behavior, invariants>
Allowed writes: <explicit paths, or no source writes; assigned report path if needed>
Resource ownership: <exclusive/isolated DB, output, port, or none>
Exclusions: <shared files, canonical plan/status, other tickets, external actions>
Verification: <fixture → action → expected result; commands if established>
Integration checks reserved for coordinator: <cross-task behavior>
Return via: <message + artifact path, or isolated commit/patch if explicitly assigned>

Stay within this contract. Report missing inputs or interface conflicts before
affected edits. Record out-of-scope findings instead of fixing them. Do not
spawn agents, publish, edit the canonical plan/status, or perform shared Git
operations. Preserve other workers' and user changes. Do not ask the user to
reapprove already authorized work; send blockers to the coordinator.
```

For a read-only research assignment, the outcome is a specific answered question with cited evidence; include allowed sources and a private output path. For a reviewer, provide the original request, plan/contract, actual artifacts, and a read-only boundary. Do not give an expected verdict.

## Worker result

```md
Task: <T ID>
Plan / input / contract revision: <what was actually used>
State: submitted | blocked | failed
Result: <observable outcome or exact obstacle>
Changed paths / artifact locations: <list; explicit none if read-only>
Checks run: <command/inspection, actual result, relevant fixture/environment>
Unverified criteria: <remaining criteria, or none>
Findings outside scope: <anchor + evidence, or none>
Handoff: <accepted-input assumptions, coordinator action needed>
```

The worker's result does not change the task to done. The coordinator verifies it and records the accepted artifact/version before releasing dependent work.

## Compact dispatch record in STATUS.md

```md
## Dispatch — plan <revision>
| Task | Agent ID | Input/contract version | Write/resource claim | Delivery state | Accepted artifact / blocker |
| --- | --- | --- | --- | --- | --- |
| T1 | <actual ID> | <version> | <scope or ticket link> | running/submitted/accepted/blocked/failed/stopped | <evidence or missing input> |

Next coordinator action: <review a submitted result, integrate, resolve blocker, or dispatch a newly ready task>
```

Keep task definitions in the plan; status holds routing and live assignments. Preserve superseded assignments as history when they explain evidence or ownership transitions.
