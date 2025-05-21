<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<header class="bg-dark text-white py-3">
    <div class="container d-flex justify-content-between align-items-center">
        <!-- 제목 클릭 시 새로 고침 되는 부분 -->
        <h1 class="m-0">프랜차이즈 관리 시스템</h1>
         <nav class="nav">
           <c:choose>
           		<c:when test="${empty role }">
           			<a class="nav-link text-white" href="${pageContext.request.contextPath }/">홈</a>
            		<a class="nav-link text-white" href="${pageContext.request.contextPath }/user/loginForm.jsp">로그인</a>
            		<a class="nav-link text-white" href="${pageContext.request.contextPath }/user/signup.jsp">회원가입</a>
           		</c:when>
           		<c:when test="${role.equals('CEO') }">
           			<a class="nav-link text-white" href="${pageContext.request.contextPath }/companyone/ceo/ceoMain.jsp">홈</a>
            		<a class="nav-link text-white" href="${pageContext.request.contextPath }/user/logout.jsp">로그아웃</a>
            		<a class="nav-link text-white" href="${pageContext.request.contextPath }/post/list.jsp">공지사항</a>
            		<p class="nav-link text-white">${ename }님 접속 중</p>
           		</c:when>
           		<c:when test="${role.equals('ADMIN') }">
           			<a class="nav-link text-white" href="${pageContext.request.contextPath }/companyone/admin/adminMain.jsp">홈</a>
            		<a class="nav-link text-white" href="${pageContext.request.contextPath }/user/logout.jsp">로그아웃</a>
            		<a class="nav-link text-white" href="${pageContext.request.contextPath }/post/list.jsp">공지사항</a>
            		<p class="nav-link text-white">${ename }님 접속 중</p>
           		</c:when>
           		<c:when test="${role.equals('STAFF') }">
           			<a class="nav-link text-white" href="${pageContext.request.contextPath }/companyone/staff/staffMain.jsp">홈</a>
            		<a class="nav-link text-white" href="${pageContext.request.contextPath }/user/logout.jsp">로그아웃</a>
           			<a class="nav-link text-white" href="${pageContext.request.contextPath }/post/list.jsp">공지사항</a>
            		<p class="nav-link text-white">${ename }님 접속 중</p>
           		</c:when>
           </c:choose>
        </nav>
    </div>
</header>
