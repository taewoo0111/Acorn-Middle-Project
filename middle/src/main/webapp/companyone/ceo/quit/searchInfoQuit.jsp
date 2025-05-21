<%@page import="test.dao.Com1QuitDao"%>
<%@page import="test.dto.Com1QuitDto"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// empno 로 정보 조회
	int empno = Integer.parseInt(request.getParameter("empno"));
	Com1QuitDto dto = Com1QuitDao.getInstance().getData(empno);
	
	// 조회 결과
	boolean isExist = dto.geteName() == null ? false : true;
	System.out.println("dto: " + dto);
	System.out.println("isExist: " + isExist);
%>
{"isExist":<%=isExist %>}