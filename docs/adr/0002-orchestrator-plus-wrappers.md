---
status: superseded
---

# One orchestrator + four sub-skills; matt-pocock skills are wrapped, never edited

The separate sub-skill packaging is superseded by [ADR-0005](0005-two-top-level-skills.md). The rule to preserve external matt-pocock skills remains unchanged.

The skill set is five separate SKILL files in this repo: `work-with-chaos` (the orchestrator) plus `benchmark`, `decide`, `input-gate`, and `report`. Existing matt-pocock skills (`research`, `to-tickets`, `implement`, `code-review`, `grilling`, `domain-modeling`, `handoff`, `wizard`) are called as-is; where they fall short, a wrapper adds behavior (e.g. the review wrapper spawns a third sub-agent axis for performance/edge-cases on top of the stock two-axis `code-review`).

The matt-pocock files are installed by `setup-matt-pocock-skills` and would be overwritten on its next update, so any local edit there is silently destroyed. Wrapping keeps this repo upgrade-safe.

## Consequences

- A new sub-skill can evolve independently without touching the orchestrator.
- Wrappers duplicate a little context-loading cost versus editing in place — accepted.
