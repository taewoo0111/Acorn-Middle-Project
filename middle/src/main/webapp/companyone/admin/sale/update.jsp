<%@page import="test.dao.Com1SaleDao"%>
<%@page import="test.dto.Com1SaleDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//입력한 월과 매출을 가져오고
	String salemonth=(String)session.getAttribute("salemonth");
	int monthlysal=(int)session.getAttribute("monthlysal");
	
	//입력한 데이터를 dto에 담고 dao로 insert
	//Com1SaleDto dto=Com1SaleDao.getInstance().insert(dto);
	//성공알림 뜨면서 매출조회 페이지로 돌아가서 열 추가
	//실패아림 뜨면서 매출수정 페이지로 돌아가기
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매출을 추가 성공한다면..</title>
</head>
<body>
	
</body>
</html>