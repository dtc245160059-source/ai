# Nhật ký Tương tác AI (Prompt Log)

### Prompt 1: Đánh giá hạn chế của CSS Grid đối với Navbar
- **Câu hỏi:** "Khi tôi cần một thanh Navbar mà kích thước các mục thay đổi linh hoạt theo độ dài ngôn ngữ (VD: tiếng Đức dài hơn tiếng Anh), tại sao việc cố định `grid-template-columns` lại gây vỡ giao diện? Flexbox giải quyết vấn đề này như thế nào?"
- **Kết quả thu được:** Hiểu rõ nguyên lý Content-first của Flexbox giúp tự căn chỉnh khoảng cách dựa trên chiều rộng tự nhiên của văn bản.

### Prompt 2: Kỹ thuật Bento Box với CSS Grid
- **Câu hỏi:** "Hãy cho tôi xem một cú pháp CSS Grid đơn giản sử dụng `span` để tạo layout Bento Box có 1 hình lớn bên trái chiếm 2x2 và các ô nhỏ xung quanh mà không cần dùng các thẻ div cột bọc lại."
- **Kết quả thu được:** Áp dụng thành công `grid-column: span 2;` và `grid-row: span 2;` để làm phẳng cấu trúc DOM.

### Prompt 3: Tận dụng Hệ thống Lưới Bootstrap 5
- **Câu hỏi:** "Cách cấu trúc Lưới 12 cột trong Bootstrap 5 sử dụng `row` và `col-12 col-md-4` cho 3 thẻ Pricing Card đạt chuẩn Responsive mà không viết thêm Media Queries thuần."
- **Kết quả thu được:** Triển khai nhanh gọn khu vực Pricing bằng các utility class chuẩn của Bootstrap.
