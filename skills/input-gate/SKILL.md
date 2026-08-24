---
name: input-gate
description: Check a task has every human-only input it needs before work starts, so sessions never stall mid-implementation. Use before starting any implement work block, when a task seems about to block on credentials/data/env/access, or when another skill needs to declare a task stalled.
---

# Input Gate

A **Stalled Task** is a task waiting on something only a human can provide — a password, a data export, an environment URL, a permission grant. Stalls are the single largest time sink this skill set exists to kill. The gate's job: discover the stall *before* the work starts, park it, and move on — never sit waiting.

## The gate

Runs at the top of every implement work block, before any code is written. For each ticket about to start, check the **Input** field of the ticket against reality:

| Check | How |
|---|---|
| Credentials | Named secret exists in env/keychain/`.env` — and a dry call succeeds |
| Data | Input files/tables exist, non-empty, at the scale the ticket assumes |
| Environment | Target env reachable (DB ping, API health, deploy target answers) |
| Access | The account in play can actually perform the ticket's actions |
| Decisions | Every open decision the ticket depends on has an ADR or a locked contract behind it |
| Plan approval | `STATUS.md` shows `Plan approved: <date>` (the Approval Gate, ADR-0004) — per-axis phase-3 clicks don't count; no approval means the whole plan is still at phase 4 |

Verify by *doing*, not by assuming: a `SELECT 1` against the real DB, a `curl` to the real endpoint. A check that only confirms the file exists is half a check.

## When a check fails

1. **Declare the task Stalled** — one line in the repo's `BLOCKED.md` section of `STATUS.md`: ticket number, the exact missing input, the exact human action that unblocks it.
2. **Offer the wizard** — if the missing input is a human-only procedure (login, dashboard walkthrough, secret entry), generate one via the `wizard` skill so the human can clear it in one focused pass later.
3. **Move to the frontier** — pick the next ticket whose blockers are done and whose gate passes. The session keeps working. A parked task costs one line in a file; a waited-on task costs the whole block.

## When the human clears the input

They say so (or the wizard script completes). Re-run just that ticket's gate, flip Stalled → ready, and it rejoins the frontier. No ceremony.
