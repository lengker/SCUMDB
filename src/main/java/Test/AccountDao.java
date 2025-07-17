package Test;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import utils.DataSourceUtils;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * @ClassName: AccountDao
 * @Description: TODO
 * @author: GGBOY
 * @date 2019/11/3 20:40
 * @Version: 1.0
 **/
public class AccountDao {

    public Account queryAccount(int cardid) throws SQLException {
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "select * from account where cardid=?";
        return runner.query(sql, new BeanHandler<>(Account.class), cardid);
    }

    /**
     * 更新账户
     *
     * @param account
     * @throws SQLException
     */
    public void updateAccount(Account account) throws SQLException {
        QueryRunner runner = new QueryRunner();
        Connection connection = DataSourceUtils.getConnection();
        String sql = "update account set account=? where cardid=?";
        runner.update(connection, sql, new Object[]{account.getAccount(), account.getCardid()});

    }
}
