package web.servlet.client;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.mysql.cj.log.Log;
import domain.Movie;
import org.apache.log4j.Logger;
import service.MovieService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;


/**
 * 处理通过ajax传递过来的各种异步请求
 */
@WebServlet(urlPatterns = "/updateData")
public class UpdateDataServlet extends HttpServlet {
    static Logger logger = Logger.getLogger(UpdateDataServlet.class);
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /*request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");*/

        String nextPage = request.getParameter("page");
        String category = request.getParameter("type");
        String choose = request.getParameter("choose");
        String year = request.getParameter("year");
        String country = request.getParameter("country");
        String score = request.getParameter("score");

        logger.warn("nextPage:" + nextPage + " choose:" + choose + " category:" + category
                + " year:" + year + " country: " + country + " score:" + score);
        int page = Integer.parseInt(nextPage);
        MovieService service = new MovieService();

        switch (choose) {
            case "Y":
                // 如果是选择年份触发的ajax事件
                chooseYear(response, page, category, year, service);
                break;
            case "G":
                // 如果是选择国家触发的ajax事件
                chooseCountry(response, page, category, country, service);
                break;
            case "S":
                // 如果是选择评分触发的ajax事件
                chooseScore(response, page, category, score, service);
                break;
            case "YG":
                // 如果是选择年份和国家触发的ajax事件
                chooseCountryAndYear(response, page, category, year, country, service);
                break;
            case "YS":
                // 如果是选择年份和评分触发的ajax事件
                chooseYearAndScore(response, page, category, year, score, service);
                break;
            case "GS":
                // 如果是选择国家和评分触发的ajax事件
                chooseCountryAndScore(response, page, category, score, country, service);
                break;
            case "YGS":
                // 如果是选择年份、国家和评分触发的ajax事件
                chooseYearAndCountryAndScore(response, page, category, year, country, score, service);
                break;
            case "none":
                // 如果是三者都没选择触发的ajax事件，即单纯的请求下一页
                showNextData(response, page, category, service);
                break;
            default:
                break;
        }


    }

    private void chooseScore(HttpServletResponse response, int page, String category, String score, MovieService service) {
        try {
            List<Movie> list = service.findMoviesByScoreAndCategory(score, category, page);
            int pageTotal = service.getMoviesCountByScoreAndCategory(score, category);
            outputToFront(response, list, pageTotal);
        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
    }


    private void chooseYearAndScore(HttpServletResponse response, int page, String category, String year, String score, MovieService service) {
        try {
            List<Movie> list = service.findMoviesByYearAndScoreAndCategory(year, score, category, page);
            int pageTotal = service.getMoviesCountByYearAndScoreAndCategory(year, score, category);
            outputToFront(response, list, pageTotal);
        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
    }

    private void chooseCountryAndScore(HttpServletResponse response, int page, String category, String score, String country, MovieService service) {
        try {
            List<Movie> list = service.findMoviesByCountryAndScoreAndCategory(country, score, category, page);
            int pageTotal = service.getMoviesCountByCountryAndScoreAndCategory(country, score, category);
            outputToFront(response, list, pageTotal);
        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
    }

    private void chooseYearAndCountryAndScore(HttpServletResponse response, int page, String category, String year, String country, String score, MovieService service) {
        try {
            List<Movie> list = service.findMoviesByYearAndCountryAndScoreAndCategory(year, country, score, category, page);
            int pageTotal = service.getMoviesCountByYearAndCountryAndScoreAndCategory(year, country, score, category);
            outputToFront(response, list, pageTotal);
        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
    }


    private void chooseCountryAndYear(HttpServletResponse response, int page, String category, String year, String country, MovieService service) throws IOException {
        try {
            List<Movie> list = service.findMoviesByCountryAndYearAndCategory(country, category, year, page);
            int pageTotal = service.getMoviesCountByCountryAndYearAndCategory(country, category, year);
            outputToFront(response, list, pageTotal);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void chooseCountry(HttpServletResponse response, int page, String category, String country, MovieService service) throws IOException {
        try {
            List<Movie> list = service.findMoviesByCountryAndCategory(country, category, page);
            int pageTotal = service.getMoviesCountByCountryAndCategory(country, category);
            outputToFront(response, list, pageTotal);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void chooseYear(HttpServletResponse response, int page, String category, String year, MovieService service) throws IOException {
        try {
            List<Movie> list = service.findMoviesByYearAndCategory(category, year, page);
            int pageTotal = service.findMoviesCountByTypeAndYear(category, year);
            outputToFront(response, list, pageTotal);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 将数据传递给前端
     *
     * @param response  响应对象
     * @param list      输出的集合
     * @param pageTotal 符合查询结果的数量
     * @author GGBOY
     * @date 2019/11/9
     */
    private void outputToFront(HttpServletResponse response, List<Movie> list, int pageTotal) throws IOException {
        System.out.println("PageTotal: " + pageTotal);
        JSONArray jsonArray = JSONArray.parseArray(JSON.toJSONString(list));
        String result = jsonArray.toJSONString() + "|" + pageTotal;
        // 获取输出流
        PrintWriter writer = response.getWriter();
        writer.write(result);
        writer.close();
    }

    /**
     * 处理分页数据请求
     *
     * @param response 响应
     * @param page     下一页
     * @param category 种类
     * @throws IOException I/O 异常
     */
    private void showNextData(HttpServletResponse response, int page, String category, MovieService service) throws IOException {
        try {
            // 得到下一页要显示的数据
            List<Movie> movieList = service.findMoviesWithTypeAndPage(category, page);

            JSONArray jsonArray = JSONArray.parseArray(JSON.toJSONString(movieList));
            // 获取输出流
            PrintWriter writer = response.getWriter();
            writer.write(jsonArray.toJSONString());
            writer.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

}
