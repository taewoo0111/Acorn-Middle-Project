<%@page import="java.net.URLEncoder"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dto.Com1WaitDto"%>
<%@page import="test.dao.Com1WaitDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	boolean isDeleteSuccess = false;
	boolean isAddSuccess = false;

	// 정보 추가에 필요한 데이터 추출 : 사원번호(empno)
	int empno = Integer.parseInt(request.getParameter("empno"));

	
	// 대기 리스트에서 해당 empno에 맞는 사람의 정보 추출
	Com1WaitDto dto_wait = Com1WaitDao.getInstance().getData(empno);

	// 직원 테이블에 그 사람 정보 추가
	Com1EmpDto dto_emp = new Com1EmpDto();
	dto_emp.setComId(dto_wait.getComId());
	dto_emp.setStoreNum(dto_wait.getStoreNum());
	dto_emp.setEmpNo(dto_wait.getEmpNo());
	dto_emp.seteName(dto_wait.geteName());
	dto_emp.setRole(dto_wait.getRole());
	dto_emp.seteCall(dto_wait.geteCall());
	dto_emp.setePwd(dto_wait.getePwd());
	dto_emp.setEmail(dto_wait.getEmail());
	isAddSuccess = Com1EmpDao.getInstance().insert(dto_emp);

	// 직원 테이블에 정보 추가 성공 시
	if(isAddSuccess){
		// 대기 리스트에서는 그 사람 정보 삭제
		isDeleteSuccess = Com1WaitDao.getInstance().delete(empno);
	}
	
	String empInsertMessage = (isAddSuccess) ? "사원 등록 성공" : "사원 등록 실패";
	String waitDeleteMessage = (isDeleteSuccess) ? "대기 목록에서 삭제 성공" : "대기 목록 삭제 실패";

	// URL 파라미터로 메시지 전달
	String redirectUrl = "acceptForm.jsp?empInsertMessage=" + URLEncoder.encode(empInsertMessage, "UTF-8") + "&waitDeleteMessage=" + URLEncoder.encode(waitDeleteMessage, "UTF-8");
	response.sendRedirect(redirectUrl);
%>

