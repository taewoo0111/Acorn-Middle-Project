<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    int empno = (int) session.getAttribute("empno");
	//변경값 불러오기
    String ename = request.getParameter("ename");
    String ecall = request.getParameter("ecall");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String newPassword = request.getParameter("newPassword");
    String newPassword2 = request.getParameter("newPassword2"); 
	
    Com1EmpDao dao = Com1EmpDao.getInstance();
    Com1EmpDto dto = dao.getData(empno);

    boolean isSuccess = false;

    if (dto.getePwd().equals(password)) {
 		//새 비밀번호와 확인란 같은지 
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            if (!newPassword.equals(newPassword2)) { 
            	System.out.println(newPassword);
            	System.out.println(newPassword2);
%>
                <script>
                    alert("새 비밀번호가 일치하지 않습니다.");
                    location.href = "<%= request.getContextPath() %>/companyone/staff/info/profileUpdateForm.jsp";
                </script>
<%
                return; 
            }
            dto.setePwd(newPassword); 
        }
        
        dto.seteName(ename);
        dto.seteCall(ecall);
        dto.setEmail(email);

        isSuccess = dao.update(dto);
    }

    if (isSuccess) {
        session.setAttribute("ename", dto.geteName());
        session.setAttribute("email", dto.getEmail());
    }
%>
<script>
    <% if (isSuccess) { %>
        alert("프로필이 성공적으로 수정되었습니다.");
        location.href = "profile.jsp";
    <% session.setAttribute("ename", ename); 
    	} else { %>
        alert("기존 비밀번호가 일치하지 않습니다.");
        location.href = "<%= request.getContextPath() %>/companyone/staff/info/profileUpdateForm.jsp";
    <% } %>
</script>