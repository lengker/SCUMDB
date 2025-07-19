package service;

import dao.ScoreDao;

/**
 * @ClassName: ScoreService.java
 * @Description: TODO(处理与分数相关的业务逻辑)
 * @version: V1.0
 */
public class ScoreService {
    ScoreDao dao = new ScoreDao();

    /**
     * @param userId    用户 id
     * @param movieName 电影名
     * @param score     分数
     * @Description: TODO(对电影进行评分)
     */
    public void addScore(int userId, String movieName, int score) {
        dao.addScore(userId, movieName, score);
    }
}
