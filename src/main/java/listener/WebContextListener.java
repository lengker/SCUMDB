package listener;

import domain.Movie;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import service.ClickTimeService;
import utils.StoreDataUtil;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

/**
 * 监听项目的生命活动
 */
@WebListener
public class WebContextListener implements ServletContextListener {
    static Logger logger = Logger.getLogger(WebContextListener.class);
    /**
     * Default constructor.
     */
    public WebContextListener() {

        // TODO Auto-generated constructor stub
    }

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        logger.setLevel(Level.WARN);

        logger.warn("正在查询");

        // 服务器一启动，向数据库中查询特定数据
        StoreDataUtil storeDataUtil = StoreDataUtil.getInstance();
        // 获取数据
        Map<String, List<Movie>> map = storeDataUtil.getMovies();
        logger.warn("map大小为： " + map.size());
        sce.getServletContext().setAttribute("data", map);


        ClickTimeService service = new ClickTimeService();
        try {
            List<Movie> threeHotMovies = service.getThreeHotMovies();
            sce.getServletContext().setAttribute("hotMovies", threeHotMovies);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // TODO Auto-generated method stub
        ServletContextListener.super.contextDestroyed(sce);
    }

}
