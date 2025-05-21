
<%@page import="test.dto.UsingDto"%>
<%@page import="test.dao.UsingDao"%>
<%@page import="test.dao.Com1CeoDao"%>
<%@page import="test.dto.Com1CeoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
	//현재 페이지 위치를 세션 영역에 저장 (관리자 전용 네비바에 활성 상태 표시 위함)
	session.setAttribute("current_page", "myinfo");
	int empno=(int)session.getAttribute("empno");
	String comname=(String)session.getAttribute("comname");
	Com1CeoDto dto = Com1CeoDao.getInstance().getData(empno);
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/ceo/myinfo_ceo.jsp</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
<style>
table {
	width: 100%; /* 화면 너비에 맞게 설정 */
	border-spacing: 0;
	border-collapse: collapse; /* 테이블의 경계를 합칩니다 */
	margin-bottom: 50px;
}

th, td {
	padding: 20px; /* 셀 안의 여백을 일정하게 */
	text-align: left; /* 텍스트를 왼쪽 정렬 */
	border-bottom: 1px solid #ddd; /* 셀에 테두리 추가 */
}

th {
	background-color: #f4f4f4; /* 헤더 셀 배경색 */
	text-align: right; /* 텍스트를 오른쪽 정렬 */
	width: 25%; /* 각 열의 넓이를 고정 비율로 설정 */
}

td {
	width: 75%; /* 데이터 셀의 넓이를 고정 비율로 설정 */
}

/* 페이지에 맞게 조정된 폰트 크기 */
h1 {
	margin-bottom: 30px;
}

/* 링크 스타일 수정 */
a {
	color: #007bff;
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
}

.container2 {
	max-width: 800px;
	margin: 40px auto;
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	border: 1px solid black;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

h1 {
	text-align: center;
	margin-bottom: 20px;
	/* color: #333; */
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

<body class="d-flex flex-column min-vh-100 bg-light">
<%@ include file="/include/header.jsp" %>
	<%-- 관리자 페이지 전용 네비바: 관리자 페이지 이동을 쉽게 하기 위함 --%>
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	<div class="main flex-grow-1"> 
	<div class="container2 ">
		<div
			style="display: flex; justify-content: space-between; align-items: center;">
			<h1>개인정보</h1>
			<a id="updatemyinfo" href="updateform.jsp"
				class="btn btn-primary btn-m">개인정보수정</a>
		</div>

		<table>
			<tr>
				<th>회사</th>
				<td>${comname }(회사 코드 : <%=dto.getComId()%>)</td>
			</tr>
			<tr>
				<th>관리자 사원번호</th>
				<td><%=dto.getEmpNo()%></td>
			</tr>
			<tr>
				<th>관리자 이름</th>
				<td><%=dto.geteName()%></td>
			</tr>

			<tr>
				<th>직급</th>
				<td><%=dto.getRole()%></td>
			</tr>
			<tr>
				<th>연락처</th>
				<td><%=dto.geteCall()%></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>********</td>
			</tr>
		</table>

		<div class="btn-container">
			<a href="${pageContext.request.contextPath }/companyone/ceo/ceoMain.jsp">메인 페이지로</a>
		</div>
	</div>
	</div>

	<%@ include file="/include/footer.jsp" %>
</body>
</html>
