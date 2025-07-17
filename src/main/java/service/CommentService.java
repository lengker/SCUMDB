package service;

import dao.CommentDao;
import domain.Comment;

import java.sql.SQLException;
import java.util.List;

/**
 * @ClassName: CommentService
 * @Description: 有关评论的业务操作
 * @author: GGBOY
 * @date 2019/12/3 22:15
 * @Version: 1.0
 **/
public class CommentService {
    private final CommentDao dao = new CommentDao();

    /**
     * 添加一条评论
     *
     * @param comment 评论对象
     * @author GGBOY
     * @date 2019/12/3
     */
    public void addComment(Comment comment) throws SQLException {
        dao.addComment(comment);
    }

    /**
     * 查找对应电影名的所有评论
     *
     * @param movieName 电影名
     * @return java.util.List<domain.Comment>
     * @author GGBOY
     * @date 2019/12/4
     */
    public List<Comment> findCommentsByMovieName(String movieName) throws SQLException {
        return dao.findCommentsByMovieName(movieName);
    }
}
