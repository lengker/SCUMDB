package domain;

/**
 * @ClassName: ClickTime.java
 * @Description: 记录电影被点击次数的实体类
 * @author: zhuhaipeng
 * @version: V1.0
 * @Date: 2019年10月31日 下午10:19:01
 */
public class ClickTime {
    /**
     * 电影名
     */
    private String movieName;
    /**
     * 电影被点击的次数
     */
    private int number;

    public String getMovieName() {
        return movieName;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    @Override
    public String toString() {
        return "ClickTime [movieName=" + movieName + ", number=" + number + "]";
    }

}
