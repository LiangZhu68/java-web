package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.UserDao;
import beans.User;

@WebServlet("/servlet/userEdit")
public class UserEditServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String userIdStr = request.getParameter("id");

        if("edit".equals(action)) {
            // 显示编辑页面
            if(userIdStr == null || userIdStr.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "用户ID参数缺失");
                return;
            }
            int userId;
            try {
                userId = Integer.parseInt(userIdStr);
            } catch(NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "无效的用户ID");
                return;
            }

            UserDao userDao = new UserDao();
            User user = userDao.getUserById(userId);

            if(user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("/userEdit.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } else if("delete".equals(action)) {
            // 删除处理
            if(userIdStr == null || userIdStr.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "用户ID参数缺失");
                return;
            }
            int userId;
            try {
                userId = Integer.parseInt(userIdStr);
            } catch(NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "无效的用户ID");
                return;
            }

            UserDao userDao = new UserDao();
            boolean success = userDao.deleteUser(userId);

            if(success) {
                response.sendRedirect(request.getContextPath() + "/servlet/userList");
            } else {
                request.setAttribute("errorMsg", "删除用户失败！");
                request.getRequestDispatcher("/servlet/userList").forward(request, response);
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userIdStr = request.getParameter("id");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        int userId;
        try {
            userId = Integer.parseInt(userIdStr);
        } catch(NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "无效的用户ID");
            return;
        }

        User user = new User();
        user.setId(userId);
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);

        UserDao userDao = new UserDao();
        boolean success = userDao.updateUser(user);

        if(success) {
            response.sendRedirect(request.getContextPath() + "/servlet/userList");
        } else {
            request.setAttribute("errorMsg", "更新用户失败！");
            request.getRequestDispatcher("/userEdit.jsp").forward(request, response);
        }
    }
}