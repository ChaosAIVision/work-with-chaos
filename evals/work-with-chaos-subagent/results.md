# Subagent workflow results — 2026-09-17

Two fresh coordinator runs used the skill and raw cases from [the evaluation guide](README.md), without the rubric or other runs' outputs. All project work stayed in isolated directories. The fixture implementation was local only; no service, deployment, or external publication was part of either case.

## Real delegated implementation

The coordinator resumed the approved r1 plan in phase 5, verified local inputs, and dispatched two real workers before waiting for their results:

| Assignment | Actual owner | Exclusive change surface | Observed evidence |
| --- | --- | --- | --- |
| T1: tenant/status selection | query_worker | report_export/query.py; tests/test_query.py | 10 unit tests passed; exact matching including empty status, stable order, duplicates, single-pass iterable, unchanged input, and 1,501 matching rows |
| T2: CSV serialization | csv_worker | report_export/csv_format.py; tests/test_csv_format.py | 4 unit tests passed; fixed columns, UTF-8, comma/quote/newline escaping, string totals, unchanged input, and empty header |
| T3: permission and integration | Coordinator | report_export/service.py; tests/test_integration.py | 6 integration tests passed; permission before iteration/module calls, query-then-CSV composition, and actual combined behavior including 1,205 matching rows |
| Integrated review | A fresh integrated_reviewer | Read-only; no source changes | Independently inspected the request, contract, source, and tests; reran 20 tests, compared six source/test hashes, found no blocking issue |

Workers returned submitted results and explicit unverified integration work. The coordinator read actual changes and reran worker checks before accepting the two upstream artifacts and implementing T3. PLAN.md and STATUS.md remained coordinator-owned. The accepted contract and original request were unchanged; the coordinator completed a local checkpoint with a clean worktree. No worker staged, committed, published, or spawned another worker.

The full generated suite passed **20 tests**. The outer evaluator independently reran it and performed additional direct checks: permission denied before reading an explosive iterable; exact tenant/status matching including the empty string; a 123-row single-pass export; preserved order and input data; UTF-8/CSV round-trip; unchanged string totals; and header-only output for empty/unmatched input. These checks passed. The service was inspected to confirm it called the two modules rather than duplicating their logic.

The trace demonstrates actual concurrent assignments and coordinator acceptance/integration. It does not measure a speedup against serial work.

## Shared-file and shared-resource planning

The plan-only run produced a canonical plan with conditional task contracts and STATUS.md at phase 4. Observed assignments:

1. Coordinator T1 owns api/report-api.yaml and generated web/report-client.ts, verifies unknown repository facts, and records an accepted interface/client contract before dispatch.
2. W1 T2 owns server/reports.py and tests/test_reports.py.
3. W2 T3 owns web/ReportsPage.tsx and web/ReportsPage.test.tsx. It consumes the accepted generated client and fixtures, so UI unit work can proceed alongside server implementation.
4. Coordinator T4 accepts both submissions, verifies the combined UI/client/API behavior, and updates docs/reports.md.

The plan explicitly serialized tests that might use the shared report_test database until isolation is established. Generated client output had one owner and could only be changed through the generator. It distinguished real dependencies from independent worker implementation, named integration evidence, preserved all export requirements, and marked new paths/functions as proposed. Unknown client signatures and data types were execution gates with owners and resolution actions, not invented facts or blockers to completing planning.

The planner labeled its review as self-review; the outer evaluator also inspected the plan against the original case. No implementation workers were claimed to be running, no source/export/test was executed, and production access was not required. W1/W2 were future roles, not fabricated runtime agent IDs.

## Packaging checks and limits

- All three skill entrypoints passed the existing skill validator. The sibling base and template links, UI metadata, JSON manifests, and Bash syntax were checked.
- The installer was exercised with isolated CHAOS_SKILLS_TARGET_DIR paths: three links, rerun, real-directory preservation, unrelated obsolete helper-link preservation, removal of checkout-owned obsolete helper links, and stale skill-link replacement passed. HOME was unchanged.
- The existing work-with-chaos and diagnose-linux-disk skill sources were unchanged. ADR-0005 retains its history while ADR-0007 supersedes its two-skill limit.
- One execution fixture and one planning case do not establish reliability for arbitrary repositories. Worker failure/reassignment, mid-flight contract revision, unavailable-agent fallback, and isolated-worktree merging remain unexercised by these runs. There is no general performance or brevity claim.
