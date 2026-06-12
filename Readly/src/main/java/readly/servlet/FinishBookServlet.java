package readly.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import readly.dao.UserBookDAO;

@WebServlet("/finishBook")
public class FinishBookServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        UserBookDAO dao = new UserBookDAO();

        // Cambia estado a finished
        dao.updateStatus(id, "finished");

        // Redirige al formulario de reseña con el id del libro
        response.sendRedirect("reviewForm.jsp?id=" + id);
    	
    }
}
