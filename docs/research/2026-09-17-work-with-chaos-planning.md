# Planning changes informed by pi-goal-x

Reviewed: 2026-09-17. Reference: [tmonk/pi-goal-x](https://github.com/tmonk/pi-goal-x), pinned to commit `5a7c4cd5b3d3bfb07a33f1babdaed8eedc4b9987`. Target baseline: `e968298f01ee828ad92f3012a5408cef78218fb1`.

## Observed mechanisms

| Upstream mechanism | Source | Application here |
| --- | --- | --- |
| Goal proposal separates objective, success criteria, boundaries, optional verification contract, and blocker rules; tasks appear in the same proposal | [goal-draft.ts](https://github.com/tmonk/pi-goal-x/blob/5a7c4cd5b3d3bfb07a33f1babdaed8eedc4b9987/extensions/goal-draft.ts) | Present a coherent outcome contract and work plan; do not make users approve disconnected fragments |
| Flexible goals and ordered Sisyphus steps have different execution rules; user ordering must be preserved | [goal-prompts.ts](https://github.com/tmonk/pi-goal-x/blob/5a7c4cd5b3d3bfb07a33f1babdaed8eedc4b9987/extensions/prompts/goal-prompts.ts) | Explicit flexible/ordered mode; blocked ordered steps cannot be bypassed |
| Task tools validate IDs and task structure; completion can require evidence; skipping requires a reason | [goal-task-tools.ts](https://github.com/tmonk/pi-goal-x/blob/5a7c4cd5b3d3bfb07a33f1babdaed8eedc4b9987/extensions/goal-task-tools.ts) | Stable ticket IDs, concrete verification, and explicit reasons for skipped work |
| Revision merges retain state and evidence for matching task IDs | [goal-drafting.ts](https://github.com/tmonk/pi-goal-x/blob/5a7c4cd5b3d3bfb07a33f1babdaed8eedc4b9987/extensions/goal-drafting.ts) | Revise the existing plan without resetting unaffected progress |
| A read-only completion auditor examines the objective and actual outputs; executor claims and completed task lists are not sufficient | [goal-auditor.ts](https://github.com/tmonk/pi-goal-x/blob/5a7c4cd5b3d3bfb07a33f1babdaed8eedc4b9987/extensions/goal-auditor.ts) | Requirement-to-evidence verdicts in review and reporting |

## Design choices made for this skill

These are adaptations, not claims that upstream implements this exact workflow:

- Retain Chaos's phase discipline, code-anchored tickets, explicit execution approval, and performance evidence ladder.
- Add requirement IDs, consumed-output dependencies, a coverage table, and a plan review checklist to make ambiguity visible before implementation.
- Prefer useful end-to-end outcomes over a list of workflow phases or one ticket per file.
- Bind approval to revision and scope. Reopen completed tasks when their acceptance criteria change, even if their IDs remain the same. Preserving historical evidence must not imply that a changed contract already passed.
- Keep a plan-only request complete without obtaining implementation credentials or asking to execute.
- Use available skills and agents honestly; portable instructions must not pretend Pi tools or runtime hooks exist in the host.

We did not import Pi tool names, its runtime continuation loops, task-count limits, or Sisyphus product mechanics. Some experiment rubrics describe older direct-creation flows that differ from the inspected drafting code; current source, rather than those rubrics, informed this change. No upstream implementation code was copied.

## Validation

See [planning evaluations](../../evals/work-with-chaos/README.md) for bounded before/after cases and observed results. They check instruction-following in two scenarios; they do not establish a general performance improvement or a numerical success rate.
