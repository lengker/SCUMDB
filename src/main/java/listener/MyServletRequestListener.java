package listener;

import domain.Visitor;
import utils.SessionUtil;

import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

@WebListener()
public class MyServletRequestListener implements ServletRequestListener {
    //用户集合
    private ArrayList<Visitor> visitors;


    @Override
    public void requestInitialized(ServletRequestEvent sre) {
        //从servletContext中获的userList
        visitors = (ArrayList<Visitor>) sre.getServletContext().getAttribute("userList");
        //如果servletContext中没有userList对象  初始化userList
        if (visitors == null) {
            visitors = new ArrayList<Visitor>();
        }
        HttpServletRequest request = (HttpServletRequest) sre.getServletRequest();

        //sessionId
        String sessionId = request.getSession().getId();
        //如果当前sessionId不存在集合中  创建当前user对象
        if (SessionUtil.getUserBySessionId(visitors, sessionId) == null) {
            if(!"0:0:0:0:0:0:0:1".equals(getIpAddress(request))){
                Visitor visitor = new Visitor();
                visitor.setSessionId(sessionId);
                visitor.setIp(getIpAddress(request));
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd  hh:mm:ss");
                String time = sdf.format(new Date());
                visitor.setFirstTime(time);
                visitors.add(visitor);
            }

        }
        //将userList集合 保存到ServletContext
        sre.getServletContext().setAttribute("userList", visitors);
    }

    public static String getIpAddress(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        if (ip.contains(",")) {
            return ip.split(",")[0];
        } else {
            return ip;
        }
    }

}
