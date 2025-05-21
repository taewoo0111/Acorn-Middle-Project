<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="test.dao.Com1SaleDao"%>
<%@page import="test.dto.Com1SaleDto"%>
<%@page import="test.dao.UsingDao"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@page import="test.dto.Com1EmpDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 입력한 데이터 가져오기 날짜, 매출
	String salesDate=request.getParameter("salesdate");
	//System.out.println("saleateStr:" +salesDate);
	
	int dailySales=Integer.parseInt(request.getParameter("dailysales"));
	
	int storenum=(int)session.getAttribute("storenum");
	
	// DTO 객체 생성
	Com1SaleDto dto=new Com1SaleDto();
		
	// 데이터 저장 
	dto.setSalesDate(salesDate);
	dto.setDailySales(dailySales);
	dto.setStoreNum(storenum);
	
	session.setAttribute("dto", dto);
	
	//입력한 데이터로 수정하기
	boolean isSuccess=Com1SaleDao.getInstance().insert(dto);
	//수정을 성공했다면 알림뜨고 조회페이지로 이동
	if(isSuccess){
		session.setAttribute("dto",dto);
%>
	<script>
		alert("입력 성공!");
		window.location.href = "<%= request.getContextPath() %>/companyone/admin/sale/saleManage2.jsp";
	</script>
<%
	} else{
%>
	<script>
		alert("입력 실패!");
		 window.location.href = "<%= request.getContextPath() %>/companyone/admin/sale/insertForm.jsp";
	</script>
<%
	}
	
%>
