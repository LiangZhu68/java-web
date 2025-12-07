package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import beans.Cart;

public class CartDao {

    // 获取用户购物车中的所有商品
    public List<Cart> getCartByUserId(int userId) {
        List<Cart> cartList = new ArrayList<>();
        String sql = "SELECT id, user_id, book_id, quantity, book_name, price FROM t_cart WHERE user_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DataSourceUtil.initConn();
            if(conn != null) {
                ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                rs = ps.executeQuery();
                while(rs.next()) {
                    Cart cart = new Cart();
                    cart.setId(rs.getInt("id"));
                    cart.setUserId(rs.getInt("user_id"));
                    cart.setBookId(rs.getInt("book_id"));
                    cart.setQuantity(rs.getInt("quantity"));
                    cart.setBookName(rs.getString("book_name"));
                    cart.setPrice(rs.getDouble("price"));
                    cartList.add(cart);
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
        return cartList;
    }

    // 根据ID获取购物车项
    public Cart getCartById(int id) {
        String sql = "SELECT id, user_id, book_id, quantity, book_name, price FROM t_cart WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Cart cart = null;

        try {
            conn = DataSourceUtil.initConn();
            if(conn != null) {
                ps = conn.prepareStatement(sql);
                ps.setInt(1, id);
                rs = ps.executeQuery();
                if(rs.next()) {
                    cart = new Cart();
                    cart.setId(rs.getInt("id"));
                    cart.setUserId(rs.getInt("user_id"));
                    cart.setBookId(rs.getInt("book_id"));
                    cart.setQuantity(rs.getInt("quantity"));
                    cart.setBookName(rs.getString("book_name"));
                    cart.setPrice(rs.getDouble("price"));
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
        return cart;
    }

    // 添加商品到购物车
    public boolean addToCart(Cart cart) {
        String checkSql = "SELECT quantity FROM t_cart WHERE user_id = ? AND book_id = ?";
        String updateSql = "UPDATE t_cart SET quantity = quantity + ? WHERE user_id = ? AND book_id = ?";
        String insertSql = "INSERT INTO t_cart (user_id, book_id, quantity, book_name, price) VALUES (?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int result = 0;

        try {
            conn = DataSourceUtil.initConn();
            if(conn != null) {
                // 检查购物车中是否已有相同的图书
                ps = conn.prepareStatement(checkSql);
                ps.setInt(1, cart.getUserId());
                ps.setInt(2, cart.getBookId());
                rs = ps.executeQuery();
                
                if(rs.next()) {
                    // 如果存在，更新数量
                    ps = conn.prepareStatement(updateSql);
                    ps.setInt(1, cart.getQuantity());
                    ps.setInt(2, cart.getUserId());
                    ps.setInt(3, cart.getBookId());
                } else {
                    // 如果不存在，插入新记录
                    ps = conn.prepareStatement(insertSql);
                    ps.setInt(1, cart.getUserId());
                    ps.setInt(2, cart.getBookId());
                    ps.setInt(3, cart.getQuantity());
                    ps.setString(4, cart.getBookName());
                    ps.setDouble(5, cart.getPrice());
                }
                
                result = ps.executeUpdate();
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
        return result > 0;
    }

    // 更新购物车中商品数量
    public boolean updateCartQuantity(int cartId, int quantity) {
        String sql = "UPDATE t_cart SET quantity = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        int result = 0;

        try {
            conn = DataSourceUtil.initConn();
            if(conn != null) {
                ps = conn.prepareStatement(sql);
                ps.setInt(1, quantity);
                ps.setInt(2, cartId);
                result = ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(ps != null) {
                try { ps.close(); } catch(Exception e) { e.printStackTrace(); }
            }
            DataSourceUtil.closeConn(conn);
        }
        return result > 0;
    }

    // 从购物车中删除商品
    public boolean removeFromCart(int cartId) {
        String sql = "DELETE FROM t_cart WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        int result = 0;

        try {
            conn = DataSourceUtil.initConn();
            if(conn != null) {
                ps = conn.prepareStatement(sql);
                ps.setInt(1, cartId);
                result = ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(ps != null) {
                try { ps.close(); } catch(Exception e) { e.printStackTrace(); }
            }
            DataSourceUtil.closeConn(conn);
        }
        return result > 0;
    }

    // 清空用户购物车
    public boolean clearCartByUserId(int userId) {
        String sql = "DELETE FROM t_cart WHERE user_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        int result = 0;

        try {
            conn = DataSourceUtil.initConn();
            if(conn != null) {
                ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                result = ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(ps != null) {
                try { ps.close(); } catch(Exception e) { e.printStackTrace(); }
            }
            DataSourceUtil.closeConn(conn);
        }
        return result > 0;
    }

    // 获取购物车中商品总数
    public int getCartItemCount(int userId) {
        String sql = "SELECT SUM(quantity) as total FROM t_cart WHERE user_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int total = 0;

        try {
            conn = DataSourceUtil.initConn();
            if(conn != null) {
                ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                rs = ps.executeQuery();
                if(rs.next()) {
                    total = rs.getInt("total");
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
        return total > 0 ? total : 0;
    }

    // 获取购物车总价格
    public double getCartTotalPrice(int userId) {
        String sql = "SELECT SUM(quantity * price) as total_price FROM t_cart WHERE user_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        double total = 0.0;

        try {
            conn = DataSourceUtil.initConn();
            if(conn != null) {
                ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                rs = ps.executeQuery();
                if(rs.next()) {
                    total = rs.getDouble("total_price");
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
        return total;
    }
}