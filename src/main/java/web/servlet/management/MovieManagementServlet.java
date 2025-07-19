package web.servlet.management;

import domain.Movie;
import service.MovieService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(urlPatterns = "/movieManagement")
public class MovieManagementServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

        MovieService service = new MovieService();

        // 获取筛选参数
        String type = request.getParameter("type");
        String years = request.getParameter("years");
        String country = request.getParameter("country");
        String minScore = request.getParameter("minScore");
        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder");

        try {
            List<Movie> movies;

            // 检查是否有任何筛选条件
            boolean hasFilters = (type != null && !type.trim().isEmpty()) ||
                               (years != null && !years.trim().isEmpty()) ||
                               (country != null && !country.trim().isEmpty()) ||
                               (minScore != null && !minScore.trim().isEmpty());

            if (hasFilters) {
                movies = service.findMoviesWithMultipleFilters(type, years, country, minScore, sortBy, sortOrder);
            } else {
                movies = service.findAllMovies();
                // 如果有排序要求，进行排序
                if (sortBy != null && !sortBy.isEmpty()) {
                    movies = service.sortMovies(movies, sortBy, sortOrder);
                }
            }

            request.setAttribute("allMovies", movies);
            request.setAttribute("filterType", type);
            request.setAttribute("filterYears", years);
            request.setAttribute("filterCountry", country);
            request.setAttribute("filterMinScore", minScore);
            request.setAttribute("sortBy", sortBy);
            request.setAttribute("sortOrder", sortOrder);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "数据库查询出错：" + e.getMessage());
        }

        request.getRequestDispatcher("/management/movieManagement.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
