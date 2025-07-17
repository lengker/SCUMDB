package domain;

import java.util.Date;

/**
 * @ClassName: History.java
 * @Description: 对应数据库中的history表，记录用户的观看历史
 * @author: zhuhaipeng
 * @version: V1.0
 * @Date: 2019年10月25日 下午9:06:58
 */
public class History {
    /**
     * 用户观看过的电影id
     */
    private String movieName;
    /**
     * 用户id
     */
    private int userId;

    /**
     * 添加历史记录的时间
     */
    private Date addTime;

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getMovieName() {
        return movieName;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }

    @Override
    public String toString() {
        return "History{" +
                "movieName='" + movieName + '\'' +
                ", userId=" + userId +
                ", addTime=" + addTime +
                '}';
    }
}
