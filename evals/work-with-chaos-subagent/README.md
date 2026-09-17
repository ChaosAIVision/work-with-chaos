# Subagent workflow evaluations

Use fresh coordinator contexts and isolated output directories. Provide only the skill, the raw request, and its project artifacts. Do not provide this rubric, another run's output, or the intended verdict to workers. These checks assess task division and evidence, not a claimed speedup.

| Case | Setup | Inspectable acceptance |
| --- | --- | --- |
| [Parallel export](cases/parallel-export.md) | Copy [the fixture](fixtures/parallel-export/) into a temporary project, create its empty tests directory, and give a fresh coordinator the request with the approved plan/status/contract. Permit at most two active workers and subsequent read-only review; no network or publication. | Real worker dispatch for independent modules; exact file ownership and contract handoff; coordinator-controlled status/Git; no repeat approval request; actual unit and integrated behavior checks; unchanged contract; final verdict based on artifacts. |
| [Shared files plan](cases/shared-files-plan.md) | Give a fresh coordinator only the snapshot, the skill, and an output directory. Plan-only; at most one read-only reviewer during this bounded run. | Assign every outcome and shared file/resource an owner; use accepted interface contracts and real dependencies; handle generated-client ownership; avoid simultaneous unsafe access to the shared test DB; define integration responsibility. No source edits, invented running workers, production blocker, or claimed test success. |

For the execution case, inspect changes to query, CSV, and service modules and run the generated tests. Independently check permission before iteration, exact tenant/status filtering, more than one page, unchanged input order/data, UTF-8/escaping, string totals, and empty CSV. Confirm that worker submission is followed by coordinator verification and integration rather than treated as final acceptance by itself.

For the planning case, read the original request against the plan and each assignment. A role label such as “backend agent” without owned paths, consumed inputs, interface, expected evidence, and handoff is insufficient. Separate a real dependency from a preference about order. If isolation of a shared resource is unknown, the plan must resolve it or serialize affected use, not assume independence.

Review actual agent activity where available; a table of fictional agent IDs is not evidence of execution. Record limitations, including any unavailable tools or untested recovery behavior. [Results](results.md) document the bounded run for this revision.
