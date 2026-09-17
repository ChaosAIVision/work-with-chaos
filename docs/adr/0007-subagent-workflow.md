# ADR-0007: Add a planned subagent workflow

Date: 2026-09-17
Status: Accepted

## Context

The user requested /work-with-chaos-subagent as an additional workflow that uses an explicit plan to delegate independent work. The existing work-with-chaos skill defines planning, phase discipline, approval, and verification; copying those rules into another entrypoint would create competing versions. ADR-0005 originally restricted the collection to two top-level skills.

## Decision

- Expose three top-level skills: work-with-chaos, work-with-chaos-subagent, and diagnose-linux-disk. Preserve the existing two entrypoints and the chaos-skill plugin and marketplace names.
- Make work-with-chaos-subagent an extension that reads ../work-with-chaos/SKILL.md as its required base. Install or copy both workflow folders together as siblings. Diagnose-linux-disk remains independent.
- Use one coordinator and one explicit plan. Each delegated task records an outcome, stable requirement IDs, dependencies, file and shared-resource ownership, interface contracts, and observable verification.
- Dispatch only dependency-ready tasks whose ownership is disjoint. Keep integration and final acceptance with the coordinator; a subagent's completion report alone does not establish that the full objective is met.
- Preserve the base workflow's phase discipline, approval gate, and evidence requirements. Delegation changes how approved work is assigned, not what work is authorized.
- Add the third skill to the fallback installer and document both flat and plugin-namespaced invocations. Preserve the installer's rerun behavior, real directories, and unrelated obsolete helper symlinks.

## Consequences

Users can select the delegated workflow explicitly while retaining the original workflow and standalone disk diagnosis. Plugin installation and the fallback installer include all three skills. Manual copies must preserve the sibling base dependency; copying only work-with-chaos-subagent is incomplete.

The exact-two restriction and two-skill installer list in ADR-0005 are superseded. Its remaining packaging decisions continue to apply. No repository URL changes are required by this decision.

Independent tasks can be assigned concurrently when the host supports subagents. Task ownership and integration checks are necessary to keep that work coherent. This design does not establish a measured speedup; performance claims still require evidence under the base workflow.
