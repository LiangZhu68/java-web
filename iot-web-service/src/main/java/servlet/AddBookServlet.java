package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.BookDao;
import beans.Book;

@WebServlet("/servlet/addBook")
public class AddBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/addBook.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String author = request.getParameter("author");
        String stockStr = request.getParameter("stock");
        
        try {
            double price = Double.parseDouble(priceStr);
            int stock = Integer.parseInt(stockStr);
            
            Book book = new Book();
            book.setName(name);
            book.setPrice(price);
            book.setAuthor(author);
            book.setBookCount(stock);
            
            BookDao bookDao = new BookDao();
            boolean success = bookDao.addBook(book);
            
            if(success) {
                response.sendRedirect(request.getContextPath() + "/servlet/bookList");
            } else {
                request.setAttribute("errorMsg", "添加图书失败！");
                request.getRequestDispatcher("/addBook.jsp").forward(request, response);
            }
        } catch(NumberFormatException e) {
            request.setAttribute("errorMsg", "价格或库存格式不正确！");
            request.getRequestDispatcher("/addBook.jsp").forward(request, response);
        }
    }
}