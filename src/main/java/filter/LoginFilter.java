package filter;

import domain.User;
import exception.LoginException;
import org.apache.log4j.Logger;
import service.UserService;
import utils.MySessionContext;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 专门拦截登录请求的过滤器
 */
@WebFilter(filterName = "LoginFilter", urlPatterns = "/login.do")
public class LoginFilter implements Filter {
    static Logger logger = Logger.getLogger(LoginFilter.class);
    static String flag = "LoginFilter.............";

    @Override
    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        UserService service = new UserService();

        logger.warn(flag + username + " " + password);
        try {
            if (username != null && !"".equals(username)) {
                User user = service.login(username, password);
                if(user != null){
                    logger.warn(flag + " " + user.getId());
                    // 获得用户id对象的session对象
                    HttpSession session = MySessionContext.getSession(String.valueOf(user.getId()));
                    // 如果session对象不为空，则代表已经存在session对象，即已经有人登录过了
                    if (session != null) {
                        logger.warn(flag + "删除seesion");
                        // 将这个session对象删除
                        MySessionContext.delSession(session);
                    }
                }
            }
        } catch (LoginException e) {
            e.printStackTrace();
        }
        // 放行
        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig config) throws ServletException {

    }

}
