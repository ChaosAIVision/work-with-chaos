# Planning evaluations

These are bounded forward tests of the Markdown skill. Each agent receives the skill path and one raw user case, then writes a plan using only the supplied project snapshot. The agent does not receive this rubric, other runs, or an explanation of the intended improvement. No implementation, live service, or production access is needed.

## Cases and checks

| Case | Required observations |
| --- | --- |
| [CSV export](cases/csv-export.md) | Preserve all-filtered-row export, tenant/permission boundaries, CSV/UTC format, empty/error/retry behavior, existing filters, 20,000-row scope, exclusions, and documentation. Connect requirements to deliverable tasks and discriminating evidence. Keep observed anchors distinct from proposed additions. Do not block plan completion on production credentials, invent an SLA, claim tests ran, or implement. |
| [Ordered resume](cases/ordered-resume.md) | Keep T1's valid snapshot and stable IDs; reopen T2 because first-match mapping does not prove uniqueness; preserve the four-step order. Add ambiguous-ID exclusion/reporting and dry-run-without-writes verification. Do not guess a new eligible count, reset all progress, run sync, bypass a blocked step, or treat r1 approval as approval of r2. Name the exact next action and distinguish future access from planning readiness. |

Review each required clause as **met**, **unmet**, or **unverified**, with a concrete output excerpt or artifact reference. Evaluate user-visible completeness, truth of anchors, task coherence, dependency validity, verification quality, revision semantics, and readability. A keyword occurrence or task count alone is not a pass. Additional implementation choices should be labeled and stay within scope.

## Reproduction

1. Use an isolated output directory for each case and skill version. Read the skill and its relevant references without modifying them.
2. Give a fresh agent only the selected case, the skill path, the output directory, and the constraint to use the supplied snapshot. Tell it to perform planning directly if external integrations are unavailable and not to spawn further agents for this bounded test.
3. Inspect the resulting plan, status, and tickets against the original case and the checks above. Confirm no implementation files were created or modified.
4. Record limitations as well as differences. These cases can expose specific regressions; they cannot estimate a general success rate or prove that every plan will improve.

The pre-change comparison uses commit `e968298f01ee828ad92f3012a5408cef78218fb1`. Results of the 2026-09-17 run are recorded in [results.md](results.md).
