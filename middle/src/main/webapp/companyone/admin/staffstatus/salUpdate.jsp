<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	String returnurl = request.getParameter("returnurl");
	int empno = Integer.parseInt(request.getParameter("empno"));
	String ename = request.getParameter("ename");
	int sal = Integer.parseInt(request.getParameter("sal"));
	int hsal = Integer.parseInt(request.getParameter("hsal"));
	int worktime = Integer.parseInt(request.getParameter("worktime"));
	
	Com1EmpDao dao=Com1EmpDao.getInstance();
	
	Com1EmpDto dto= dao.getData(empno);
    dto.setSal(sal);
    dto.setHsal(hsal);
    dto.setWorktime(worktime);
    
    boolean isSuccess=dao.update(dto);

%>
<%if(isSuccess==true){ %>
	<script>
		alert("<%=empno %> <%=ename %>사원의 급여 및 근무시간 정보가 수정되었습니다.");
		window.location.href = "<%=returnurl %>";
	</script>
<%
	} else{
%>
	<script>
		alert("실패! 다시 수정해주세요");
		 window.location.href = "salUpdateForm.jsp?empno=<%=empno %>";
	</script>
<%
	}
	
%>
