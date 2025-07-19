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
import java.util.List;

@WebServlet(urlPatterns = "/userManagement")
public class UserManagementServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        
        // 获取筛选参数
        String filterType = request.getParameter("filterType");
        String filterValue = request.getParameter("filterValue");
        
        UserService service = new UserService();
        
        try {
            List<User> users;
            
            // 根据筛选条件获取用户列表
            if (filterType != null && filterValue != null && !filterValue.trim().isEmpty()) {
                users = service.findUsersWithFilter(filterType, filterValue);
            } else {
                users = service.findAllUsers();
            }
            
            request.setAttribute("allUsers", users);
            request.setAttribute("filterType", filterType);
            request.setAttribute("filterValue", filterValue);
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "数据库查询出错：" + e.getMessage());
        }
        
        request.getRequestDispatcher("/management/userManagement.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
