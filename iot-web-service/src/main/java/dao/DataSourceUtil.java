package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class DataSourceUtil {
    private static String driverClassName;
    private static String url;
    private static String username;
    private static String password;
    private static Connection conn = null; // 保持旧的静态连接以确保兼容性

    // 静态代码块在类被加载的时候运行，而且只运行一次，并且优先于各种代码块以及构造函数
    static {
        try {
            ResourceBundle resource = ResourceBundle.getBundle("jdbc");
            driverClassName = resource.getString("driverClassName");
            url = resource.getString("url");
            username = resource.getString("username");
            password = resource.getString("password");
        } catch (Exception e) {
            System.out.println("加载jdbc配置失败！");
            e.printStackTrace();
        }
    }

    public static Connection initConn() {
        Connection conn = null;
        try {
            System.out.println("driverClassName=" + driverClassName);
            System.out.println("url=" + url);
            System.out.println("username=" + username);
            System.out.println("password=" + password);
            
            Class.forName(driverClassName);
            conn = DriverManager.getConnection(url, username, password);
            System.out.println("conn=" + conn);
            if (conn != null) {
                System.out.println("数据库连接成功！");
            } else {
                System.out.println("数据库连接失败！");
            }
        } catch (Exception e) {
            System.out.println("数据库加载失败！错误信息：" + e.getMessage());
            e.printStackTrace();
        }
        return conn;
    }
    
    // 保持原有的静态连接方法以确保兼容性
    public static Connection initStaticConn() {
        try {
            System.out.println("driverClassName=" + driverClassName);
            Class.forName(driverClassName);
            conn = DriverManager.getConnection(url, username, password);
            System.out.println("conn=" + conn);
            if (conn != null)
                System.out.println("数据库连接成功！");
        } catch (Exception e) {
            System.out.println("数据库加载失败！");
            e.printStackTrace();
        }
        return conn;
    }

    public static void closeConn(Connection conn) {
        try {
            if (conn != null && !conn.isClosed())
                conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public static void closeConn() {
        // 关闭静态连接
        try {
            if (conn != null && !conn.isClosed())
                conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}