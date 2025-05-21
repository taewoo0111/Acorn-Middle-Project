<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1.세션 초기화
	session.invalidate();
	//2. 응답
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
		alert("로그아웃 되었습니다");
		//javascript 로 페이지 이동
		location.href = "${pageContext.request.contextPath }/user/loginForm.jsp";
	</script>
</body>
</html>