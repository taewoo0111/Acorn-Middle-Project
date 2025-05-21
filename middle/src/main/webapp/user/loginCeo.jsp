<%@page import="test.dao.UsingDao"%>
<%@page import="test.dto.UsingDto"%>
<%@page import="test.dto.Com1CeoDto"%>
<%@page import="test.dao.Com1CeoDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int comid = Integer.parseInt(request.getParameter("comid"));
	int empno = Integer.parseInt(request.getParameter("empno"));
	String ename = request.getParameter("ename");
	String epwd = request.getParameter("epwd");
	String role = request.getParameter("role");
	
	Com1CeoDto dto = Com1CeoDao.getInstance().getData(empno);
	String comname = UsingDao.getInstance().getComName(comid);
	
	if(dto != null) {
		if(empno == dto.getEmpNo() && role.equals(dto.getRole()) && comid == dto.getComId() 
		   && ename.equals(dto.geteName()) && epwd.equals(dto.getePwd())) {
			session.setAttribute("comid", comid);
			session.setAttribute("comname", comname);
        	session.setAttribute("empno", empno);
        	session.setAttribute("role", dto.getRole());
        	session.setAttribute("ename", ename);
        	session.setAttribute("storenum", -1);	// dummy for header.jsp
%> 
	<script>
		alert("관리자 계정 로그인 성공!");
		window.location.href = "../companyone/ceo/ceoMain.jsp";
	</script>
<%
		} else {
%>
	<script>
		alert("관리자 계정 로그인 실패!");
		window.location.href = "loginForm.jsp";
	</script>		
<%
		}
	} else { 
%>
	<script>
		alert("없는 사원번호 입니다!");
		window.location.href = "loginForm.jsp";
	</script>
<%
	} 
%>
