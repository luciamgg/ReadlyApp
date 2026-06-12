package readly.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import readly.dao.BookDAO;
import readly.dao.UserBookDAO;
import readly.model.User;

@WebServlet("/addBook")
public class AddBookServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String pagesStr = request.getParameter("pages");
        String status = request.getParameter("status");
        String coverUrl = request.getParameter("coverUrl");
        
        request.setCharacterEncoding("UTF-8");
        
        int pages = 0;

        if (pagesStr != null && !pagesStr.isEmpty()) {
            pages = Integer.parseInt(pagesStr);
        }

        User user = (User) request.getSession().getAttribute("user");

        BookDAO bookDAO = new BookDAO();
        UserBookDAO userBookDAO = new UserBookDAO();

        // Crear libro
        int bookId = bookDAO.addBook(title, author, pages);

        // Relacionarlo con usuario
        if (bookId != -1) {
            userBookDAO.addUserBook(user.getId(), bookId, status);
        }
        
        // Añadir portada
        userBookDAO.addBook(title, author, pages, status, coverUrl);

        response.sendRedirect("home.jsp");
    }
}
