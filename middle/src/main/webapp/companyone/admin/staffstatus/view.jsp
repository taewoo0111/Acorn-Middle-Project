<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>     	
<%
	session.setAttribute("current_page", "staffstatusview");

	// DB 에서 조회할 때 넘겨줄 객체
	Com1EmpDto dto = new Com1EmpDto();
	
	// 페이징 처리
	final int PAGE_ROW_COUNT = 10;
	final int PAGE_DISPLAY_COUNT = 3;
	
	// 보여줄페이지 초기값1
	int pageNum = 1;
	String condition = "STAFF";
	dto.setCondition(condition);
	
	
	String strPageNum = request.getParameter("pageNum");
	if(strPageNum != null) pageNum = Integer.parseInt(strPageNum);
	
	
	// 보여줄 row 값
	int startRowNum = (pageNum-1)*PAGE_ROW_COUNT + 1;
	int endRowNum = PAGE_ROW_COUNT*pageNum;
	System.out.println("startRowNum: " + startRowNum);
	System.out.println("endRowNum: " + endRowNum);
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	
	// 하단 페이징 값
	int startPageNum = ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT + 1;
	int endPageNum = startPageNum+PAGE_DISPLAY_COUNT - 1;
	System.out.println("startPageNum: " + startPageNum);
	System.out.println("endPageNum: " + endPageNum);
	
	// 페이지 수 계산
	int totalRow = Com1EmpDao.getInstance().getCount(dto);
	System.out.println("totalRow: " + totalRow);
	int totalPageCount =  (int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
//	if(endRowNum > totalPageCount) endPageNum = totalPageCount;
	if(endPageNum > totalPageCount) endPageNum = totalPageCount;
	
	
	// DB 에서 정보 추출
	List<Com1EmpDto> list = Com1EmpDao.getInstance().getList3(dto);
	pageContext.setAttribute("list", list);
	
	System.out.println("startPageNum: " + startPageNum);
	System.out.println("endPageNum: " + endPageNum);
	
	// request 영역에 필요한 정보 저장
	request.setAttribute("startPageNum", startPageNum);
	request.setAttribute("endPageNum", endPageNum);
	request.setAttribute("totalPageCount", totalPageCount);
	request.setAttribute("pageNum", pageNum);
	request.setAttribute("totalRow", totalRow);

	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원관리</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
<style>
	@media(max-width: 992px){
		.hidden-column{
			display:none;
		}
	}
</style>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
<%@ include file="/include/header.jsp" %>
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	

	<%--main컨텐츠감싸기 --%>
	<div class="main flex-grow-1">  
		<div class="container my-5">
	
			<h1 class="text-center mb-4">사원 관리</h1>
			<%--테이블--%>
			<table class="table table-borederd table-hover text-center">
				<thead class="table-dark">
					<tr>
						<th>회사ID</th>
						<th>소속지점</th>
						<th>사번</th>
						<th>이름</th>
						<th class="hidden-column">연락처</th>
						<th>월급</th>
						<th>시급</th>
						<th>일한시간</th>
						<th class="hidden-column">이메일</th>
						<th>근로계약서</th>
						<th class="hidden-column">근로시간 및 급여변경</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
					<% for(Com1EmpDto tmp:list){%>
					<tr>
						<td><%=tmp.getComId()%></td>
						<td><%=tmp.getStoreNum()%></td>
						<td><%=tmp.getEmpNo()%></td>
						<td><%=tmp.geteName()%></td>
						<td class="hidden-column"><%=tmp.geteCall()%></td>
						<td><fmt:formatNumber value="<%=tmp.getSal()%>" pattern="#,###" /></td>
						<td><fmt:formatNumber value="<%=tmp.getHsal()%>" pattern="#,###" /></td>
						<td><%=tmp.getWorktime()%></td>
						<td class="hidden-column"><%=tmp.getEmail()%></td>										
						<td>
							<a href="contract.jsp?empno=<%=tmp.getEmpNo()%>">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-file-earmark-person" viewBox="0 0 16 16">
							  <path d="M11 8a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
							  <path d="M14 14V4.5L9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2M9.5 3A1.5 1.5 0 0 0 11 4.5h2v9.255S12 12 8 12s-5 1.755-5 1.755V2a1 1 0 0 1 1-1h5.5z"/>
							</svg>
							<span class="visually-hidden">근로계약서</span>
							</a>
						</td>
						<td class="hidden-column"><a href="salUpdateForm.jsp?empno=<%=tmp.getEmpNo()%>&returnurl=view.jsp">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
						  <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
						  <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z"/>
						</svg>
						<span class="visually-hidden">근로시간 및 급여변경</span>
						</a></td>
						<td>
							<a href="delete.jsp?empno=<%=tmp.getEmpNo()%>"> 
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-dash" viewBox="0 0 16 16">
	  							 <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7M11 12h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1 0-1m0-7a3 3 0 1 1-6 0 3 3 0 0 1 6 0M8 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4" />
	 							 <path d="M8.256 14a4.5 4.5 0 0 1-.229-1.004H3c.001-.246.154-.986.832-1.664C4.484 10.68 5.711 10 8 10q.39 0 .74.025c.226-.341.496-.65.804-.918Q8.844 9.002 8 9c-5 0-6 3-6 4s1 1 1 1z" />
							</svg> 
							<span class="visually-hidden">회원삭제</span>
							</a>
						</td>						
					</tr>
				<%}%>	
				</tbody>
			</table>
		</div>
		
		<%-- 하단 페이징 버튼 --%>
		<div class="mt-3 d-flex justify-content-center">
			<nav class="d-flex justify-content-center mt-2">
				<ul class="pagination">
					<!-- Prev 버튼 -->
					<c:if test="${startPageNum ne 1}">
						<li class="page-item">
							<a class="page-link" href="view.jsp?pageNum=${startPageNum - 1}${findQuery}">Prev</a>
						</li>
					</c:if>
					<!-- 페이지 번호 -->
					<c:forEach begin="${startPageNum}" end="${endPageNum}" var="i">
						<li class="page-item ${i == pageNum ? 'active' : ''}">
							<a class="page-link" href="view.jsp?pageNum=${i}${findQuery}">${i}</a>
						</li>
					</c:forEach>
					<!-- Next 버튼 -->
					<c:if test="${endPageNum < totalPageCount}">
						<li class="page-item">
							<a class="page-link" href="view.jsp?pageNum=${endPageNum + 1}${findQuery}">Next</a>
						</li>
					</c:if>
				</ul>		
			</nav>
		</div>
		
	</div> <%--메인 --%>


	<%--푸터 --%>
	<jsp:include page="/include/footer.jsp" />
</body>
</html>