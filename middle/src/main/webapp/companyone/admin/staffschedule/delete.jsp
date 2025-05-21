<%@page import="test.dao.Com1SchDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int storenum = (int)session.getAttribute("storenum");
	//int storenum = Integer.parseInt(request.getParameter("storenum"));
	String date = request.getParameter("date");
	Com1SchDao dao=Com1SchDao.getInstance();
	boolean isSuccess= dao.delete(storenum);

%>
<%if(isSuccess==true){ %>
	<script>
		alert("<%=storenum %>호점 <%=date %>월 근무표를 삭제했습니다.");
		window.location.href = "view.jsp?storenum=<%=storenum %>";
	</script>
<%
	} else{
%>
	<script>
		alert("근무표 삭제 실패!");
		 window.location.href = "view.jsp?storenum=<%=storenum %>";
	</script>
<%
	}
	
%>