<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.setAttribute("current_page", "");
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<style>
    .container3 {
       
        text-align: center;
    }
    button {
        width: 500px; /* 버튼의 고정된 너비 */
        height: 80px; /* 버튼의 고정된 높이 */
        font-size: 30px; /* 글자 크기 */
        padding: 20px; /* 버튼 내부 여백 */
        margin: 5px; /* 버튼 사이 간격 */
        cursor: pointer; /* 마우스 커서 변경 */
        border: none; /* 기본 버튼 테두리 없애기 */
        background-color: grey; /* 버튼 배경 색 */
        color: white; /* 버튼 텍스트 색 */
        border-radius: 5px; /* 버튼 모서리 둥글게 */
        transition: background-color 0.3s; /* 버튼 색 변경에 대한 애니메이션 */
    }
    button:hover {
        background-color:black; /* 호버 시 색상 변화 */
    }
    .container2 {
	max-width: 800px;
	margin: 40px auto;
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	border: 1px solid black;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}
</style>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
<%@ include file="/include/header.jsp" %>
	<%-- 관리자 페이지 전용 네비바 --%>
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	<div class="main flex-grow-1">  

		<div class="container2">	
			<div class="container3">		
				<p>
					<a href="info/view.jsp" style="text-decoration: none; color: inherit;">
						<button>나의 정보 보기</button>
		    		</a>
				</p>
			</div>
			<div class="container3">
				<p>
					<a href="sale/view.jsp" style="text-decoration: none; color: inherit;">
		       			<button>매출 관리</button>
		       		</a>
				</p>
			</div>
			<div class="container3">
				<p>
					<a href="accept/acceptForm.jsp" style="text-decoration: none; color: inherit;">
		        		<button>가입 승인</button>
		        	</a>
		    	</p>
			</div>
			<div class="container3">
				<p>
					<a href="employee/manageForm.jsp" style="text-decoration: none; color: inherit;">
		        		<button>직원 관리</button>
		        	</a>
		    	</p>
			</div>
			<div class="container3">
				<p>
					<a href="quit/quitForm.jsp" style="text-decoration: none; color: inherit;">
						<button>퇴사자 관리</button>
		    		</a>
				</p>
			</div>
		</div>
	</div>

<%@ include file="/include/footer.jsp" %>
</body>
</html>