# Planning evaluation results — 2026-09-17

Four fresh-agent runs: one baseline and one updated-skill run for each of the two [cases](README.md). Baseline skill: commit `e968298f01ee828ad92f3012a5408cef78218fb1`. Updated skill: the planning revision committed with this report. Agents received the raw case and skill, not the evaluation rubric or other outputs. The main agent inspected the generated plans, status, and tickets afterward.

These are planning-behavior tests on supplied snapshots. No application implementation, CSV endpoint, database migration, or live service was tested. Verification proposed inside the plans remains unexecuted.

## Observations

| Check | Baseline observation | Updated observation |
| --- | --- | --- |
| CSV requirement preservation | Covered permissions, tenant isolation, pagination, CSV/UTC, empty/error/retry, 20,000-row scope, and documentation | Same required coverage, with stable R1–R10 IDs and explicit ownership/verification; the plan-only boundary is tracked separately from feature completion |
| CSV task boundaries | Three tickets: backend/CSV, client/UI/retry, documentation/acceptance | Three outcome tasks: usable page-to-CSV flow, visible error/retry behavior, and usage documentation. T1 includes server/client/UI checks; T2 explicitly consumes T1's Blob/error contract |
| CSV evidence and unknowns | Concrete acceptance matrix, proposed functions distinguished, no claimed test execution or production blocker | Concrete fixtures and expected results; distinguishes observed anchors, proposed additions, and U1–U3 implementation unknowns. Includes actual local integration evidence to collect in addition to mocked checks |
| Canonical planning artifact | Plan plus linked tickets, Decision Report, and a functional Quality Contract | One plan with inline task contracts and a STATUS.md pointer; no artificial performance contract or extra ADR. Both remain at phase 4 for the plan-only request |
| Ordered revision | Correctly retained T1, reopened T2, kept T3/T4 pending, and followed the user's hard order despite the old generic move-on rule | Same correct states, expressed using the defined revision/mode rules and stable IDs; revised requirements map to affected verification |
| Historical evidence | Correctly treated 112/8 as r1 history, not r2 counts | Same; T2 requires fresh uniqueness evidence while T1 retains the immutable 120-record snapshot and timestamp |
| Blockers and approval | Recognized missing full-candidate mapping evidence and local write access; did not infer r2 execution approval | Same, with explicit distinction between T2's data uncertainty, T3's write-access blocker, and readiness to finish the plan-only request |
| Honesty and scope | No implementation or fake test results; new anchors labeled | Same; self-review explicitly labeled as self-review and no live-access requirement imposed on planning |

The updated outputs met the critical checks in both cases. The baseline also handled many of them correctly; this is not evidence of a universal quality gain. The observed differences are more explicit traceability, a usable first CSV slice, fewer separate planning artifacts in these runs, and revision behavior that is now specified by the skill rather than left to inference.

## Inspectable output excerpts

The updated CSV overview assigned T1 the outcome:

> Từ trang báo cáo, tài khoản hợp lệ tải trọn dữ liệu đã lọc thành CSV đúng định dạng; danh sách vẫn phân trang như cũ

Its verification used 121 matching records plus another tenant and out-of-filter rows, exported from page 2, to distinguish complete filtered export from exporting only the visible page. A separate R5 ownership entry assigned client rejection to T1 and visible error/retry behavior to T2. The plan labeled every implementation check as planned, not passed.

The updated resume plan recorded:

- T1: `done → done`, keeping the immutable source evidence.
- T2: `done → pending`, reopened because the new uniqueness criterion was not established by first-match mapping.
- T3/T4: `pending → pending`, with dry-run and reconciliation checks added.
- Next action: verify the full offline candidate mapping at T2; do not infer uniqueness from r1's first-match output or bypass T3's missing write access to run T4.

Its dry-run verification required no write/upsert/commit calls and no data change, including error paths. It distinguished predicted dry-run counts from actual synchronized counts.

## Structural checks and limits

- Both skill entrypoints passed the existing skill validator; the collection still exposes exactly two skills.
- Relative documentation links and patch whitespace were checked. The diagnose-linux-disk skill, installer, and plugin metadata were unchanged.
- Generated outputs stayed in isolated evaluation directories and contained planning Markdown only.
- One run per version/case cannot measure reliability, generalization, or a numerical improvement. The fixtures give unusually detailed requirements; vague requests, larger projects, actual execution, and long-term resume behavior remain outside this evaluation.
- Detailed plans can still be long. The overview and inline contracts improved navigation in these runs, but brevity was not established by a controlled comparison.
