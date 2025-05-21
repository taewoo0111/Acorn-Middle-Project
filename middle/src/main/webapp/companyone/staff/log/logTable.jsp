<%@page import="java.util.List"%>
<%@page import="test.dto.Com1EmpLogDto"%>
<%@page import="test.dao.Com1EmpLogDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	session.setAttribute("current_page", "log");
	int empno=(int)session.getAttribute("empno");
	String ename=(String)session.getAttribute("ename");
	String month = request.getParameter("month"); //선택한 월 가져오기
	if (month == null || month.isEmpty()) {
	    month = "01"; // 기본값: 1월
	}
	
	
	String findQuery = "";
	
	// DTO 생성
	Com1EmpLogDto dto = new Com1EmpLogDto();
	
	if (month != null && !month.isEmpty()) {
	    dto.setMonth(month);
	    findQuery += "&month=" + month;
	}

	//페이지 설정
	//한 페이지에 몇개씩 표시할 것인지
	final int PAGE_ROW_COUNT=10;
	//하단 페이지를 몇개씩 표시할 것인지
	final int PAGE_DISPLAY_COUNT=3;
	
	//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
	int pageNum=1;
	
	//페이지 번호가 파라미터로 전달되는지 읽어와 본다.
	String strPageNum=request.getParameter("pageNum");
	//만일 페이지 번호가 파라미터로 넘어 온다면
	if(strPageNum != null){
		//숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
		pageNum=Integer.parseInt(strPageNum);
	}	
	
	//보여줄 페이지의 시작 ROWNUM
	int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
	//보여줄 페이지의 끝 ROWNUM
	int endRowNum=pageNum*PAGE_ROW_COUNT;
	
	//하단 시작 페이지 번호 
	int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
	//하단 끝 페이지 번호
	int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
	//전체 글의 갯수
	int totalRow=Com1EmpLogDao.getInstance().getCountByMonth(empno, month);
	//전체 페이지의 갯수 구하기
	int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
	//끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
	if(endPageNum > totalPageCount){
		endPageNum=totalPageCount; //보정해 준다. 
	}	
	
	// startRowNum 과 endRowNum 을 Dto 객체에 담아서
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	
	
    // 해당 월의 근태 기록 가져오기
    //int totalRow = Com1EmpLogDao.getInstance().getCountByMonth(month);
    List<Com1EmpLogDto> list = Com1EmpLogDao.getInstance().getListByMonth(empno, month, startRowNum, endRowNum);
	
	/*
		jsp 페이지에서 응답에 필요한 데이터를 el 에서 활용할 수 있도록
		request 객체에 특정 키값으로 담는다
	*/
	request.setAttribute("list", list); //List<Com1EmpLogDto>
	request.setAttribute("month", month);
	request.setAttribute("startPageNum", startPageNum); //int
	request.setAttribute("endPageNum", endPageNum); //int
	request.setAttribute("totalPageCount", totalPageCount); //int
	request.setAttribute("pageNum", pageNum); //int
	request.setAttribute("totalRow", totalRow); //int
	request.setAttribute("dto", dto); //Com1EmpLogDto
	request.setAttribute("findQuery", findQuery); //String
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근태 기록 관리</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
	html, body {
	    height: 100%;
	    margin: 0;
	    padding: 0;
	}
	
	.wrapper {
	    display: flex;
	    flex-direction: column;
	    min-height: 100vh; /* 뷰포트 높이만큼 최소 유지 */
	}

	.container2 {
		flex-grow: 1; /* 본문 영역이 확장되도록 설정 */
		width: 100%;
		max-width: 800px;
		margin: auto;
		background-color: #fff;
		padding: 20px 40px;
		border-radius: 8px;
		border: 1px solid black;
		box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	}
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    th, td {
        padding: 8px 12px;
        border: 1px solid #ddd;
        text-align: center;
    }
    th {
        background-color: #c8c8c8;
    }    
    .footer {
	    text-align: center;
	    width: 100%;
	    margin-top: auto;    
		margin-top: 40px;
	    position: relative;
	    bottom: 0;   
	}
</style>
</head>
<body>
	<div class="wrapper">
	<%@ include file="/include/header.jsp" %>
	<jsp:include page="/include/navbar.jsp"></jsp:include>
		<div class="container2" id="logTable">
		    <a href="log.jsp?empno=<%=empno %>">출퇴근 페이지로 돌아가기</a>
			<h1><strong><%=ename %></strong> 님 월별 근태 기록</h1>
		
				<form action="logTable.jsp" method="get" id="logForm">
					<label for="month">월 선택: </label> 
					<select name="month" id="month" onchange="document.getElementById('logForm').submit();">
						<!-- <option value="">-- 월을 선택하세요 --</option> -->
					    <% 
				            String selectedMonth = request.getParameter("month"); // 선택한 월 가져오기
				            for (int tmp = 1; tmp <= 12; tmp++) { 
				        %>
				            <option value="<%= tmp %>" <%= (String.valueOf(tmp).equals(selectedMonth) ? "selected" : "") %>>
								<%= tmp %>월
							</option>
						<% } %>
					</select>				
				</form>		
			
			<table class="table table-striped">
				<thead class="table-dark">
					<tr>
						<th>날짜</th>
						<th>출근 시간</th>
						<th>퇴근 시간</th>
						<!-- <th>근무 시간</th> -->
						<th>비고</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="log" items="${list}">
						<tr>
							<td>${log.workingDate}</td>
							<td>${log.checkIn}</td>
							<td>${log.checkOut}</td>
							<!-- <td>${log.workingHours}</td> -->
							<td>${log.remarks}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<nav class="d-flex justify-content-center ">
				<ul class="pagination">
					<!-- Prev 버튼 -->
					<c:if test="${startPageNum ne 1}">
						<li class="page-item">
							<a class="page-link" href="logTable.jsp?pageNum=${startPageNum - 1}${findQuery}">Prev</a>
						</li>
					</c:if>
					<!-- 페이지 번호 -->
					<c:forEach begin="${startPageNum}" end="${endPageNum}" var="i">
						<li class="page-item ${i == pageNum ? 'active' : ''}">
							<a class="page-link" href="logTable.jsp?pageNum=${i}${findQuery}">${i}</a>
						</li>
					</c:forEach>
					<!-- Next 버튼 -->
					<c:if test="${endPageNum < totalPageCount}">
						<li class="page-item">
							<a class="page-link" href="logTable.jsp?pageNum=${endPageNum + 1}${findQuery}">Next</a>
						</li>
					</c:if>
				</ul>		
			</nav>
	        
		</div>
		
		<footer class="footer">
	        <jsp:include page="/include/footer.jsp" />
	    </footer>
	</div>
</body>
</html>