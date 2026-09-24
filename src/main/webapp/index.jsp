<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CodeGym JSP Demo</title>
    </head>
    <body style="font-family: Arial, sans-serif; text-align: center; margin-top: 100px;">
        <h2>Chào mừng tới lớp học Java Web!</h2>
        <p>Thời gian hệ thống hiện tại: <strong style="color: red;"><%= new java.util.Date() %></strong></p>
        <br/>
        <a href="hello">Đi tới HelloServlet</a>
    </body>
</html>
