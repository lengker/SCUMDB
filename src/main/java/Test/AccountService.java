package Test;

import utils.DataSourceUtils;

import java.sql.SQLException;

/**
 * @ClassName: TranseferService
 * @Description: TODO
 * @author: GGBOY
 * @date 2019/11/3 20:40
 * @Version: 1.0
 **/
public class AccountService {

    public void transfer(int fromCardid, int toCardid, int money) {
        AccountDao dao = new AccountDao();
        // 开启事务
        try {
            DataSourceUtils.startTransaction();
            // 各种DML操作

            // 根据cardid查找账户
            Account fromAccount = dao.queryAccount(fromCardid);
            Account toAccount = dao.queryAccount(toCardid);
            if (fromAccount.getAccount() >= money) {
                fromAccount.setAccount(fromAccount.getAccount() - money);
                toAccount.setAccount(toAccount.getAccount() + money);

                // 转账
                dao.updateAccount(fromAccount);
                System.out.println(1 / 0);
                dao.updateAccount(toAccount);
                // 正常提交事务
                DataSourceUtils.commitTransaction();
                System.out.println("转账成功");
            } else {
                System.out.println("余额不足");
            }


        } catch (Exception e) {
            try {
                // 回滚事务
                DataSourceUtils.rollback();
                System.out.println("转账失败");
            } catch (SQLException ex) {
                ex.printStackTrace();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                // 结束事务
                DataSourceUtils.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

    }
}
