package dao;

import java.util.List;

/**
 * @ClassName: ScoreDao.java
 * @Description: TODO(处理与score表相关的操作)
 * @author: zhuhaipeng
 * @version: V1.0
 * @Date: 2019年10月27日 下午3:51:23
 */
public class ScoreDao {

    /**
     * @param userId    用户id
     * @param movieName 电影名
     * @return
     * @Description: TODO(根据用户id和电影名查找用户对该电影的评分)
     */
    public int findScore(int userId, String movieName) {
        return 0;
    }

    /**
     * @param movieName 电影名
     * @return
     * @Description: TODO(根据电影名 ， 查找所有用户对这部电影的评分)
     */
    public List<Integer> findALlScoreByMovieID(String movieName) {
        return null;
    }

    /**
     * @param userId    用户id
     * @param movieName 电影名
     * @param score     用户对电影的评分
     * @return
     * @Description: TODO(向数据库中添加用户对电影的评分)
     */
    public void addScore(int userId, String movieName, int score) {

    }

    /**
     * @param userId    用户id
     * @param movieName 电影名
     * @Description: TODO(更新用户对电影的评分)
     */
    public void updateScore(int userId, String movieName) {

    }
}
