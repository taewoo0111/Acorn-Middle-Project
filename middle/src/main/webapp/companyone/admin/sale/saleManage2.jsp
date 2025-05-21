<%@page import="test.dto.Com1SaleDto"%>
<%@page import="test.dao.Com1SaleDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    

<%
	
	session.setAttribute("current_page", "saleview");
	
	//세션에 담긴 매장번호 가져오기
	
	
	// 매출 조회 페이지에서 day에 입력한 날짜를 담기
	String selectday = request.getParameter("day");
	int storenum=(int)session.getAttribute("storenum");
	
	if (selectday != null) {
		//처음에 페이지 들어가면 입력한 날짜가 아무것도 안나오게
		int daySale = Com1SaleDao.getInstance().getStoreDate(selectday, storenum);
		pageContext.setAttribute("salesdate", selectday);
		pageContext.setAttribute("daySale", daySale);
	}
	;
	// 매출 조회 페이지에서 입력한 달 가져오기
	String selectmonth = request.getParameter("month");
	
	// 매출 조회 페이지에서 입력한 연 가져오기
	String selectyear = request.getParameter("year");
	
	

	if (selectmonth != null && selectyear != null) {
		int month = Integer.parseInt(selectmonth);
		int year = Integer.parseInt(selectyear);
		Com1SaleDto dto = Com1SaleDao.getInstance().getStoreMonth(storenum, year, month);
		pageContext.setAttribute("dto", dto);
		
	} else if (selectyear != null) {
		int year = Integer.parseInt(selectyear);
		Com1SaleDto dto2 = Com1SaleDao.getInstance().getStoreYear(storenum, year);
		pageContext.setAttribute("dto2", dto2);

	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>점장 매출 조회 페이지</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
<style>
    .tabbutton {
        padding: 10px 20px;
        cursor: pointer;
        font-weight: bold;
        background-color: #f1f1f1;
        border: 1px solid #ddd;
        transition: background-color 0.3s ease;
    }
    .activetab {
        background-color: #dcdcdc; 
        border-bottom: 2px solid #999; 
    }    
</style>
</head>

<body class="d-flex flex-column min-vh-100 bg-light">
<%@ include file="/include/header.jsp" %>
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	<%--main 컨텐츠 감싸기 --%>
	<div class="main flex-grow-1">
		<div class="container">

			<div class="d-inline-block tabbutton" id="dayTab"
				onclick="switchTab('day')">일매출</div>
			<div class="d-inline-block tabbutton" id="monthTab"
				onclick="switchTab('month')">월매출</div>
			<div class="d-inline-block tabbutton" id="yearTab"
				onclick="switchTab('year')">연매출</div>

			<%-- 일매출 테이블 div --%>
			<div class="row justify-content-center mb-3" id="dayContent">
				<div class="col-xl">
					<div class="card p-4">
						<h1 class="mb-4">원하는 날짜의 일 매출 조회하기</h1>
						<%--조회 버튼--%>
						<form action="saleManage2.jsp?day=" method="get" class="mb-3">
							<input type="date" name="day" required />
							<button type="submit">조회</button>
						</form>
						<%--일매출 테이블 --%>
						<table class="table table-borederd table-hover text-center">
							<thead class="table-dark">
								<tr>
									<th>선택한 날짜</th>
									<th>일 매출</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th>${salesdate }</th>
									<th><fmt:formatNumber value="${pageScope.daySale}" pattern="#,###" /></th>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>

			<%-- 월매출 테이블 div --%>
			<div class="row justify-content-center mb-3" id="monthContent">
				<div class="col-xl">
					<div class="card p-4">
						<h1 class="mb-4">원하는 달의 달 매출 조회하기</h1>
						<%--입력 및 조회 버튼 --%>
						<form action="saleManage2.jsp" method="get" class="mb-3">
							<input type="number" name="year" required /> <input
								type="number" name="month" required />
							<button type="submit">조회</button>
						</form>
						<%--월매출 테이블 --%>
						<table class="table table-borederd table-hover text-center">
							<thead class="table-dark">
								<tr>
									<th>선택한 년도</th>
									<th>선택한 월</th>
									<th>월 매출</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th>${pageScope.dto.year }</th>
									<th>${pageScope.dto.month }</th>
									<th><fmt:formatNumber value="${pageScope.dto.monthlySales}" pattern="#,###" /></th>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>

			<%--연매출 테이블 div --%>
			<div class="row justify-content-center mb-3" id="yearContent">
				<div class="col-xl">
					<div class="card p-4">
						<h1>원하는 년도의 연 매출 조회하기</h1>
						<%--입력 및 조회 버튼 --%>
						<form action="saleManage2.jsp" method="get" class="mb-3">
							<input type="number" name="year" required />
							<button type="submit">조회</button>
						</form>

						<%--연매출 테이블 --%>
						<table class="table table-borederd table-hover text-center">
							<thead class="table-dark">
								<tr>
									<th>선택한 년도</th>
									<th>년 매출</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th>${dto2.year }</th>
									<th><fmt:formatNumber value="${pageScope.dto2.yearlySales}" pattern="#,###" /></th>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>

		</div> <%--main 이 끝나은 div --%>

		<%-- <div class="container">
      <h1>원하는 달의 모든 매출 조회하기</h1>
      <form action="salemanage2.jsp" method="get">
         <input type="number" name="year" required />
         <button type="submit">조회</button>
      </form>
      <table>
         <thead>
            <tr>
               <th>선택한 날짜</th>
               <th>일 매출</th>
            </tr>
         </thead>
         <tbody>
            <tr>
               <th>${salesdate }</th>
               <th>${daySale }</th>
            </tr>
         </tbody>
      </table>
   </div> --%>


	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<jsp:include page="/include/footer.jsp" />
	
	<script>
	function switchTab(tab) {
        const tabs = ['day', 'month', 'year'];

        tabs.forEach(t => {
            document.getElementById(t + 'Content').style.display = 'none';
            document.getElementById(t + 'Tab').classList.remove('activetab');
        });

        document.getElementById(tab + 'Content').style.display = 'block';
        document.getElementById(tab + 'Tab').classList.add('activetab');
    }
	
	// URL에서 현재 조회 중인 파라미터 확인
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('day')) { // 일을 가지고 있다면 일매출 탭으로
        switchTab('day');
    } else if (urlParams.has('month') && urlParams.has('year')) { // 달과 연도 데이터를 모두 가졌다면 달매출 보여주기
        switchTab('month');
    } else if (urlParams.has('year')) { // 연도 데이터를 가졌다면 연매출 탭 보여주기
        switchTab('year');
    } else {
        switchTab('day'); // 기본 접속하면 일매출 탭 보여주기
    }
	</script>
</body>
</html>
