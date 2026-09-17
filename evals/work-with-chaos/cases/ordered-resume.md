# Request

Cập nhật plan đang chạy này theo thay đổi mới của tôi. Chỉ cập nhật plan; không chạy migration hoặc gọi server.

Thứ tự bắt buộc vẫn là: (1) xuất snapshot nguồn, (2) tạo bảng đối chiếu và report cần kiểm tra, (3) chỉ sync bản ghi đã đối chiếu hợp lệ vào local, (4) đối soát và báo cáo kết quả. Không bỏ qua bước đang bị chặn để chạy bước phía sau.

Thay đổi: ngoài case không tìm được ID mới, cả case một old_id khớp nhiều ID mới cũng phải loại khỏi batch sync và xuất riêng trong report. Bổ sung chế độ dry-run cho bước sync; dry-run không được ghi vào local. Các requirement khác giữ nguyên. Hãy nêu rõ task nào giữ trạng thái cũ, task nào phải kiểm tra lại, phần nào còn chặn, và hành động tiếp theo.

## Accepted plan at revision r1

Objective: Sync eligible agent records from a captured source snapshot to the local database while excluding unmapped records and reporting reconciliation results.
Mode: ordered.
Approval: r1 approved previously; r2 is requested as a plan update only.

R1: Export a read-only source snapshot with its capture time.
R2: Map source old_id to the corresponding current Abbott agent ID; exclude unmapped records and report them.
R3: Sync mapped records into local without duplicate inserts on repeat runs.
R4: Reconcile input, synced, and excluded counts and produce a report.

T1: Capture source snapshot. Covers R1. Dependencies: none. Status: done. Evidence: artifacts/source-20260916.json exists, 120 records; capture timestamp 2026-09-16T09:00:00Z. The snapshot is immutable for this batch.
T2: Resolve ID mapping and record exclusions. Covers R2. Dependencies: T1 snapshot. Status: done under r1. Evidence: artifacts/mapping-r1.csv has 112 eligible rows and artifacts/unmapped-r1.csv has 8 rows. The old mapping code selected the first match; uniqueness was not checked.
T3: Apply eligible records idempotently. Covers R3. Dependencies: T2 mapping report. Status: pending. Gate input: write access to the local test database is not available yet. No synchronization has run.
T4: Reconcile and report. Covers R4. Dependencies: T3 result. Status: pending.

## Current source anchors

scripts/sync_agents.py: capture_snapshot() already produced T1 output; resolve_ids(snapshot, mapping_rows) takes the first match; apply_batch(rows, db) performs idempotent upserts but has no dry_run argument; reconcile(source_rows, results, excluded) writes the final report.
tests/test_sync_agents.py: fixtures for mapped and unmapped rows, repeat-run idempotency; no duplicate-mapping or dry-run tests yet.
artifacts/source-20260916.json: existing immutable 120-row source fixture.
artifacts/mapping-r1.csv and artifacts/unmapped-r1.csv: historical r1 evidence, not evidence of the new uniqueness requirement.

The new number of eligible rows is unknown until uniqueness is checked. There is no live server connection in this task. Do not invent new reconciliation counts or claim tests ran.
