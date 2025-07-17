package domain;

/**
 * @ClassName: Score.java
 * @Description: 对应数据库中的score表，记录用户对电影的评分
 * @author: zhuhaipeng
 * @version: V1.0
 * @Date: 2019年10月25日 下午9:07:51
 */
public class Score {
    /**
     * 用户评分的电影id
     */
    private int movieId;
    /**
     * 对电影进行评分的用户id
     */
    private int userId;
    /**
     * 用户对电影的评分
     */
    private int score;

    public int getMovieId() {
        return movieId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    @Override
    public String toString() {
        return "Score [movieId=" + movieId + ", userId=" + userId + ", score=" + score + "]";
    }

}
