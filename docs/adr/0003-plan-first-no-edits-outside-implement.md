# ADR-0003: Plan first — no code edits outside phase 5

Date: 2026-08-24
Status: Accepted

## Context

A real session: during research/verification (phase 2), the agent found a wrong
function signature, and — instead of recording it — immediately edited the file.
One edit invited the next; the session slid from research into unreviewed
implementation, edit after edit, while the human believed planning was still
underway. The human interrupted: *"why is the AI not following the workflow and
diving into code edits?"*

Post-mortem, three causes:

1. **Training bias toward action.** Models are rewarded for "see defect → fix
   defect" trajectories. Verification output is a strong trigger to edit.
2. **Soft prose constraints.** The protocol existed as guidance text competing
   with in-the-moment task momentum — and after context compaction, phase
   rules can thin out while the half-done task stays.
3. **The small-fix illusion.** A one-line edit feels like tidying, not
   implementing, so the agent doesn't classify it as a phase violation. Hence
   *lia lịa* — a burst of small edits — rather than one big unauthorized change.

## Decision

1. Edits to code files are allowed **only in phase 5 (Implement)**, and only on
   the frontier ticket's files. All other phases, and absent `STATUS.md`, are
   read-only for source.
2. Defects found outside phase 5 become **Candidate Findings**: `file:line`,
   what's wrong, evidence, proposed fix — filed into the Decision Report or a
   ticket. They are fixed in phase 5, against a ticket, at a Checkpoint.
3. Edits made in the wrong phase are **reverted**, then recorded as Candidate
   Findings. "The fix was correct" does not preserve it; the decision trail was
   still corrupted.
4. A human saying "fix it now" is a phase change: set `STATUS.md` to phase 5
   with that ticket first, then edit. The human can override any time — through
   the door, not around it.
5. Review (phase 6) is read-only by the same logic: review that repairs is
   review that grades its own homework.

## Consequences

- Planning output stays truthful: the Decision Report and tickets describe the
  codebase the human actually approved changes to.
- Mid-research "just one fix" urges get funneled into the ticket queue instead
  of the working tree; nothing is lost, nothing lands unreviewed.
- Slightly slower per-fix latency (finding → ticket → phase 5) — accepted,
  because the failure this replaces was not slowness but silent scope drift.
- A PreToolUse hook can enforce this mechanically later (block `Edit`/`Write`
  on source when `STATUS.md` phase ≠ 5); this ADR is the semantic layer such a
  hook would enforce.
