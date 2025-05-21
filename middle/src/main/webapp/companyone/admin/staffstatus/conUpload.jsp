<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int empno = Integer.parseInt(request.getParameter("empno"));
	String srcurl = request.getParameter("srcurl");

	Com1EmpDao dao=Com1EmpDao.getInstance();
	
	Com1EmpDto dto= dao.getData(empno);
	dto.setContract(srcurl);

	boolean isSuccess=dao.update(dto);
%>
<%if(isSuccess==true){ %>
	<script>
		alert("<%=empno %> <%=dto.geteName() %>사원의 계약서 업로드됐습니다.");
		window.location.href = "contract.jsp?empno=<%=empno%>";
	</script>
<%
	} else{
%>
	<script>
		alert("계약서 업로드실패! 다시 업로드해주세요");
		 window.location.href = "conUploadForm.jsp?empno=<%=empno %>";
	</script>
<%
	}
	
%>