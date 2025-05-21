<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int empno = (int) session.getAttribute("empno");
	
	String srcurl = request.getParameter("srcurl");
	
	Com1EmpDao dao=Com1EmpDao.getInstance();
	
	Com1EmpDto dto= dao.getData(empno);
	dto.setContract(srcurl);
	
	boolean isSuccess=dao.update(dto);

%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계약서 수정</title>
</head>
<body>
<div class="container">
	<%if(isSuccess==true){ %>
		<script>
			alert("근로계약서를 업로드했습니다.");
			//javascript 로 페이지 이동
			location.href = "${pageContext.request.contextPath }/companyone/staff/info/contract.jsp?empno=<%=empno%>";
		</script>
	<%}else{ %>
		<script>
			alert("근로계약서를 업로드해 주십시오.");
			//javascript 로 페이지 이동
			location.href = "${pageContext.request.contextPath }/companyone/staff/info/contract.jsp?empno=<%=empno%>";
		</script>
	<%} %>
</div>
</body>
</html>