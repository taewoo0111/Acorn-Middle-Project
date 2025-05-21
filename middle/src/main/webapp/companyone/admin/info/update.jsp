<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    int empno = (int) session.getAttribute("empno");
	Com1EmpDto empdto = Com1EmpDao.getInstance().getData(empno);
	
	String newName = request.getParameter("ename");
	String newCall = request.getParameter("ecall");
	String newPassword = request.getParameter("newPassword");
	String newEmail = request.getParameter("email");

	boolean isSuccess = false;
	
	// Java의 문자열에선 \ = 이스케이프 문자 
	String reg_name = "^[가-힣]{2,5}$";
	String reg_call = "^01[016789]-\\d{3,4}-\\d{4}$"; 
	String reg_pwd = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[\\W_]).{8,}$";
	String reg_email = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
	
	// 이름 업데이트
	if (newName != null && !newName.isEmpty()) {
	    if (newName.matches(reg_name)) {
	        empdto.seteName(newName);
	        Com1EmpDao.getInstance().update(empdto);
	        isSuccess = true;
	    } else {
%>
	    <script>
	        alert("이름 형식이 올바르지 않습니다.");
	        location.href = "updateForm.jsp";
	    </script>
<%
	        return;
	    }
	}

	// 전화번호 업데이트
	if (newCall != null && !newCall.isEmpty()) {
	    if (newCall.matches(reg_call)) {
	        empdto.seteCall(newCall);
	        Com1EmpDao.getInstance().update(empdto);
	        isSuccess = true;
	    } else {
%>
	    <script>
	        alert("전화번호 형식이 올바르지 않습니다.");
	        location.href = "updateForm.jsp";
	    </script>
<%
	        return;
	    }
	}

	// 비밀번호 업데이트
	if (newPassword != null && !newPassword.isEmpty()) {
	    if (newPassword.matches(reg_pwd)) { 
	        empdto.setePwd(newPassword);
	        Com1EmpDao.getInstance().update(empdto);
	        isSuccess = true;
	    } else {
%>
	    <script>
	        alert("비밀번호 형식이 올바르지 않습니다.");
	        location.href = "updateForm.jsp";
	    </script>
<%
	        return;
	    }
	}
	
	// 이메일 업데이트
		if (newEmail!= null && !newEmail.isEmpty()) {
		    if (newEmail.matches(reg_email)) { 
		        empdto.setEmail(newEmail);
		        Com1EmpDao.getInstance().update(empdto);
		        isSuccess = true;
		    } else {
	%>
		    <script>
		        alert("이메일 형식이 올바르지 않습니다.");
		        location.href = "updateForm.jsp";
		    </script>
	<%
		        return;
		    }
		}
%>

	

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정 결과</title>
</head>
<body>
<div class="container">
	<% if (isSuccess) { %>
	    <script>
	        alert("개인 정보를 수정했습니다.");
	        location.href = "${pageContext.request.contextPath }/companyone/admin/info/view.jsp";
	    </script>
	<%  session.setAttribute("ename", newName); 
	  } else { %>
	    <script>
	        alert("수정 실패했습니다.");
	        location.href = "updateForm.jsp";
	    </script>
	<% } %>
</div>
</body>
</html>
