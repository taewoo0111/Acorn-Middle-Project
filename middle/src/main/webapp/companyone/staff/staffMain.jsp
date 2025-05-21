<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	session.setAttribute("current_page", "staffMain");
	/*
	String comname = (String) session.getAttribute("comname");
	int storenum = (int) session.getAttribute("storenum");
	int empno = (int) session.getAttribute("empno");
	String role = (String) session.getAttribute("role");
	String ename = (String) session.getAttribute("ename");
	*/
	if(session.getAttribute("empno") == null) {
		response.sendRedirect("loginForm.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 메인 페이지</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<style>
    .container2 {
        max-width: 800px;
        margin: 40px auto;
        background-color: #fff;
        padding: 30px;
        border-radius: 8px;
        border: 1px solid black;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        text-align: center;
    }
    .btn-container {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        gap: 15px;
    }
    .btn-container button {
        width: 100%;
        max-width: 350px;
        height: 80px;
        font-size: 20px;
        border: 1px solid black;
        border-radius: 8px;
        transition: background-color 0.3s;
        background-color: #f8f9fa;
    }
    .btn-container button a {
        text-decoration: none;
        color: black;
        display: block;
        width: 100%;
        height: 100%;
        line-height: 80px;
    }
    .btn-container button:hover {
        background-color: #e2e6ea;
    }
</style>
</head>
<body>
	<%@ include file="/include/header.jsp" %>	
	<jsp:include page="/include/navbar.jsp"></jsp:include>
    <div class="container2">
        <h2 class="text-center mb-4">${comname } </h2>
        <h3>호점: ${storenum } 사원번호: ${empno }</h3>
        <h3>환영합니다, ${ename}님!</h3>
        <div class="btn-container">
        	<button><a href="${pageContext.request.contextPath }/companyone/staff/log/log.jsp">출/퇴근</a></button>
            <button><a href="${pageContext.request.contextPath }/companyone/staff/schedule/schedule.jsp">스케줄</a></button>
            <button><a href="${pageContext.request.contextPath }/companyone/staff/salary/salary.jsp">급여</a></button>
            <button><a href="${pageContext.request.contextPath }/companyone/staff/info/profile.jsp">프로필 관리</a></button>
        </div>
    </div>
	<div class="position-fixed bottom-0 w-100">
  		<jsp:include page="/include/footer.jsp" />
  	</div>
</body>
</html>