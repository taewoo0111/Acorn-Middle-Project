<%@page import="test.dao.UsingDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String comname = request.getParameter("comname");
	
	boolean isSuccess = UsingDao.getInstance().insert(comname);
	
	if(isSuccess){
%>
	<script>
		alert("회사가 성공적으로 추가되었습니다!");
		window.location.href = "../developer1234.jsp"; 
	</script>
<%
	} else {
%>
	<script>
		alert("회사 추가에 실패했습니다. 다시 시도해주세요.");
		window.location.href = "../developer1234.jsp"; 
	</script>
<%
	}
%>
    