package web.servlet.client;

import domain.User;
import exception.RegisterException;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.log4j.Logger;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;

@WebServlet(urlPatterns = "/register")
public class RegisterServlet extends HttpServlet {
    static Logger logger = Logger.getLogger(RegisterServlet.class);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8");
        String captcha = request.getParameter("captcha");
        HttpSession session = request.getSession();
        String sessionCaptcha = (String) session.getAttribute("captchaCode");

        if (sessionCaptcha == null || !sessionCaptcha.equalsIgnoreCase(captcha)) {
            response.getWriter().write("验证码不正确！");
            return;
        }

        User user = new User();
        try {
            BeanUtils.populate(user, request.getParameterMap());
        } catch (IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
            response.getWriter().write("服务器内部错误！");
            return;
        }

        UserService service = new UserService();
        try {
            service.register(user);
            response.getWriter().write("success");
        } catch (RegisterException e) {
            response.getWriter().write(e.getMessage());
        }
    }
}
