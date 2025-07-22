package utils;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

public class DataSourceUtils {
    private static HikariDataSource datasource;

    // ThreadLocal 为每个线程创建副本，每个线程访问自己的内部样本
    private static ThreadLocal<Connection> tl = new ThreadLocal<Connection>();

    static {
        try {
            Properties props = new Properties();
            InputStream inputStream = DataSourceUtils.class.getClassLoader().getResourceAsStream("db.properties");
            if (inputStream == null) {
                throw new IllegalStateException("在类路径中找不到 db.properties");
            }
            props.load(inputStream);

            HikariConfig config = new HikariConfig();
            config.setJdbcUrl(props.getProperty("jdbc.url"));
            config.setUsername(props.getProperty("jdbc.username"));
            config.setPassword(props.getProperty("jdbc.password"));
            config.setDriverClassName(props.getProperty("jdbc.driverClassName"));
            config.setMaximumPoolSize(Integer.parseInt(props.getProperty("hikari.maximumPoolSize")));
            config.setMinimumIdle(Integer.parseInt(props.getProperty("hikari.minimumIdle")));
            config.setConnectionTimeout(Long.parseLong(props.getProperty("hikari.connectionTimeout")));
            config.setIdleTimeout(Long.parseLong(props.getProperty("hikari.idleTimeout")));
            config.setMaxLifetime(Long.parseLong(props.getProperty("hikari.maxLifetime")));
            config.setLeakDetectionThreshold(Long.parseLong(props.getProperty("hikari.leakDetectionThreshold")));
            config.setPoolName(props.getProperty("hikari.poolName"));
            config.setAutoCommit(Boolean.parseBoolean(props.getProperty("hikari.autoCommit")));

            datasource = new HikariDataSource(config);
        } catch (IOException e) {
            throw new RuntimeException("无法加载 db.properties", e);
        }
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
