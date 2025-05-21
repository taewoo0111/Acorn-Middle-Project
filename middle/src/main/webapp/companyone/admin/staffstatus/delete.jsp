<%@page import="test.dao.Com1EmpLogDao"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	int empno = Integer.parseInt(request.getParameter("empno"));
	Com1EmpDao dao=Com1EmpDao.getInstance();
	Com1EmpLogDao logdao=Com1EmpLogDao.getInstance();
	boolean logisSuccess= logdao.delete(empno);
	boolean isSuccess= dao.delete(empno);

	

%>
<%if(isSuccess==true ){ %>
	<script>
		alert("<%=empno %>번 사원의 정보를 삭제했습니다.");
		window.location.href = "view.jsp";
	</script>
<%
	} else{
%>
	<script>
		alert("실패! 사원정보삭제를 실패했습니다.");
		 window.location.href = "view.jsp";
	</script>
<%
	}
	
%>