package web.servlet.client;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import domain.Comment;
import service.CommentService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(urlPatterns = "/commentPage.do")
public class CommentPageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        String movieName = request.getParameter("movieName");
        String pageStr = request.getParameter("page");
        String pageSizeStr = request.getParameter("pageSize");

        int page = pageStr != null ? Integer.parseInt(pageStr) : 1;
        int pageSize = pageSizeStr != null ? Integer.parseInt(pageSizeStr) : 5;

        CommentService service = new CommentService();
        Map<String, Object> result = new HashMap<>();

        try {
            // 获取分页评论数据
            List<Comment> comments = service.findCommentsByMovieNameWithPaging(movieName, page, pageSize);
            // 获取总评论数
            int totalComments = service.getCommentsCountByMovieName(movieName);
            // 计算总页数
            int totalPages = (int) Math.ceil((double) totalComments / pageSize);

            // 为了确保日期格式正确，我们手动格式化日期
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            for (Comment comment : comments) {
                if (comment.getAddTime() != null) {
                    System.out.println("原始日期: " + comment.getAddTime());
                    System.out.println("格式化日期: " + sdf.format(comment.getAddTime()));
                }
            }

            result.put("success", true);
            result.put("comments", comments);
            result.put("currentPage", page);
            result.put("pageSize", pageSize);
            result.put("totalComments", totalComments);
            result.put("totalPages", totalPages);

        } catch (SQLException e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "获取评论数据失败");
        }

        PrintWriter writer = response.getWriter();
        // 使用WriteDateUseDateFormat来确保日期格式化
        writer.write(JSON.toJSONString(result, SerializerFeature.WriteDateUseDateFormat));
        writer.flush();
        writer.close();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
