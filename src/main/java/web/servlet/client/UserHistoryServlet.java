package web.servlet.client;

import domain.History;
import domain.Movie;
import domain.User;
import org.apache.log4j.Logger;
import service.HistoryService;
import service.MovieService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = "/history")
public class UserHistoryServlet extends HttpServlet {
    private Logger logger = Logger.getLogger(UserHistoryServlet.class);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      /*  request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");*/

        HistoryService service = new HistoryService();
        MovieService movieService = new MovieService();

        User user = (User) request.getSession().getAttribute("user");

        List<History> records = null;
        try {
            records = service.getRecords(user.getId());
            List<Movie> movies = new ArrayList<>();
            for (History history : records) {
                movies.add(movieService.findMovieByName(history.getMovieName()));
            }
            request.setAttribute("histories", movies);
            request.getRequestDispatcher("userHistory.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();

        }


    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
