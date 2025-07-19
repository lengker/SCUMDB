package service;

import dao.UserDao;
import domain.User;
import exception.LoginException;
import exception.RegisterException;
import exception.UpdateUserException;
import utils.BlackBox;

import java.sql.SQLException;
import java.util.List;

/**
 * @ClassName: UserService.java
 * @Description: 与用户相关的业务逻辑层
 * @version: V1.0
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

    /**
     * 根据用户名查找用户
     *
     * @param username 用户名
     * @return domain.User
     */
    public User findUserByUsername(String username) throws SQLException {
        return dao.findUserByUsername(username);
    }

    /**
     * 获取所有用户
     *
     * @return 用户列表
     */
    public List<User> findAllUsers() throws SQLException {
        return dao.findAllUsers();
    }

    /**
     * 根据筛选条件查找用户
     *
     * @param filterType  筛选类型
     * @param filterValue 筛选值
     * @return 用户列表
     */
    public List<User> findUsersWithFilter(String filterType, String filterValue) throws SQLException {
        return dao.findUsersWithFilter(filterType, filterValue);
    }

    /**
     * 添加用户
     *
     * @param user 用户对象
     */
    public void addUser(User user) throws SQLException {
        dao.addUser(user);
    }

    /**
     * 更新用户信息
     *
     * @param user             更新后的用户信息
     * @param originalUsername 原始用户名
     */
    public void updateUser(User user, String originalUsername) throws SQLException {
        dao.updateUser(user, originalUsername);
    }

    /**
     * 根据用户名删除用户
     *
     * @param username 用户名
     */
    public void deleteUserByUsername(String username) throws SQLException {
        dao.deleteUserByUsername(username);
    }
}
