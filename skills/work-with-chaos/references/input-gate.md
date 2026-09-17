# Input Gate

A **Stalled Task** is a task waiting on a required external input, often something only a human can provide: access, a data export, or an environment. Discover the missing input before the affected work starts. Continue other eligible work only when the plan's dependencies and execution mode permit it.

## The gate

Runs at the top of every implement work block, before any code is written. Check the ticket's **Gate inputs**, not its code-anchored Input field. During planning, record later execution blockers without requiring those inputs to finish the plan. Verify only the environment and access actually needed for the current task.

| Check | How |
|---|---|
| Credentials | Required credential is available through the project's normal mechanism; do not print its value |
| Data | Input files/tables exist, non-empty, at the scale the ticket assumes |
| Environment | Target env reachable (DB ping, API health, deploy target answers) |
| Access | The account in play can actually perform the ticket's actions |
| Decisions | Required choices are settled in the plan, ADR, or applicable quality contract |
| Dependencies and mode | Required outputs exist; an ordered predecessor has not been skipped or blocked |
| Plan approval | `STATUS.md` records user approval covering the active revision and scope; an old approval does not automatically cover a changed contract |

Use a permitted read-only probe when reachability or access is needed, such as a local test DB connection. Do not perform a production write or contact a prohibited service to demonstrate readiness. If only supplied artifacts are authorized, inspect those and leave live access unverified.

## When a check fails

1. **Record Stalled** in the `Stalled` section of `STATUS.md`: stable ticket ID, missing input, affected work, and the action/owner that resolves it.
2. **Help resolve the input** — use an available `wizard` for a human-only procedure when useful; otherwise give the concrete action directly.
3. **Select permitted work** — in flexible mode, choose a dependency-ready ticket whose gate passes. In ordered mode, stop execution at the blocked step; do not leap to later steps. Continue allowed planning or an independent project if available, otherwise report the blocker without a polling loop.

## When the human clears the input

They say so (or the wizard script completes). Re-run just that ticket's gate, flip Stalled → ready, and it rejoins the frontier. No ceremony.
