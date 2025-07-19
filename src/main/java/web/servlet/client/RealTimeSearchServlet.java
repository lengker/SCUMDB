package web.servlet.client;

import com.alibaba.fastjson.JSON;
import domain.Movie;
import service.SearchService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * @ClassName: RealTimeSearchServlet.java
 * @Description: 处理实时搜索的AJAX请求
 * @version: V1.0
 */
@WebServlet(urlPatterns = "/realtimeSearch.do")
public class RealTimeSearchServlet extends HttpServlet {

  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    doPost(request, response);
  }

  @Override
  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    request.setCharacterEncoding("utf-8");
    response.setContentType("application/json;charset=utf-8");

    String searchTerm = request.getParameter("search");

    System.out.println("搜索关键词: " + searchTerm); // 调试信息

    if (searchTerm == null || searchTerm.trim().isEmpty()) {
      System.out.println("搜索关键词为空"); // 调试信息
      response.getWriter().write("[]");
      return;
    }

    SearchService service = new SearchService();
    List<Movie> movies;

    try {
      movies = service.search(searchTerm.trim());
      System.out.println("搜索结果数量: " + movies.size()); // 调试信息
      // 限制返回结果数量，避免返回过多数据
      if (movies.size() > 8) {
        movies = movies.subList(0, 8);
      }

      // 转换为JSON格式返回
      String jsonResult = JSON.toJSONString(movies);
      response.getWriter().write(jsonResult);

    } catch (SQLException e) {
      e.printStackTrace();
      response.getWriter().write("[]");
    }
  }
}