package service;

import dao.MovieDao;
import domain.Movie;

import java.sql.SQLException;
import java.util.List;

/**
 * @ClassName: MovieService.java
 * @Description: 与电影相关的业务逻辑处理
 * @author: zhuhaipeng
 * @version: V1.0
 * @Date: 2019年10月26日 下午10:41:45
 */
public class MovieService {
    private MovieDao dao = new MovieDao();

    /**
     * @return
     * @Description: TODO(获取所有电影)
     */
    public List<Movie> findAllMovies() throws SQLException {
        return dao.findAllMovies();
    }

    /**
     * @param params 电影种类
     * @return 电影集合
     * @Description: 获取对应种类的12部电影
     */
    public List<Movie> findMoviesByTypeWithLimit(Object... params) throws SQLException {
        return dao.findMoviesByCategoryWithLimit(params);
    }


    /**
     * 根据电影种类和年份查找电影
     *
     * @param year     电影年份
     * @param category 电影种类
     * @param page     当前显示页
     * @return java.util.List<domain.Movie>
     * @author GGBOY
     * @date 2019/11/7
     */
    public List<Movie> findMoviesByYearAndCategory(String category, String year, int page) throws SQLException {
        return dao.findMovieByYearAndCatrgory(category, year, page);
    }

    /**
     * @param movie 被添加的电影
     * @Description: TODO(添加电影)
     */
    public void addMovie(Movie movie) throws SQLException {
        dao.addMovie(movie);
    }

    /**
     * @param movieName 要被删除电影的电影名
     * @Description: TODO(根据电影名删除电影)
     */
    public void deleteMovieByName(String movieName) throws SQLException {
        dao.deleteMovieByName(movieName);
    }

    /**
     * @param movie 被更新的电影
     * @Description: TODO(更新电影信息)
     */
    public void updateMovie(Movie movie, String originName) throws SQLException {
        dao.updateMovie(movie, originName);
    }

    /**
     * 根据电影名查找电影
     *
     * @param movieName 电影名
     * @return domain.Movie
     * @author GGBOY
     * @date 2019/11/15
     */
    public Movie findMovieByName(String movieName) throws SQLException {
        return dao.findMovieByName(movieName);
    }


    /**
     * 获取对应种类电影的部分数据，从第几行开始取决于page
     *
     * @param type 电影种类
     * @param page 分页数
     * @return 电影集合
     */
    public List<Movie> findMoviesWithTypeAndPage(String type, int page) throws SQLException {
        return dao.findMoviesWithTypeAndPage(type, page);
    }

    /**
     * 查找对应年份和种类的电影数量
     *
     * @param type 电影种类
     * @param year 电影年份
     * @return int 电影数量
     * @author GGBOY
     * @date 2019/11/7
     */
    public int findMoviesCountByTypeAndYear(String type, String year) throws SQLException {
        return dao.findMoviesCountByTypeAndYear(type, year);
    }

    /**
     * 根据电影出版国家和种类来查找电影
     *
     * @param country  电影国家
     * @param category 电影种类
     * @return java.util.List<domain.Movie>
     * @author GGBOY
     * @date 2019/11/8
     */
    public List<Movie> findMoviesByCountryAndCategory(String country, String category, int page) throws SQLException {
        return dao.findMoviesByCountryAndCategory(country, category, page);
    }


    /**
     * 根据电影出版国家，年份和所属类型来查找对应的电影
     *
     * @param country  电影国家
     * @param category 电影种类
     * @param year     电影上映年份
     * @return java.util.List<domain.Movie>
     * @author GGBOY
     * @date 2019/11/8
     */
    public List<Movie> findMoviesByCountryAndYearAndCategory(String country, String category, String year, int page) throws SQLException {
        return dao.findMoviesByCountryAndYearAndCategory(country, category, year, page);
    }


    /**
     * 查找符合年份、评分和种类的电影
     *
     * @param year     电影上映年份
     * @param score    电影评分
     * @param category 电影种类
     * @return java.util.List<domain.Movie>
     * @author GGBOY
     * @date 2019/11/9
     */
    public List<Movie> findMoviesByYearAndScoreAndCategory(String year, String score, String category, int page) throws SQLException {
        return dao.findMoviesByYearAndScoreAndCategory(year, score, category, page);
    }

