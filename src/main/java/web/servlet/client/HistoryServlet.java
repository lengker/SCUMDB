package web.servlet.client;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import domain.History;
import domain.User;
import org.apache.log4j.Logger;
import service.HistoryService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

/**
 * 处理与用户浏览记录相关的请求、事件的 Servlet
 */
@WebServlet(name = "HistoryServlet", urlPatterns = "/history.do")
public class HistoryServlet extends HttpServlet {
    static Logger logger = Logger.getLogger(HistoryServlet.class);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String movieName = request.getParameter("movieName");
        String userName = request.getParameter("userName");

        logger.warn(movieName + "   " + userName);

        HistoryService service = new HistoryService();
        User user = (User) request.getSession().getAttribute("user");

        try {
            List<History> list = service.getRecords(user.getId());
            logger.warn("history-->" + list.size());
            JSONArray jsonArray = JSONArray.parseArray(JSON.toJSONString(list));
            String result = jsonArray.toJSONString();
            // 获取输出流
            PrintWriter writer = response.getWriter();
            writer.write(result);
            writer.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
