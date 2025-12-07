package servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import beans.User;
import beans.Order;
import dao.OrderDao;

@WebServlet("/servlet/orderList")
public class OrderListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 获取当前用户
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        
        if (currentUser == null) {
            // 如果用户未登录，重定向到登录页面
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 从数据库获取订单列表，只获取当前用户的订单
        OrderDao orderDao = new OrderDao();
        List<Order> orders = orderDao.getOrdersByUserId(currentUser.getId());

        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/orderList.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            deleteOrder(request, response);
        } else if ("cancel".equals(action)) {
            cancelOrder(request, response);
        } else if ("confirm".equals(action)) {
            confirmOrder(request, response);
        } else {
            doGet(request, response);
        }
    }

    private void deleteOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderId = request.getParameter("orderId");

        OrderDao orderDao = new OrderDao();
        boolean success = orderDao.deleteOrder(orderId);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/servlet/orderList");
        } else {
            request.setAttribute("errorMsg", "删除订单失败！");
            doGet(request, response);
        }
    }

    private void cancelOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderId = request.getParameter("orderId");

        // 更新订单状态为已取消(-1)
        OrderDao orderDao = new OrderDao();
        boolean success = orderDao.updateOrderStatus(orderId, -1);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/servlet/orderList");
        } else {
            request.setAttribute("errorMsg", "取消订单失败！");
            doGet(request, response);
        }
    }

    private void confirmOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderId = request.getParameter("orderId");

        // 更新订单状态为已完成(3)
        OrderDao orderDao = new OrderDao();
        boolean success = orderDao.updateOrderStatus(orderId, 3);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/servlet/orderList");
        } else {
            request.setAttribute("errorMsg", "确认收货失败！");
            doGet(request, response);
        }
    }
}