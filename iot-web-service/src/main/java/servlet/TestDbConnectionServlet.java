package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.DataSourceUtil;

@WebServlet("/testDbConnection")
public class TestDbConnectionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>数据库连接测试</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h2>数据库连接测试</h2>");
        
        try {
            java.sql.Connection conn = DataSourceUtil.initConn();
            if(conn != null && !conn.isClosed()) {
                out.println("<p style='color:green;'>✓ 数据库连接成功！</p>");
                out.println("<p>连接对象: " + conn + "</p>");
                out.println("<p>连接是否有效: " + conn.isValid(5) + "</p>");
                
                // 测试查询
                java.sql.Statement stmt = conn.createStatement();
                java.sql.ResultSet rs = stmt.executeQuery("SHOW TABLES;");
                out.println("<p style='color:blue;'>可用表:</p><ul>");
                while(rs.next()) {
                    out.println("<li>" + rs.getString(1) + "</li>");
                }
                out.println("</ul>");
                
                rs.close();
                stmt.close();
                DataSourceUtil.closeConn(conn);
            } else {
                out.println("<p style='color:red;'>✗ 数据库连接失败！</p>");
            }
        } catch(Exception e) {
            out.println("<p style='color:red;'>✗ 数据库连接异常: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
        
        out.println("<br/><a href='../index.jsp'>返回首页</a>");
        out.println("</body>");
        out.println("</html>");
    }
}