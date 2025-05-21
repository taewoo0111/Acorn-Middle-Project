<%@page import="test.dto.Com1EmpDto"%>
<%@ page import="test.dao.Com1EmpDao" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
    int empno = Integer.parseInt(request.getParameter("empno"));


    Com1EmpDao dao = Com1EmpDao.getInstance();
    Com1EmpDto dto = dao.getData(empno);
    dto.setContract("");

    boolean isSuccess=dao.update(dto);


    if (isSuccess) {
        out.print("삭제 성공");
    } else {
        out.print("삭제 실패");
    }
%>