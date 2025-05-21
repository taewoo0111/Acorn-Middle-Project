<%@page import="test.dao.Com1WaitDao"%>
<%@page import="test.dto.Com1WaitDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	session.setAttribute("current_page", "acceptStaff");

	List<Com1WaitDto> list = Com1WaitDao.getInstance().getListStaff();
	String empInsertMessage = request.getParameter("empInsertMessage");
	String waitDeleteMessage = request.getParameter("waitDeleteMessage");
    if (empInsertMessage != null || waitDeleteMessage != null) {
%>
    <script>
        <% if (empInsertMessage != null) { %>
            alert('<%= empInsertMessage %>');
        <% } %>
        <% if (waitDeleteMessage != null) { %>
            alert('<%= waitDeleteMessage %>');
        <% } %>
    </script>
<% } %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 승인 관리</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
</head>
<body class="d-flex flex-column min-vh-100">
	<%@ include file="/include/header.jsp" %>
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	<div class="main flex-grow-1"> 
		<div class="container my-5">
			<h2 class="text-center mb-4">사원 승인 관리</h2>
			<table class="table table-striped table-hover text-center">
				<thead class="table-dark">
					<tr>
						<th>회사코드</th>
						<th>매장번호</th>
						<th>사원번호</th>
						<th>이름</th>
						<th>직위</th>
						<th>전화번호</th>
						<th>비밀번호</th>
						<th>승인</th>
						<th>거절</th>
					</tr>
				</thead>
				<tbody>
					<%for (Com1WaitDto dto : list) {%>
					<tr>
						<td><%=dto.getComId()%></td>
						<td><%=dto.getStoreNum()%></td>
						<td><%=dto.getEmpNo()%></td>
						<td><%=dto.geteName()%></td>
						<td><%=dto.getRole()%></td>
						<td><%=dto.geteCall()%></td>
						<td><%=dto.getePwd()%></td>
						<td><a href="insertStaff.jsp?empno=<%=dto.getEmpNo() %>" class="btn btn-success btn-sm">승인</a></td>
						<td><a href="deleteStaff.jsp?empno=<%=dto.getEmpNo() %>" class="btn btn-success btn-sm">거절</a></td>
					</tr>
					<%}%>
				</tbody>
			</table>
		</div>
	</div>
	
	<%--푸터 --%>
	<jsp:include page="/include/footer.jsp" />
</body>
</html>
