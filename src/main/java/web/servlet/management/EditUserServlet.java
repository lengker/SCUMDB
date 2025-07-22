package web.servlet.management;

import domain.User;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(urlPatterns = "/editUser")
public class EditUserServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        
        String username = request.getParameter("username");
        
        if (username == null || username.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/userManagement");
            return;
        }
        
        UserService service = new UserService();
        try {
            User user = service.findUserByUsername(username);
            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("/management/editUser.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "用户不存在");
                response.sendRedirect(request.getContextPath() + "/userManagement");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "数据库查询出错：" + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/userManagement");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        
        String originalUsername = request.getParameter("originalUsername");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String ageStr = request.getParameter("age");
        
        // 验证必填字段
        if (originalUsername == null || originalUsername.trim().isEmpty() ||
            username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "用户名和密码不能为空");
            doGet(request, response);
            return;
        }
        
        try {
            User user = new User();
            user.setUsername(username.trim());
            user.setPassword(password.trim());
            user.setEmail(email != null ? email.trim() : "");
            user.setPhone(phone != null ? phone.trim() : "");
            user.setGender(gender != null ? gender.trim() : "");

            // 处理年龄
            if (ageStr != null && !ageStr.trim().isEmpty()) {
                try {
                    user.setAge(Integer.parseInt(ageStr.trim()));
                } catch (NumberFormatException e) {
                    user.setAge(0);
                }
            } else {
                user.setAge(0);
            }
            
            UserService service = new UserService();
            service.updateUser(user, originalUsername.trim());
            
            // 重定向到用户管理页面
            response.sendRedirect(request.getContextPath() + "/userManagement?success=edit");
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "更新用户信息失败：" + e.getMessage());
            doGet(request, response);
        }
    }
}
