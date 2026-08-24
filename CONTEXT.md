# Work With Chaos

Bộ kỹ năng cá nhân điều phối cách Chaos làm việc với AI across nhiều project: mọi task đi qua một pipeline chuẩn (research → quyết định → tickets → implement → review → report), chống stall, và mọi claim hiệu năng phải có bằng chứng.

## Language

### Quy trình

**Work Block**:
Một khung thời gian định trước dành cho một loại việc (plan, implement, review). Đơn vị căn nhịp làm việc trong ngày.
_Avoid_: block, time-block (trùng với nghĩa "bị nghẽn")

**Stalled Task**:
Task bị treo vì thiếu input chỉ con người cung cấp được (password, data, quyền truy cập). Vào hàng đợi `BLOCKED.md`, AI nhảy sang task khác thay vì chờ.
_Avoid_: blocked task, block

**Input Gate**:
Checklist chạy đầu mọi Work Block implement: credentials, env, data, quyền. Thiếu gì → task chuyển Stalled, không bắt đầu làm.
_Avoid_: pre-check, checklist đầu block

**Checkpoint**:
Điểm lưu trạng thái khi kết thúc một task: commit + tick acceptance criteria trong ticket + handoff doc nếu hết block.
_Avoid_: save point

### Lập kế hoạch

**Breadth-Plan**:
Lớp kế hoạch mỏng phủ mọi project trong một buổi: chỉ đủ sâu để xếp thứ tự các Work Block và phát hiện project nào thiếu input.
_Avoid_: master plan, big plan

**Deep-Plan**:
Lớp kế hoạch sâu của một project, làm ngay trong Work Block trước Work Block implement của chính project đó.
_Avoid_: detailed plan

**Domino Note**:
Trường trong ticket ghi: task này hoàn thành thì task nào dễ test/sửa hơn hoặc không còn cần nữa. Thứ tự domino khi xếp ticket (nguyên tắc CHUỖI, timvu.vn/fast).
_Avoid_: dependency note

### Chất lượng & bằng chứng

**Quality Contract**:
Bộ ngưỡng s��� đo được (p95 latency, query time, memory, CPU, cost) mà một phương án phải đạt mới được claim "tốt". AI đề xuất ngưỡng lúc research; Chaos chốt một lần; lưu `QUALITY-CONTRACT.md` trong repo. Không được tự bịa ngưỡng khi đang đề xuất phương án.
_Avoid_: perf requirements, SLA

**Evidence Ladder**:
4 bậc gắn bắt buộc vào mọi claim hiệu năng: 🟢 đo thật trên env thật · 🟡 micro-benchmark sandbox (kèm điều kiện) · 🔴 trích primary source (kèm link + điều kiện áp dụng) · ⚫ chưa xác minh. Claim không nhãn không được phép xuất hiện trong report.
_Avoid_: confidence level, source rating

### Tài liệu

**Decision Report**:
Report sinh ra sau research: phương án, trade-off, dẫn chứng có nhãn Evidence Ladder — nguyên liệu để grill chốt 6 trục.
_Avoid_: research report

**Delivery Report**:
Report sinh ra cuối milestone (hoặc on-demand): 2 dạng — flow end-to-end và bảng per-module Input/Output (Task → module → interfaces → tests → architecture rules).
_Avoid_: final report
