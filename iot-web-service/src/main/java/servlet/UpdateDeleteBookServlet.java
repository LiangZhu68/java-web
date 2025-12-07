package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.BookDao;
import beans.Book;

@WebServlet({"/servlet/updateBook", "/servlet/deleteBook"})
public class UpdateDeleteBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String path = request.getServletPath();
        
        if("/servlet/updateBook".equals(path)) {
            updateBook(request, response);
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        if("/servlet/updateBook".equals(path)) {
            showEditForm(request, response);
        } else if("/servlet/deleteBook".equals(path)) {
            deleteBook(request, response);
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");

        try {
            int id = Integer.parseInt(idStr);
            BookDao bookDao = new BookDao();
            Book book = bookDao.getBookById(id);

            if(book != null) {
                request.setAttribute("book", book);
                request.getRequestDispatcher("/editBook.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMsg", "未找到指定的图书！");
                request.getRequestDispatcher("/servlet/bookList").forward(request, response);
            }
        } catch(NumberFormatException e) {
            request.setAttribute("errorMsg", "无效的图书ID！");
            request.getRequestDispatcher("/servlet/bookList").forward(request, response);
        }
    }
    
    private void updateBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String author = request.getParameter("author");
        String stockStr = request.getParameter("stock");
        
        try {
            int id = Integer.parseInt(idStr);
            double price = Double.parseDouble(priceStr);
            int stock = Integer.parseInt(stockStr);
            
            Book book = new Book();
            book.setId(id);
            book.setName(name);
            book.setPrice(price);
            book.setAuthor(author);
            book.setBookCount(stock);
            
            BookDao bookDao = new BookDao();
            boolean success = bookDao.updateBook(book);
            
            if(success) {
                response.sendRedirect(request.getContextPath() + "/servlet/bookList");
            } else {
                request.setAttribute("errorMsg", "更新图书失败！");
                request.setAttribute("book", book);
                request.getRequestDispatcher("/editBook.jsp").forward(request, response);
            }
        } catch(NumberFormatException e) {
            request.setAttribute("errorMsg", "输入格式不正确！");
            request.getRequestDispatcher("/editBook.jsp").forward(request, response);
        }
    }
    
    private void deleteBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        
        try {
            int id = Integer.parseInt(idStr);
            
            BookDao bookDao = new BookDao();
            boolean success = bookDao.deleteBook(id);
            
            if(success) {
                response.sendRedirect(request.getContextPath() + "/servlet/bookList");
            } else {
                request.setAttribute("errorMsg", "删除图书失败！");
                request.getRequestDispatcher("/servlet/bookList").forward(request, response);
            }
        } catch(NumberFormatException e) {
            request.setAttribute("errorMsg", "无效的图书ID！");
            request.getRequestDispatcher("/servlet/bookList").forward(request, response);
        }
    }
}