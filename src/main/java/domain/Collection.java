package domain;

import java.util.Date;

/**
 * @ClassName: Collection.java
 * @Description: 对应数据库的collection表，记录用户喜欢的电影
 * @author: zhuhaipeng
 * @version: V1.0
 * @Date: 2019年10月25日 下午9:05:50
 */
public class Collection {
    /**
     * 用户名
     */
    private String userName;
    /**
     * 用户喜欢的电影名
     */
    private String movieName;

    /**
     * 添加收藏记录的时间
     */
    private Date addTime;

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getMovieName() {
        return movieName;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }

    @Override
    public String toString() {
        return "Collection{" +
                "userName='" + userName + '\'' +
                ", movieName='" + movieName + '\'' +
                ", addTime=" + addTime +
                '}';
    }
}
