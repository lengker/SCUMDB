package service;

import dao.CommentDao;
import domain.Comment;

import java.sql.SQLException;
import java.util.List;

/**
 * @ClassName: CommentService
 * @Description: 有关评论的业务操作
 * @Version: 1.0
 **/
public class CommentService {
    private final CommentDao dao = new CommentDao();

    /**
     * 添加一条评论
     *
     * @param comment 评论对象
     */
    public void addComment(Comment comment) throws SQLException {
        dao.addComment(comment);
    }

    /**
     * 查找对应电影名的所有评论
     *
     * @param movieName 电影名
     * @return java.util.List<domain.Comment>
     */
    public List<Comment> findCommentsByMovieName(String movieName) throws SQLException {
        return dao.findCommentsByMovieName(movieName);
    }

    /**
     * 分页查找对应电影名的评论
     *
     * @param movieName 电影名
     * @param page      页码（从1开始）
     * @param pageSize  每页数量
     * @return 评论列表
     */
    public List<Comment> findCommentsByMovieNameWithPaging(String movieName, int page, int pageSize) throws SQLException {
        return dao.findCommentsByMovieNameWithPaging(movieName, page, pageSize);
    }

    /**
     * 获取指定电影的评论总数
     *
     * @param movieName 电影名
     * @return 评论总数
     */
    public int getCommentsCountByMovieName(String movieName) throws SQLException {
        return dao.getCommentsCountByMovieName(movieName);
    }
}
