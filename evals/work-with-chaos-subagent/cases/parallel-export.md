# Request

Dùng work-with-chaos-subagent để triển khai plan r1 đã được duyệt trong project fixture này. Tôi đã duyệt objective, requirement, phạm vi file và thứ tự phụ thuộc trong PLAN.md; bạn có thể giao việc và thực hiện ngay trong workspace được cung cấp. Không cần hỏi lại để bắt đầu. Không gọi dịch vụ bên ngoài, không deploy hoặc push.

Tính năng: export báo cáo của một tenant thành CSV; giữ bộ lọc trạng thái và toàn bộ dòng khớp. Hợp đồng dữ liệu và API Python đã chốt trong CONTRACT.md. Các module query và CSV hiện là stub, service chưa nối chúng. Chỉ dùng Python standard library.

Yêu cầu giữ nguyên:
- Quyền export phải được kiểm trước khi truy cập dữ liệu; thiếu quyền raise PermissionError.
- Chỉ lấy dữ liệu tenant được truyền; status=None giữ mọi trạng thái, status có giá trị thì khớp chính xác. Giữ thứ tự nguồn và không phân trang hay sửa dữ liệu đầu vào.
- CSV UTF-8, thứ tự cột order_id,customer_name,total; escape đúng Unicode, dấu phẩy, nháy kép, newline; dữ liệu rỗng có header. Không tự đổi total từ chuỗi sang số.
- Service gọi query rồi CSV; không nhân bản logic của hai module. Có kiểm chứng unit và integration cho các yêu cầu trên.

Hoàn thành implementation, kiểm tra kết quả tích hợp và cập nhật trạng thái. Báo rõ task nào giao cho agent nào, kết quả nào đã được kiểm chứng, phần nào còn thiếu. Những test bạn chưa chạy không được báo là đã pass.
