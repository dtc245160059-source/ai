package com.codegym;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DictionaryServlet", urlPatterns = {"/translate"})
public class DictionaryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Cấu hình UTF-8 hỗ trợ Tiếng Việt
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        // 1. Khởi tạo danh sách từ vựng (Map)
        Map<String, String> dictionary = new HashMap<>();
        dictionary.put("hello", "Xin chào");
        dictionary.put("how", "Thế nào");
        dictionary.put("book", "Quyển sách");
        dictionary.put("computer", "Máy tính");
        dictionary.put("student", "Sinh viên");

        // 2. Nhận tham số 'word' từ form
        String searchWord = request.getParameter("word");

        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head><title>Kết quả tra cứu</title></head>");
            out.println("<body style='font-family: \"Segoe UI\", Arial, sans-serif; text-align: center; margin-top: 100px; background-color: #f8fafc;'>");
            out.println("<div style='background: white; padding: 30px; display: inline-block; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); width: 350px;'>");
            
            if (searchWord != null && !searchWord.trim().isEmpty()) {
                // Chuyển từ khóa về chữ thường để tra cứu
                String result = dictionary.get(searchWord.trim().toLowerCase());
                
                if (result != null) {
                    out.println("<h2 style='color: #1b2a7a; margin-top: 0;'>Từ khóa: " + searchWord + "</h2>");
                    out.println("<h3 style='color: #16a34a;'>Nghĩa tiếng Việt: " + result + "</h3>");
                } else {
                    out.println("<h2 style='color: #dc2626; margin-top: 0;'>Không tìm thấy từ: " + searchWord + "</h2>");
                }
            } else {
                out.println("<h2 style='color: #eab308; margin-top: 0;'>Vui lòng nhập từ khóa hợp lệ!</h2>");
            }
            
            out.println("<br><a href='index.jsp' style='text-decoration: none; display: inline-block; padding: 10px 20px; background-color: #1b2a7a; color: white; border-radius: 4px; font-weight: bold;'>← Quay lại</a>");
            out.println("</div>");
            out.println("</body>");
            out.println("</html>");
        }
    }
}
