package servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.BookDao;
import beans.Book;

@WebServlet("/servlet/bookList")
public class BookListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String sortBy = request.getParameter("sortBy");
        String order = request.getParameter("order");

        BookDao bookDao = new BookDao();
        List<Book> bookList = bookDao.getAllBooks(sortBy, order);

        request.setAttribute("bookList", bookList);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("order", order);
        request.getRequestDispatcher("/bookList.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}