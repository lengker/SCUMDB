package utils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "CheckUserOnlineServlet", urlPatterns = "/checkUserOnline")
public class CheckUserOnlineServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session.getAttribute("msg") != null){
            PrintWriter out = response.getWriter();
            out.print(session.getAttribute("msg"));
            // 将用户从session中移除
            request.getSession().removeAttribute("user");
            request.getSession().removeAttribute("userId");
            //将从sessionContext中移出的Session失效 --相当于清除当前Session对应的登录用户
            session.invalidate();
            response.sendRedirect("/login.do");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
