package listener;

import domain.Visitor;
import utils.SessionUtil;

import javax.servlet.ServletRequestListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.util.ArrayList;

/**
 * 监听在线用户数量
 *
 * @author zhuhaipeng
 * @version 1.0
 */
@WebListener()
public class OnlineUserListener implements ServletRequestListener,
        HttpSessionListener {
    private int visiterCount = 0;

    // Public constructor is required by servlet spec
    public OnlineUserListener() {
    }


    // -------------------------------------------------------
    // HttpSessionListener implementation
    // -------------------------------------------------------
    @Override
    public void sessionCreated(HttpSessionEvent se) {
        /* Session is created. */
        // 创建了一个session,就将访问人数加一
        visiterCount++;
        se.getSession().getServletContext().setAttribute("onlineNumber", visiterCount);

    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        /* Session is destroyed. */
        // 销毁了一个session,就将访问人数减一
        visiterCount--;
        se.getSession().getServletContext().setAttribute("onlineNumber", visiterCount);

        ArrayList<Visitor> visitors = (ArrayList<Visitor>) se.getSession().getServletContext().getAttribute("userList");
        String sessionId = se.getSession().getId();
        //如果当前用户在userList中  在session销毁时  将当前用户移出userList
        if (SessionUtil.getUserBySessionId(visitors, sessionId) != null) {
            visitors.remove(SessionUtil.getUserBySessionId(visitors, sessionId));
        }
        //将userList集合  重新保存到servletContext
        se.getSession().getServletContext().setAttribute("userList", visitors);

    }

}
