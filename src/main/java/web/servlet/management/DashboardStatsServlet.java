package web.servlet.management;

import com.fasterxml.jackson.databind.ObjectMapper;
import dao.ClickTimeDao;
import dao.MovieDao;
import dao.UserDao;
import domain.Movie;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/dashboardStats")
public class DashboardStatsServlet extends HttpServlet {
    private final MovieDao movieDao = new MovieDao();
    private final UserDao userDao = new UserDao();
    private final ClickTimeDao clickTimeDao = new ClickTimeDao();
    private final ObjectMapper mapper = new ObjectMapper();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, Object> stats = new HashMap<>();
        try {
            stats.put("movieCount", movieDao.getMoviesCount());
//            stats.put("movieCount", 554);
            stats.put("userCount", userDao.getUsersCount());
            stats.put("topMovies", clickTimeDao.getTopTenClickTimes());
            stats.put("movieTypeDistribution", movieDao.getMovieTypeDistribution());
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        mapper.writeValue(resp.getWriter(), stats);
    }
}