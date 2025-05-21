package test.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import test.dao.Com1WaitDao;
import test.dto.Com1WaitDto;

@WebServlet("/signup")
public class SignUpServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
        Com1WaitDto dto = new Com1WaitDto();
        
        int comid = Integer.parseInt(request.getParameter("comid"));
        int storenum = Integer.parseInt(request.getParameter("storenum"));
        //int empno = Integer.parseInt(request.getParameter("empno"));
		String ename = request.getParameter("ename");
        String role = request.getParameter("role");
        String ecall = request.getParameter("ecall");
        String epwd = request.getParameter("pwd");
        String email = request.getParameter("email");
        
        if ("ADMIN".equals(role) || "STAFF".equals(role)) {
        	dto.setComId(comid);
        	dto.setStoreNum(storenum);
        	dto.seteName(ename);
        	dto.setRole(role);
        	dto.seteCall(ecall);
        	dto.setePwd(epwd);
        	dto.setEmail(email);
        	Com1WaitDao.getInstance().insert(dto);
            response.sendRedirect("index.jsp?message=success");
            
//        } else if ("STAFF".equals(role)) {
//        	dto.setComId(comid);
//        	dto.setStoreNum(storenum);
//        	dto.seteName(ename);
//        	dto.setRole(role);
//        	dto.seteCall(ecall);
//        	dto.setePwd(epwd);
//        	dto.setEmail(email);
//        	Com1WaitDao.getInstance().insert(dto);
//            response.sendRedirect("index.jsp?message=success");
//            
        } else {
            response.sendRedirect("/user/signup.jsp?message=fail");
        }
    }
}