    /**
     * 查找符合年份、评分和种类的电影
     *
     * @param country  电影上映国家
     * @param score    电影评分
     * @param category 电影种类
     * @return java.util.List<domain.Movie>
     * @author GGBOY
     * @date 2019/11/9
     */
    public List<Movie> findMoviesByCountryAndScoreAndCategory(String country, String score, String category, int page) throws SQLException {
        return dao.findMoviesByCountryAndScoreAndCategory(country, score, category, page);
    }

    /**
     * 查找符合年份、评分和种类的电影
     *
     * @param year     电影上映年份
     * @param country  电影上映国家
     * @param score    电影评分
     * @param category 电影种类
     * @return java.util.List<domain.Movie>
     * @author GGBOY
     * @date 2019/11/9
     */
    public List<Movie> findMoviesByYearAndCountryAndScoreAndCategory(String year, String country, String score,
                                                                     String category, int page) throws SQLException {
        return dao.findMoviesByYearAndCountryAndScoreAndCategory(year, country, score, category, page);
    }

    /**
     * 查找符合评分和种类条件的电影
     *
     * @param score    电影评分
     * @param category 电影种类
     * @param page     当前显示页数
     * @return java.util.List<domain.Movie>
     * @author GGBOY
     * @date 2019/11/10
     */
    public List<Movie> findMoviesByScoreAndCategory(String score, String category, int page) throws SQLException {
        return dao.findMoviesByScoreAndCategory(score, category, page);
    }

    /**
     * 根据电影出版国家，年份和所属类型来统计符合条件的电影数量
     *
     * @param country  电影国家
     * @param category 电影种类
     * @param year     电影上映年份
     * @return 符合条件的电影数量
     * @author GGBOY
     * @date 2019/11/8
     */
    public int getMoviesCountByCountryAndYearAndCategory(String country, String category, String year) throws SQLException {
        return dao.getMoviesCountByCountryAndYearAndCategory(country, category, year);
    }

    /**
     * 统计符合年份和评分、种类条件的电影数量
     *
     * @param year     电影上映年份
     * @param score    电影评分
     * @param category 电影种类
     * @return int
     * @author GGBOY
     * @date 2019/11/10
     */
    public int getMoviesCountByYearAndScoreAndCategory(String year, String score, String category) throws SQLException {
        return dao.getMoviesCountByYearAndScoreAndCategory(year, score, category);
    }

    /**
     * 统计符合国家和评分、种类条件的电影数量
     *
     * @param country  电影国家
     * @param score    电影评分
     * @param category 电影种类
     * @return int
     * @author GGBOY
     * @date 2019/11/10
     */
    public int getMoviesCountByCountryAndScoreAndCategory(String country, String score, String category) throws SQLException {
        return dao.getMoviesCountByCountryAndYearAndCategory(country, score, category);
    }

    /**
     * 统计符合年份、国家、评分和种类条件的电影数量
     *
     * @param year     电影上映年份
     * @param country  电影国家
     * @param score    电影评分
     * @param category 电影种类
     * @return int
     * @author GGBOY
     * @date 2019/11/10
     */
    public int getMoviesCountByYearAndCountryAndScoreAndCategory(String year, String country, String score, String category) throws SQLException {
        return dao.getMoviesCountByYearAndCountryAndScoreAndCategory(year, country, score, category);
    }

    /**
     * 统计符合评分和种类的电影数量
     *
     * @param score    电影评分
     * @param category 电影种类
     * @return int
     * @author GGBOY
     * @date 2019/11/10
     */
    public int getMoviesCountByScoreAndCategory(String score, String category) throws SQLException {
        return dao.getMoviesCountByScoreAndCategory(score, category);
    }

    /**
     * 统计对应电影种类和出版国家的电影数量
     *
     * @param country  电影国家
     * @param category 电影种类
     * @return int
     * @author GGBOY
     * @date 2019/11/8
     */
    public int getMoviesCountByCountryAndCategory(String country, String category) throws SQLException {
        return dao.getMoviesCountByCountryAndCategory(country, category);
    }

    /**
     * 获取对应种类电影的数量
     *
     * @param category 电影种类
     * @return 返回对应电影种类的数量
     */
    public int getMoviesCountByCategory(String category) throws SQLException {
        return dao.findMoviesNumberByCategory(category);
    }

    /**
     * 得到电影的所有数量
     *
     * @return int
     * @author GGBOY
     * @date 2019/11/25
     */
    public int getMaxMovieId() throws SQLException {
        return dao.getMaxMovieId();
    }
}
