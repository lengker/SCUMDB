package dao;

import domain.History;
import domain.Movie;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ArrayListHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import utils.DataSourceUtils;

import java.sql.SQLException;
import java.util.List;

public class HistoryDao {


    /**
     * @param userId    用户 id
     * @param movieName 电影名
     * @throws SQLException
     * @Description: 添加一条浏览记录, 如果存在则忽略
     */
    public void addRecord(int userId, String movieName) throws SQLException {
        String sql = "INSERT IGNORE INTO history (movieName, userid) values(?,?) ";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        runner.update(sql, movieName, userId);

    }


    public List<History> getRecords(int userId) throws SQLException {
        String sql = "select * from history where userid = ? ORDER BY addTime desc";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        return runner.query(sql, new BeanListHandler<>(History.class), userId);
    }


}
