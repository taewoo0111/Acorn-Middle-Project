<%@page import="java.net.URLEncoder"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@page import="test.dto.Com1WaitDto"%>
<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dao.Com1WaitDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int empno = Integer.parseInt(request.getParameter("empno"));
	
	Com1WaitDto dto1 = Com1WaitDao.getInstance().getData(empno);
	
	Com1EmpDto dto2 = new Com1EmpDto();
	dto2.setComId(dto1.getComId());
	dto2.setStoreNum(dto1.getStoreNum());
	dto2.setEmpNo(dto1.getEmpNo());
	dto2.seteName(dto1.geteName());
	dto2.setRole(dto1.getRole());
	dto2.seteCall(dto1.geteCall());
	dto2.setePwd(dto1.getePwd());
	dto2.setEmail(dto1.getEmail());
	
	boolean EmpInsertSuccess = Com1EmpDao.getInstance().insert(dto2);
	boolean WaitDeleteSuccess = Com1WaitDao.getInstance().delete(empno);
	
	String empInsertMessage = (EmpInsertSuccess) ? "사원 등록 성공" : "사원 등록 실패";
	String waitDeleteMessage = (WaitDeleteSuccess) ? "대기 목록에서 삭제 성공" : "대기 목록 삭제 실패";

	// URL 파라미터로 메시지 전달
	String redirectUrl = request.getContextPath() + "/companyone/admin/accept/acceptStaff.jsp?empInsertMessage=" + URLEncoder.encode(empInsertMessage, "UTF-8") + "&waitDeleteMessage=" + URLEncoder.encode(waitDeleteMessage, "UTF-8");
	response.sendRedirect(redirectUrl);
%>