package web.servlet.client;

import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import org.apache.log4j.Logger;

@WebServlet("/resetPassword")
public class ResetPasswordServlet extends HttpServlet {
    private final UserService userService = new UserService();
    private static final Logger LOGGER = Logger.getLogger(ResetPasswordServlet.class);

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("resetEmail");
        String codeFromSession = (String) session.getAttribute("resetCode");
        String codeFromRequest = request.getParameter("code");

        LOGGER.info("doPost - Email from session: " + email);
        LOGGER.info("doPost - Code from session: " + codeFromSession);
        LOGGER.info("doPost - Code from request: " + codeFromRequest);


        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (password == null || !password.equals(confirmPassword)) {
            request.setAttribute("error", "两次输入的密码不一致");
            request.getRequestDispatcher("/resetPassword.jsp").forward(request, response);
            return;
        }

        try {
            userService.resetPassword(email, password, codeFromRequest); // 使用请求中的code
            session.removeAttribute("resetEmail");
            session.removeAttribute("resetCode");
            session.setAttribute("message", "密码重置成功，请登录");
            response.sendRedirect(request.getContextPath() + "/loginAndRegister.jsp?show=login");
        } catch (Exception e) {
            LOGGER.error("Reset password failed for email: " + email, e);
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/resetPassword.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String code = request.getParameter("code");

        LOGGER.info("doGet - Email from parameter: " + email);
        LOGGER.info("doGet - Code from parameter: " + code);

        HttpSession session = request.getSession();
        session.setAttribute("resetEmail", email);
        session.setAttribute("resetCode", code);

        request.setAttribute("email", email);
        request.setAttribute("code", code);

        request.getRequestDispatcher("/resetPassword.jsp").forward(request, response);
    }
}
