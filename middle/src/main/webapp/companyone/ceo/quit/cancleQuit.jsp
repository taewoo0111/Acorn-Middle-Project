<%@page import="test.dto.Com1QuitDto"%>
<%@page import="test.dao.Com1QuitDao"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@page import="test.dto.Com1EmpDto"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 취소 대상의 사원번호(empno)
	int empno = Integer.parseInt(request.getParameter("empno"));
	
	// 퇴사처리할 사람 정보 DTO 가져오기
	Com1QuitDto dto_quit = Com1QuitDao.getInstance().getData(empno);
	
	Com1EmpDto dto_emp = new Com1EmpDto();
	dto_emp.setComId(dto_quit.getComId());
	
	dto_emp.seteCall(dto_quit.getContract());
	dto_emp.setEmail(dto_quit.getEmail());
	dto_emp.setEmpNo(dto_quit.getEmpNo());
	dto_emp.seteName(dto_quit.geteName());
	dto_emp.setePwd(dto_quit.getePwd());
	dto_emp.setStoreNum(dto_quit.getStoreNum());
	dto_emp.setWorktime(dto_quit.getWorktime());
	dto_emp.seteCall(dto_quit.geteCall());
	dto_emp.setRole(dto_quit.getRole());
	
	
	// emp 테이블에서 그 사람 row 추가
	boolean isAddSuccess = Com1EmpDao.getInstance().insert(dto_emp);
	
	// quit 테이블에서 그 사람 row 삭제
	boolean isDeleteSuccess = Com1QuitDao.getInstance().delete(empno);
	
%>
{"isAddSuccess":<%=isAddSuccess %>,"isDeleteSuccess":<%=isDeleteSuccess %>}