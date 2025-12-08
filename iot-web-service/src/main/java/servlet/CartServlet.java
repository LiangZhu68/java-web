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
import beans.Cart;
import beans.Book;
import dao.CartDao;
import dao.BookDao;

@WebServlet("/servlet/cart")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if("addToCart".equals(action)) {
            // 处理GET请求的添加到购物车操作
            addToCart(request, response);
        } else {
            // 处理显示购物车的请求
            // 获取当前用户
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("currentUser");

            if (currentUser == null) {
                // 如果用户未登录，重定向到登录页面
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }

            // 从数据库获取购物车数据
            CartDao cartDao = new CartDao();
            List<Cart> cartList = cartDao.getCartByUserId(currentUser.getId());

            // 计算总价格
            double totalPrice = 0.0;
            for(Cart cartItem : cartList) {
                totalPrice += cartItem.getPrice() * cartItem.getQuantity();
            }

            request.setAttribute("cartList", cartList);
            request.setAttribute("totalPrice", totalPrice);
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if("addToCart".equals(action)) {
            addToCart(request, response);
        } else if("removeFromCart".equals(action)) {
            removeFromCart(request, response);
        } else if("updateQuantity".equals(action)) {
            updateQuantity(request, response);
        } else if("checkout".equals(action)) {
            checkout(request, response);
        } else {
            doGet(request, response);
        }
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 获取当前用户
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int bookId = Integer.parseInt(request.getParameter("id"));

        // 从数据库获取图书信息，而不是依赖页面传递的参数
        BookDao bookDao = new BookDao();
        Book book = bookDao.getBookById(bookId);

        if (book == null) {
            request.setAttribute("errorMsg", "图书不存在！");
            response.sendRedirect(request.getContextPath() + "/servlet/bookList");
            return;
        }

        int quantity = 1; // 默认添加数量为1

        Cart cart = new Cart();
        cart.setUserId(currentUser.getId());
        cart.setBookId(bookId);
        cart.setQuantity(quantity);
        cart.setBookName(book.getName());
        cart.setPrice(book.getPrice());

        CartDao cartDao = new CartDao();
        boolean success = cartDao.addToCart(cart);

        if(success) {
            response.sendRedirect(request.getContextPath() + "/servlet/cart");
        } else {
            // 添加失败，可以设置错误信息
            request.setAttribute("errorMsg", "添加到购物车失败！");
            response.sendRedirect(request.getContextPath() + "/servlet/bookList");
        }
    }

    private void removeFromCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int cartId = Integer.parseInt(request.getParameter("id"));

        CartDao cartDao = new CartDao();
        boolean success = cartDao.removeFromCart(cartId);

        if(success) {
            response.sendRedirect(request.getContextPath() + "/servlet/cart");
        } else {
            request.setAttribute("errorMsg", "从购物车删除失败！");
            doGet(request, response);
        }
    }

    private void updateQuantity(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int cartId = Integer.parseInt(request.getParameter("cartId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        if(quantity <= 0) {
            // 如果数量小于等于0，删除该项
            CartDao cartDao = new CartDao();
            cartDao.removeFromCart(cartId);
        } else {
            // 更新数量
            CartDao cartDao = new CartDao();
            boolean success = cartDao.updateCartQuantity(cartId, quantity);
            
            if(!success) {
                request.setAttribute("errorMsg", "更新购物车数量失败！");
            }
        }

        response.sendRedirect(request.getContextPath() + "/servlet/cart");
    }

    private void checkout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 获取当前用户
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        CartDao cartDao = new CartDao();
        List<Cart> cartList = cartDao.getCartByUserId(currentUser.getId());

        if(cartList != null && !cartList.isEmpty()) {
            // 生成订单号
            String orderId = "ORDER_" + System.currentTimeMillis();

            // 计算订单总价格
            double totalPrice = 0.0;
            for(Cart cartItem : cartList) {
                totalPrice += cartItem.getPrice() * cartItem.getQuantity();
            }

            // 创建订单并保存到数据库
            beans.Order order = new beans.Order();
            order.setOrderId(orderId);
            order.setUserId(currentUser.getId());
            order.setTotalPrice(totalPrice);
            order.setStatus(0); // 待付款状态
            // 这里可以将购物车项转换为订单项的JSON字符串
            order.setOrderItems(generateOrderItemsString(cartList));

            dao.OrderDao orderDao = new dao.OrderDao();
            boolean orderSuccess = orderDao.addOrder(order);

            if(orderSuccess) {
                // 清空购物车
                cartDao.clearCartByUserId(currentUser.getId());
                
                request.setAttribute("orderId", orderId);
                request.setAttribute("totalPrice", totalPrice);
                request.setAttribute("cartList", cartList);
                request.getRequestDispatcher("/orderConfirmation.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMsg", "创建订单失败！");
                doGet(request, response);
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/servlet/cart");
        }
    }
    
    // 辅助方法：生成订单项字符串
    private String generateOrderItemsString(List<Cart> cartList) {
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        for(int i = 0; i < cartList.size(); i++) {
            Cart cart = cartList.get(i);
            sb.append("{");
            sb.append("\"bookId\":").append(cart.getBookId()).append(",");
            sb.append("\"bookName\":\"").append(cart.getBookName()).append("\",");
            sb.append("\"price\":").append(cart.getPrice()).append(",");
            sb.append("\"quantity\":").append(cart.getQuantity());
            sb.append("}");
            if(i < cartList.size() - 1) {
                sb.append(",");
            }
        }
        sb.append("]");
        return sb.toString();
    }
}