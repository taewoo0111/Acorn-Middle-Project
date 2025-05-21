<%@page import="test.dao.Com1EmpLogDao"%>
<%@page import="test.dto.Com1EmpLogDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int empno = Integer.parseInt(request.getParameter("empno"));
	 
	Com1EmpLogDto dto = new Com1EmpLogDto();
	dto.setEmpno(empno);
	
	boolean isSuccess = true;

    isSuccess = Com1EmpLogDao.getInstance().updateFinish(dto);
%>
{
	"isSuccess":"<%=isSuccess%>"
}