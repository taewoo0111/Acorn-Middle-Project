package test.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import test.dao.Com1CeoDao;
import test.dao.Com1EmpDao;

@WebServlet("/checkEmail")
public class CheckEmailServlet extends HttpServlet{
	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        String email = request.getParameter("email");
        String role = request.getParameter("role");
        boolean isDuplicate = false;
        
        if(role.equals("CEO")) {
        	isDuplicate = Com1CeoDao.getInstance().isDuplicateEmail(email);
        }
        	isDuplicate = Com1EmpDao.getInstance().isDuplicateEmail(email);
        
        response.getWriter().write("{\"isDuplicate\": " + isDuplicate + "}");
    }
}
