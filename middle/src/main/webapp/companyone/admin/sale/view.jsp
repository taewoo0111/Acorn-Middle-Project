<%@page import="java.util.List"%>
<%@page import="test.dao.Com1SaleDao"%>
<%@page import="test.dto.Com1SaleDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	//세션에 담은 storenum 가져오기
	//int storenum = (int)session.getAttribute("storenum");
	//storenum에 해당하는 데이터 리스트 가져오기
	//List<Com1SaleDto> list=Com1SaleDao.getInstance().getList(storenum);
	//request.setAttribute("list", list);
	
	
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매출조회 페이지</title>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
<%@ include file="/include/header.jsp" %>	
  <!-- 네비게이션 바 -->
  <jsp:include page="/include/navbar.jsp"></jsp:include>

  <!-- 메인 컨텐츠 -->
  <div class="container flex-grow-1 my-4">
    <!-- 버튼 -->
    <div class="d-flex justify-content-between mb-3">
      <a href="${pageContext.request.contextPath}/companyone/admin/sale/updateform.jsp" class="btn btn-success mt-3" role="button" >매출추가</a>
    </div>
 
    <!-- 테이블 -->
		<table class="table table-bordered table-hover text-center">
			<thead class="table-success">
				<tr>
					<th>월</th>
					<th>매출</th>
					<th>매출현황</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="tmp" items="${list }">
				<tr>
					<td>${tmp.salemonth }</td>
					<td>${tmp.monthlysal }</td>
					<td>${tmp.diff }</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
	
  <!-- 푸터 -->
  <jsp:include page="/include/footer.jsp" />
</body>
</html>