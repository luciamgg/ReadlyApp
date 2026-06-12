package readly.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import readly.dao.UserDAO;
import readly.model.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        request.setCharacterEncoding("UTF-8");
        
        UserDAO dao = new UserDAO();
        User user = dao.login(email, password);

        if (user != null) {

            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            response.sendRedirect(request.getContextPath() + "/home.jsp");

        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=1");
        }
    }
}