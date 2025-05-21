<%@page import="test.dto.Com1SchDto"%>
<%@page import="java.util.List"%>
<%@page import="test.dao.Com1SchDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.setAttribute("current_page", "staffscheduleview");

	//int storenum = Integer.parseInt(request.getParameter("storenum"));
	int storenum = (int)session.getAttribute("storenum");
	
	//dao이용해서 회원목록 얻어오기
	Com1SchDao dao=Com1SchDao.getInstance();
	List<Com1SchDto> list=dao.getListSchStore(storenum);
	
    String schdate = "";
    if (!list.isEmpty()) {
        schdate = list.get(0).getSchdate();  // 첫 번째 row의 schdate 값 가져오기
    }

    String srcurl = "";
    if (!list.isEmpty()) {
    	srcurl = list.get(0).getSrcurl();  // 첫 번째 row의 schdate 값 가져오기
    }
    
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원스케줄조회</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
<style>
    #imgsrcurl {
        max-width: 100%;
        height: 600px;
        margin: 0 auto; 
        border: 2px solid #ddd; /* 테두리 추가 */
        border-radius: 8px; /* 모서리 둥글게 */
    }
    #smalltext {
        font-size: 0.8em;
        color: #888;
        margin-bottom: 3px;
    }

</style>

</head>
<body class="d-flex flex-column min-vh-100 bg-light">
<%@ include file="/include/header.jsp" %>
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	
	<%--main컨텐츠감싸기 --%>
	<div class="main flex-grow-1">  
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-sm">
                    <div class="card shadow-sm p-4">
						<h1><%=storenum %>호점 <%=schdate %>월 근무표조회</h1>
						
						
						<%--업로드 버튼--%>
						<div class="d-flex justify-content-between mb-3 ">
			     	 	
			     	 	<%--srcurl이 null이거나, 공백을 제거했을 때 빈 문자열이면 true --%>
			     	    <% if (srcurl == null || srcurl.trim().isEmpty()) { %>
			     	    <a href="uploadForm.jsp?storenum=<%=storenum %>" class="btn btn-primary mt-3" role="button" >근무표업로드</a>
						<% } else { %>
						<button class="btn btn-primary mt-3" disabled  >근무표업로드</button>
    					<%--삭제 버튼--%>
			     	    <a href="delete.jsp?storenum=<%=storenum %>&date=<%=schdate %>" class="btn btn-danger mt-3" role="button" >근무표삭제</a>
						<% } %>
			     	    
			     	    
			    	    </div>
                    	
                    	<% if (srcurl != null && !srcurl.trim().isEmpty()) { %>     
                    		 <p id="smalltext">근무표를 삭제한 후 새로운 근무표를 업로드할 수 있습니다.</p>
                    		 <img src="<%=srcurl %>" alt="직원근무표" id="imgsrcurl" />
                    		
                        <% } %>
                  </div>
              </div>                          
          </div>			
			
			
			
			
			
		</div>    	
    </div> <%--main --%>
	<%--푸터 --%>
    <jsp:include page="/include/footer.jsp" />

    
</body>
</html>