<%@page import="test.dto.Com1EmpDto"%>
<%@page import="java.util.List"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.setAttribute("current_page", "staffstatusview");
	int empno = Integer.parseInt(request.getParameter("empno"));
	Com1EmpDao dao=Com1EmpDao.getInstance();
	Com1EmpDto dto= dao.getData(empno);
	String Contract = dto.getContract();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근로계약서조회</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
<style>
	.containers {
        max-width: 700px;
        margin: 40px auto;

    }
    #imgsrcurl{
        max-width: 100%;  
        height : 650px;
        margin: 0 auto; 
        border: 2px solid #ddd; /* 테두리 추가 */
        border-radius: 8px; /* 모서리 둥글게 */
    }
</style>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
<%@ include file="/include/header.jsp" %>	
	<jsp:include page="/include/navbar.jsp"></jsp:include>
			
	<%--main컨텐츠감싸기 --%>
	<div class="main flex-grow-1">  
        <div class="containers">
            <div class="row justify-content-center">
                <div class="col-lg">
                    <div class="card shadow-lg p-5 rounded-4">
                    	
                    	
						
						<% if (Contract != null && !Contract.trim().isEmpty()) { %>     
                    	<h1><%=empno%> <%=dto.geteName()%> 사원의 근로계약서</h1>
                    	<a href="conUpdate.jsp?empno=<%=empno %>" class="btn btn-danger mt-3" role="button" >계약서삭제</a>
						<img src="<%=dto.getContract()%>" alt="근로계약서" id="imgsrcurl" />	
                        <% } else {%>
                        <h1><%=empno%> <%=dto.geteName()%> 사원의 </h1>
                        <h3>근로계약서가 업로드되지 않았습니다.</h3>
                        <a href="conUploadForm.jsp?empno=<%=empno %>" class="btn btn-primary mt-3" role="button" >계약서업로드</a>
                        <% }%>
						
						
	                 </div>
	              </div>                          
	          </div>			
		</div>    	
    </div> <%--main --%>

	<%--푸터 --%>
    <jsp:include page="/include/footer.jsp" />
</body>
</html>
