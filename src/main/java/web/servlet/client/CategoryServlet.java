package web.servlet.client;

import domain.Movie;
import org.apache.log4j.Logger;
import service.MovieService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(urlPatterns = "/category.do")
public class CategoryServlet extends HttpServlet {
    static Logger logger = Logger.getLogger(CategoryServlet.class);
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String category = request.getParameter("category");
        MovieService service = new MovieService();

        if (!"".equals(category)) {
            logger.warn(category);
            try {
                double numbers = service.getMoviesCountByCategory(category);
                List<Movie> movies = service.findMoviesByTypeWithLimit(category);

                int pageTotal = (int) (Math.ceil(numbers / 12));
                logger.warn("有： " + pageTotal + "页");

                // 将电影集合和当前页数存储在request中，便于在页面中使用
                request.setAttribute("movies", movies);
                request.setAttribute("pageNumber", pageTotal);

            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        request.getRequestDispatcher("/category.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
