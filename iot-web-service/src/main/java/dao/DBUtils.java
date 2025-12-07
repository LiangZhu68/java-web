package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import beans.Book;

public class DBUtils {
    private Connection conn = null;
    private Statement stm = null;
    private ResultSet rs = null;
    private PreparedStatement ps = null;

    // 获取所有图书数据
    public List<Book> getAllBook() {
        List<Book> bookList = new ArrayList<>();
        String sql = "select * from t_book";
        try {
            conn = DataSourceUtil.initConn();
            stm = conn.createStatement();
            rs = stm.executeQuery(sql);
            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getInt("id"));
                book.setName(rs.getString("name"));
                book.setPrice(rs.getDouble("price"));
                book.setBookCount(rs.getInt("stock"));
                book.setAuthor(rs.getString("author"));
                bookList.add(book);
            }
            if(rs != null) {
                rs.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeStatement(stm);
            DataSourceUtil.closeConn();
        }
        return bookList;
    }

    // 插入一本图书信息
    public void insertRecord(Book book, String sql) {
        try {
            conn = DataSourceUtil.initConn();
            ps = conn.prepareStatement(sql);
            System.out.println(conn);
            System.out.println(ps);
            ps.setString(1, book.getName());
            ps.setDouble(2, book.getPrice());
            ps.setString(3, book.getAuthor());
            ps.setInt(4, book.getBookCount()); // stock
            ps.setInt(5, 0); // sales - default value
            ps.setString(6, "static/img/default.jpg"); // img_path - default value
            int insertCount = ps.executeUpdate();
            if (insertCount != 0) {
                System.out.println("插入" + insertCount + "条数据");
            } else {
                System.out.println("插入失败！");
            }
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

    // 执行一条sql语句
    public void updateAndDelete(String sql) {
        try {
            conn = DataSourceUtil.initConn();

            stm = conn.createStatement();
            int num = stm.executeUpdate(sql);
            if (num == 1) {
                System.out.println("一条记录删除/更新成功！");
            } else {
                System.out.println("一条记录删除/更新失败！");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeStatement(stm);
            DataSourceUtil.closeConn();
        }
    }

    // 删除指定id的图书
    public void deleteId(String id) {
        try {
            conn = DataSourceUtil.initConn();
            String sql = "delete from t_book where id=?";
            ps = conn.prepareStatement(sql);

            ps.setString(1, id);
            int insertCount = ps.executeUpdate();
            if (insertCount != 0) {
                System.out.println("删除" + insertCount + "条数据");
            } else {
                System.out.println("删除失败！");
            }

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

    // 回收Statement资源
    private static void closeStatement(Statement statement) {
        try {
            if (null != statement) {
                statement.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}