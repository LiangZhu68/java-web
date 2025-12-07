import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import dao.DataSourceUtil;

public class AddBooks {
    public static void main(String[] args) {
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DataSourceUtil.initConn();
            
            // 20本示例图书数据
            String[] bookData = {
                "《Java核心技术》, 99.00, 'Cay S. Horstmann', 20",
                "《Spring实战》, 85.00, 'Craig Walls', 15",
                "《深入理解Java虚拟机》, 128.00, '周志明', 10",
                "《算法导论》, 158.00, 'Thomas H.Cormen', 8",
                "《设计模式》, 65.00, 'Gang of Four', 25",
                "《JavaScript高级程序设计》, 149.00, 'Nicholas C. Zakas', 12",
                "《Python编程：从入门到实践》, 79.00, 'Eric Matthes', 30",
                "《Head First设计模式》, 128.00, 'Eric Freeman', 18",
                "《数据结构与算法分析》, 78.00, 'Mark Allen Weiss', 15",
                "《Effective Java》, 89.00, 'Joshua Bloch', 20",
                "《计算机网络》, 108.00, '谢希仁', 25",
                "《操作系统概念》, 139.00, 'Abraham Silberschatz', 12",
                "《编译原理》, 119.00, 'Alfred V. Aho', 8",
                "《Redis设计与实现》, 79.00, '黄健宏', 22",
                "《MySQL必知必会》, 59.00, 'Ben Forta', 30",
                "《Vue.js实战》, 78.00, '梁灏', 18",
                "《React进阶之路》, 89.00, '徐超', 15",
                "《Node.js开发指南》, 65.00, '郭家寶', 20",
                "《深入浅出Node.js》, 95.00, '朴灵', 12",
                "《高性能MySQL》, 128.00, 'Baron Schwartz', 10"
            };
            
            String sql = "INSERT INTO t_book (name, price, author, stock) VALUES (?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            
            for (String book : bookData) {
                String[] parts = book.split(", ");
                ps.setString(1, parts[0]);
                ps.setBigDecimal(2, new java.math.BigDecimal(parts[1]));
                ps.setString(3, parts[2]);
                ps.setInt(4, Integer.parseInt(parts[3]));
                ps.addBatch();
            }
            
            int[] results = ps.executeBatch();
            System.out.println("成功添加 " + results.length + " 本图书到数据库！");
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            DataSourceUtil.closeConn();
        }
    }
}