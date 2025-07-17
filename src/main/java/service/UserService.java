package service;

import dao.UserDao;
import domain.User;
import exception.LoginException;
import exception.RegisterException;
import exception.UpdateUserException;
import utils.BlackBox;

import java.sql.SQLException;

/**
 * @ClassName: UserService.java
 * @Description: 与用户相关的业务逻辑层
 * @author: zhuhaipeng
 * @version: V1.0
 * @Date: 2019年10月25日 下午9:46:47
 */
public class UserService {

    private UserDao dao = new UserDao();

    /**
     * @param params 验证所需参数
     * @return
     * @throws LoginException 参数
     * @Description: 登录操作
     */
    public User login(String username, String password) throws LoginException {
        try {
            // 根据登录时表单输入的用户名和密码，查找用户
			User user = dao.findUserByUsernameAndPassword(username, password);

            // 如果找到，还需要确定用户是否为激活用户
            if (user != null) {
                // 只有是激活才能登录成功，否则提示“用户未激活”
                if (user.getState() == 1) {
                    return user;
                }
                throw new LoginException("用户未激活");
            }

            throw new LoginException("用户名或密码错误");
        } catch (Exception e) {
            e.printStackTrace();
            throw new LoginException("登录失败，请检查用户名或密码是否有误！！");
        }
    }

    public void register(User user) throws RegisterException {
        try {
            // 调用 dao完成注册操作
            dao.addUser(user);

            // TODO:后期补充，发送邮件过去激活
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            throw new RegisterException("注册失败！用户名已存在！");
        }
    }

    public void updateUser(User user) throws UpdateUserException {
        try {
            dao.updateUser(user);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new UpdateUserException("更新用户信息失败!");
        }
    }

    public User findUserByUserName(String userName) throws SQLException {
        return dao.findUserByUserName(userName);
    }
}
