<%@page import="test.dao.Com1Dao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String storecall = request.getParameter("storecall");
	
	boolean isSuccess = Com1Dao.getInstance().insert(storecall);
	
	if(isSuccess){
%>
	<script>
		alert("매장이 성공적으로 추가되었습니다!");
		window.location.href = "../developer1234.jsp"; 
	</script>
<%
	} else {
%>
	<script>
		alert("매장 추가에 실패했습니다. 다시 시도해주세요.");
		window.location.href = "../developer1234.jsp"; 
	</script>
<%
	}
%>

