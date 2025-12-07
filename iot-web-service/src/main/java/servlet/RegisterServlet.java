package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dao.UserDao;
import beans.User;

@WebServlet("/servlet/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        
        UserDao userDao = new UserDao();
        
        // 检查用户名是否已经存在
        User existingUser = userDao.getUserByUsername(username);
        if(existingUser != null) {
            request.setAttribute("errorMsg", "用户名已存在，请选择其他用户名！");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // 创建新用户
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        
        boolean success = userDao.addUser(user);
        
        if(success) {
            request.setAttribute("successMsg", "注册成功，请登录！");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMsg", "注册失败，请重试！");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}