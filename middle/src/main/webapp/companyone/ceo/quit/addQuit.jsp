<%@page import="test.dao.Com1EmpLogDao"%>
<%@page import="test.dto.Com1QuitDto"%>
<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@page import="test.dao.Com1QuitDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	boolean isAddSuccess = false;
	boolean isDeleteLog = false;
	boolean isDeleteSuccess = false;
	
	// 정보 추가에 필요한 데이터 추출 : 사원번호(empno), 퇴사일자(quitdate)
	int empno = Integer.parseInt(request.getParameter("empno"));
	String quitdate = request.getParameter("quitdate");
	
	// 퇴사처리할 사람 정보 DTO 가져오기
	Com1EmpDto dto = Com1EmpDao.getInstance().getData(empno);
	
	// quit 테이블에서 그 사람 row 추가
	isAddSuccess = Com1QuitDao.getInstance().insert(dto,quitdate);
	
	// 퇴사 테이블에 추가 성공 시
	if(isAddSuccess){
		// emp 테이블에서 그 사람 row 삭제
		isDeleteLog = Com1EmpLogDao.getInstance().delete(empno); // 직원의 관련 로그 정보가 삭제되어야 아래 직원 테이블에서 삭제 가능함
		isDeleteSuccess = Com1EmpDao.getInstance().delete(empno);
	}
	
	System.out.println("isAddSuccess 결과: " + isAddSuccess);
	System.out.println("isDeleteSuccess 결과: " + isAddSuccess);
%>
{"isAddSuccess":<%=isAddSuccess %>,"isDeleteSuccess":<%=isDeleteSuccess %>}