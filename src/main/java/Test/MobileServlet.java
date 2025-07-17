package Test;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "MobileServlet", urlPatterns = "/mobile")
public class MobileServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        // 获取手机号，判断手机号是否再数据库中，利用ajax异步刷新返回结果
        String mobile = request.getParameter("mobile");

        // 获取输出流
        PrintWriter out = response.getWriter();

        // mobile.equals这种对象点的方式可能会有空指针异常，所以推荐下面的方式
        if ("18770411594".equals(mobile)) {
//            out.write("true");
            out.write("此号码已存在");
        } else {
//            out.write("false");
            out.write("注册成功");
        }

        out.close();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
