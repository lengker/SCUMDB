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

@WebServlet(urlPatterns = "/addUser")
public class AddUserServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // 验证必填字段
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/userManagement?error=required");
            return;
        }
        
        try {
            UserService service = new UserService();
            
            // 检查用户名是否已存在
            if (service.findUserByUsername(username.trim()) != null) {
                response.sendRedirect(request.getContextPath() + "/userManagement?error=exists");
                return;
            }
            
            User user = new User();
            user.setUsername(username.trim());
            user.setPassword(password.trim());
            // 设置其他字段为默认值
            user.setEmail("");
            user.setPhone("");
            user.setGender("");
            user.setAge(0);
            
            service.addUser(user);
            
            // 重定向到用户管理页面
            response.sendRedirect(request.getContextPath() + "/userManagement?success=add");
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/userManagement?error=database");
        }
    }
}
