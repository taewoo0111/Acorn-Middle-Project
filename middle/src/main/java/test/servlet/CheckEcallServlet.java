package test.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import test.dao.Com1CeoDao;
import test.dao.Com1EmpDao;

@WebServlet("/checkEcall")
public class CheckEcallServlet extends HttpServlet{
	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        String ecall = request.getParameter("ecall");
        String role = request.getParameter("role");
        boolean isDuplicate = false;
        boolean isDuplicate1 = false;
        boolean isDuplicate2 = false;
        
        if(role.equals("CEO")) {
        	isDuplicate1 = Com1CeoDao.getInstance().isDuplicateEcall(ecall);
        	isDuplicate2 = Com1EmpDao.getInstance().isDuplicateEcall(ecall);
        	if(isDuplicate1 || isDuplicate2) {
        		isDuplicate = true;
        	} else {
        		isDuplicate = false;
        	}
        }else{
        	isDuplicate1 = Com1EmpDao.getInstance().isDuplicateEcall(ecall);
        	isDuplicate2 = Com1CeoDao.getInstance().isDuplicateEcall(ecall);
        	if(isDuplicate1 || isDuplicate2) {
        		isDuplicate = true;
        	} else {
        		isDuplicate = false;
        	}
        }
        
        response.getWriter().write("{\"isDuplicate\": " + isDuplicate + "}");
    }
}
