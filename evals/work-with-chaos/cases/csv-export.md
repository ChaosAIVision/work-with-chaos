# Request

Hãy lập plan để bổ sung CSV export cho trang báo cáo. Chỉ tạo plan, chưa sửa code và chưa triển khai. Requirement dưới đây đã chốt; không cần hỏi lại các lựa chọn đã nêu.

## Requirements

- Nút Export tải file CSV chứa toàn bộ dòng khớp bộ lọc hiện tại, không chỉ 50 dòng của trang đang xem.
- Chỉ tài khoản có reports:export được xuất; dữ liệu phải nằm trong tenant của người dùng. Không thay đổi quy tắc phân quyền hiện có.
- Giữ đúng thứ tự cột order_id, customer_name, total, created_at. UTF-8; dấu phẩy, dấu nháy và xuống dòng trong tên khách phải được escape đúng. created_at dùng UTC ISO 8601.
- Không có kết quả vẫn tải một CSV chỉ có header. Lỗi API phải hiển thị trên trang và cho phép thử lại; không tải file lỗi như thể thành công.
- Bộ lọc date_from/date_to dùng quy tắc UTC hiện có; không thêm timezone selector. Bộ dữ liệu tối đa 20.000 dòng; không cần background job, email, S3, hệ thống export dùng chung hay thay đổi schema.
- Có kiểm chứng quyền truy cập, tenant isolation, bộ lọc với hơn một trang, CSV escaping, trường hợp rỗng và UI retry. Cập nhật hướng dẫn sử dụng hiện có.
- Chưa có môi trường production hoặc thông tin đăng nhập production. Đây là task lập plan dựa trên snapshot code, không phải task deploy.

## Repository snapshot

These are the complete relevant source anchors available for planning. Treat snippets as observed; do not invent other existing functions or files. New paths may be proposed and must be labeled new.

server/reports.py:
```python
@router.get('/reports')
def list_reports(filters: ReportFilters, page: int, user: User):
    require_permission(user, 'reports:view')
    query = filtered_report_query(tenant_id=user.tenant_id, filters=filters)
    return paginate(query.order_by(Report.created_at, Report.id), page=page, page_size=50)
```

server/report_queries.py:
```python
def filtered_report_query(tenant_id: str, filters: ReportFilters):
    query = Report.where(Report.tenant_id == tenant_id)
    return apply_utc_date_filters(query, filters.date_from, filters.date_to)
```

server/auth.py: require_permission(user, permission) raises an existing HTTP 403 response.

web/ReportsPage.tsx: ReportsPage owns filters, page, rows, loading, and error state; calls api.listReports(filters, page). It renders a filter form, a 50-row table, and pagination.

web/api.ts: api.listReports serializes filters and page using the existing authenticated fetch wrapper.

Existing verification: pytest tests/test_reports.py; npm test -- ReportsPage in web/. The tests contain two tenant fixtures and users with distinct permission sets. No CSV export test or endpoint exists yet.

Existing documentation: docs/reports.md.

No STATUS.md, task plan, ADR, or QUALITY-CONTRACT.md exists in this fixture.

## Deliverable

Một plan có thể giao cho người khác thực hiện: người đọc biết sẽ có kết quả gì sau từng phần, bắt đầu từ đâu, phụ thuộc gì và kiểm chứng thế nào. Giữ câu trả lời dễ đọc bằng tiếng Việt.
