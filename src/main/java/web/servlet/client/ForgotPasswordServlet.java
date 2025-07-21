package web.servlet.client;

import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/forgotPassword")
public class ForgotPasswordServlet extends HttpServlet {
    private final UserService userService = new UserService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        String email = request.getParameter("email");

        try {
            userService.sendResetPasswordEmail(email);
            request.setAttribute("message", "密码重置邮件已发送至您的邮箱，请注意查收。");
        } catch (Exception e) {
            e.printStackTrace();
            // 向用户显示更友好的错误信息，而不是暴露底层的异常细节
            String errorMessage = "邮件发送失败，请稍后重试或联系管理员。";
            if (e.getMessage().contains("535")) {
                errorMessage = "邮箱验证失败，请检查发件人邮箱配置。";
            } else if (e.getMessage().contains("Invalid address")) {
                errorMessage = "无效的邮箱地址，请检查后重试。";
            }
            request.setAttribute("error", errorMessage);
        }
        request.getRequestDispatcher("/forgotPassword.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/forgotPassword.jsp").forward(request, response);
    }
}
