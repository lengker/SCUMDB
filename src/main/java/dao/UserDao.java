package dao;

import domain.User;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import utils.DataSourceUtils;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * @ClassName: UserDao.java
 * @Description: 用于操纵数据库，对 user表进行增删改查
 * @version: V1.0
 */
public class UserDao {

    /**
     * @return User
     * @throws SQLException 参数
     * @throws SQLException
     * @Description: 根据用户名和密码查找用户
     */
    public User findUserByUsernameAndPassword(String username, String password) throws SQLException {
        String sql = "select * from users where username=? and password=?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        return runner.query(sql, new BeanHandler<User>(User.class), username, password);
    }

    /**
     * @param email
     * @param password
     * @return
     * @throws SQLException
     */
    public User findUserByEmailAndPassword(String email, String password) throws SQLException {
        String sql = "select * from users where email=? and password=?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        return runner.query(sql, new BeanHandler<User>(User.class), email, password);
    }

    /**
     * @param email
     * @return
     * @throws SQLException
     */
    public User findUserByEmail(String email) throws SQLException {
        String sql = "SELECT id, username, password, gender, email, telephone, introduce, activeCode, state, role, registTime," +
        "email_code AS emailCode, code_expire_time AS codeExpireTime " +
//        String sql = "SELECT *" +
                     "FROM users WHERE email=?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        return runner.query(sql, new BeanHandler<User>(User.class), email);
    }

    /**
     * @param user 被添加的用户对象
     * @throws SQLException 参数
     * @Description: 添加用户
     */
    public void addUser(User user) throws SQLException {
        String sql = "insert into users(username,password,email) values(?,?,?)";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        int row = runner.update(sql, user.getUsername(), user.getPassword(), user.getEmail());
        if (row == 0) {
            throw new RuntimeException();
        }
    }

    /**
     * @param user 更新的用户信息
     * @Description:更新用户信息
     */
    public void updateUser(User user) throws SQLException {
        String sql = "UPDATE users SET introduce = ?, password = ? WHERE id = ?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        runner.update(sql, user.getIntroduce(), user.getPassword(), user.getId());
    }

    /**
     * 根据用户名查找用户
     *
     * @param userName 用户名
     * @throws SQLException
     */
    public User findUserByUserName(String userName) throws SQLException {
        String sql = "select * from users where userName = ?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        return runner.query(sql, new BeanHandler<>(User.class), userName);
    }

    /**
     * 根据用户名查找用户
     *
     * @param username 用户名
     * @return 用户对象
     */
    public User findUserByUsername(String username) throws SQLException {
        String sql = "SELECT * FROM users WHERE username = ? LIMIT 1";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        return runner.query(sql, new BeanHandler<User>(User.class), username);
    }

    /**
     * 获取所有用户
     *
     * @return 用户列表
     */
    public List<User> findAllUsers() throws SQLException {
        String sql = "SELECT * FROM users ORDER BY username";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        return runner.query(sql, new BeanListHandler<User>(User.class));
    }

    /**
     * 根据筛选条件查找用户
     *
     * @param filterType  筛选类型
     * @param filterValue 筛选值
     * @return 用户列表
     */
    public List<User> findUsersWithFilter(String filterType, String filterValue) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT * FROM users WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (filterType != null && filterValue != null && !filterValue.trim().isEmpty()) {
            switch (filterType) {
                case "username":
                    sql.append(" AND username LIKE ?");
                    params.add("%" + filterValue.trim() + "%");
                    break;
                case "email":
                    sql.append(" AND email LIKE ?");
                    params.add("%" + filterValue.trim() + "%");
                    break;
                case "gender":
                    sql.append(" AND gender = ?");
                    params.add(filterValue.trim());
                    break;
                case "state":
                    try {
                        sql.append(" AND state = ?");
                        params.add(Integer.parseInt(filterValue.trim()));
                    } catch (NumberFormatException e) {
                        // 如果不是数字，忽略此筛选条件
                    }
                    break;
            }
        }

        sql.append(" ORDER BY username");

        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        return runner.query(sql.toString(), new BeanListHandler<User>(User.class), params.toArray());
    }

    /**
     * 更新用户信息
     *
     * @param user             更新后的用户信息
     * @param originalUsername 原始用户名
     */
    public void updateUser(User user, String originalUsername) throws SQLException {
        String sql = "UPDATE users SET username=?, password=?, email=?, telephone=?, gender=? WHERE username=?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        runner.update(sql,
                user.getUsername(),
                user.getPassword(),
                user.getEmail(),
                user.getTelephone(),
                user.getGender(),
                originalUsername
        );
    }

    /**
     * 根据用户名删除用户
     *
     * @param username 用户名
     */
    public void deleteUserByUsername(String username) throws SQLException {
        String sql = "DELETE FROM users WHERE username = ?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        runner.update(sql, username);
    }

    /**
     * 更新用户的邮箱验证码和过期时间
     *
     * @param user 包含邮箱、验证码和过期时间的用户对象
     * @throws SQLException
     */
    public void updateUserEmailCode(User user) throws SQLException {
        String sql = "UPDATE users SET email_code=?, code_expire_time=? WHERE email=?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        runner.update(sql, user.getEmailCode(), user.getCodeExpireTime(), user.getEmail());
    }

    /**
     * 通过邮箱重置用户密码
     *
     * @param user 包含邮箱和新密码的用户对象
     * @throws SQLException
     */
    public void resetPasswordByEmail(User user) throws SQLException {
        String sql = "UPDATE users SET password=? WHERE email=?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        runner.update(sql, user.getPassword(), user.getEmail());
    }

    /**
     * 更新用户头像
     *
     * @param userId    用户ID
     * @param avatarUrl 头像URL
     * @throws SQLException
     */
    public void updateUserAvatar(int userId, String avatarUrl) throws SQLException {
        String sql = "UPDATE users SET avatar = ? WHERE id = ?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        runner.update(sql, avatarUrl, userId);
    }
}
