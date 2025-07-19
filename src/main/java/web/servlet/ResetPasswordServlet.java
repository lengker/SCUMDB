package web.servlet;

import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/resetPassword")
public class ResetPasswordServlet extends HttpServlet {
    private final UserService userService = new UserService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String emailCode = request.getParameter("emailCode");

        if (password == null || !password.equals(confirmPassword)) {
            request.setAttribute("error", "两次输入的密码不一致。");
            request.getRequestDispatcher("/resetPassword.jsp").forward(request, response);
            return;
        }

        try {
            userService.resetPassword(email, password, emailCode);
            request.setAttribute("message", "密码重置成功，请使用新密码登录。");
            request.getRequestDispatcher("/loginAndRegister.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "操作失败：" + e.getMessage());
            request.getRequestDispatcher("/resetPassword.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 从请求中获取 email 和 code，以便在页面上显示
        String email = request.getParameter("email");
        String code = request.getParameter("code");
        request.setAttribute("email", email);
        request.setAttribute("emailCode", code);
        request.getRequestDispatcher("/resetPassword.jsp").forward(request, response);
    }
}

