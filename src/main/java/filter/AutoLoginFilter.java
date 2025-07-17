package filter;

import domain.User;
import exception.LoginException;
import org.apache.log4j.Logger;
import service.UserService;
import utils.MySessionContext;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 用于自动登录以及控制用户登录（即只允许的多ip，单用户登录）的过滤器
 */
@WebFilter(filterName = "AutoLoginFilter", urlPatterns = {"*.do", "*.jsp"})
public class AutoLoginFilter implements Filter {
    static Logger logger = Logger.getLogger(AutoLoginFilter.class);

    @Override
    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        logger.warn("AutoLoginFilter............" + request.getRequestURI());

        // 获得自动登录的cookie
        Cookie[] cookies = request.getCookies();
        String autoLogin = null;
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("autoLogin".equals(cookie.getName())) {
                    // 找到了指定的 cookie
                    autoLogin = cookie.getValue();
                    break;
                }
            }
        }
        // 判断session是否无效，如果无效则跳转到登录界面
        if (request.getSession().getAttribute("msg") != null) {
            request.getSession().removeAttribute("msg");
            System.out.println("session无效，重新登录");
            // 从客户端删除自动登录 cookie,防止用户通过回退键可以回去
            Cookie cookie = new Cookie("autoLogin", "msg");
            cookie.setPath(request.getContextPath());
            // 设置 cookie有效时间为0，表示通知浏览器立即删除这个cookie
            cookie.setMaxAge(0);
            response.addCookie(cookie);
            synchronized (this) {
                // 使当前登录用户的session失效，即被踢下线
                request.getSession().invalidate();
                request.getServletContext().setAttribute("msg", "你已被踢下线！！！");
                // 跳转到登录界面重新登录
                response.sendRedirect("loginOrRegister.do");
            }
        } else {
            // 如果没有登录，则自动登录
            if (autoLogin != null && (request.getSession().getAttribute("user") == null)) {
                logger.warn("自动登录！");
                // 做自动登录
                String[] parts = autoLogin.split("-");
                String username = parts[0];
                String password = parts[1];
                // 检查用户名和密码
                UserService service = new UserService();
                try {
                    User user = service.login(username, password);
                    synchronized (this) {
                        if (user != null) {
                            HttpSession session = MySessionContext.getSession(String.valueOf(user.getId()));
                            // 如果能获取到Session，就说明这个账号已经被登录或者这个Session还没失效，那么
                            // 下面要把这个Session失效，替换为新的Session
                            if (session != null) {
                                MySessionContext.delSession(session);
                            }
                            request.getSession().setAttribute("user", user);
                            request.getSession().setAttribute("userId", String.valueOf(user.getId()));
                            MySessionContext.addSession(request.getSession());
                        }
                    }
                } catch (LoginException e) {
                    e.printStackTrace();
                }
            }

            // 放行，让后续的过滤器再进行处理
            chain.doFilter(request, resp);
        }

    }

    @Override
    public void init(FilterConfig config) throws ServletException {

    }

}
