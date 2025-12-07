package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import beans.User;
import beans.Book;

public class UserDao {

    // 获取所有用户数据
    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        String sql = "SELECT id, username, password, email FROM t_user";
        Connection conn = null;
        Statement stm = null;
        ResultSet rs = null;

        try {
            conn = DataSourceUtil.initConn();
            if(conn == null) {
                System.out.println("数据库连接失败！");
                return userList;
            }
            stm = conn.createStatement();
            rs = stm.executeQuery(sql);
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                userList.add(user);
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
        return userList;
    }

    // 根据ID获取用户
    public User getUserById(int id) {
        String sql = "SELECT id, username, password, email FROM t_user WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        User user = null;

        try {
            conn = DataSourceUtil.initConn();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            DataSourceUtil.closeConn();
        }
        return user;
    }

    // 添加用户
    public boolean addUser(User user) {
        String sql = "INSERT INTO t_user (username, password, email) VALUES (?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        int result = 0;

        try {
            conn = DataSourceUtil.initConn();
            ps = conn.prepareStatement(sql);
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            result = ps.executeUpdate();
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
            DataSourceUtil.closeConn();
        }
        return result > 0;
    }

    // 更新用户
    public boolean updateUser(User user) {
        String sql = "UPDATE t_user SET username=?, password=?, email=? WHERE id=?";
        Connection conn = null;
        PreparedStatement ps = null;
        int result = 0;

        try {
            conn = DataSourceUtil.initConn();
            ps = conn.prepareStatement(sql);
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setInt(4, user.getId());
            result = ps.executeUpdate();
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
            DataSourceUtil.closeConn();
        }
        return result > 0;
    }

    // 删除用户（先删除相关数据，再删除用户）
    public boolean deleteUser(int id) {
        Connection conn = null;
        PreparedStatement ps = null;
        int result = 0;

        try {
            conn = DataSourceUtil.initConn();
            if(conn != null) {
                conn.setAutoCommit(false); // 开始事务

                // 先删除相关购物车项
                String deleteCartSql = "DELETE FROM t_cart WHERE user_id=?";
                ps = conn.prepareStatement(deleteCartSql);
                ps.setInt(1, id);
                ps.executeUpdate();
                if (ps != null) ps.close();

                // 再删除相关订单
                String deleteOrdersSql = "DELETE FROM t_orders WHERE user_id=?";
                ps = conn.prepareStatement(deleteOrdersSql);
                ps.setInt(1, id);
                ps.executeUpdate();
                if (ps != null) ps.close();

                // 最后删除用户
                String deleteUserSql = "DELETE FROM t_user WHERE id=?";
                ps = conn.prepareStatement(deleteUserSql);
                ps.setInt(1, id);
                result = ps.executeUpdate();

                conn.commit(); // 提交事务
                System.out.println("删除用户，影响行数: " + result);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // 回滚事务
            try {
                if(conn != null) conn.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
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

    // 根据用户名查询用户
    public User getUserByUsername(String username) {
        String sql = "SELECT id, username, password, email FROM t_user WHERE username=?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        User user = null;

        try {
            conn = DataSourceUtil.initConn();
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            DataSourceUtil.closeConn();
        }
        return user;
    }

    // 用户登录验证
    public User login(String username, String password) {
        String sql = "SELECT id, username, password, email FROM t_user WHERE username=? AND password=?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        User user = null;

        try {
            conn = DataSourceUtil.initConn();
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            DataSourceUtil.closeConn();
        }
        return user;
    }
}