package web.servlet.management;

import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = "/unlock")
public class UnlockScreenServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /*request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");*/

        String password = request.getParameter("password");
        System.out.println("解锁屏幕密码: " + password);
        if("123456".equals(password)){
            response.sendRedirect("management/index.jsp");
        }else{
            response.sendRedirect("management/auth-lock-screen.html");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
