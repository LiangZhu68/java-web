import dao.DataSourceUtil;
import java.sql.Connection;

public class TestDatabaseConnection {
    public static void main(String[] args) {
        System.out.println("开始测试数据库连接...");
        
        Connection conn = null;
        try {
            conn = DataSourceUtil.initConn();
            if (conn != null && !conn.isClosed()) {
                System.out.println("数据库连接测试成功！");
                System.out.println("连接对象: " + conn);
                
                // 测试执行一个简单的查询
                java.sql.Statement stmt = conn.createStatement();
                java.sql.ResultSet rs = stmt.executeQuery("SELECT 1 as test");
                if (rs.next()) {
                    System.out.println("查询测试成功: " + rs.getInt("test"));
                }
                rs.close();
                stmt.close();
            } else {
                System.out.println("数据库连接测试失败！");
            }
        } catch (Exception e) {
            System.out.println("数据库连接异常: " + e.getMessage());
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                    System.out.println("数据库连接已关闭");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}