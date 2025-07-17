package service;

import dao.ClickTimeDao;
import domain.Movie;

import java.sql.SQLException;
import java.util.List;

public class ClickTimeService {
    private ClickTimeDao dao = new ClickTimeDao();

    /**
     * @param movieName
     * @throws SQLException
     * @Description: 更新对应电影名的点击次数
     */
    public void updateRecord(String movieName) throws SQLException {
        dao.updateRecord(movieName);
    }

    /**
     * @return
     * @throws SQLException
     * @Description: 查询数据库中点击次数最多的4部电影
     */
    public List<Movie> getHotMovies() throws SQLException {
        return dao.getHotMovies();
    }

    public List<Movie> getThreeHotMovies() throws SQLException {
        return dao.getThreeHotMovies();
    }
}
