<%@page import="test.dao.UsingDao"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@page import="test.dto.Com1EmpDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int comid = Integer.parseInt(request.getParameter("comid"));
	int storenum = Integer.parseInt(request.getParameter("storenum"));
	int empno = Integer.parseInt(request.getParameter("empno"));
	String ename = request.getParameter("ename");
	String epwd = request.getParameter("epwd");
	String role = request.getParameter("role");

	Com1EmpDto dto = Com1EmpDao.getInstance().getData(empno);
	String comname = UsingDao.getInstance().getComName(comid);

	if(dto != null){
		if(empno == dto.getEmpNo() && role.equals(dto.getRole()) && comid == dto.getComId() && storenum == dto.getStoreNum() && ename.equals(dto.geteName()) && epwd.equals(dto.getePwd())){
			session.setAttribute("comname", comname);
			session.setAttribute("storenum", storenum);
			session.setAttribute("empno", empno);
			session.setAttribute("role", dto.getRole());
			session.setAttribute("ename", ename);
			session.setAttribute("comid", -1);	// dummy for header.jsp
%>
	<script>
		alert("사원 계정 로그인 성공!");
		window.location.href = "../companyone/staff/staffMain.jsp";
	</script>
<%
	}else{
%>
	<script>
		alert("사원 계정 로그인 실패!");
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
	