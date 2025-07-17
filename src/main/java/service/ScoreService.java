package service;

import dao.ScoreDao;

/**
 * @ClassName: ScoreService.java
 * @Description: TODO(处理与分数相关的业务逻辑)
 * @author: zhuhaipeng
 * @version: V1.0
 * @Date: 2019年10月27日 下午5:05:18
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
