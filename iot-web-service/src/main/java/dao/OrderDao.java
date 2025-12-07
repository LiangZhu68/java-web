package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import beans.Order;

public class OrderDao {

    // 获取所有订单
    public List<Order> getAllOrders() {
        List<Order> orderList = new ArrayList<>();
        String sql = "SELECT id, order_id, user_id, total_price, status, create_time, update_time, order_items FROM t_orders";
        Connection conn = null;
        Statement stm = null;
        ResultSet rs = null;

        try {
            conn = DataSourceUtil.initConn();
            if(conn != null) {
                stm = conn.createStatement();
                rs = stm.executeQuery(sql);
                while(rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setOrderId(rs.getString("order_id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setTotalPrice(rs.getDouble("total_price"));
                    order.setStatus(rs.getInt("status"));
                    order.setCreateTime(rs.getString("create_time"));
                    order.setUpdateTime(rs.getString("update_time"));
                    order.setOrderItems(rs.getString("order_items"));
                    orderList.add(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(rs != null) {
                try { rs.close(); } catch(Exception e) { e.printStackTrace(); }
            }
            if(stm != null) {
                try { stm.close(); } catch(Exception e) { e.printStackTrace(); }
            }
            DataSourceUtil.closeConn(conn);
        }
        return orderList;
    }

    // 根据用户ID获取订单列表
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orderList = new ArrayList<>();
        String sql = "SELECT id, order_id, user_id, total_price, status, create_time, update_time, order_items FROM t_orders WHERE user_id = ?";
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
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setOrderId(rs.getString("order_id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setTotalPrice(rs.getDouble("total_price"));
                    order.setStatus(rs.getInt("status"));
                    order.setCreateTime(rs.getString("create_time"));
                    order.setUpdateTime(rs.getString("update_time"));
                    order.setOrderItems(rs.getString("order_items"));
                    orderList.add(order);
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
        return orderList;
    }

    // 根据订单ID获取订单
    public Order getOrderByOrderId(String orderId) {
        String sql = "SELECT id, order_id, user_id, total_price, status, create_time, update_time, order_items FROM t_orders WHERE order_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Order order = null;

        try {
            conn = DataSourceUtil.initConn();
            if(conn != null) {
                ps = conn.prepareStatement(sql);
                ps.setString(1, orderId);
                rs = ps.executeQuery();
                if(rs.next()) {
                    order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setOrderId(rs.getString("order_id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setTotalPrice(rs.getDouble("total_price"));
                    order.setStatus(rs.getInt("status"));
                    order.setCreateTime(rs.getString("create_time"));
                    order.setUpdateTime(rs.getString("update_time"));
                    order.setOrderItems(rs.getString("order_items"));
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
        return order;
    }

    // 根据ID获取订单
    public Order getOrderByOrderId(int id) {
        String sql = "SELECT id, order_id, user_id, total_price, status, create_time, update_time, order_items FROM t_orders WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Order order = null;

        try {
            conn = DataSourceUtil.initConn();
            if(conn != null) {
                ps = conn.prepareStatement(sql);
                ps.setInt(1, id);
                rs = ps.executeQuery();
                if(rs.next()) {
                    order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setOrderId(rs.getString("order_id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setTotalPrice(rs.getDouble("total_price"));
                    order.setStatus(rs.getInt("status"));
                    order.setCreateTime(rs.getString("create_time"));
                    order.setUpdateTime(rs.getString("update_time"));
                    order.setOrderItems(rs.getString("order_items"));
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
        return order;
    }

    // 添加订单
    public boolean addOrder(Order order) {
        String sql = "INSERT INTO t_orders (order_id, user_id, total_price, status, create_time, update_time, order_items) VALUES (?, ?, ?, ?, NOW(), NOW(), ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        int result = 0;

        try {
            conn = DataSourceUtil.initConn();
            if(conn != null) {
                ps = conn.prepareStatement(sql);
                ps.setString(1, order.getOrderId());
                ps.setInt(2, order.getUserId());
                ps.setDouble(3, order.getTotalPrice());
                ps.setInt(4, order.getStatus());
                ps.setString(5, order.getOrderItems());
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

    // 更新订单状态
    public boolean updateOrderStatus(String orderId, int status) {
        String sql = "UPDATE t_orders SET status = ?, update_time = NOW() WHERE order_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        int result = 0;

        try {
            conn = DataSourceUtil.initConn();
            if(conn != null) {
                ps = conn.prepareStatement(sql);
                ps.setInt(1, status);
                ps.setString(2, orderId);
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

    // 删除订单
    public boolean deleteOrder(String orderId) {
        String sql = "DELETE FROM t_orders WHERE order_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        int result = 0;

        try {
            conn = DataSourceUtil.initConn();
            if(conn != null) {
                ps = conn.prepareStatement(sql);
                ps.setString(1, orderId);
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
}