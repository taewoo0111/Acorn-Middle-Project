<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	session.setAttribute("current_page", "staffsalaryview");

	//dao이용해서 회원목록 얻어오기
	Com1EmpDao dao=Com1EmpDao.getInstance();
	List<Com1EmpDto> list=dao.getListStaff();
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원월급</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
<style>
    .tabbutton {
        padding: 10px 20px;
        cursor: pointer;
        font-weight: bold;
        background-color: #f1f1f1;
        border: 1px solid #ddd;
        transition: background-color 0.3s ease;
    }
    .activetab {
        background-color: #dcdcdc; 
        border-bottom: 2px solid #999; 
    }    
</style>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
<%@ include file="/include/header.jsp" %>
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	
	<%--main컨텐츠감싸기 --%>
	<div class="main flex-grow-1">  
		<div class="container">
		 
		 	<div class="d-inline-block tabbutton" id="yetTab" onclick="switchTab('yet')">급여미입력</div>
      		<div class="d-inline-block tabbutton" id="salTab" onclick="switchTab('sal')">직원</div>
       		<div class="d-inline-block tabbutton" id="hsalTab" onclick="switchTab('hsal')">알바</div>
       		
			<%--미입력테이블div --%>
			<div class="row justify-content-center mb-3" id="yetContent" >
            	<div class="col-xl">
                	<div class="card p-4">        
						<h1 class="mb-4">급여 미입력 사원정보</h1>
						<%--미입력 테이블--%>
						<table class="table table-borederd table-hover text-center">
							<thead class="table-dark">
								<tr>
									<th>사번</th>
									<th>이름</th>
									<th>시급</th>
									<th>일한시간</th>
									<th>월급</th>
									<th>근로시간변경</th>
								</tr>
							</thead>
							<tbody>
								<% for(Com1EmpDto tmp:list){
									 if (tmp.getHsal() == 0 && tmp.getSal() == 0 && tmp.getWorktime() == 0) {
								%>
								<tr>
									<td><%=tmp.getEmpNo()%></td>
									<td><%=tmp.geteName()%></td>
									<td><fmt:formatNumber value="<%=tmp.getHsal()%>" pattern="#,###" /></td>								
									<td><%=tmp.getWorktime()%></td>
									<td><fmt:formatNumber value="<%=tmp.getSal()%>" pattern="#,###" /></td>
									<td><a href="../staffstatus/salUpdateForm.jsp?empno=<%=tmp.getEmpNo()%>&returnurl=../staffsalary/view.jsp">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
									  <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
									  <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z"/>
									</svg>
									<span class="visually-hidden">근로시간변경</span>
									</a></td>
								</tr>
							<%} }%>
							</tbody>
						</table>
			    	</div>
            	</div>
            </div>
            
            
            
			
			<%--직원div --%>
			<div class="row justify-content-center mb-3" id="salContent">
            	<div class="col-xl">
                	<div class="card p-4">
						<h1 class="mb-4">직원</h1>
						<%--직원 월급 테이블--%>
						<table class="table table-borederd table-hover text-center">
							<thead class="table-dark">
								<tr>
									<th>사번</th>
									<th>이름</th>
									<th>월급</th>
								</tr>
							</thead>
							<tbody>
								<% for(Com1EmpDto tmp:list){
									 if (tmp.getSal() != 0) {
								%>
								<tr>
									<td><%=tmp.getEmpNo()%></td>
									<td><%=tmp.geteName()%></td>
									<td><fmt:formatNumber value="<%=tmp.getSal()%>" pattern="#,###" /></td>
								</tr>
								<%} }%>
							</tbody>
						</table>
           			</div>
            	</div>
            </div>				

			<%--알바div --%>
			<div class="row justify-content-center mb-3" id="hsalContent">
            	<div class="col-xl">
                	<div class="card p-4">          
            	
						<h1 class="mb-4">알바</h1>
						<%--알바 월급 테이블--%>
						<table class="table table-borederd table-hover text-center">
							<thead class="table-dark">
								<tr>
									<th>사번</th>
									<th>이름</th>
									<th>시급</th>
									<th>일한시간</th>
									<th>월급</th>
								</tr>
							</thead>
							<tbody>
								<% for(Com1EmpDto tmp:list){
									 if (tmp.getHsal() != 0) {
								%>
								<tr>
									<td><%=tmp.getEmpNo()%></td>
									<td><%=tmp.geteName()%></td>
									<td><fmt:formatNumber value="<%=tmp.getHsal()%>" pattern="#,###" /></td>						
									<td><%=tmp.getWorktime()%></td>
									<td><fmt:formatNumber value="<%=tmp.getHsal()*tmp.getWorktime()%>" pattern="#,###" /></td>
								</tr>
							<%} }%>
							</tbody>
						</table>
			    	</div>
            	</div>
            </div>
            

            
		</div>	<%--container --%>
    </div> <%--main --%>

	
	<%--푸터 --%>
    <jsp:include page="/include/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
	    function switchTab(tab) {
	        const tabs = ['yet', 'sal', 'hsal'];
	
	        tabs.forEach(t => {
	            document.getElementById(t + 'Content').style.display = 'none';
	            document.getElementById(t + 'Tab').classList.remove('activetab');
	        });
	
	        document.getElementById(tab + 'Content').style.display = 'block';
	        document.getElementById(tab + 'Tab').classList.add('activetab');
	    }
	
	    switchTab('yet');
    </script>
</body>
</html>