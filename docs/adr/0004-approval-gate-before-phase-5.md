# ADR-0004: Phase 5 entry requires an approved plan — the Approval Gate

Date: 2026-08-24
Status: Accepted

## Context

A real session: phase 3 closed its open decision axes one AskUserQuestion at a
time, the ADRs were written, the tickets were filed and domino-ordered — and the
agent rolled straight into phase 5 and started implementing. The human
interrupted: the chosen direction and the full ticket list had never been shown
before the building started.

Post-mortem, the protocol itself was the cause — the session followed its letter:

1. **Per-axis clicks are not plan approval.** Phase 3's AskUserQuestion closes one
   axis at a time. Each click approves a single decision; nothing ever shows the
   human the whole package — direction + every ticket + order — as one thing to
   accept or reject. After the last click the agent reads "all decided" and its
   momentum says go.
2. **Phase 4 had no human touchpoint.** Tickets are written and ordered entirely
   AI-side. The moment the human would first see the full plan was never scheduled.
3. **The only gate before code checked externals, not consent.** `input-gate`
   verifies credentials, data, env, access, and that decisions have ADRs. "The
   human approved the plan" was not a row — a green gate said *ready*, never
   *agreed*.
4. **ADR-0003 fixed where edits may happen, not when phase 5 may begin.** Phase
   discipline says phase 5 is the only phase that may edit — so reaching phase 5
   became self-granted: write tickets, declare phase 5, code.

The protocol even *assumed* an approval it never defined as a step: "the human
approved a plan that no longer exists" (phase discipline, rule 1) — an approval
that exists in no phase.

## Decision

1. Between phase 4 and phase 5 there is a mandatory **Approval Gate**: the AI
   presents the complete package in one pass — one line per locked ADR, the full
   ticket list in domino order, the locked `QUALITY-CONTRACT.md` thresholds — and
   asks one AskUserQuestion: approve the plan and enter phase 5, or revise.
2. Until `STATUS.md` records `Plan approved: <date>`, phase stays 4 and the only
   permitted work is revising the plan. No ticket starts, `input-gate` does not
   pass any ticket, no source edit happens.
3. Per-axis clicks from phase 3 are decisions, **not** plan approval. The gate is a
   separate, explicit act — the human sees the whole and presses once.
4. `input-gate` gains a "Plan approval" row checking `STATUS.md`, so the gate is
   enforceable from both entry points: the phase transition and the per-ticket
   gate.
5. A human saying "just start" at the gate *is* approval — record it and proceed
   (same door-not-around-it rule as ADR-0003). What the gate blocks is the agent
   self-promoting to phase 5, not the human's choice.

## Consequences

- Phase 3 stays fast: clicks close axes without ceremony, because the package
  review happens once, later, in full view.
- Tickets get written knowing they may be revised — the gate is where the human
  reshapes scope while it is still cheap.
- One more stop per task. Accepted: the failure this replaces was not slowness but
  building for hours without anyone choosing to start.
- Mechanically enforceable later (hook: block `Edit`/`Write` on source while
  `STATUS.md` lacks `Plan approved:` — same shape as the ADR-0003 hook idea; this
  ADR is the semantic layer such a hook would enforce).
