<%@page import="test.dao.UsingDao"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@page import="test.dao.Com1CeoDao"%>
<%@page import="test.dto.Com1EmpDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>	
<%
	session.setAttribute("current_page", "infoview");

	//점장이 로그인한 상태로 개인정보 조회
	//필요한 정보 : 사원번호, 비밀번호, 이름,  이메일 , 전화번호, 소속회사, 소속지점
	
	//비밀번호는 비밀번호 수정 페이지에서...
	//이름 뽑아오기
	
	
	// DB에서 점장정보 뽑아오기
	Com1EmpDao dao=Com1EmpDao.getInstance();
	//dao로 로그인한 사원번호에 해당하는 사람의 정보 가져오기
	int empno=(int)session.getAttribute("empno");
	Com1EmpDto empdto = Com1EmpDao.getInstance().getData(empno);
	session.setAttribute("empdto", empdto);
		
	//소속회사의 정보는 comid를 통해서 test_using_app에서 comname를 뽑아야 한다.
	//로그인한 점장의 comId 가져오기
	
	//로그인한 점장의 회사이름 뽑기
	UsingDao dao_using=UsingDao.getInstance();
	String comname=(String)session.getAttribute("comname");
	session.setAttribute("comname", comname);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>점장정보조회</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
<style>
	.tbl_row_wrap {
        border: 1px solid #dee2e6; /* 전체 테이블 테두리 */
        border-radius: 10px; /* 둥근 테두리 */
        padding: 20px;
        background-color: #fff; /* 테이블 배경 */
    }

    .tbl_row {
        width: 100%;
        border-collapse: separate;
    }

    .tbl_row th, .tbl_row td {
        padding: 12px;
        border-bottom: 1px solid #dee2e6; /* 행 구분선 */
    }

    .tbl_row th {
        background-color: #f8f9fa; /* 제목 부분 배경색 */
        text-align: left;
        font-weight: bold;
        width: 250px;
    }

    .tbl_row:last-child tr:last-child th, .tbl_row:last-child tr:last-child td  {
        border-bottom: none; /* 마지막 줄 구분선 제거 */
    }
    
    .btn{
    	background-color: #28A745;
    	border-color: #28A745;
    }
   
</style>
</head>
<body class="d-flex flex-column min-vh-100">
<%@ include file="/include/header.jsp" %>	
	<jsp:include page="/include/navbar.jsp"></jsp:include>		
		<div class="main flex-grow-1">
		<div class="container">
			<h1 class="mb-2">회원정보조회 페이지</h1>
			<div class="tbl_row_wrap">
				<table class="tbl_row">
					<colgroup>
						<col style="width:264px;">
						<col style="width:auto;">
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">회사명</th>
							<td><%=comname %></td>
						</tr>
						<tr>
							<th scope="row">회사Id</th>
							<td><%=empdto.getComId() %></td>
						</tr>
						<tr>
							<th scope="row">소속지점(storenum)</th>
							<td><%=empdto.getStoreNum() %></td>
						</tr>
						<tr>
							<th scope="row">아이디</th>
							<td><%=empdto.getEmpNo() %></td>
						</tr>
						<tr>
							<th scope="row">이름</th>
							<td><%=empdto.geteName() %></td>
						</tr>
						<tr>
							<th scope="row">역할</th>
							<td><%=empdto.getRole() %></td>
						</tr>
						<tr>
							<th scope="row">전화번호</th>
							<td><%=empdto.geteCall() %></td>
						</tr>
						<tr>
							<th scope="row">비밀번호</th>
							<td>-----</td>
						</tr>
						<tr>
							<th scope="row">월급</th>
							<td><%=empdto.getSal() %></td>
						</tr>
						<tr>
							<th scope="row">시급</th>
							<td><%=empdto.getHsal() %></td>
						</tr>
						<tr>
							<th scope="row">근무시간</th>
							<td><%=empdto.getWorktime() %></td>
						</tr>
						<tr>
							<th scope="row">이메일</th>
							<td><%=empdto.getEmail() %></td>
						</tr>
						<tr>
							<th scope="row">입사일</th>
							<td><%=empdto.getHiredate() %></td>
						</tr>
						<tr>
							<th scope="row">근로계약서</th>
							<td><a href="${pageContext.request.contextPath}/companyone/admin/staffstatus/contract.jsp?empno=<%=empdto.getEmpNo()%>">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-file-earmark-person" viewBox="0 0 16 16">
							  <path d="M11 8a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
							  <path d="M14 14V4.5L9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2M9.5 3A1.5 1.5 0 0 0 11 4.5h2v9.255S12 12 8 12s-5 1.755-5 1.755V2a1 1 0 0 1 1-1h5.5z"/>
							</svg>
							<span>근로계약서</span>
							</a></td>
						</tr>
					</tbody>
				</table>
			</div>

			<a href="${pageContext.request.contextPath}/companyone/admin/info/updateForm.jsp" class="btn btn-primary mt-2 mb-4" role="button">개인정보수정</a>

		</div>
	</div>
	<jsp:include page="/include/footer.jsp" />

</body>
</html>