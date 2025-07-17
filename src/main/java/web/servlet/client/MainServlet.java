package web.servlet.client;

import domain.Movie;
import org.apache.log4j.Logger;
import service.ClickTimeService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(urlPatterns = "/main.do")
public class MainServlet extends HttpServlet {
    static Logger logger = Logger.getLogger(MainServlet.class);
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        logger.warn("在线人数为：" +
                request.getServletContext().getAttribute("onlineNumber"));

        ClickTimeService service = new ClickTimeService();
        try {
            List<Movie> threeHotMovies = service.getThreeHotMovies();
            request.setAttribute("hotMovies", threeHotMovies);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // 单纯的跳转，改变网址
        request.getRequestDispatcher("main.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
