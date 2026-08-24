---
status: accepted
---

# Every task runs the full pipeline — no fast lane

The work-with-chaos pipeline (research → decide → tickets → implement → review → report) applies to **every task, regardless of size**, with no small-task fast lane. This was chosen against the recommendation of a two-lane split (full pipeline only for schema/API/architecture-touching work).

The pain being solved is inconsistency and stall across many parallel project sessions: when lane assignment is a judgement call, it reintroduces exactly the ad-hoc decisions that caused unclear requirements and rework. A uniform protocol trades some per-task overhead for predictability — the user acts as manager, the AI as a worker following a fixed protocol.

## Considered Options

- **Two lanes (rejected)** — full pipeline for big tasks, straight-to-implement for small. Faster on paper, but lane assignment becomes a per-task judgement call, the inconsistency this skill exists to kill.
