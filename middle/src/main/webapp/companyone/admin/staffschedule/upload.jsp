<%@page import="test.dto.Com1SchDto"%>
<%@page import="test.dao.Com1SchDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int storenum = (int)session.getAttribute("storenum");
	//int storenum = Integer.parseInt(request.getParameter("storenum"));
	String month = request.getParameter("title");
	String srcurl = request.getParameter("srcurl");
	
	Com1SchDto dto = new Com1SchDto();
	dto.setStoreNum(storenum);
	dto.setSchdate(month);
	dto.setSrcurl(srcurl);

	Com1SchDao dao=Com1SchDao.getInstance();
	boolean isSuccess=dao.insert(dto);
	
%>
<%if(isSuccess==true){ %>
	<script>
		alert("<%=month %>월 근무표 업로드됐습니다.");
		window.location.href = "view.jsp?storenum=<%=storenum %>";
	</script>
<%
	} else{
%>
	<script>
		alert("실패! 다시 업로드해주세요");
		 window.location.href = "uploadForm.jsp?storenum=<%=storenum %>";
	</script>
<%
	}
	
%>