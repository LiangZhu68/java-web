package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import beans.Book;

public class BookDao {

    // 获取所有图书数据
    public List<Book> getAllBooks() {
        List<Book> bookList = new ArrayList<>();
        String sql = "SELECT id, name, price, author, stock FROM t_book";
        Connection conn = null;
        Statement stm = null;
        ResultSet rs = null;
        
        try {
            conn = DataSourceUtil.initConn();
            if(conn == null) {
                System.out.println("数据库连接失败！");
                return bookList;
            }
            stm = conn.createStatement();
            rs = stm.executeQuery(sql);
            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getInt("id"));
                book.setName(rs.getString("name"));
                book.setPrice(rs.getDouble("price"));
                book.setAuthor(rs.getString("author"));
                book.setBookCount(rs.getInt("stock"));
                // 如果需要其他字段，可以在这里设置
                bookList.add(book);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 关闭资源
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (stm != null) {
                try {
                    stm.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            DataSourceUtil.closeConn(conn);
        }
        return bookList;
    }

    // 根据ID获取图书
    public Book getBookById(int id) {
        String sql = "SELECT id, name, price, author, stock FROM t_book WHERE id=?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Book book = null;
        
        try {
            conn = DataSourceUtil.initConn();
            if(conn != null) {
                ps = conn.prepareStatement(sql);
                ps.setInt(1, id);
                rs = ps.executeQuery();
                if(rs.next()) {
                    book = new Book();
                    book.setId(rs.getInt("id"));
                    book.setName(rs.getString("name"));
                    book.setPrice(rs.getDouble("price"));
                    book.setAuthor(rs.getString("author"));
                    book.setBookCount(rs.getInt("stock"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(rs != null) {
                try { rs.close(); } catch(Exception e) { e.printStackTrace(); }
            }
            if(ps != null) {
                try { ps.close(); } catch(Exception e) { e.printStackTrace(); }
            }
            DataSourceUtil.closeConn(conn);
        }
        return book;
    }

    // 添加图书
    public boolean addBook(Book book) {
        String sql = "INSERT INTO t_book (name, price, author, sales, stock, img_path) VALUES (?, ?, ?, 0, ?, 'static/img/default.jpg')";
        Connection conn = null;
        PreparedStatement ps = null;
        int result = 0;
        
        try {
            conn = DataSourceUtil.initConn();
            if(conn == null) {
                System.out.println("数据库连接失败！");
                return false;
            }
            ps = conn.prepareStatement(sql);
            ps.setString(1, book.getName());
            ps.setDouble(2, book.getPrice());
            ps.setString(3, book.getAuthor());
            ps.setInt(4, book.getBookCount()); // stock
            result = ps.executeUpdate();
            System.out.println("图书添加成功，影响行数: " + result);
        } catch (Exception e) {
            System.out.println("添加图书时发生异常: " + e.getMessage());
            e.printStackTrace();
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            DataSourceUtil.closeConn(conn);
        }
        return result > 0;
    }

    // 更新图书
    public boolean updateBook(Book book) {
        String sql = "UPDATE t_book SET name=?, price=?, author=?, stock=? WHERE id=?";
        Connection conn = null;
        PreparedStatement ps = null;
        int result = 0;
        
        try {
            conn = DataSourceUtil.initConn();
            if(conn != null) {
                ps = conn.prepareStatement(sql);
                ps.setString(1, book.getName());
                ps.setDouble(2, book.getPrice());
                ps.setString(3, book.getAuthor());
                ps.setInt(4, book.getBookCount()); // stock
                ps.setInt(5, book.getId());
                result = ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            DataSourceUtil.closeConn(conn);
        }
        return result > 0;
    }

    // 删除图书
    public boolean deleteBook(int id) {
        String sql = "DELETE FROM t_book WHERE id=?";
        Connection conn = null;
        PreparedStatement ps = null;
        int result = 0;
        
        try {
            conn = DataSourceUtil.initConn();
            if(conn != null) {
                ps = conn.prepareStatement(sql);
                ps.setInt(1, id);
                result = ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            DataSourceUtil.closeConn(conn);
        }
        return result > 0;
    }
}