package utils;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DataSourceUtils {
    private static HikariDataSource datasource;

    // ThreadLocal 为每个线程创建副本，每个线程访问自己的内部样本
    private static ThreadLocal<Connection> tl = new ThreadLocal<Connection>();

    static {
        HikariConfig config = new HikariConfig();

        config.setJdbcUrl("jdbc:mysql://localhost:3306/moviesdata?serverTimezone=Asia/Shanghai");
        config.setUsername("root");
        config.setPassword("123456");
        config.setDriverClassName("com.mysql.jdbc.Driver");

        config.setMaximumPoolSize(20);
        config.setMinimumIdle(5);
        config.setConnectionTimeout(30000);
        config.setIdleTimeout(600000);
        config.setMaxLifetime(1800000);
        config.setLeakDetectionThreshold(60000);

        config.setPoolName("HikariCP");

        config.setAutoCommit(true);

        datasource = new HikariDataSource(config);
    }

    public static DataSource getDataSource() {
        return datasource;
    }

    public static Connection getConnection() throws SQLException {
        Connection con = tl.get();
        if (con == null) {
            con = datasource.getConnection();
            tl.set(con);
        }

        return con;
    }

    public static void startTransaction() throws SQLException {
        Connection con = getConnection();
        if (con != null) {
            con.setAutoCommit(false);
        }
    }

    public static void commitTransaction() throws SQLException {
        Connection con = getConnection();
        if (con != null) {
            con.commit();
        }
    }

    public static void rollback() throws SQLException {
        Connection con = getConnection();
        if (con != null) {
            con.rollback();
        }
    }

    public static void close() throws SQLException {
        Connection connection = tl.get();
        if (connection != null) {
            try {
                // 如果连接未自动提交，则回滚未提交的事务
                if (!connection.getAutoCommit()) {
                    connection.rollback();
                    connection.setAutoCommit(true);
                }
            } finally {
                // 清空ThreadLocal
                tl.remove();
                // 关闭连接
                connection.close();
            }
        }
    }


}
