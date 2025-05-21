<%@page import="test.dto.UsingDto"%>
<%@page import="test.dao.UsingDao"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@page import="test.dto.Com1EmpDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	
	//int empno = (int) session.getAttribute("empno");
	session.setAttribute("current_page", "profile");
	
	int empno=(int)session.getAttribute("empno");
	Com1EmpDto dto = Com1EmpDao.getInstance().getData(empno);
	//Com1EmpDao dao = Com1EmpDao.getInstance();
	//Com1EmpDto dto = dao.getData(empno);
	
	//int comid = dto.getComId();
	//String comname = UsingDao.getInstance().getComName(comid);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필</title>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<style>
	.container2 {
		max-width: 800px;
		margin: 40px auto;
		background-color: #fff;
		padding: 20px;
		border-radius: 8px;
		border: 1px solid black;
		box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	}
	table {
		width: 100%;
		border-collapse: collapse;
		margin: 20px 0;
	}
	
	th, td {
		padding: 10px;
		text-align: left;
		border-bottom: 1px solid #ddd;
	}
	
	th {
		font-weight: bold;
	}
	
	td a {
		color: #007bff;
		text-decoration: none;
		font-weight: bold;
	}
	
	td a:hover {
		text-decoration: underline;
	}
	
	.btn-container {
		display: flex;
		justify-content: center;
		margin-top: 20px;
	}
	
	.btn-container a {
		margin: 0 10px;
		padding: 10px 20px;
		border-radius: 4px;
		text-decoration: none;
		font-weight: bold;
		background-color: #007bff;
		color: #fff;
		transition: background-color 0.3s;
	}
	
	.btn-container a:hover {
		background-color: #0056b3;
	}
</style>
</head>
<body class="d-flex flex-column min-vh-100" >
	<%@ include file="/include/header.jsp" %>	
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	<div class="main flex-grow-1">
	<div class="container2">
		<div
			class="d-flex align-items-center justify-content-between border-bottom">
			<h1 class="text-center flex-grow-1 mb-3">프로필</h1>
			<a href="profileUpdateForm.jsp" class="btn btn-link p-0"> <svg
					xmlns="http://www.w3.org/2000/svg" width="25" height="25"
					fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
		            <path
						d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
		            <path fill-rule="evenodd"
						d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z" />
		        </svg>
			</a>
		</div>
		<table>
			<tr>
				<th>회사명</th>
				<td>${comname }</td>
			</tr>
			<tr>
				<th>회사번호</th>
				<td><%=dto.getComId() %></td>
			</tr>
			<tr>
				<th>호점</th>
				<td>${storenum } 호점</td>
			</tr>
			<tr>
				<th>사원번호</th>
				<td>${empno }</td>
			</tr>
			<tr>
				<th>유저 이름</th>
				<td>${ename }</td>
			</tr>
			<tr>
				<th>직급</th>
				<td>${role }</td>
			</tr>
			<tr>
				<th>전화 번호</th>
				<td><%=dto.geteCall() %></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>-----</td>
			</tr>
			<tr>
				<th>월급</th>
				<td><%=dto.getSal() %></td>
			</tr>
			<tr>
				<th>시급</th>
				<td><%=dto.getHsal() %></td>
			</tr>
			<tr>
				<th>근무 시간</th>
				<td><%=dto.getWorktime() %></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><%=dto.getEmail() %></td>
			</tr>
			<tr>
				<th>고용 날짜</th>
				<td><%=dto.getHiredate() %></td>
			</tr>
			<tr>
				<th>근로계약서</th>
				<td><a href="contract.jsp?empno=${empno} ">근로 계약서 보기</a></td>
			</tr>
			<%--
			<tr>
				<th><a href="">퇴사 요청</a></th>
			</tr>
			 --%>
		</table>
		<div class="btn-container">
			<a href="../staffMain.jsp">메인 페이지로</a> <%--<a href="logout.jsp">로그아웃</a> --%>		
		</div>
	</div>
	</div>
	<jsp:include page="/include/footer.jsp" />
</body>
</html>