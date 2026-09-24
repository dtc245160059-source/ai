package com.codegym;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ConverterServlet", urlPatterns = {"/convert"})
public class ConverterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Thiết lập bảng mã UTF-8 hỗ trợ tiếng Việt
        response.setContentType("text/html;charset=UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Kết quả chuyển đổi</title>");
            out.println("<style>");
            out.println("body { font-family: 'Segoe UI', Arial, sans-serif; text-align: center; margin-top: 100px; background-color: #f8fafc; }");
            out.println(".card { background: white; width: 400px; margin: 0 auto; padding: 30px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }");
            out.println(".btn { display: inline-block; margin-top: 20px; text-decoration: none; padding: 10px 20px; background-color: #1b2a7a; color: white; border-radius: 4px; font-weight: bold; }");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");
            out.println("<div class='card'>");
            
            try {
                // 1. Nhận tham số từ form và ép kiểu sang số thực
                float rate = Float.parseFloat(request.getParameter("rate"));
                float usd = Float.parseFloat(request.getParameter("usd"));
                
                // 2. Tính toán quy đổi
                float vnd = rate * usd;
                
                // 3. Xuất kết quả ra màn hình
                out.println("<h2 style='color: #1b2a7a; margin-top: 0;'>KẾT QUẢ CHUYỂN ĐỔI</h2>");
                out.println("<p style='font-size: 16px; color: #475569;'>Tỉ giá: <strong>" + rate + " VND/USD</strong></p>");
                out.println("<p style='font-size: 16px; color: #475569;'>Số tiền USD: <strong>$" + usd + "</strong></p>");
                out.println("<h3 style='color: #16a34a; font-size: 22px; margin-top: 20px;'>Thành tiền: " + vnd + " VNĐ</h3>");
                
            } catch (NumberFormatException e) {
                // Xử lý ngoại lệ khi người dùng nhập dữ liệu không phải là số
                out.println("<h2 style='color: #dc2626;'>Lỗi nhập dữ liệu!</h2>");
                out.println("<p>Vui lòng nhập các giá trị số hợp lệ cho Tỉ giá và Số USD.</p>");
            }
            
            out.println("<a href='index.jsp' class='btn'>← Quay lại</a>");
            out.println("</div>");
            out.println("</body>");
            out.println("</html>");
        }
    }
}
