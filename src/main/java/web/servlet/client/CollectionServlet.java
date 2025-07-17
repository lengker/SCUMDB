package web.servlet.client;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import domain.Collection;
import org.apache.log4j.Logger;
import service.CollectionService;

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
 * 处理与用户收藏相关请求、事件的Servlet
 */
@WebServlet(urlPatterns = "/collection.do")
public class CollectionServlet extends HttpServlet {
    private Logger logger = Logger.getLogger(CollectionServlet.class);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String movieName = request.getParameter("movieName");
        String userName = request.getParameter("userName");

        logger.warn(movieName + "   " + userName);

        CollectionService service = new CollectionService();

        // 如果只传递过来用户名,表示获取用户的收藏电影记录
        if (movieName == null || "".equals(movieName)) {
            try {
                List<Collection> list = service.findAllRecordByUserName(userName);
                logger.warn("collection-->" + list.size());
                JSONArray jsonArray = JSONArray.parseArray(JSON.toJSONString(list));
                String result = jsonArray.toJSONString();
                // 获取输出流
                PrintWriter writer = response.getWriter();
                writer.write(result);
                writer.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else {
            // 如果电影名和用户名都传递过来，则表示添加一条用户收藏记录
            try {
                service.addUserCollectionMovie(userName, movieName);
            } catch (SQLException e) {
                e.printStackTrace();
                logger.warn(e.getMessage() + "添加收藏出错");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
