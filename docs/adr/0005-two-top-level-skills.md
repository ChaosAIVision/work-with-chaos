# ADR-0005: Two top-level skills in chaos-skill

Date: 2026-09-17
Status: Accepted; the two-skill limit and installer list are superseded by [ADR-0007](0007-subagent-workflow.md).

## Supersession

The decision below records the original two-skill packaging. ADR-0007 adds work-with-chaos-subagent as a third entrypoint and includes it in the installer, superseding the exact-two restriction. The collection name, internal helper layout, installer preservation rules, and independent disk diagnosis workflow remain in effect.

## Context

The user requested chaos-skill as the collection name, with work-with-chaos as the first skill and diagnose-linux-disk as the second. The existing repository exposed four workflow helpers as additional skills.

## Decision

- Keep exactly two skill entrypoints under skills/: work-with-chaos and diagnose-linux-disk.
- Preserve the benchmark, decide, input-gate, and report procedures as internal references of work-with-chaos, alongside its existing templates and vocabulary.
- Read those references directly instead of invoking retired helper skills. Preserve the workflow's phase discipline, approval gate, evidence rules, and external skill integrations.
- Name the Claude plugin and marketplace chaos-skill. Install only the two top-level skills through the fallback installer.
- Keep diagnose-linux-disk independent; invoking it does not invoke the work-with-chaos pipeline.

## Consequences

The four former helper slash commands are replaced by requests to work-with-chaos. The installer removes only obsolete helper symlinks owned by this checkout, and retains real directories and unrelated helper symlinks. The GitHub repository slug is a separate administrative rename; content and plugin naming do not perform it.
