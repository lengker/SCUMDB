package web.servlet.client;

import domain.User;
import exception.UpdateUserException;
import org.apache.log4j.Logger;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(urlPatterns = "/alterUserInfo.do")
public class AlterUserInfoServlet extends HttpServlet {
    static Logger logger = Logger.getLogger(AlterUserInfoServlet.class);
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");

        String introduce = request.getParameter("introduce");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        String ageStr = request.getParameter("age");

        logger.warn(introduce);
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.getWriter().write("false");
            return;
        }
        if (password != null && !"".equals(password)) {
            user.setPassword(password);
        }
        if (introduce != null) {
            user.setIntroduce(introduce);
        }
        if (gender != null) {
            user.setGender(gender);
        }
        if (ageStr != null) {
            try {
                user.setAge(Integer.parseInt(ageStr));
            } catch (NumberFormatException e) {
                response.getWriter().write("false");
                return;
            }
        }
        UserService service = new UserService();
        PrintWriter writer = response.getWriter();
        try {
            // 密码或介绍修改
            if (password != null || introduce != null) {
                service.updateUser(user);
            }
            // 性别或年龄修改
            if (gender != null || ageStr != null) {
                service.updateUserInfo(user);
            }
            writer.write("ok");
        } catch (UpdateUserException e) {
            e.printStackTrace();
            writer.write("false");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
