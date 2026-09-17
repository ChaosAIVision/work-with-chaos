# Request

Lập plan dùng subagent để thêm CSV và JSON export vào trang Reports. Chỉ lập plan và bản giao việc; chưa sửa code hoặc chạy export. Tôi muốn chia việc rõ để sau này các agent làm song song nếu phù hợp. Có tối đa hai worker triển khai; coordinator chịu trách nhiệm ghép kết quả.

Yêu cầu đã chốt:
- Export mọi dòng khớp filters hiện tại trong tenant của user, không chỉ trang đang xem; giữ permission reports:export.
- Một endpoint GET /reports/export?format=csv|json, dùng bộ lọc hiện tại; định dạng khác trả 400, thiếu quyền trả 403.
- CSV: UTF-8, ba cột order_id,customer_name,total và escaping chuẩn; JSON: array các object có đúng ba trường này, giữ total là chuỗi. Rỗng tương ứng header-only hoặc [].
- Trang có nút chọn CSV/JSON, hiện lỗi và cho retry; không download response lỗi. Không đổi schema DB, auth hoặc tạo background job.
- Có test quyền, tenant, hơn một trang, định dạng/rỗng/lỗi/retry; tài liệu dùng được sau khi ghép.

Snapshot toàn bộ những gì đã biết:
- server/reports.py::list_reports() có tenant/filter/auth cho danh sách, phân trang 50. File này chứa mọi report route hiện tại; chưa có export route.
- server/report_query.py::filtered_reports(tenant_id, filters) trả query đã lọc, chưa paginate.
- api/report-api.yaml định nghĩa API và là nguồn tạo web/report-client.ts. Lệnh đã có: python scripts/generate_client.py. Không sửa tay output được generate.
- web/report-client.ts được generate từ schema; web/ReportsPage.tsx::ReportsPage gọi client danh sách, giữ filters và page. Không có export UI.
- tests/test_reports.py và web/ReportsPage.test.tsx là test hiện có. Lệnh pytest tests/test_reports.py và npm test -- ReportsPage (trong web/) được cung cấp.
- docs/reports.md là hướng dẫn hiện có. Chưa có STATUS.md hoặc plan.
- Các worker sẽ dùng chung checkout và test database local report_test. Chưa biết test DB có hỗ trợ namespace riêng hay không; không có quyền production trong task lập plan này.

Đầu ra: một plan tiếng Việt dễ bàn giao, có outcome, requirement, owner, phụ thuộc, file/resource được sửa, interface, verification và thứ tự tích hợp. Mọi path/hàm mới phải được ghi rõ là đề xuất. Không bịa agent đã chạy hoặc kết quả test.
