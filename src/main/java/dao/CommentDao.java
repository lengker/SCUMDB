package dao;

import domain.Comment;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import utils.DataSourceUtils;

import java.sql.SQLException;
import java.util.List;

public class CommentDao {

    /**
     * @param userId
     * @param movieId
     * @return
     * @Description: TODO(根据用户Id和电影id查找评论)
     */
    public String findCommentByUserIdAndMovieId(int userId, int movieId) {
        return null;

    }

    /**
     * @param movieName 电影名
     * @return 返回评论集合
     * @Description: 根据电影名，查找该电影的所有评论
     */
    public List<Comment> findCommentsByMovieName(String movieName) throws SQLException {
        String sql = "select * from comments where movieName = ?  ORDER BY addTime DESC";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        return runner.query(sql, new BeanListHandler<>(Comment.class), movieName);
    }

    /**
     * 分页查找对应电影名的评论
     *
     * @param movieName 电影名
     * @param page 页码（从1开始）
     * @param pageSize 每页数量
     * @return 评论列表
     */
    public List<Comment> findCommentsByMovieNameWithPaging(String movieName, int page, int pageSize) throws SQLException {
        String sql = "select * from comments where movieName = ? ORDER BY addTime DESC LIMIT ?, ?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        int offset = (page - 1) * pageSize;
        return runner.query(sql, new BeanListHandler<>(Comment.class), movieName, offset, pageSize);
    }

    /**
     * 获取指定电影的评论总数
     *
     * @param movieName 电影名
     * @return 评论总数
     */
    public int getCommentsCountByMovieName(String movieName) throws SQLException {
        String sql = "select count(*) from comments where movieName = ?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        Long count = (Long) runner.query(sql, new ScalarHandler(), movieName);
        return count.intValue();
    }

    /**
     * 添加一条评论
     *
     * @param comment 评论对象
     */
    public void addComment(Comment comment) throws SQLException {
        String sql = "insert into comments(userName,movieName,description) values(?,?,?)";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        runner.update(sql, comment.getUserName(), comment.getMovieName(), comment.getDescription());
    }
}
