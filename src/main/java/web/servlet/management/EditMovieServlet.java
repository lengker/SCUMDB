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

@WebServlet(urlPatterns = "/editMovie")
public class EditMovieServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        
        String movieName = request.getParameter("movieName");
        
        if (movieName == null || movieName.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/movieManagement");
            return;
        }
        
        MovieService service = new MovieService();
        try {
            Movie movie = service.findMovieByName(movieName);
            if (movie != null) {
                request.setAttribute("movie", movie);
                request.getRequestDispatcher("/management/editMovie.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "电影不存在");
                response.sendRedirect(request.getContextPath() + "/movieManagement");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "数据库查询出错：" + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/movieManagement");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        
        String originalName = request.getParameter("originalName");
        String name = request.getParameter("name");
        String scoreStr = request.getParameter("score");
        String director = request.getParameter("director");
        String scriptwriter = request.getParameter("scriptwriter");
        String actor = request.getParameter("actor");
        String years = request.getParameter("years");
        String country = request.getParameter("country");
        String languages = request.getParameter("languages");
        String lengthStr = request.getParameter("length");
        String image = request.getParameter("image");
        String des = request.getParameter("des");
        String url = request.getParameter("url");
        String type = request.getParameter("type");
        
        // 验证必填字段
        if (originalName == null || originalName.trim().isEmpty() ||
            name == null || name.trim().isEmpty()) {
            request.setAttribute("error", "电影名称不能为空");
            doGet(request, response);
            return;
        }
        
        try {
            Movie movie = new Movie();
            movie.setName(name.trim());
            movie.setDirector(director != null ? director.trim() : "");
            movie.setScriptwriter(scriptwriter != null ? scriptwriter.trim() : "");
            movie.setActor(actor != null ? actor.trim() : "");
            movie.setYears(years != null ? years.trim() : "");
            movie.setCountry(country != null ? country.trim() : "");
            movie.setLanguages(languages != null ? languages.trim() : "");
            movie.setImage(image != null ? image.trim() : "");
            movie.setDes(des != null ? des.trim() : "");
            movie.setUrl(url != null ? url.trim() : "");
            movie.setType(type != null ? type.trim() : "");
            
            // 处理评分
            if (scoreStr != null && !scoreStr.trim().isEmpty()) {
                try {
                    movie.setScore((int) Double.parseDouble(scoreStr.trim()));
                } catch (NumberFormatException e) {
                    movie.setScore(0);
                }
            } else {
                movie.setScore(0);
            }

            // 处理片长
            if (lengthStr != null && !lengthStr.trim().isEmpty()) {
                try {
                    movie.setLength(lengthStr.trim());
                } catch (NumberFormatException e) {
                    movie.setLength("0");
                }
            } else {
                movie.setLength("0");
            }
            
            MovieService service = new MovieService();
            service.updateMovie(movie, originalName.trim());
            
            // 重定向到电影管理页面
            response.sendRedirect(request.getContextPath() + "/movieManagement?success=edit");
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "更新电影信息失败：" + e.getMessage());
            doGet(request, response);
        }
    }
}
