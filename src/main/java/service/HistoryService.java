package service;

import dao.HistoryDao;
import domain.History;

import java.sql.SQLException;
import java.util.List;


/**
 * @ClassName: HistoryService.java
 * @Description: 处理与用户浏览记录相关业务逻辑
 * @author: zhuhaipeng
 * @version: V1.0
 * @Date: 2019年10月31日 下午9:53:39
 */
public class HistoryService {
    private HistoryDao dao = new HistoryDao();

    /**
     * @param userId    用户 id
     * @param movieName 用户浏览的电影名
     * @throws SQLException
     * @Description: 添加一条浏览记录
     */
    public void addRecord(int userId, String movieName) throws SQLException {
        dao.addRecord(userId, movieName);
    }

    /**
     * 获得用户的浏览记录
     *
     * @param userId 用户 id
     * @return java.util.List<java.lang.String>
     * @author GGBOY
     * @date 2019/11/15
     */
    public List<History> getRecords(int userId) throws SQLException {
        return dao.getRecords(userId);
    }
}
