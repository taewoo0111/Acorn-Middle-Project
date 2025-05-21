<%@page import="test.dao.Com1Dao"%>
<%@page import="test.dto.Com1Dto"%>
<%@page import="test.dao.Com1SaleDao"%>
<%@page import="test.dto.Com1SaleDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	int storenum = (int)session.getAttribute("storenum"); // 몇호점 점장인지 알아내기

    String condition = request.getParameter("condition");
    if (condition == null) {
        condition = "none";
    }
    
    System.out.println("condition 값: " + condition); // 콘솔 출력 확인

	pageContext.setAttribute("condition", condition);
	
	Com1SaleDao saledao = Com1SaleDao.getInstance();
	List<Com1SaleDto> list = new ArrayList<>();

	if(condition.equals("day")){
		String saleDate = (String)session.getAttribute("saleDate");
		int daySal = saledao.getStoreDate(saleDate, storenum);
		session.setAttribute("saleDate", saleDate);
		session.setAttribute("daySal", daySal);
	} else if(condition.equals("monthSal")){
		int year = (int)session.getAttribute("year");
		int month = (int)session.getAttribute("month");
		Com1SaleDto dto = saledao.getStoreMonth(storenum, year, month);
	} else if(condition.equals("yearSal")){ //conditon.equals("yearSal");
		int year = (int)session.getAttribute("year");
		Com1SaleDto dto = saledao.getStoreYear(storenum, year);
	}
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매출 관리 페이지</title>
<style>
/* 탭 버튼 스타일 */
.tab-button {
	padding: 10px 20px;
	cursor: pointer;
	font-weight: bold;
	background-color: #f1f1f1;
	border: 1px solid #ddd;
	transition: background-color 0.3s ease;
	display: inline-block;
}

/* 활성화된 탭 스타일 */
.active-tab {
	background-color: #dcdcdc;
	border-bottom: 2px solid #999;
}

/* 탭 내용 스타일 */
.tab-content {
	padding: 20px;
	background-color: #fff;
	border-top: 1px solid #ddd;
	display: none;
}

/* 테이블 스타일 */
table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
	table-layout: fixed;
}
th, td {
	border: 1px solid #ddd;
	padding: 12px;
	text-align: center;
	background-color: #fff;
	font-size: 16px;
	white-space: normal;
	overflow-wrap: break-word;
	text-overflow: ellipsis;
	word-wrap: break-word;
}
th {
	background-color: #f5f5f5;
	font-weight: bold;
	color: #333;
	border-bottom: 2px solid #bbb;
}
tbody tr:nth-child(even) {
	background-color: #f9f9f9;
}
tbody tr:hover {
	background-color: #eef;
}
</style>

</head>
<body class="d-flex flex-column min-vh-100">

    <!-- 네비게이션 바 포함 -->
	<%-- <jsp:include page="/include/navbar.jsp"></jsp:include> --%>

	<div class="container">
		<!-- 현재 로그인한 사용자 정보 출력 (추후 주석 해제 가능) -->
		<p>
		<%-->	회사코드 :
			<%=comid %>
			회사번호 :
			<%=comname %>
			사원번호 :
			<%=empno %>
			역할 :
			<%=role %>
			이름 :
			<%=ename %> --%>
		</p>
	</div>

	<div class="contents text-center mt-3 mx-auto" style="width:900px;">
		<!-- 관리자 페이지 전용 네비바: 관리자 페이지 이동을 쉽게 하기 위함 -->
		<%-- <jsp:include page="/include/ceoNav.jsp"></jsp:include> --%>
		<h4>매출 현황</h4>
		
		<input type="date" id="salesdate" name="salesdate" required/>
    	
		<!-- 조회 조건 -->
		<div>
		<ul class="nav nav-tabs">
		  	<li class="nav-item">
		  		<a class="nav-link" aria-current="page" href="salemanage.jsp?condition=day">하루 매출</a>
		  	</li>
		  	<li class="nav-item">
		  		<a class="nav-link" aria-current="page" href="salemanage.jsp?condition=month">달 매출</a>
		  	</li>
		  	<li class="nav-item">
		  		<a class="nav-link" aria-current="page" href="salemanage.jsp?condition=year">년 매출</a>
		  	</li>
		</ul>
		</div>

       <div class="tab-content p-3 bg-light rounded shadow-sm" id="myTabContent">
    		<div>
    			<h1>날짜 선택하기</h1>
    			<input type="date" id="salesdate" name="salesdate" required/>
    			<button>날짜 선택</button>
    		</div>
			<div class="table-responsive">
				<table class="table table-hover text-center align-middle">
					<thead class="table-dark">
						<tr>
							<th>?호점</th>
							<th>선택한 날짜</th>
							<th>일매출</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${condition eq 'day'}">
									<tr>
										<td>${storenum }</td>
										<td>${saleDate }</td>
										<td>${daySal }</td>
									</tr>
							</c:when>
						</c:choose>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>