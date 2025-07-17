package web.servlet.client;

import domain.Comment;
import domain.Movie;
import domain.User;
import service.ClickTimeService;
import service.CommentService;
import service.HistoryService;
import service.MovieService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

@WebServlet(urlPatterns = "/detail.do")
public class DetailServlet extends HttpServlet {

    /**
     * The doGet method of the servlet. <br>
     * <p>
     * This method is called when a form has its tag value method equals to get.
     *
     * @param request  the request send by the client to the server
     * @param response the response send by the server to the client
     * @throws ServletException if an error occurred
     * @throws IOException      if an error occurred
     */
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /*request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");*/

        // 得到电影名
        String movieName = request.getParameter("movieName");
        System.out.println("movieName:" + movieName);
        MovieService service = new MovieService();
        try {
            // 查找这部电影
            Movie movie = service.findMovieByName(movieName);
            request.setAttribute("detail", movie);

        } catch (Exception e) {
            e.printStackTrace();

        }


        // 如果用户登录了，则将次电影记录到其历史记录中
        if (request.getSession().getAttribute("user") != null) {
            User user = (User) request.getSession().getAttribute("user");
            HistoryService hService = new HistoryService();
            try {
                hService.addRecord(user.getId(), movieName);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // 更新电影对应的被点击次数
        ClickTimeService cTimeService = new ClickTimeService();
        try {
            cTimeService.updateRecord(movieName);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            System.out.println("更新电影点击次数出错！！");
        }

        try {
            //  查询数据库中点击次数最多的电影作为热门电影
            List<Movie> hotMovies = cTimeService.getHotMovies();
            request.setAttribute("hotMovies", hotMovies);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }


        // 查找评论
        CommentService commentService = new CommentService();
        try {
            List<Comment> comments = commentService.findCommentsByMovieName(movieName);
            request.setAttribute("comments", comments);

            request.setAttribute("commentsSize", (int) Math.ceil((double)comments.size() / 4));
            System.out.println("评论数量：" + comments.size());
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("/detail.jsp").forward(request, response);
    }

    /**
     * The doPost method of the servlet. <br>
     * <p>
     * This method is called when a form has its tag value method equals to post.
     *
     * @param request  the request send by the client to the server
     * @param response the response send by the server to the client
     * @throws ServletException if an error occurred
     * @throws IOException      if an error occurred
     */
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        doGet(request, response);
    }

}
