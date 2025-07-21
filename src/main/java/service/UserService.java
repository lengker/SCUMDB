package service;

import dao.UserDao;
import domain.User;
import exception.LoginException;
import exception.RegisterException;
import exception.UpdateUserException;
import utils.BlackBox;
import utils.MailUtils;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.Random;

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
            User user;
            // 判断是邮箱还是用户名
            if (username.contains("@")) {
                user = dao.findUserByEmailAndPassword(username, password);
            } else {
                user = dao.findUserByUsernameAndPassword(username, password);
            }

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
            if (e instanceof LoginException) { // 保留原始的异常信息
                throw (LoginException) e;
            }
            throw new LoginException("登录失败，请检查用户名或密码是否有误！！");
        }
    }

    /**
     * 发送重置密码邮件
     *
     * @param email 邮箱
     * @throws Exception
     */
    public String sendResetPasswordEmail(String email) throws Exception {
        User user = dao.findUserByEmail(email);
        if (user == null) {
            throw new Exception("该邮箱未注册");
        }

        // 生成6位数字验证码
        Random random = new Random();
        int code = 100000 + random.nextInt(900000);
        String emailCode = String.valueOf(code);
        // 设置验证码过期时间（例如10分钟）
        Date codeExpireTime = new Date(System.currentTimeMillis() + 10 * 60 * 1000);

        user.setEmailCode(emailCode);
        user.setCodeExpireTime(codeExpireTime);

        // 更新数据库中的验证码和过期时间
        dao.updateUserEmailCode(user);

        // 发送邮件
        String subject = "SCUMDB - 密码重置";
        // 构建重置链接
        String resetLink = "http://localhost:8080/resetPassword?email=" + email + "&code=" + emailCode;
        String content = "您正在申请重置密码，请点击以下链接进行重置：<br><a href='" + resetLink + "'>" + resetLink + "</a><br>您的验证码是：<b>" + emailCode + "</b>，请在10分钟内使用。如果不是您本人操作，请忽略此邮件。";
        MailUtils.sendMail(email, subject, content);
        return emailCode;
    }

    /**
     * 重置密码
     *
     * @param email     邮箱
     * @param password  新密码
     * @param emailCode 验证码
     * @throws Exception
     */
    public void resetPassword(String email, String password, String emailCode) throws Exception {
        User user = dao.findUserByEmail(email);
        if (user == null) {
            throw new Exception("用户不存在");
        }

        // 校验验证码
        if (user.getEmailCode() == null || emailCode == null || !user.getEmailCode().trim().equalsIgnoreCase(emailCode.trim())) {
            String dbCode = user.getEmailCode() != null ? user.getEmailCode() : "null";
            String requestCode = emailCode != null ? emailCode : "null";
        }

        // 校验验证码是否过期
        if (user.getCodeExpireTime() == null || new Date().after(user.getCodeExpireTime())) {
            throw new Exception("验证码已过期");
        }

        // 重置密码
        user.setPassword(password); // 实际应用中密码应该加密存储
        dao.resetPasswordByEmail(user);

        // 重置密码后，将验证码设置为空，防止重复使用
        user.setEmailCode(null);
        user.setCodeExpireTime(null);
        dao.updateUserEmailCode(user);
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
     * ��据用户名查找用户
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

    /**
     * 更新用户头像
     *
     * @param userId    用户ID
     * @param avatarUrl 头像URL
     * @throws SQLException
     */
    public void updateUserAvatar(int userId, String avatarUrl) throws SQLException {
        dao.updateUserAvatar(userId, avatarUrl);
    }
}
