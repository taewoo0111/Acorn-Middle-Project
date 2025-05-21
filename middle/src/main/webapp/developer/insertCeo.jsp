<%@page import="test.dao.Com1CeoDao"%>
<%@page import="test.dto.Com1CeoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int comid = Integer.parseInt(request.getParameter("comid"));
	String ename = request.getParameter("ename");
	String ecall = request.getParameter("ecall");
	String epwd = request.getParameter("epwd");
	
	Com1CeoDto dto = new Com1CeoDto();
	dto.setComId(comid);
	dto.seteName(ename);
	dto.seteCall(ecall);
	dto.setePwd(epwd);
	
	boolean isSuccess = Com1CeoDao.getInstance().insert(dto);
	
	if(isSuccess){
%>
        <script>
            alert("관리자가 성공적으로 추가되었습니다!");
            window.location.href = "../developer1234.jsp"; 
        </script>
<%
    } else {
%>
        <script>
            alert("관리자 추가에 실패했습니다. 다시 시도해주세요.");
            window.location.href = "../developer1234.jsp"; 
        </script>
<%
    }
%>