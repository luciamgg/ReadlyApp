package readly.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import readly.dao.UserBookDAO;

@WebServlet("/updateStatus")
public class UpdateStatusServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	request.setCharacterEncoding("UTF-8");
    	
        int id = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");

        UserBookDAO dao = new UserBookDAO();

        dao.updateStatus(id, status);

        response.sendRedirect("home.jsp");
    }
}
