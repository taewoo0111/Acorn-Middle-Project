<%@page import="java.net.URLEncoder"%>
<%@page import="test.dao.Com1WaitDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int empno = Integer.parseInt(request.getParameter("empno"));
	
	boolean isDeleteSuccess = Com1WaitDao.getInstance().delete(empno);
	
	String waitDeleteMessage = (isDeleteSuccess) ? "대기 목록에서 삭제 성공" : "대기 목록 삭제 실패";
	
	String redirectUrl = "acceptForm.jsp?empInsertMessage=" + URLEncoder.encode(waitDeleteMessage, "UTF-8");
	response.sendRedirect(redirectUrl);
%>