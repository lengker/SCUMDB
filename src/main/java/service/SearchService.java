package service;

import dao.MovieDao;
import domain.Movie;

import java.sql.SQLException;
import java.util.List;

/**
 * @ClassName: SearchService.java
 * @Description: TODO(处理电影的搜索)
 * @author: zhuhaipeng
 * @version: V1.0
 * @Date: 2019年10月30日 下午3:44:54
 */
public class SearchService {
    private MovieDao movieDao = new MovieDao();

    /**
     * @param condition 查找条件
     * @return
     * @throws SQLException
     * @Description: TODO(根据电影名模糊查找电影)
     */
    public List<Movie> search(String condition) throws SQLException {
        return movieDao.findMoviesByDimName(condition);
    }
}
